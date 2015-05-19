Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yubwj-0002X4-RZ
 for kexec@lists.infradead.org; Tue, 19 May 2015 07:28:15 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Support ARM64
Date: Tue, 19 May 2015 07:26:52 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DB50DF@BPXM01GP.gisp.nec.co.jp>
References: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
In-Reply-To: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "panand@redhat.com" <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Pratyush,

>Patch adds support for ARM64 in makedumpfile. It takes care of vmalloc,
>vmemmap, module and directly map kernel memory region's translation.
>
>Currently we only support 2 leverl 64K pages and VA_BITS as 42. Support
>to find these machine specific parameters dynamically and then to act
>accordingly can be added latter.
>
>Signed-off-by: Pratyush Anand <panand@redhat.com>

Thanks for your work, I'll merge this into v1.5.9.


Regards,
Atsushi Kumagai

>---
> Makefile       |   1 +
> arch/arm64.c   | 255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> makedumpfile.h |  48 +++++++++++
> 3 files changed, 304 insertions(+)
> create mode 100644 arch/arm64.c
>
>diff --git a/Makefile b/Makefile
>index 2d2b1b72929a..fc21a3f0e50a 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -49,6 +49,7 @@ SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info
> SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c
> OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
> SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
>+SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
> OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
>
> LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz
>diff --git a/arch/arm64.c b/arch/arm64.c
>new file mode 100644
>index 000000000000..23aabf09b332
>--- /dev/null
>+++ b/arch/arm64.c
>@@ -0,0 +1,255 @@
>+/*
>+ * arch/arm64.c : Based on arch/arm.c
>+ *
>+ * Copyright (C) 2015 Red Hat, Pratyush Anand <panand@redhat.com>
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License as published by
>+ * the Free Software Foundation (version 2 of the License).
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>+ */
>+
>+#ifdef __aarch64__
>+
>+#include "../elf_info.h"
>+#include "../makedumpfile.h"
>+#include "../print_info.h"
>+
>+#if CONFIG_ARM64_PGTABLE_LEVELS == 2
>+typedef struct {
>+	unsigned long pgd;
>+} pgd_t;
>+
>+typedef struct {
>+	pgd_t pgd;
>+} pud_t;
>+
>+typedef struct {
>+	pud_t pud;
>+} pmd_t;
>+
>+#define pud_offset(pgd, vaddr) 	((pud_t *)pgd)
>+#define pmd_offset(pud, vaddr) 	((pmd_t *)pud)
>+#define pgd_val(x)		((x).pgd)
>+#define pud_val(x)		(pgd_val((x).pgd))
>+#define pmd_val(x)		(pud_val((x).pud))
>+
>+#define PUD_SHIFT		PGDIR_SHIFT
>+#define PUD_SIZE		(1UL << PUD_SHIFT)
>+
>+#endif
>+
>+typedef struct {
>+	unsigned long pte;
>+} pte_t;
>+#define pte_val(x)		((x).pte)
>+
>+#define PAGE_SIZE		(1UL << PAGE_SHIFT)
>+#define PAGE_MASK		(~(PAGE_SIZE - 1))
>+#define PGDIR_SHIFT		((PAGE_SHIFT - 3) * ARM64_PGTABLE_LEVELS + 3)
>+#define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
>+#define PMD_SHIFT		((PAGE_SHIFT - 3) * 2 + 3)
>+#define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
>+#define PMD_SHIFT		((PAGE_SHIFT - 3) * 2 + 3)
>+#define PMD_SIZE		(1UL << PMD_SHIFT)
>+#define PMD_MASK		(~(PMD_SIZE - 1))
>+#define PTRS_PER_PMD		PTRS_PER_PTE
>+
>+#define PAGE_PRESENT		(1 << 0)
>+#define SECTIONS_SIZE_BITS	30
>+/*
>+
>+* Highest possible physical address supported.
>+*/
>+#define PHYS_MASK_SHIFT		48
>+#define PHYS_MASK		((1UL << PHYS_MASK_SHIFT) - 1)
>+
>+#define PMD_TYPE_MASK		3
>+#define PMD_TYPE_SECT		1
>+#define PMD_TYPE_TABLE		3
>+
>+#define __va(paddr) 			((paddr) - info->phys_base + PAGE_OFFSET)
>+#define __pa(vaddr) 			((vaddr) - PAGE_OFFSET + info->phys_base)
>+
>+#define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>+#define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
>+
>+#define pte_index(addr) 		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
>+#define pmd_page_vaddr(pmd)		(__va(pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK))
>+#define pte_offset(dir, vaddr) 		((pte_t*)pmd_page_vaddr((*dir)) + pte_index(vaddr))
>+
>+/* kernel struct page size can be kernel version dependent, currently
>+ * keep it constant.
>+ */
>+#define KERN_STRUCT_PAGE_SIZE		64
>+#define ALIGN(x, a) 			(((x) + (a) - 1) & ~((a) - 1))
>+#define PFN_DOWN(x)			((x) >> PAGE_SHIFT)
>+#define VMEMMAP_SIZE			ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
>+#define MODULES_END			PAGE_OFFSET
>+#define MODULES_VADDR			(MODULES_END - 0x4000000)
>+
>+
>+static int is_vtop_from_page_table_arm64(unsigned long vaddr)
>+{
>+	/* If virtual address lies in vmalloc, vmemmap or module space
>+	 * region then, get the physical address from page table.
>+	 */
>+	return ((vaddr >= VMALLOC_START && vaddr <= VMALLOC_END)
>+		|| (vaddr >= VMEMMAP_START && vaddr <= VMEMMAP_END)
>+		|| (vaddr >= MODULES_VADDR && vaddr <= MODULES_END));
>+}
>+
>+int get_phys_base_arm64(void)
>+{
>+	unsigned long phys_base = ULONG_MAX;
>+	unsigned long long phys_start;
>+	int i;
>+	/*
>+	 * We resolve phys_base from PT_LOAD segments. LMA contains physical
>+	 * address of the segment, and we use the lowest start as
>+	 * phys_base.
>+	 */
>+	for (i = 0; get_pt_load(i, &phys_start, NULL, NULL, NULL); i++) {
>+		if (phys_start < phys_base)
>+			phys_base = phys_start;
>+	}
>+
>+	if (phys_base == ULONG_MAX) {
>+		ERRMSG("Can't determine phys_base\n");
>+		return FALSE;
>+	}
>+
>+	info->phys_base = phys_base;
>+
>+	DEBUG_MSG("phys_base    : %lx\n", phys_base);
>+
>+	return TRUE;
>+}
>+
>+int get_machdep_info_arm64(void)
>+{
>+	info->max_physmem_bits = PHYS_MASK_SHIFT;
>+	info->section_size_bits = SECTIONS_SIZE_BITS;
>+	info->page_offset = KVBASE;
>+	info->vmalloc_start = 0xffffffffffffffffUL << VA_BITS;
>+	info->vmalloc_end = PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - 0x10000;
>+	info->vmemmap_start = VMALLOC_END + 0x10000;
>+	info->vmemmap_end = VMEMMAP_START + VMEMMAP_SIZE;
>+
>+	DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
>+	DEBUG_MSG("section_size_bits: %lx\n", info->section_size_bits);
>+	DEBUG_MSG("page_offset      : %lx\n", info->page_offset);
>+	DEBUG_MSG("vmalloc_start    : %lx\n", info->vmalloc_start);
>+	DEBUG_MSG("vmalloc_end      : %lx\n", info->vmalloc_end);
>+	DEBUG_MSG("vmemmap_start    : %lx\n", info->vmemmap_start);
>+	DEBUG_MSG("vmemmap_end      : %lx\n", info->vmemmap_end);
>+	DEBUG_MSG("modules_start    : %lx\n", MODULES_VADDR);
>+	DEBUG_MSG("modules_end      : %lx\n", MODULES_END);
>+
>+	return TRUE;
>+}
>+
>+unsigned long long kvtop_xen_arm64(unsigned long kvaddr)
>+{
>+	return ERROR;
>+}
>+
>+int get_xen_basic_info_arm64(void)
>+{
>+	return ERROR;
>+}
>+
>+int get_xen_info_arm64(void)
>+{
>+	return ERROR;
>+}
>+
>+int get_versiondep_info_arm64(void)
>+{
>+	return TRUE;
>+}
>+
>+/*
>+ * vtop_arm64() - translate arbitrary virtual address to physical
>+ * @vaddr: virtual address to translate
>+ *
>+ * Function translates @vaddr into physical address using page tables. This
>+ * address can be any virtual address. Returns physical address of the
>+ * corresponding virtual address or %NOT_PADDR when there is no translation.
>+ */
>+static unsigned long long vtop_arm64(unsigned long vaddr)
>+{
>+	unsigned long long paddr = NOT_PADDR;
>+	pgd_t	*pgda, pgdv;
>+	pud_t	*puda;
>+	pmd_t	*pmda, pmdv;
>+	pte_t 	*ptea, ptev;
>+
>+	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
>+		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
>+		return NOT_PADDR;
>+	}
>+
>+	pgda = pgd_offset(SYMBOL(swapper_pg_dir), vaddr);
>+	if (!readmem(VADDR, (unsigned long long)pgda, &pgdv, sizeof(pgdv))) {
>+		ERRMSG("Can't read pgd\n");
>+		return NOT_PADDR;
>+	}
>+
>+	puda = pud_offset(pgda, vaddr);
>+	pmda = pmd_offset(puda, vaddr);
>+	if (!readmem(VADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
>+		ERRMSG("Can't read pmd\n");
>+		return NOT_PADDR;
>+	}
>+
>+	switch (pmd_val(pmdv) & PMD_TYPE_MASK) {
>+	case PMD_TYPE_TABLE:
>+		ptea = pte_offset(&pmdv, vaddr);
>+		/* 64k page */
>+		if (!readmem(VADDR, (unsigned long long)ptea, &ptev, sizeof(ptev))) {
>+			ERRMSG("Can't read pte\n");
>+			return NOT_PADDR;
>+		}
>+
>+		if (!(pte_val(ptev) & PAGE_PRESENT)) {
>+			ERRMSG("Can't get a valid pte.\n");
>+			return NOT_PADDR;
>+		} else {
>+
>+			paddr = (PAGEBASE(pte_val(ptev)) & PHYS_MASK)
>+					+ (vaddr & (PAGESIZE() - 1));
>+		}
>+		break;
>+	case PMD_TYPE_SECT:
>+		/* 1GB section */
>+		paddr = (pmd_val(pmdv) & PMD_MASK) + (vaddr & (PMD_SIZE - 1));
>+		break;
>+	}
>+
>+	return paddr;
>+}
>+
>+unsigned long long vaddr_to_paddr_arm64(unsigned long vaddr)
>+{
>+	/*
>+	 * use translation tables when a) user has explicitly requested us to
>+	 * perform translation for a given address. b) virtual address lies in
>+	 * vmalloc, vmemmap or modules memory region. Otherwise we assume that
>+	 * the translation is done within the kernel direct mapped region.
>+	 */
>+	if ((info->vaddr_for_vtop == vaddr) ||
>+			is_vtop_from_page_table_arm64(vaddr))
>+		return vtop_arm64(vaddr);
>+
>+	return __pa(vaddr);
>+}
>+#endif
>diff --git a/makedumpfile.h b/makedumpfile.h
>index d2fadbd1f985..92a2bb629bcb 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -483,6 +483,33 @@ do { \
> #define VMEMMAP_START		(info->vmemmap_start)
> #define VMEMMAP_END		(info->vmemmap_end)
>
>+#ifdef __aarch64__
>+#define CONFIG_ARM64_PGTABLE_LEVELS	2
>+#define CONFIG_ARM64_VA_BITS		42
>+#define CONFIG_ARM64_64K_PAGES		1
>+
>+/* Currently we only suport following defines based on above
>+ * config definitions.
>+ * TODOs: We need to find a way to get above defines dynamically and
>+ * then to support following definitions based on that
>+ */
>+
>+#if CONFIG_ARM64_PGTABLE_LEVELS == 2
>+#define ARM64_PGTABLE_LEVELS	2
>+#endif
>+
>+#if CONFIG_ARM64_VA_BITS == 42
>+#define VA_BITS			42
>+#endif
>+
>+#ifdef CONFIG_ARM64_64K_PAGES
>+#define PAGE_SHIFT		16
>+#endif
>+
>+#define KVBASE_MASK		(0xffffffffffffffffUL << (VA_BITS - 1))
>+#define KVBASE			(SYMBOL(_stext) & KVBASE_MASK)
>+#endif /* aarch64 */
>+
> #ifdef __arm__
> #define KVBASE_MASK		(0xffff)
> #define KVBASE			(SYMBOL(_stext) & ~KVBASE_MASK)
>@@ -761,6 +788,22 @@ do { \
>  */
> static inline int stub_true() { return TRUE; }
> static inline int stub_true_ul(unsigned long x) { return TRUE; }
>+#ifdef __aarch64__
>+int get_phys_base_arm64(void);
>+int get_machdep_info_arm64(void);
>+unsigned long long vaddr_to_paddr_arm64(unsigned long vaddr);
>+int get_versiondep_info_arm64(void);
>+int get_xen_basic_info_arm64(void);
>+int get_xen_info_arm64(void);
>+#define vaddr_to_paddr(X)	vaddr_to_paddr_arm64(X)
>+#define get_phys_base()		get_phys_base_arm64()
>+#define get_machdep_info()	get_machdep_info_arm64()
>+#define get_versiondep_info()	get_versiondep_info_arm64()
>+#define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
>+#define get_xen_info_arch(X) get_xen_info_arm64(X)
>+#define is_phys_addr(X)		stub_true_ul(X)
>+#endif /* aarch64 */
>+
> #ifdef __arm__
> int get_phys_base_arm(void);
> int get_machdep_info_arm(void);
>@@ -1608,6 +1651,11 @@ struct domain_list {
> #define PAGES_PER_MAPWORD 	(sizeof(unsigned long) * 8)
> #define MFNS_PER_FRAME		(info->page_size / sizeof(unsigned long))
>
>+#ifdef __aarch64__
>+unsigned long long kvtop_xen_arm64(unsigned long kvaddr);
>+#define kvtop_xen(X)	kvtop_xen_arm64(X)
>+#endif /* aarch64 */
>+
> #ifdef __arm__
> #define kvtop_xen(X)	FALSE
> #define get_xen_basic_info_arch(X) FALSE
>--
>2.1.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
