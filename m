Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1boywJ-00016j-Bh
 for kexec@lists.infradead.org; Tue, 27 Sep 2016 20:25:20 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RKMRrT036391
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:59 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qxu1tbg5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:58 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 06:24:56 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A39F02CE8056
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:24:52 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RKOqIH7078304
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:24:52 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RKOqYa028467
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:24:52 +1000
Subject: [PATCH 8/8] ppc64: enable address translation support for radix mmu
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 01:54:48 +0530
In-Reply-To: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
References: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147500788806.31772.10502950728533678809.stgit@hbathini.in.ibm.com>
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
To: Kexec-ml <kexec@lists.infradead.org>
Cc: Ken'ichi <oomichi@mxs.nes.nec.co.jp>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

As both radix and hash MMU are supported in a single kernel on
Power ISA 3.0 based server processors, identify the current MMU
type and set page table index values accordingly.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |   47 +++++++++++++++++++++++++++++++++++++++++------
 makedumpfile.c |   11 +++++++++++
 makedumpfile.h |   39 ++++++++++++++++++++++++++++++---------
 3 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 40076eb..6aeab7e 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -237,7 +237,13 @@ ppc64_vmalloc_init(void)
 		/*
 		 * 64K pagesize
 		 */
-		if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+		if (info->cur_mmu_type & RADIX_MMU) {
+			info->l1_index_size = PTE_INDEX_SIZE_RADIX_64K;
+			info->l2_index_size = PMD_INDEX_SIZE_RADIX_64K;
+			info->l3_index_size = PUD_INDEX_SIZE_RADIX_64K;
+			info->l4_index_size = PGD_INDEX_SIZE_RADIX_64K;
+
+		} else if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
 			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
 			info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_6;
@@ -272,11 +278,19 @@ ppc64_vmalloc_init(void)
 		/*
 		 * 4K pagesize
 		 */
-		info->l1_index_size = PTE_INDEX_SIZE_L4_4K;
-		info->l2_index_size = PMD_INDEX_SIZE_L4_4K;
-		info->l3_index_size = (info->kernel_version >= KERNEL_VERSION(3, 7, 0) ?
-			PUD_INDEX_SIZE_L4_4K_3_7 : PUD_INDEX_SIZE_L4_4K);
-		info->l4_index_size = PGD_INDEX_SIZE_L4_4K;
+		if (info->cur_mmu_type & RADIX_MMU) {
+			info->l1_index_size = PTE_INDEX_SIZE_RADIX_4K;
+			info->l2_index_size = PMD_INDEX_SIZE_RADIX_4K;
+			info->l3_index_size = PUD_INDEX_SIZE_RADIX_4K;
+			info->l4_index_size = PGD_INDEX_SIZE_RADIX_4K;
+
+		} else {
+			info->l1_index_size = PTE_INDEX_SIZE_L4_4K;
+			info->l2_index_size = PMD_INDEX_SIZE_L4_4K;
+			info->l3_index_size = (info->kernel_version >= KERNEL_VERSION(3, 7, 0) ?
+				PUD_INDEX_SIZE_L4_4K_3_7 : PUD_INDEX_SIZE_L4_4K);
+			info->l4_index_size = PGD_INDEX_SIZE_L4_4K;
+		}
 
 		info->pte_rpn_shift = (info->kernel_version >= KERNEL_VERSION(4, 5, 0) ?
 			PTE_RPN_SHIFT_L4_4K_4_5 : PTE_RPN_SHIFT_L4_4K);
