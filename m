Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1boyvI-0000uk-DQ
 for kexec@lists.infradead.org; Tue, 27 Sep 2016 20:24:17 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RKMRjp044203
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:23:58 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qy5rshku-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:23:58 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 06:23:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1FB963578053
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:23:54 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RKNsgA3998076
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:23:54 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RKNrPt013381
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 06:23:53 +1000
Subject: [PATCH 1/8] ppc64: fix vtop page translation for 4K pages
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 01:53:48 +0530
In-Reply-To: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
References: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147500782897.31772.17600026656159119180.stgit@hbathini.in.ibm.com>
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

PUD index size was changed to 9 from 7 since kernel v3.7, but it was
not updated here. Also, currently L4_MASK is set to 0xfff for kernel
v3.10 and above irrespective of page size but it should be based on
l4 index size which is different for 4k & 64K page sizes. This patch
fixes them.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |   10 +++++++---
 makedumpfile.h |    5 ++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 89a7f05..2cc3906 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -160,10 +160,12 @@ ppc64_vmalloc_init(void)
 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
 			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_3_10;
 			info->l3_index_size = PUD_INDEX_SIZE_L4_64K;
+			info->l4_index_size = PGD_INDEX_SIZE_L4_64K_3_10;
 		} else {
 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K;
 			info->l2_index_size = PMD_INDEX_SIZE_L4_64K;
 			info->l3_index_size = PUD_INDEX_SIZE_L4_64K;
+			info->l4_index_size = PGD_INDEX_SIZE_L4_64K;
 		}
 
 		info->pte_shift = SYMBOL(demote_segment_4k) ?
@@ -175,7 +177,9 @@ ppc64_vmalloc_init(void)
 		 */
 		info->l1_index_size = PTE_INDEX_SIZE_L4_4K;
 		info->l2_index_size = PMD_INDEX_SIZE_L4_4K;
-		info->l3_index_size = PUD_INDEX_SIZE_L4_4K;
+		info->l3_index_size = (info->kernel_version >= KERNEL_VERSION(3, 7, 0) ?
+			PUD_INDEX_SIZE_L4_4K_3_7 : PUD_INDEX_SIZE_L4_4K);
+		info->l4_index_size = PGD_INDEX_SIZE_L4_4K;
 
 		info->pte_shift = PTE_SHIFT_L4_4K;
 		info->l2_masked_bits = PMD_MASKED_BITS_4K;
@@ -188,8 +192,8 @@ ppc64_vmalloc_init(void)
 	info->ptrs_per_l1 = (1 << info->l1_index_size);
 	info->ptrs_per_l2 = (1 << info->l2_index_size);
 	info->ptrs_per_l3 = (1 << info->l3_index_size);
-
-	info->ptrs_per_pgd = info->ptrs_per_l3;
+	info->ptrs_per_l4 = (1 << info->l4_index_size);
+	info->ptrs_per_pgd = info->ptrs_per_l4;
 
 	/*
 	 * Compute shifts
diff --git a/makedumpfile.h b/makedumpfile.h
index 1814139..46c940c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -650,6 +650,7 @@ int get_va_bits_arm64(void);
 #define PMD_INDEX_SIZE_L4_4K  7
 #define PUD_INDEX_SIZE_L4_4K  7
 #define PGD_INDEX_SIZE_L4_4K  9
+#define PUD_INDEX_SIZE_L4_4K_3_7  9
 #define PTE_SHIFT_L4_4K  17
 #define PMD_MASKED_BITS_4K  0
 
@@ -666,7 +667,7 @@ int get_va_bits_arm64(void);
 #define PMD_MASKED_BITS_64K  0x1ff
 
 #define L4_MASK		\
-	(info->kernel_version >= KERNEL_VERSION(3, 10, 0) ? 0xfff : 0x1ff)
+	(info->kernel_version >= KERNEL_VERSION(3, 10, 0) ? (info->ptrs_per_pgd - 1) : 0x1ff)
 #define L4_OFFSET(vaddr)	((vaddr >> (info->l4_shift)) & L4_MASK)
 
 #define PGD_OFFSET_L4(vaddr)	\
@@ -1123,9 +1124,11 @@ struct DumpInfo {
 	 * page table info for ppc64
 	 */
 	int		ptrs_per_pgd;
+	uint		l4_index_size;
 	uint		l3_index_size;
 	uint		l2_index_size;
 	uint		l1_index_size;
+	uint		ptrs_per_l4;
 	uint		ptrs_per_l3;
 	uint		ptrs_per_l2;
 	uint		ptrs_per_l1;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
