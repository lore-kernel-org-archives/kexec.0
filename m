Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eDCsh-0006Gh-KB
 for kexec@lists.infradead.org; Fri, 10 Nov 2017 17:14:17 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAAHCbjN133565
 for <kexec@lists.infradead.org>; Fri, 10 Nov 2017 12:13:53 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e5dhj192k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 10 Nov 2017 12:13:53 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 10 Nov 2017 17:13:48 -0000
Subject: [makedumpfile PATCH] ppc64: update hash page table geometry
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 22:43:41 +0530
MIME-Version: 1.0
Message-Id: <151033402186.13486.3228487082738293986.stgit@hbathini.in.ibm.com>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Kexec-ml <kexec@lists.infradead.org>
Cc: Ankit Kumar <ankit@linux.vnet.ibm.com>

Starting with kernel 4.12, BOOK3S hash page table geometry is updated
to accommodate larger virtual address range. Update here accordingly.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |   12 +++++++++---
 makedumpfile.h |    3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 2f5a0da..8bdbcc5 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -245,10 +245,16 @@ ppc64_vmalloc_init(void)
 
 		} else if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
-			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
-			info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_6;
-			info->l4_index_size = PGD_INDEX_SIZE_L4_64K_3_10;
 
+			if (info->kernel_version >= KERNEL_VERSION(4, 12, 0)) {
+				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_12;
+				info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_12;
+				info->l4_index_size = PGD_INDEX_SIZE_L4_64K_4_12;
+			} else {
+				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
+				info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_6;
+				info->l4_index_size = PGD_INDEX_SIZE_L4_64K_3_10;
+			}
 		} else if (info->kernel_version >= KERNEL_VERSION(3, 10, 0)) {
 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
 			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_3_10;
diff --git a/makedumpfile.h b/makedumpfile.h
index db75379..b983aaf 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -670,6 +670,9 @@ unsigned long get_kvbase_arm64(void);
 #define PGD_INDEX_SIZE_L4_64K_3_10  12
 #define PMD_INDEX_SIZE_L4_64K_4_6  5
 #define PUD_INDEX_SIZE_L4_64K_4_6  5
+#define PMD_INDEX_SIZE_L4_64K_4_12 10
+#define PUD_INDEX_SIZE_L4_64K_4_12 7
+#define PGD_INDEX_SIZE_L4_64K_4_12 8
 #define PTE_INDEX_SIZE_RADIX_64K  5
 #define PMD_INDEX_SIZE_RADIX_64K  9
 #define PUD_INDEX_SIZE_RADIX_64K  9


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
