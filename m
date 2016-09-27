Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1boyvW-0000v4-My
 for kexec@lists.infradead.org; Tue, 27 Sep 2016 20:24:31 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RKMRBj132595
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:09 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qthsfeee-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:09 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 06:24:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BACAB3578056
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:24:03 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RKO327131582
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:24:03 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RKO3K4003820
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:24:03 +1000
Subject: [PATCH 2/8] ppc64: Use kernel terminology for each level in 4-level
 page table
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 01:53:58 +0530
In-Reply-To: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
References: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147500783894.31772.11588899114427684670.stgit@hbathini.in.ibm.com>
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

For 4-level page table, we are referring to level3 as PGD instead of
PUD, which is not inline with how kernel refers to it.  This patch
corrects it by referring to level4 as PGD and level3 as PUD.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |   34 +++++++++++++++++-----------------
 makedumpfile.h |    6 +++---
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 2cc3906..d1d000f 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -231,10 +231,10 @@ ppc64_vmemmap_to_phys(unsigned long vaddr)
 static unsigned long long
 ppc64_vtop_level4(unsigned long vaddr)
 {
-	ulong *level4, *level4_dir;
-	ulong *page_dir, *page_middle;
-	ulong *page_table;
-	unsigned long long level4_pte, pgd_pte;
+	ulong *level4;
+	ulong *pgdir, *page_upper;
+	ulong *page_middle, *page_table;
+	unsigned long long pgd_pte, pud_pte;
 	unsigned long long pmd_pte, pte;
 	unsigned long long paddr = NOT_PADDR;
 
@@ -251,34 +251,34 @@ ppc64_vtop_level4(unsigned long vaddr)
 	}
 
 	level4 = (ulong *)info->kernel_pgd;
-	level4_dir = (ulong *)((ulong *)level4 + L4_OFFSET(vaddr));
+	pgdir = (ulong *)((ulong *)level4 + PGD_OFFSET_L4(vaddr));
 	if (!readmem(VADDR, PAGEBASE(level4), info->page_buf, PAGESIZE())) {
-		ERRMSG("Can't read level4 page: 0x%llx\n", PAGEBASE(level4));
+		ERRMSG("Can't read PGD page: 0x%llx\n", PAGEBASE(level4));
 		return NOT_PADDR;
 	}
-	level4_pte = ULONG((info->page_buf + PAGEOFFSET(level4_dir)));
-	if (!level4_pte)
+	pgd_pte = ULONG((info->page_buf + PAGEOFFSET(pgdir)));
+	if (!pgd_pte)
 		return NOT_PADDR;
 
 	/*
 	 * Sometimes we don't have level3 pagetable entries
 	 */
 	if (info->l3_index_size != 0) {
-		page_dir = (ulong *)((ulong *)level4_pte + PGD_OFFSET_L4(vaddr));
-		if (!readmem(VADDR, PAGEBASE(level4_pte), info->page_buf, PAGESIZE())) {
-			ERRMSG("Can't read PGD page: 0x%llx\n", PAGEBASE(level4_pte));
+		page_upper = (ulong *)((ulong *)pgd_pte + PUD_OFFSET_L4(vaddr));
+		if (!readmem(VADDR, PAGEBASE(pgd_pte), info->page_buf, PAGESIZE())) {
+			ERRMSG("Can't read PUD page: 0x%llx\n", PAGEBASE(pgd_pte));
 			return NOT_PADDR;
 		}
-		pgd_pte = ULONG((info->page_buf + PAGEOFFSET(page_dir)));
-		if (!pgd_pte)
+		pud_pte = ULONG((info->page_buf + PAGEOFFSET(page_upper)));
+		if (!pud_pte)
 			return NOT_PADDR;
 	} else {
-		pgd_pte = level4_pte;
+		pud_pte = pgd_pte;
 	}
 
-	page_middle = (ulong *)((ulong *)pgd_pte + PMD_OFFSET_L4(vaddr));
-	if (!readmem(VADDR, PAGEBASE(pgd_pte), info->page_buf, PAGESIZE())) {
-		ERRMSG("Can't read PMD page: 0x%llx\n", PAGEBASE(pgd_pte));
+	page_middle = (ulong *)((ulong *)pud_pte + PMD_OFFSET_L4(vaddr));
+	if (!readmem(VADDR, PAGEBASE(pud_pte), info->page_buf, PAGESIZE())) {
+		ERRMSG("Can't read PMD page: 0x%llx\n", PAGEBASE(pud_pte));
 		return NOT_PADDR;
 	}
 	pmd_pte = ULONG((info->page_buf + PAGEOFFSET(page_middle)));
diff --git a/makedumpfile.h b/makedumpfile.h
index 46c940c..c154abd 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -666,11 +666,11 @@ int get_va_bits_arm64(void);
 #define PTE_SHIFT_L4_64K_V2  30
 #define PMD_MASKED_BITS_64K  0x1ff
 
-#define L4_MASK		\
+#define PGD_MASK_L4		\
 	(info->kernel_version >= KERNEL_VERSION(3, 10, 0) ? (info->ptrs_per_pgd - 1) : 0x1ff)
-#define L4_OFFSET(vaddr)	((vaddr >> (info->l4_shift)) & L4_MASK)
+#define PGD_OFFSET_L4(vaddr)	((vaddr >> (info->l4_shift)) & PGD_MASK_L4)
 
-#define PGD_OFFSET_L4(vaddr)	\
+#define PUD_OFFSET_L4(vaddr)	\
 	((vaddr >> (info->l3_shift)) & (info->ptrs_per_l3 - 1))
 
 #define PMD_OFFSET_L4(vaddr)	\


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
