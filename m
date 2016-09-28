Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bp7Cp-0000yH-O5
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 05:14:57 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S5ChN5144065
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:36 -0400
Received: from e28smtp03.in.ibm.com ([125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qxu2c6ww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:36 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 10:44:28 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B93413940033
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:25 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S5EE2j27852932
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:14 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S5EO3H022830
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:25 +0530
Subject: [RESEND PATCH 5/8] makedumpfile/ppc64: use physical addresses and
 unfold pud for 64K page size
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 10:44:23 +0530
In-Reply-To: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
References: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147503965731.1199.13549001279613827412.stgit@hbathini.in.ibm.com>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

Starting with kernel v4.6, Linux page tables store physical addresses
in upper page table tree levels for server processors. Also, for 64K
pagesize, Linux page table is switched to 4-level (PUD not folded) to
support both hash and radix page tables in a single kernel. This patch
updates the corresponding changes here.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h |   20 +++++++++++
 2 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index dc8f0f2..69f6348 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -25,6 +25,68 @@
 #include "../makedumpfile.h"
 
 /*
+ * Convert physical address to kernel virtual address
+ */
+static inline ulong paddr_to_vaddr_ppc64(ulong paddr)
+{
+	return (paddr + info->kernel_start);
+}
+
+/*
+ * Convert the raw pgd entry to next pgtable adress
+ */
+static inline ulong pgd_page_vaddr_l4(ulong pgd)
+{
+	ulong pgd_val;
+
+	pgd_val = (pgd & ~info->pgd_masked_bits);
+	if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+		/*
+		 * physical address is stored starting from kernel v4.6
+		 */
+		pgd_val = paddr_to_vaddr_ppc64(pgd_val);
+	}
+
+	return pgd_val;
+}
+
+/*
+ * Convert the raw pud entry to next pgtable adress
+ */
+static inline ulong pud_page_vaddr_l4(ulong pud)
+{
+	ulong pud_val;
+
+	pud_val = (pud & ~info->pud_masked_bits);
+	if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+		/*
+		 * physical address is stored starting from kernel v4.6
+		 */
+		pud_val = paddr_to_vaddr_ppc64(pud_val);
+	}
+
+	return pud_val;
+}
+
+/*
+ * Convert the raw pmd entry to next pgtable adress
+ */
+static inline ulong pmd_page_vaddr_l4(ulong pmd)
+{
+	ulong pmd_val;
+
+	pmd_val = (pmd & ~info->pmd_masked_bits);
+	if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+		/*
+		 * physical address is stored starting from kernel v4.6
+		 */
+		pmd_val = paddr_to_vaddr_ppc64(pmd_val);
+	}
+
+	return pmd_val;
+}
+
+/*
  * This function traverses vmemmap list to get the count of vmemmap regions
  * and populates the regions' info in info->vmemmap_list[]
  */
@@ -156,7 +218,13 @@ ppc64_vmalloc_init(void)
 		/*
 		 * 64K pagesize
 		 */
