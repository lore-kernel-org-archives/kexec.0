Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5h-0000gq-HN
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:24:15 +0000
Received: by mail-qk0-f182.google.com with SMTP id z190so253968384qkc.2
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:48 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 08/10] arm64: immunize identity mapped address
 finding w.r.t. kernel changes
Date: Tue, 25 Oct 2016 12:53:00 +0530
Message-Id: <077c409cd377c4ca59b92aa71611d97016a92639.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, sgoel@codeaurora.org, mansip@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org

Kernel mappings may change for vmalloc, vmemmap and module addresses. More
over, proposed kexec arm64 kernel patches do not provide sufficient
information in vmcore to separate out these areas.

Makedumpfile should be able to read entries from swapper page tables
minimally. Virtual address of swapper_pg_dir symbol will always be linearly
translatable. So, using __pa() macro we get physical address of
swapper_pg_dir and then we find physical address of any kernel virtual
address by reading corresponding entries in page table.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c   | 75 +++++++++++++---------------------------------------------
 makedumpfile.h |  3 ++-
 2 files changed, 19 insertions(+), 59 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 6f61b4c5497f..da8f43c62380 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -53,8 +53,6 @@ static int va_bits;
 
 #define PAGE_MASK		(~(PAGESIZE() - 1))
 #define PGDIR_SHIFT		((PAGESHIFT() - 3) * pgtable_level + 3)
-#define PUD_SHIFT		PGDIR_SHIFT
-#define PUD_SIZE		(1UL << PUD_SHIFT)
 #define PTRS_PER_PGD		(1 << (va_bits - PGDIR_SHIFT))
 #define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
 #define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
@@ -77,31 +75,19 @@ static int va_bits;
 #define PMD_TYPE_SECT		1
 #define PMD_TYPE_TABLE		3
 
-#define __va(paddr) 			((paddr) - info->phys_base + PAGE_OFFSET)
 #define __pa(vaddr) 			((vaddr) - PAGE_OFFSET + info->phys_base)
 
 #define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
 
 #define pte_index(vaddr) 		(((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
-#define pmd_page_vaddr(pmd)		(__va(pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK))
-#define pte_offset(dir, vaddr) 		((pte_t*)pmd_page_vaddr((*dir)) + pte_index(vaddr))
+#define pmd_page_paddr(pmd)		(pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK)
+#define pte_offset(dir, vaddr) 		((pte_t*)pmd_page_paddr((*dir)) + pte_index(vaddr))
 
 #define pmd_index(vaddr)		(((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
-#define pud_page_vaddr(pud)		(__va(pud_val(pud) & PHYS_MASK & (int32_t)PAGE_MASK))
+#define pud_page_paddr(pud)		(pud_val(pud) & PHYS_MASK & (int32_t)PAGE_MASK)
 #define pmd_offset_pgtbl_lvl_2(pud, vaddr) ((pmd_t *)pud)
-#define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_vaddr((*pud)) + pmd_index(vaddr))
-
-/* kernel struct page size can be kernel version dependent, currently
- * keep it constant.
- */
-#define KERN_STRUCT_PAGE_SIZE		get_structure_size("page", DWARF_INFO_GET_STRUCT_SIZE)
-
-#define ALIGN(x, a) 			(((x) + (a) - 1) & ~((a) - 1))
-#define PFN_DOWN(x)			((x) >> PAGESHIFT())
-#define VMEMMAP_SIZE			ALIGN((1UL << (va_bits - PAGESHIFT())) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
-#define MODULES_END			PAGE_OFFSET
-#define MODULES_VADDR			(MODULES_END - 0x4000000)
+#define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_paddr((*pud)) + pmd_index(vaddr))
 
 static pmd_t *
 pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
@@ -136,15 +122,10 @@ static int calculate_plat_config(void)
 	return TRUE;
 }
 
-static int
-is_vtop_from_page_table_arm64(unsigned long vaddr)
+unsigned long
+get_kvbase_arm64(void)
 {
-	/* If virtual address lies in vmalloc, vmemmap or module space
-	 * region then, get the physical address from page table.
-	 */
-	return ((vaddr >= VMALLOC_START && vaddr <= VMALLOC_END)
-		|| (vaddr >= VMEMMAP_START && vaddr <= VMEMMAP_END)
-		|| (vaddr >= MODULES_VADDR && vaddr <= MODULES_END));
+	return (0xffffffffffffffffUL << va_bits);
 }
 
 int
@@ -168,20 +149,10 @@ get_machdep_info_arm64(void)
 	info->max_physmem_bits = PHYS_MASK_SHIFT;
 	info->section_size_bits = SECTIONS_SIZE_BITS;
 	info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);