@@ -537,6 +551,27 @@ get_machdep_info_ppc64(void)
 int
 get_versiondep_info_ppc64()
 {
+	unsigned long cur_cpu_spec;
+	uint mmu_features;
+
+	/*
+	 * On PowerISA 3.0 based server processors, a kernel can run with
+	 * radix MMU or standard MMU. Get the current MMU type.
+	 */
+	info->cur_mmu_type = STD_MMU;
+	if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
+	    && (OFFSET(cpu_spec.mmu_features) != NOT_FOUND_STRUCTURE)) {
+		if (readmem(VADDR, SYMBOL(cur_cpu_spec), &cur_cpu_spec,
+		    sizeof(cur_cpu_spec))) {
+			if (readmem(VADDR, cur_cpu_spec + OFFSET(cpu_spec.mmu_features),
+			    &mmu_features, sizeof(mmu_features)))
+				info->cur_mmu_type = mmu_features & RADIX_MMU;
+		}
+	}
+
+	/*
+	 * Initialize Linux page table info
+	 */
 	if (ppc64_vmalloc_init() == FALSE) {
 		ERRMSG("Can't initialize for vmalloc translation\n");
 		return FALSE;
diff --git a/makedumpfile.c b/makedumpfile.c
index d168dfd..c4b3c62 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1567,6 +1567,7 @@ get_symbol_info(void)
 
 	SYMBOL_INIT(cpu_pgd, "cpu_pgd");
 	SYMBOL_INIT(demote_segment_4k, "demote_segment_4k");
+	SYMBOL_INIT(cur_cpu_spec, "cur_cpu_spec");
 
 	return TRUE;
 }
@@ -1949,6 +1950,12 @@ get_structure_info(void)
 	SIZE_INIT(mmu_psize_def, "mmu_psize_def");
 	OFFSET_INIT(mmu_psize_def.shift, "mmu_psize_def", "shift");
 
+	/*
+	 * Get offsets of the cpu_spec's members.
+	 */
+	SIZE_INIT(cpu_spec, "cpu_spec");
+	OFFSET_INIT(cpu_spec.mmu_features, "cpu_spec", "mmu_features");
+
 	return TRUE;
 }
 
@@ -2151,6 +2158,7 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
 	WRITE_SYMBOL("cpu_pgd", cpu_pgd);
 	WRITE_SYMBOL("demote_segment_4k", demote_segment_4k);
