Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X7mX3-0003GE-4Z
 for kexec@lists.infradead.org; Thu, 17 Jul 2014 14:19:38 +0000
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 18 Jul 2014 00:19:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 670DE3578052
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:19:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6HEIsva11469176
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:18:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6HEJ9fo026135
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:19:09 +1000
Subject: [PATCH 1/2] makedumpfile: Initialize for vmalloc address
 translation support in PPC64 arch
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 17 Jul 2014 19:49:07 +0530
Message-ID: <20140717141907.8955.74650.stgit@localhost.localdomain>
In-Reply-To: <20140717141827.8955.95825.stgit@localhost.localdomain>
References: <20140717141827.8955.95825.stgit@localhost.localdomain>
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
To: Kexec-ml <kexec@lists.infradead.org>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Ken'ichi <oomichi@mxs.nes.nec.co.jp>

In this patch, initializing of page table information that is to be
used for virtual to physical address translation  of vmalloc region
is added to the initialization sequence.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |    7 +++++
 makedumpfile.h |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 09c0eb3..dabf2e7 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -149,6 +149,58 @@ ppc64_vmemmap_init(void)
 	return TRUE;
 }
 
+static int
+ppc64_vmalloc_init(void)
+{
+	info->page_buf = (char *)calloc(1, PAGESIZE());
+	if (info->page_buf == NULL) {
+		ERRMSG("Can't allocate memory for page tables. %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
+
+	/* 2.6.14 layout */
+	if (info->page_size == 65536) {
+		/* 64K pagesize */
+		if (info->kernel_version >= KERNEL_VERSION(3, 10, 0)) {
+			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
+			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_3_10;
+			info->l3_index_size = PUD_INDEX_SIZE_L4_64K;
+		} else {
+			info->l1_index_size = PTE_INDEX_SIZE_L4_64K;
+			info->l2_index_size = PMD_INDEX_SIZE_L4_64K;
+			info->l3_index_size = PUD_INDEX_SIZE_L4_64K;
+		}
+
+		info->pte_shift = SYMBOL(demote_segment_4k) ?
+			PTE_SHIFT_L4_64K_V2 : PTE_SHIFT_L4_64K_V1;
+		info->l2_masked_bits = PMD_MASKED_BITS_64K;
+	} else {
+		/* 4K pagesize */
+		info->l1_index_size = PTE_INDEX_SIZE_L4_4K;
+		info->l2_index_size = PMD_INDEX_SIZE_L4_4K;
+		info->l3_index_size = PUD_INDEX_SIZE_L4_4K;
+
+		info->pte_shift = PTE_SHIFT_L4_4K;
+		info->l2_masked_bits = PMD_MASKED_BITS_4K;
+	}
+
+	/* Compute ptrs per each level */
+	info->l1_shift = info->page_shift;
+	info->ptrs_per_l1 = (1 << info->l1_index_size);
+	info->ptrs_per_l2 = (1 << info->l2_index_size);
+	info->ptrs_per_l3 = (1 << info->l3_index_size);
+
+	info->ptrs_per_pgd = info->ptrs_per_l3;
+
+	/* Compute shifts */
+	info->l2_shift = info->l1_shift + info->l1_index_size;
+	info->l3_shift = info->l2_shift + info->l2_index_size;
+	info->l4_shift = info->l3_shift + info->l3_index_size;
+
+	return TRUE;
+}
+
 /*
  *  If the vmemmap address translation information is stored in the kernel,
  *  make the translation.
@@ -251,6 +303,15 @@ get_machdep_info_ppc64(void)
 	info->vmalloc_start = vmalloc_start;
 	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
 
+	if (SYMBOL(swapper_pg_dir) != NOT_FOUND_SYMBOL) {
+		info->kernel_pgd = SYMBOL(swapper_pg_dir);
+	} else if (SYMBOL(cpu_pgd) != NOT_FOUND_SYMBOL) {
+		info->kernel_pgd = SYMBOL(cpu_pgd);
+	} else {
+		ERRMSG("No swapper_pg_dir or cpu_pgd symbols exist\n");
+		return FALSE;
+	}
+
 	if (SYMBOL(vmemmap_list) != NOT_FOUND_SYMBOL) {
 		info->vmemmap_start = VMEMMAP_REGION_ID << REGION_SHIFT;
 		info->vmemmap_end = info->vmemmap_start;
@@ -265,6 +326,17 @@ get_machdep_info_ppc64(void)
 }
 
 int
+get_versiondep_info_ppc64()
+{
+	if (ppc64_vmalloc_init() == FALSE) {
+		ERRMSG("Can't initialize for vmalloc translation\n");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+int
 is_vmalloc_addr_ppc64(unsigned long vaddr)
 {
 	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
diff --git a/makedumpfile.c b/makedumpfile.c
index 3884aa5..f54ff8f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1181,6 +1181,9 @@ get_symbol_info(void)
 	SYMBOL_INIT(mmu_psize_defs, "mmu_psize_defs");
 	SYMBOL_INIT(mmu_vmemmap_psize, "mmu_vmemmap_psize");
 
+	SYMBOL_INIT(cpu_pgd, "cpu_pgd");
+	SYMBOL_INIT(demote_segment_4k, "demote_segment_4k");
+
 	return TRUE;
 }
 
@@ -1694,6 +1697,8 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("vmemmap_list", vmemmap_list);
 	WRITE_SYMBOL("mmu_psize_defs", mmu_psize_defs);
 	WRITE_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
+	WRITE_SYMBOL("cpu_pgd", cpu_pgd);
+	WRITE_SYMBOL("demote_segment_4k", demote_segment_4k);
 
 	/*
 	 * write the structure size of 1st kernel
@@ -2033,6 +2038,8 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("vmemmap_list", vmemmap_list);
 	READ_SYMBOL("mmu_psize_defs", mmu_psize_defs);
 	READ_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
+	READ_SYMBOL("cpu_pgd", cpu_pgd);
+	READ_SYMBOL("demote_segment_4k", demote_segment_4k);
 
 	READ_STRUCTURE_SIZE("page", page);
 	READ_STRUCTURE_SIZE("mem_section", mem_section);
diff --git a/makedumpfile.h b/makedumpfile.h
index 9402f05..7816241 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -586,6 +586,58 @@ do { \
 #define _MAX_PHYSMEM_BITS_3_7   (46)
 #define REGION_SHIFT            (60UL)
 #define VMEMMAP_REGION_ID       (0xfUL)
+
+#define PGDIR_SHIFT	\
+	(info->page_shift + (info->page_shift -3) + (info->page_shift - 2))
+#define PMD_SHIFT       (info->page_shift + (info->page_shift - 3))
+
+/* shift to put page number into pte */
+#define PTE_SHIFT 16
+
+#define PTE_INDEX_SIZE  9
+#define PMD_INDEX_SIZE  10
+#define PGD_INDEX_SIZE  10
+
+#define PTRS_PER_PTE    (1 << PTE_INDEX_SIZE)
+#define PTRS_PER_PMD    (1 << PMD_INDEX_SIZE)
+#define PTRS_PER_PGD    (1 << PGD_INDEX_SIZE)
+
+#define PGD_OFFSET(vaddr)       ((vaddr >> PGDIR_SHIFT) & 0x7ff)
+#define PMD_OFFSET(vaddr)       ((vaddr >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
+/* 4-level page table support */
+
+/* 4K pagesize */
+#define PTE_INDEX_SIZE_L4_4K  9
+#define PMD_INDEX_SIZE_L4_4K  7
+#define PUD_INDEX_SIZE_L4_4K  7
+#define PGD_INDEX_SIZE_L4_4K  9
+#define PTE_SHIFT_L4_4K  17
+#define PMD_MASKED_BITS_4K  0
+
+/* 64K pagesize */
+#define PTE_INDEX_SIZE_L4_64K   12
+#define PMD_INDEX_SIZE_L4_64K   12
+#define PUD_INDEX_SIZE_L4_64K   0
+#define PGD_INDEX_SIZE_L4_64K   4
+#define PTE_INDEX_SIZE_L4_64K_3_10  8
+#define PMD_INDEX_SIZE_L4_64K_3_10  10
+#define PGD_INDEX_SIZE_L4_64K_3_10  12
+#define PTE_SHIFT_L4_64K_V1  32
+#define PTE_SHIFT_L4_64K_V2  30
+#define PMD_MASKED_BITS_64K  0x1ff
+
+#define L4_MASK		\
+	(info->kernel_version >= KERNEL_VERSION(3, 10, 0) ? 0xfff : 0x1ff)
+#define L4_OFFSET(vaddr)	((vaddr >> (info->l4_shift)) & L4_MASK)
+
+#define PGD_OFFSET_L4(vaddr)	\
+	((vaddr >> (info->l3_shift)) & (info->ptrs_per_l3 - 1))
+
+#define PMD_OFFSET_L4(vaddr)	\
+	((vaddr >> (info->l2_shift)) & (info->ptrs_per_l2 - 1))
+
+#define _PAGE_PRESENT		0x1UL
 #endif
 
 #ifdef __powerpc32__
@@ -731,10 +783,11 @@ unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
 
 #ifdef __powerpc64__ /* powerpc64 */
 int get_machdep_info_ppc64(void);
+int get_versiondep_info_ppc64(void);
 unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
 #define get_phys_base()		TRUE
 #define get_machdep_info()	get_machdep_info_ppc64()
-#define get_versiondep_info()	TRUE
+#define get_versiondep_info()	get_versiondep_info_ppc64()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
 #endif          /* powerpc64 */
 
@@ -932,6 +985,25 @@ struct DumpInfo {
 	struct ppc64_vmemmap	*vmemmap_list;
 
 	/*
+	 * page table info for ppc64
+	 */
+	int		ptrs_per_pgd;
+	uint		l3_index_size;
+	uint		l2_index_size;
+	uint		l1_index_size;
+	uint		ptrs_per_l3;
+	uint		ptrs_per_l2;
+	uint		ptrs_per_l1;
+	uint		l4_shift;
+	uint		l3_shift;
+	uint		l2_shift;
+	uint		l1_shift;
+	uint		pte_shift;
+	uint		l2_masked_bits;
+	ulong		kernel_pgd;
+	char		*page_buf; /* A page buffer to hold page table data */
+
+	/*
 	 * Filter config file containing filter commands to filter out kernel
 	 * data from vmcore.
 	 */
@@ -1192,6 +1264,12 @@ struct symbol_table {
 	unsigned long long		vmemmap_list;
 	unsigned long long		mmu_vmemmap_psize;
 	unsigned long long		mmu_psize_defs;
+
+	/*
+	 * vm related symbols for ppc64 arch
+	 */
+	unsigned long long		cpu_pgd;
+	unsigned long long		demote_segment_4k;
 };
 
 struct size_table {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
