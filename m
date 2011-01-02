Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.windriver.com ([147.11.1.11])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PZIJq-0006No-GT
	for kexec@lists.infradead.org; Sun, 02 Jan 2011 07:25:37 +0000
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [34-longterm 226/260] mm,
	x86: Saving vmcore with non-lazy freeing of vmas
Date: Sun,  2 Jan 2011 02:18:42 -0500
Message-Id: <1293952756-15010-227-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1293952756-15010-1-git-send-email-paul.gortmaker@windriver.com>
References: <1293952756-15010-1-git-send-email-paul.gortmaker@windriver.com>
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
To: stable@kernel.org, linux-kernel@vger.kernel.org
Cc: Cliff Wickman <cpw@sgi.com>, kexec@lists.infradead.org, stable-review@kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

From: Cliff Wickman <cpw@sgi.com>

commit 3ee48b6af49cf534ca2f481ecc484b156a41451d upstream.

During the reading of /proc/vmcore the kernel is doing
ioremap()/iounmap() repeatedly. And the buildup of un-flushed
vm_area_struct's is causing a great deal of overhead. (rb_next()
is chewing up most of that time).

This solution is to provide function set_iounmap_nonlazy(). It
causes a subsequent call to iounmap() to immediately purge the
vma area (with try_purge_vmap_area_lazy()).

With this patch we have seen the time for writing a 250MB
compressed dump drop from 71 seconds to 44 seconds.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org
LKML-Reference: <E1OwHZ4-0005WK-Tw@eag09.americas.sgi.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/x86/include/asm/io.h       |    1 +
 arch/x86/kernel/crash_dump_64.c |    1 +
 mm/vmalloc.c                    |    9 +++++++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 30a3e97..6a45ec4 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -206,6 +206,7 @@ static inline void __iomem *ioremap(resource_size_t offset, unsigned long size)
 
 extern void iounmap(volatile void __iomem *addr);
 
+extern void set_iounmap_nonlazy(void);
 
 #ifdef __KERNEL__
 
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 045b36c..ce96a6b 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -46,6 +46,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	} else
 		memcpy(buf, vaddr + offset, csize);
 
+	set_iounmap_nonlazy();
 	iounmap(vaddr);
 	return csize;
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ae00746..20a402c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -513,6 +513,15 @@ static atomic_t vmap_lazy_nr = ATOMIC_INIT(0);
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
-- 
1.7.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