-	info->vmalloc_start = 0xffffffffffffffffUL << va_bits;
-	info->vmalloc_end = PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - 0x10000;
-	info->vmemmap_start = VMALLOC_END + 0x10000;
-	info->vmemmap_end = VMEMMAP_START + VMEMMAP_SIZE;
 
 	DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
 	DEBUG_MSG("section_size_bits: %lx\n", info->section_size_bits);
 	DEBUG_MSG("page_offset      : %lx\n", info->page_offset);
-	DEBUG_MSG("vmalloc_start    : %lx\n", info->vmalloc_start);
-	DEBUG_MSG("vmalloc_end      : %lx\n", info->vmalloc_end);
-	DEBUG_MSG("vmemmap_start    : %lx\n", info->vmemmap_start);
-	DEBUG_MSG("vmemmap_end      : %lx\n", info->vmemmap_end);
-	DEBUG_MSG("modules_start    : %lx\n", MODULES_VADDR);
-	DEBUG_MSG("modules_end      : %lx\n", MODULES_END);
 
 	return TRUE;
 }
@@ -211,17 +182,18 @@ get_versiondep_info_arm64(void)
 }
 
 /*
- * vtop_arm64() - translate arbitrary virtual address to physical
+ * vaddr_to_paddr_arm64() - translate arbitrary virtual address to physical
  * @vaddr: virtual address to translate
  *
  * Function translates @vaddr into physical address using page tables. This
  * address can be any virtual address. Returns physical address of the
  * corresponding virtual address or %NOT_PADDR when there is no translation.
  */
-static unsigned long long
-vtop_arm64(unsigned long vaddr)
+unsigned long long
+vaddr_to_paddr_arm64(unsigned long vaddr)
 {
 	unsigned long long paddr = NOT_PADDR;
+	unsigned long long swapper_phys;
 	pgd_t	*pgda, pgdv;
 	pud_t	*puda, pudv;
 	pmd_t	*pmda, pmdv;
@@ -232,8 +204,10 @@ vtop_arm64(unsigned long vaddr)
 		return NOT_PADDR;
 	}
 
-	pgda = pgd_offset(SYMBOL(swapper_pg_dir), vaddr);
-	if (!readmem(VADDR, (unsigned long long)pgda, &pgdv, sizeof(pgdv))) {
+	swapper_phys = __pa(SYMBOL(swapper_pg_dir));
+
+	pgda = pgd_offset(swapper_phys, vaddr);
+	if (!readmem(PADDR, (unsigned long long)pgda, &pgdv, sizeof(pgdv))) {
 		ERRMSG("Can't read pgd\n");
 		return NOT_PADDR;
 	}
@@ -242,7 +216,7 @@ vtop_arm64(unsigned long vaddr)
 	puda = (pud_t *)pgda;
 
 	pmda = pmd_offset(puda, &pudv, vaddr);
-	if (!readmem(VADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
+	if (!readmem(PADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
 		ERRMSG("Can't read pmd\n");
 		return NOT_PADDR;
 	}
@@ -251,7 +225,7 @@ vtop_arm64(unsigned long vaddr)
 	case PMD_TYPE_TABLE:
 		ptea = pte_offset(&pmdv, vaddr);
 		/* 64k page */
-		if (!readmem(VADDR, (unsigned long long)ptea, &ptev, sizeof(ptev))) {
+		if (!readmem(PADDR, (unsigned long long)ptea, &ptev, sizeof(ptev))) {
 			ERRMSG("Can't read pte\n");
 			return NOT_PADDR;
 		}
@@ -275,19 +249,4 @@ vtop_arm64(unsigned long vaddr)
 	return paddr;
 }
 
-unsigned long long
-vaddr_to_paddr_arm64(unsigned long vaddr)
-{
-	/*
-	 * use translation tables when a) user has explicitly requested us to
-	 * perform translation for a given address. b) virtual address lies in
-	 * vmalloc, vmemmap or modules memory region. Otherwise we assume that
-	 * the translation is done within the kernel direct mapped region.
-	 */
-	if ((info->vaddr_for_vtop == vaddr) ||
-			is_vtop_from_page_table_arm64(vaddr))
-		return vtop_arm64(vaddr);
-
-	return __pa(vaddr);
-}
 #endif /* __aarch64__ */
diff --git a/makedumpfile.h b/makedumpfile.h
index 1a119ac949b6..8ddc2c43cc29 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -516,7 +516,8 @@ do { \
 #define PMASK			(0x7ffffffffffff000UL)
 
 #ifdef __aarch64__
-#define KVBASE			VMALLOC_START
+unsigned long get_kvbase_arm64(void);
+#define KVBASE			get_kvbase_arm64()
 #endif /* aarch64 */
 
 #ifdef __arm__
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
