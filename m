Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OwHXA-0006Uw-Oj
	for kexec@lists.infradead.org; Thu, 16 Sep 2010 16:42:05 +0000
Subject: [PATCH] x86: saving vmcore with non-lazy freeing of vmas 
Message-Id: <E1OwHZ4-0005WK-Tw@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Thu, 16 Sep 2010 11:44:02 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org

From: Cliff Wickman <cpw@sgi.com>

During the reading of /proc/vmcore the kernel is doing ioremap()/iounmap()
repeatedly. And the buildup of un-flushed vm_area_struct's is causing
a great deal of overhead. (rb_next() is chewing up most of that time).

This solution is to provide function set_iounmap_nonlazy(). It causes a
subsequent call to iounmap() to immediately purge the vma area (with
try_purge_vmap_area_lazy()).

With this patch we have seen the time for writing a 250MB compressed dump
drop from 71 seconds to 44 seconds.

Diffed against 2.6.36-rc3

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 arch/x86/include/asm/io.h       |    1 +
 arch/x86/kernel/crash_dump_64.c |    1 +
 mm/vmalloc.c                    |    9 +++++++++
 3 files changed, 11 insertions(+)

Index: linus.current/arch/x86/kernel/crash_dump_64.c
===================================================================
--- linus.current.orig/arch/x86/kernel/crash_dump_64.c
+++ linus.current/arch/x86/kernel/crash_dump_64.c
@@ -46,6 +46,7 @@ ssize_t copy_oldmem_page(unsigned long p
 	} else
 		memcpy(buf, vaddr + offset, csize);
 
+	set_iounmap_nonlazy();
 	iounmap(vaddr);
 	return csize;
 }
Index: linus.current/mm/vmalloc.c
===================================================================
--- linus.current.orig/mm/vmalloc.c
+++ linus.current/mm/vmalloc.c
@@ -517,6 +517,15 @@ static atomic_t vmap_lazy_nr = ATOMIC_IN
 static void purge_fragmented_blocks_allcpus(void);
 
 /*
+ * called before a call to iounmap() if the caller wants vm_area_struct's
+ * immediately freed.
+ */
+void set_iounmap_nonlazy(void)
+{
+	atomic_set(&vmap_lazy_nr, lazy_max_pages()+1);
+}
+
+/*
  * Purges all lazily-freed vmap areas.
  *
  * If sync is 0 then don't purge if there is already a purge in progress.
Index: linus.current/arch/x86/include/asm/io.h
===================================================================
--- linus.current.orig/arch/x86/include/asm/io.h
+++ linus.current/arch/x86/include/asm/io.h
@@ -206,6 +206,7 @@ static inline void __iomem *ioremap(reso
 
 extern void iounmap(volatile void __iomem *addr);
 
+extern void set_iounmap_nonlazy(void);
 
 #ifdef __KERNEL__
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
