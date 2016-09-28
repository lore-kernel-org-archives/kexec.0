Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bp7DX-0001lI-1W
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 05:15:40 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S5CmLp005723
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:15:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25qu85y9pn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:15:17 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 15:15:15 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2DE413578058
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 15:15:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S5FApu65667200
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 15:15:10 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S5FAa4020189
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 15:15:10 +1000
Subject: [RESEND PATCH 7/8] makedumpfile/ppc64: use the same masked bit
 values for 4K and 64K pagesizes
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 10:45:05 +0530
In-Reply-To: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
References: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147503969031.1199.8217398215656663678.stgit@hbathini.in.ibm.com>
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

Starting with kernel v4.7, masked bit values are the same for 4K and
64K pagesizes. This patch updates here accordingly.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |    6 ++++++
 makedumpfile.h |    4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 6b82cc2..40076eb 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -286,6 +286,12 @@ ppc64_vmalloc_init(void)
 		info->pmd_masked_bits = PMD_MASKED_BITS_4K;
 	}
 
+	if (info->kernel_version >= KERNEL_VERSION(4, 7, 0)) {
+		info->pgd_masked_bits = PGD_MASKED_BITS_4_7;
+		info->pud_masked_bits = PUD_MASKED_BITS_4_7;
+		info->pmd_masked_bits = PMD_MASKED_BITS_4_7;
+	}
+
 	info->pte_rpn_mask = PTE_RPN_MASK_DEFAULT;
 	if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
 		info->pte_rpn_mask = PTE_RPN_MASK_L4_4_6;
diff --git a/makedumpfile.h b/makedumpfile.h
index a85fd7f..69747c0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -664,6 +664,10 @@ int get_va_bits_arm64(void);
 #define PTE_RPN_MASK_L4_4_6   (((1UL << PTE_RPN_SIZE_L4_4_6) - 1) << info->page_shift)
 #define PTE_RPN_SHIFT_L4_4_6  info->page_shift
 
+#define PGD_MASKED_BITS_4_7  0xc0000000000000ffUL
+#define PUD_MASKED_BITS_4_7  0xc0000000000000ffUL
+#define PMD_MASKED_BITS_4_7  0xc0000000000000ffUL
+
 #define PGD_MASK_L4		\
 	(info->kernel_version >= KERNEL_VERSION(3, 10, 0) ? (info->ptrs_per_pgd - 1) : 0x1ff)
 #define PGD_OFFSET_L4(vaddr)	((vaddr >> (info->l4_shift)) & PGD_MASK_L4)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
