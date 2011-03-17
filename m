Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kroah.org ([198.145.64.141] helo=coco.kroah.org)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q0Kw8-0002bt-Bt
	for kexec@lists.infradead.org; Thu, 17 Mar 2011 21:40:53 +0000
Message-Id: <20110317212848.172918367@clark.kroah.org>
Date: Thu, 17 Mar 2011 14:22:02 -0700
From: Greg KH <gregkh@suse.de>
Subject: [072/474] mm, x86: Saving vmcore with non-lazy freeing of vmas
In-Reply-To: <20110317213822.GA27980@kroah.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: stable-review@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

2.6.33-longterm review patch.  If anyone has any objections, please let us know.

------------------
Content-Length: 2026
Lines: 68

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/x86/include/asm/io.h       |    1 +
 arch/x86/kernel/crash_dump_64.c |    1 +
 mm/vmalloc.c                    |    9 +++++++++
 3 files changed, 11 insertions(+)

--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -172,6 +172,7 @@ static inline void __iomem *ioremap(reso
 
 extern void iounmap(volatile void __iomem *addr);
 
+extern void set_iounmap_nonlazy(void);
 
 #ifdef CONFIG_X86_32
 # include "io_32.h"
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -46,6 +46,7 @@ ssize_t copy_oldmem_page(unsigned long p
 	} else
 		memcpy(buf, vaddr + offset, csize);
 
+	set_iounmap_nonlazy();
 	iounmap(vaddr);
 	return csize;
 }
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -513,6 +513,15 @@ static atomic_t vmap_lazy_nr = ATOMIC_IN
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



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
