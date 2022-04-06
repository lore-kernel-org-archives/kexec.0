From: Omar Sandoval <osandov@osandov.com>
Date: Wed,  6 Apr 2022 13:36:36 -0700
Subject: [PATCH v2] mm/vmalloc: fix spinning drain_vmap_work after reading
 from /proc/vmcore
Message-ID: <52f819991051f9b865e9ce25605509bfdbacadcd.1649277321.git.osandov@fb.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Omar Sandoval <osandov@fb.com>

Commit 3ee48b6af49c ("mm, x86: Saving vmcore with non-lazy freeing of
vmas") introduced set_iounmap_nonlazy(), which sets vmap_lazy_nr to
lazy_max_pages() + 1, ensuring that any future vunmaps() immediately
purge the vmap areas instead of doing it lazily.

Commit 690467c81b1a ("mm/vmalloc: Move draining areas out of caller
context") moved the purging from the vunmap() caller to a worker thread.
Unfortunately, set_iounmap_nonlazy() can cause the worker thread to spin
(possibly forever). For example, consider the following scenario:

1. Thread reads from /proc/vmcore. This eventually calls
   __copy_oldmem_page() -> set_iounmap_nonlazy(), which sets
   vmap_lazy_nr to lazy_max_pages() + 1.
2. Then it calls free_vmap_area_noflush() (via iounmap()), which adds 2
   pages (one page plus the guard page) to the purge list and
   vmap_lazy_nr. vmap_lazy_nr is now lazy_max_pages() + 3, so the
   drain_vmap_work is scheduled.
3. Thread returns from the kernel and is scheduled out.
4. Worker thread is scheduled in and calls drain_vmap_area_work(). It
   frees the 2 pages on the purge list. vmap_lazy_nr is now
   lazy_max_pages() + 1.
5. This is still over the threshold, so it tries to purge areas again,
   but doesn't find anything.
6. Repeat 5.

If the system is running with only one CPU (which is typicial for kdump)
and preemption is disabled, then this will never make forward progress:
there aren't any more pages to purge, so it hangs. If there is more than
one CPU or preemption is enabled, then the worker thread will spin
forever in the background. (Note that if there were already pages to be
purged at the time that set_iounmap_nonlazy() was called, this bug is
avoided.)

This can be reproduced with anything that reads from /proc/vmcore
multiple times. E.g., vmcore-dmesg /proc/vmcore.

It turns out that improvements to vmap() over the years have obsoleted
the need for this "optimization". I benchmarked
`dd if=/proc/vmcore of=/dev/null` with 4k and 1M read sizes on a system
with a 32GB vmcore. The test was run on 5.17, 5.18-rc1 with a fix that
avoided the hang, and 5.18-rc1 with set_iounmap_nonlazy() removed
entirely:

  |5.17  |5.18+fix|5.18+removal
4k|40.86s|  40.09s|      26.73s
1M|24.47s|  23.98s|      21.84s

The removal was the fastest (by a wide margin with 4k reads). This patch
removes set_iounmap_nonlazy().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Changes from v1:

- Remove set_iounmap_nonlazy() entirely instead of fixing it.

 arch/x86/include/asm/io.h       |  2 --
 arch/x86/kernel/crash_dump_64.c |  1 -
 mm/vmalloc.c                    | 11 -----------
 3 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f6d91ecb8026..e9736af126b2 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -210,8 +210,6 @@ void __iomem *ioremap(resource_size_t offset, unsigned long size);
 extern void iounmap(volatile void __iomem *addr);
 #define iounmap iounmap
 
-extern void set_iounmap_nonlazy(void);
-
 #ifdef __KERNEL__
 
 void memcpy_fromio(void *, const volatile void __iomem *, size_t);
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index a7f617a3981d..97529552dd24 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -37,7 +37,6 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	} else
 		memcpy(buf, vaddr + offset, csize);
 
-	set_iounmap_nonlazy();
 	iounmap((void __iomem *)vaddr);
 	return csize;
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e163372d3967..0b17498a34f1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1671,17 +1671,6 @@ static DEFINE_MUTEX(vmap_purge_lock);
 /* for per-CPU blocks */
 static void purge_fragmented_blocks_allcpus(void);
 
-#ifdef CONFIG_X86_64
-/*
- * called before a call to iounmap() if the caller wants vm_area_struct's
- * immediately freed.
- */
-void set_iounmap_nonlazy(void)
-{
-	atomic_long_set(&vmap_lazy_nr, lazy_max_pages()+1);
-}
-#endif /* CONFIG_X86_64 */
-
 /*
  * Purges all lazily-freed vmap areas.
  */
-- 
2.35.1


