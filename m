Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cb0pi-0004V5-Hk
 for kexec@lists.infradead.org; Tue, 07 Feb 2017 08:09:06 +0000
Received: by mail-pf0-f176.google.com with SMTP id 189so31315200pfu.3
 for <kexec@lists.infradead.org>; Tue, 07 Feb 2017 00:08:42 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v32 05/13] arm64: mm: allow for unmapping part of kernel
 mapping
Date: Tue,  7 Feb 2017 17:08:57 +0900
Message-Id: <20170207080904.5974-3-takahiro.akashi@linaro.org>
In-Reply-To: <20170207080601.5816-1-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

create_pgd_mapping() is enhanced here so that it will accept
PAGE_KERNEL_INVALID protection attribute and unmap a given range of memory.

The feature will be used in a later kdump patch to implement the protection
against possible corruption of crash dump kernel memory which is to be set
aside from ther other memory on primary kernel.

Note that, in this implementation, it assumes that all the range of memory
to be processed is mapped in page-level since the only current user is
kdump where page mappings are also required.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/pgtable-prot.h |  1 +
 arch/arm64/mm/mmu.c                   | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2142c7726e76..945d84cd5df7 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -54,6 +54,7 @@
 #define PAGE_KERNEL_ROX		__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
+#define PAGE_KERNEL_INVALID	__pgprot(0)
 
 #define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
 #define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 17243e43184e..3c674831f856 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -140,7 +140,11 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				__prot = prot;
 		}
 
-		set_pte(pte, pfn_pte(pfn, __prot));
+		if (pgprot_val(prot) & PTE_VALID)
+			set_pte(pte, pfn_pte(pfn, __prot));
+		else
+			pte_clear(null, null, pte);
+
 		pfn++;
 
 		/*
@@ -334,12 +338,14 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, false);
 }
 
-void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
-			       unsigned long virt, phys_addr_t size,
-			       pgprot_t prot, bool page_mappings_only)
+/*
+ * Note that PAGE_KERNEL_INVALID should be used with page_mappings_only
+ * true for now.
+ */
+void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
+			unsigned long virt, phys_addr_t size,
+			pgprot_t prot, bool page_mappings_only)
 {
-	BUG_ON(mm == &init_mm);
-
 	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
 			     pgd_pgtable_alloc, page_mappings_only);
 }
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