-		if (info->kernel_version >= KERNEL_VERSION(3, 10, 0)) {
+		if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
+			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
+			info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_6;
+			info->l4_index_size = PGD_INDEX_SIZE_L4_64K_3_10;
+
+		} else if (info->kernel_version >= KERNEL_VERSION(3, 10, 0)) {
 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
 			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_3_10;
 			info->l3_index_size = PUD_INDEX_SIZE_L4_64K;
@@ -170,7 +238,17 @@ ppc64_vmalloc_init(void)
 
 		info->pte_rpn_shift = (SYMBOL(demote_segment_4k) ?
 			PTE_RPN_SHIFT_L4_64K_V2 : PTE_RPN_SHIFT_L4_64K_V1);
-		info->l2_masked_bits = PMD_MASKED_BITS_64K;
+
+		if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+			info->pgd_masked_bits = PGD_MASKED_BITS_64K_4_6;
+			info->pud_masked_bits = PUD_MASKED_BITS_64K_4_6;
+			info->pmd_masked_bits = PMD_MASKED_BITS_64K_4_6;
+		} else {
+			info->pgd_masked_bits = PGD_MASKED_BITS_64K;
+			info->pud_masked_bits = PUD_MASKED_BITS_64K;
+			info->pmd_masked_bits = (info->kernel_version >= KERNEL_VERSION(3, 11, 0) ?
+				PMD_MASKED_BITS_64K_3_11 : PMD_MASKED_BITS_64K);
+		}
 	} else {
 		/*
 		 * 4K pagesize
@@ -183,7 +261,16 @@ ppc64_vmalloc_init(void)
 
 		info->pte_rpn_shift = (info->kernel_version >= KERNEL_VERSION(4, 5, 0) ?
 			PTE_RPN_SHIFT_L4_4K_4_5 : PTE_RPN_SHIFT_L4_4K);
-		info->l2_masked_bits = PMD_MASKED_BITS_4K;
+
+		info->pgd_masked_bits = PGD_MASKED_BITS_4K;
+		info->pud_masked_bits = PUD_MASKED_BITS_4K;
+		info->pmd_masked_bits = PMD_MASKED_BITS_4K;
+	}
+
+	info->pte_rpn_mask = PTE_RPN_MASK_DEFAULT;
+	if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+		info->pte_rpn_mask = PTE_RPN_MASK_L4_4_6;
+		info->pte_rpn_shift = PTE_RPN_SHIFT_L4_4_6;
 	}
 
 	/*
@@ -265,6 +352,7 @@ ppc64_vtop_level4(unsigned long vaddr)
 	 * Sometimes we don't have level3 pagetable entries
 	 */
 	if (info->l3_index_size != 0) {
+		pgd_pte = pgd_page_vaddr_l4(pgd_pte);
 		page_upper = (ulong *)((ulong *)pgd_pte + PUD_OFFSET_L4(vaddr));
 		if (!readmem(VADDR, PAGEBASE(pgd_pte), info->page_buf, PAGESIZE())) {
 			ERRMSG("Can't read PUD page: 0x%llx\n", PAGEBASE(pgd_pte));
@@ -277,6 +365,7 @@ ppc64_vtop_level4(unsigned long vaddr)
 		pud_pte = pgd_pte;
 	}
 
+	pud_pte = pud_page_vaddr_l4(pud_pte);
 	page_middle = (ulong *)((ulong *)pud_pte + PMD_OFFSET_L4(vaddr));
 	if (!readmem(VADDR, PAGEBASE(pud_pte), info->page_buf, PAGESIZE())) {
 		ERRMSG("Can't read PMD page: 0x%llx\n", PAGEBASE(pud_pte));
@@ -286,7 +375,8 @@ ppc64_vtop_level4(unsigned long vaddr)
 	if (!(pmd_pte))
 		return NOT_PADDR;
 
-	page_table = (ulong *)(pmd_pte & ~(info->l2_masked_bits))
+	pmd_pte = pmd_page_vaddr_l4(pmd_pte);
+	page_table = (ulong *)(pmd_pte)
 			+ (BTOP(vaddr) & (info->ptrs_per_l1 - 1));
 	if (!readmem(VADDR, PAGEBASE(pmd_pte), info->page_buf, PAGESIZE())) {
 		ERRMSG("Can't read page table: 0x%llx\n", PAGEBASE(pmd_pte));
@@ -301,7 +391,8 @@ ppc64_vtop_level4(unsigned long vaddr)
 	if (!pte)
 		return NOT_PADDR;
 
-	paddr = PAGEBASE(PTOB(pte >> info->pte_rpn_shift)) + PAGEOFFSET(vaddr);
+	paddr = PAGEBASE(PTOB((pte & info->pte_rpn_mask) >> info->pte_rpn_shift))
+			+ PAGEOFFSET(vaddr);
 
 	return paddr;
 }
diff --git a/makedumpfile.h b/makedumpfile.h
index 7f9dfb1..a85fd7f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -635,6 +635,8 @@ int get_va_bits_arm64(void);
 #define PUD_INDEX_SIZE_L4_4K_3_7  9
 #define PTE_RPN_SHIFT_L4_4K  17
 #define PTE_RPN_SHIFT_L4_4K_4_5  18
+#define PGD_MASKED_BITS_4K  0
+#define PUD_MASKED_BITS_4K  0
 #define PMD_MASKED_BITS_4K  0
 
 /* 64K pagesize */
@@ -645,9 +647,22 @@ int get_va_bits_arm64(void);
 #define PTE_INDEX_SIZE_L4_64K_3_10  8
 #define PMD_INDEX_SIZE_L4_64K_3_10  10
 #define PGD_INDEX_SIZE_L4_64K_3_10  12
+#define PMD_INDEX_SIZE_L4_64K_4_6  5
+#define PUD_INDEX_SIZE_L4_64K_4_6  5
 #define PTE_RPN_SHIFT_L4_64K_V1  32
 #define PTE_RPN_SHIFT_L4_64K_V2  30
+#define PGD_MASKED_BITS_64K  0
+#define PUD_MASKED_BITS_64K  0x1ff
 #define PMD_MASKED_BITS_64K  0x1ff
+#define PMD_MASKED_BITS_64K_3_11 0xfff
+#define PGD_MASKED_BITS_64K_4_6  0xc0000000000000ffUL
+#define PUD_MASKED_BITS_64K_4_6  0xc0000000000000ffUL
+#define PMD_MASKED_BITS_64K_4_6  0xc0000000000000ffUL
+
+#define PTE_RPN_MASK_DEFAULT  0xffffffffffffffffUL
+#define PTE_RPN_SIZE_L4_4_6   (info->page_size == 65536 ? 41 : 45)
+#define PTE_RPN_MASK_L4_4_6   (((1UL << PTE_RPN_SIZE_L4_4_6) - 1) << info->page_shift)
+#define PTE_RPN_SHIFT_L4_4_6  info->page_shift
 
 #define PGD_MASK_L4		\
 	(info->kernel_version >= KERNEL_VERSION(3, 10, 0) ? (info->ptrs_per_pgd - 1) : 0x1ff)
@@ -1124,7 +1139,10 @@ struct DumpInfo {
 	uint		l2_shift;
 	uint		l1_shift;
 	uint		pte_rpn_shift;
-	uint		l2_masked_bits;
+	ulong		pte_rpn_mask;
+	ulong		pgd_masked_bits;
+	ulong		pud_masked_bits;
+	ulong		pmd_masked_bits;
 	ulong		kernel_pgd;
 	char		*page_buf; /* Page buffer to read page tables */
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
