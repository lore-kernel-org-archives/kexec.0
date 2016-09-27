Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1boywC-00014A-BF
 for kexec@lists.infradead.org; Tue, 27 Sep 2016 20:25:13 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RKMSel036466
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:51 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25qv5xa7mn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:51 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 01:54:47 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 435B6125805E
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:55:06 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RKOihE38600874
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:54:44 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RKOhcR012178
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:54:43 +0530
Subject: [PATCH 7/8] ppc64: use the same masked bit values for 4K and 64K
 pagesizes
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 01:54:41 +0530
In-Reply-To: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
References: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147500788172.31772.6746512607639499139.stgit@hbathini.in.ibm.com>
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
