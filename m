Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bp7CI-0000sn-Kc
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 05:14:23 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S5CiA8089178
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:01 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25r2ykkcgx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:01 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 10:43:58 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 297651258026
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:16 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S5Dh9631195240
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:43:43 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S5DrkQ029699
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:43:53 +0530
Subject: [RESEND PATCH 3/8] makedumpfile/ppc64: address changes in kernel v4.5
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 10:43:52 +0530
In-Reply-To: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
References: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147503961259.1199.16436419722659526570.stgit@hbathini.in.ibm.com>
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

Starting with kernel v4.5, PTE RPN shift value for 4K page size
is increased by one to accommodate page soft dirty tracking and
_PAGE_PRESENT bit is changed. Make the corresponding changes here
and replace all instances of pte_shift with pte_rpn_shift to be
in sync with how it is referred to in the kernel. Also, remove
macro definitions that are no longer used.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |    9 +++++----
 makedumpfile.h |   30 +++++++-----------------------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index d1d000f..dc8f0f2 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -168,8 +168,8 @@ ppc64_vmalloc_init(void)
 			info->l4_index_size = PGD_INDEX_SIZE_L4_64K;
 		}
 
-		info->pte_shift = SYMBOL(demote_segment_4k) ?
-			PTE_SHIFT_L4_64K_V2 : PTE_SHIFT_L4_64K_V1;
+		info->pte_rpn_shift = (SYMBOL(demote_segment_4k) ?
+			PTE_RPN_SHIFT_L4_64K_V2 : PTE_RPN_SHIFT_L4_64K_V1);
 		info->l2_masked_bits = PMD_MASKED_BITS_64K;
 	} else {
 		/*
@@ -181,7 +181,8 @@ ppc64_vmalloc_init(void)
 			PUD_INDEX_SIZE_L4_4K_3_7 : PUD_INDEX_SIZE_L4_4K);
 		info->l4_index_size = PGD_INDEX_SIZE_L4_4K;
 
-		info->pte_shift = PTE_SHIFT_L4_4K;
+		info->pte_rpn_shift = (info->kernel_version >= KERNEL_VERSION(4, 5, 0) ?
+			PTE_RPN_SHIFT_L4_4K_4_5 : PTE_RPN_SHIFT_L4_4K);
 		info->l2_masked_bits = PMD_MASKED_BITS_4K;
 	}
 
@@ -300,7 +301,7 @@ ppc64_vtop_level4(unsigned long vaddr)
 	if (!pte)
 		return NOT_PADDR;
 
-	paddr = PAGEBASE(PTOB(pte >> info->pte_shift)) + PAGEOFFSET(vaddr);
+	paddr = PAGEBASE(PTOB(pte >> info->pte_rpn_shift)) + PAGEOFFSET(vaddr);
 
 	return paddr;
 }
diff --git a/makedumpfile.h b/makedumpfile.h
index c154abd..e45ad09 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -625,24 +625,6 @@ int get_va_bits_arm64(void);
 #define REGION_SHIFT            (60UL)
 #define VMEMMAP_REGION_ID       (0xfUL)
 
-#define PGDIR_SHIFT	\
-	(PAGESHIFT() + (PAGESHIFT() - 3) + (PAGESHIFT() - 2))
-#define PMD_SHIFT       (PAGESHIFT() + (PAGESHIFT() - 3))
-
-/* shift to put page number into pte */
-#define PTE_SHIFT 16
-
-#define PTE_INDEX_SIZE  9
-#define PMD_INDEX_SIZE  10
-#define PGD_INDEX_SIZE  10
-
-#define PTRS_PER_PTE    (1 << PTE_INDEX_SIZE)
-#define PTRS_PER_PMD    (1 << PMD_INDEX_SIZE)
-#define PTRS_PER_PGD    (1 << PGD_INDEX_SIZE)
-
-#define PGD_OFFSET(vaddr)       ((vaddr >> PGDIR_SHIFT) & 0x7ff)
-#define PMD_OFFSET(vaddr)       ((vaddr >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
-
 /* 4-level page table support */
 
 /* 4K pagesize */
@@ -651,7 +633,8 @@ int get_va_bits_arm64(void);
 #define PUD_INDEX_SIZE_L4_4K  7
 #define PGD_INDEX_SIZE_L4_4K  9
 #define PUD_INDEX_SIZE_L4_4K_3_7  9
-#define PTE_SHIFT_L4_4K  17
+#define PTE_RPN_SHIFT_L4_4K  17
+#define PTE_RPN_SHIFT_L4_4K_4_5  18
 #define PMD_MASKED_BITS_4K  0
 
 /* 64K pagesize */
@@ -662,8 +645,8 @@ int get_va_bits_arm64(void);
 #define PTE_INDEX_SIZE_L4_64K_3_10  8
 #define PMD_INDEX_SIZE_L4_64K_3_10  10
 #define PGD_INDEX_SIZE_L4_64K_3_10  12
-#define PTE_SHIFT_L4_64K_V1  32
-#define PTE_SHIFT_L4_64K_V2  30
+#define PTE_RPN_SHIFT_L4_64K_V1  32
+#define PTE_RPN_SHIFT_L4_64K_V2  30
 #define PMD_MASKED_BITS_64K  0x1ff
 
 #define PGD_MASK_L4		\
@@ -676,7 +659,8 @@ int get_va_bits_arm64(void);
 #define PMD_OFFSET_L4(vaddr)	\
 	((vaddr >> (info->l2_shift)) & (info->ptrs_per_l2 - 1))
 
-#define _PAGE_PRESENT		0x1UL
+#define _PAGE_PRESENT		\
+	(info->kernel_version >= KERNEL_VERSION(4, 5, 0) ? 0x2UL : 0x1UL)
 #endif
 
 #ifdef __powerpc32__
@@ -1136,7 +1120,7 @@ struct DumpInfo {
 	uint		l3_shift;
 	uint		l2_shift;
 	uint		l1_shift;
-	uint		pte_shift;
+	uint		pte_rpn_shift;
 	uint		l2_masked_bits;
 	ulong		kernel_pgd;
 	char		*page_buf; /* Page buffer to read page tables */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