+	WRITE_SYMBOL("cur_cpu_spec", cur_cpu_spec);
 	WRITE_SYMBOL("free_huge_page", free_huge_page);
 
 	/*
@@ -2226,6 +2234,7 @@ write_vmcoreinfo_data(void)
 	    vmemmap_backing.virt_addr);
 	WRITE_MEMBER_OFFSET("vmemmap_backing.list", vmemmap_backing.list);
 	WRITE_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
+	WRITE_MEMBER_OFFSET("cpu_spec.mmu_features", cpu_spec.mmu_features);
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		WRITE_ARRAY_LENGTH("node_data", node_data);
@@ -2503,6 +2512,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
 	READ_SYMBOL("cpu_pgd", cpu_pgd);
 	READ_SYMBOL("demote_segment_4k", demote_segment_4k);
+	READ_SYMBOL("cur_cpu_spec", cur_cpu_spec);
 	READ_SYMBOL("free_huge_page", free_huge_page);
 
 	READ_STRUCTURE_SIZE("page", page);
@@ -2561,6 +2571,7 @@ read_vmcoreinfo(void)
 	    vmemmap_backing.virt_addr);
 	READ_MEMBER_OFFSET("vmemmap_backing.list", vmemmap_backing.list);
 	READ_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
+	READ_MEMBER_OFFSET("cpu_spec.mmu_features", cpu_spec.mmu_features);
 
 	READ_STRUCTURE_SIZE("printk_log", printk_log);
 	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
diff --git a/makedumpfile.h b/makedumpfile.h
index 69747c0..a5955ff 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -633,6 +633,10 @@ int get_va_bits_arm64(void);
 #define PUD_INDEX_SIZE_L4_4K  7
 #define PGD_INDEX_SIZE_L4_4K  9
 #define PUD_INDEX_SIZE_L4_4K_3_7  9
+#define PTE_INDEX_SIZE_RADIX_4K  9
+#define PMD_INDEX_SIZE_RADIX_4K  9
+#define PUD_INDEX_SIZE_RADIX_4K  9
+#define PGD_INDEX_SIZE_RADIX_4K  13
 #define PTE_RPN_SHIFT_L4_4K  17
 #define PTE_RPN_SHIFT_L4_4K_4_5  18
 #define PGD_MASKED_BITS_4K  0
@@ -649,6 +653,10 @@ int get_va_bits_arm64(void);
 #define PGD_INDEX_SIZE_L4_64K_3_10  12
 #define PMD_INDEX_SIZE_L4_64K_4_6  5
 #define PUD_INDEX_SIZE_L4_64K_4_6  5
+#define PTE_INDEX_SIZE_RADIX_64K  5
+#define PMD_INDEX_SIZE_RADIX_64K  9
+#define PUD_INDEX_SIZE_RADIX_64K  9
+#define PGD_INDEX_SIZE_RADIX_64K  13
 #define PTE_RPN_SHIFT_L4_64K_V1  32
 #define PTE_RPN_SHIFT_L4_64K_V2  30
 #define PGD_MASKED_BITS_64K  0
@@ -668,6 +676,17 @@ int get_va_bits_arm64(void);
 #define PUD_MASKED_BITS_4_7  0xc0000000000000ffUL
 #define PMD_MASKED_BITS_4_7  0xc0000000000000ffUL
 
+/*
+ * Supported MMU types
+ */
+#define STD_MMU         0x0
+/*
+ * The flag bit for radix MMU in cpu_spec.mmu_features
+ * in the kernel. Use the same flag here.
+ */
+#define RADIX_MMU       0x40
+
+
 #define PGD_MASK_L4		\
 	(info->kernel_version >= KERNEL_VERSION(3, 10, 0) ? (info->ptrs_per_pgd - 1) : 0x1ff)
 #define PGD_OFFSET_L4(vaddr)	((vaddr >> (info->l4_shift)) & PGD_MASK_L4)
@@ -1129,6 +1148,7 @@ struct DumpInfo {
 	/*
 	 * page table info for ppc64
 	 */
+	int		cur_mmu_type;
 	int		ptrs_per_pgd;
 	uint		l4_index_size;
 	uint		l3_index_size;
@@ -1438,17 +1458,14 @@ struct symbol_table {
 	unsigned long long	kexec_crash_image;
 
 	/*
-	 * vmemmap symbols on ppc64 arch
+	 * symbols on ppc64 arch
 	 */
 	unsigned long long		vmemmap_list;
 	unsigned long long		mmu_vmemmap_psize;
 	unsigned long long		mmu_psize_defs;
-
-	/*
-	 * vm related symbols for ppc64 arch
-	 */
 	unsigned long long		cpu_pgd;
 	unsigned long long		demote_segment_4k;
+	unsigned long long		cur_cpu_spec;
 };
 
 struct size_table {
@@ -1485,10 +1502,11 @@ struct size_table {
 	long	elf64_hdr;
 
 	/*
-	 * vmemmap symbols on ppc64 arch
+	 * symbols on ppc64 arch
 	 */
 	long	vmemmap_backing;
 	long	mmu_psize_def;
+	long	cpu_spec;
 
 	long	pageflags;
 };
@@ -1637,18 +1655,21 @@ struct offset_table {
 	} printk_log;
 
 	/*
-	 * vmemmap symbols on ppc64 arch
+	 * symbols on ppc64 arch
 	 */
-	struct mmu_psize_def {
+	struct mmu_psize_def_s {
 		long	shift;
 	} mmu_psize_def;
 
-	struct vmemmap_backing {
+	struct vmemmap_backing_s {
 		long	phys;
 		long	virt_addr;
 		long	list;
 	} vmemmap_backing;
 
+	struct cpu_spec_s {
+		long	mmu_features;
+	} cpu_spec;
 };
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
