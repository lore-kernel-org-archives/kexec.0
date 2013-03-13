Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lgemrelse1q.lge.com ([156.147.1.111])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFfFO-0004dj-Nx
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 06:33:13 +0000
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 1/8] mm,
 vmalloc: change iterating a vmlist to find_vm_area()
Date: Wed, 13 Mar 2013 15:32:53 +0900
Message-Id: <1363156381-2881-2-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1363156381-2881-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1363156381-2881-1-git-send-email-iamjoonsoo.kim@lge.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bob Liu <lliubbo@gmail.com>, Joonsoo Kim <js1304@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "H. Peter Anvin" <hpa@zytor.com>, Dave Anderson <anderson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vivek Goyal <vgoyal@redhat.com>

From: Joonsoo Kim <js1304@gmail.com>

The purpose of iterating a vmlist is finding vm area with specific
virtual address. find_vm_area() is provided for this purpose
and more efficient, because it uses a rbtree.
So change it.

Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Chris Metcalf <cmetcalf@tilera.com>
Signed-off-by: Joonsoo Kim <js1304@gmail.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/arch/tile/mm/pgtable.c b/arch/tile/mm/pgtable.c
index b3b4972..dfd63ce 100644
--- a/arch/tile/mm/pgtable.c
+++ b/arch/tile/mm/pgtable.c
@@ -592,12 +592,7 @@ void iounmap(volatile void __iomem *addr_in)
 	   in parallel. Reuse of the virtual address is prevented by
 	   leaving it in the global lists until we're done with it.
 	   cpa takes care of the direct mappings. */
-	read_lock(&vmlist_lock);
-	for (p = vmlist; p; p = p->next) {
-		if (p->addr == addr)
-			break;
-	}
-	read_unlock(&vmlist_lock);
+	p = find_vm_area((void *)addr);
 
 	if (!p) {
 		pr_err("iounmap: bad address %p\n", addr);
diff --git a/arch/unicore32/mm/ioremap.c b/arch/unicore32/mm/ioremap.c
index b7a6055..13068ee 100644
--- a/arch/unicore32/mm/ioremap.c
+++ b/arch/unicore32/mm/ioremap.c
@@ -235,7 +235,7 @@ EXPORT_SYMBOL(__uc32_ioremap_cached);
 void __uc32_iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
-	struct vm_struct **p, *tmp;
+	struct vm_struct *vm;
 
 	/*
 	 * If this is a section based mapping we need to handle it
@@ -244,17 +244,10 @@ void __uc32_iounmap(volatile void __iomem *io_addr)
 	 * all the mappings before the area can be reclaimed
 	 * by someone else.
 	 */
-	write_lock(&vmlist_lock);
-	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
-		if ((tmp->flags & VM_IOREMAP) && (tmp->addr == addr)) {
-			if (tmp->flags & VM_UNICORE_SECTION_MAPPING) {
-				unmap_area_sections((unsigned long)tmp->addr,
-						    tmp->size);
-			}
-			break;
-		}
-	}
-	write_unlock(&vmlist_lock);
+	vm = find_vm_area(addr);
+	if (vm && (vm->flags & VM_IOREMAP) &&
+		(vm->flags & VM_UNICORE_SECTION_MAPPING))
+		unmap_area_sections((unsigned long)vm->addr, vm->size);
 
 	vunmap(addr);
 }
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 78fe3f1..9a1e658 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -282,12 +282,7 @@ void iounmap(volatile void __iomem *addr)
 	   in parallel. Reuse of the virtual address is prevented by
 	   leaving it in the global lists until we're done with it.
 	   cpa takes care of the direct mappings. */
-	read_lock(&vmlist_lock);
-	for (p = vmlist; p; p = p->next) {
-		if (p->addr == (void __force *)addr)
-			break;
-	}
-	read_unlock(&vmlist_lock);
+	p = find_vm_area((void __force *)addr);
 
 	if (!p) {
 		printk(KERN_ERR "iounmap: bad address %p\n", addr);
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
