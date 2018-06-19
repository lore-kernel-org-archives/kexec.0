Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVHsy-00065j-QC
 for kexec@lists.infradead.org; Tue, 19 Jun 2018 14:45:34 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JEcmtI100542
 for <kexec@lists.infradead.org>; Tue, 19 Jun 2018 10:45:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jq159r0v4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 19 Jun 2018 10:45:18 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.ibm.com>;
 Tue, 19 Jun 2018 15:45:16 +0100
Subject: [PATCH] makedumpfile/ppc64: Increase the VA range
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Tue, 19 Jun 2018 20:15:09 +0530
MIME-Version: 1.0
Message-Id: <152941950897.27658.15976744741411711134.stgit@hbathini.in.ibm.com>
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
To: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>
Cc: Dave Young <dyoung@redhat.com>, ptesarik@suse.cz, Kexec-ml <kexec@lists.infradead.org>, piliu@redhat.com, andrej.skvortzov@gmail.com

* Required for kernel 4.17

Since kernel commit c2b4d8b7417a ("powerpc/mm/hash64: Increase the VA
range"), the max virtual (effective) address value has been increased
to 4PB. Update page table index values accordingly.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/ppc64.c   |    5 ++++-
 makedumpfile.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 8bdbcc5..8b6f7d5 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -248,7 +248,10 @@ ppc64_vmalloc_init(void)
 
 			if (info->kernel_version >= KERNEL_VERSION(4, 12, 0)) {
 				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_12;
-				info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_12;
+				if (info->kernel_version >= KERNEL_VERSION(4, 17, 0))
+					info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_17;
+				else
+					info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_12;
 				info->l4_index_size = PGD_INDEX_SIZE_L4_64K_4_12;
 			} else {
 				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
diff --git a/makedumpfile.h b/makedumpfile.h
index 121eab2..4960e43 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -703,6 +703,7 @@ unsigned long get_kvbase_arm64(void);
 #define PMD_INDEX_SIZE_L4_64K_4_12 10
 #define PUD_INDEX_SIZE_L4_64K_4_12 7
 #define PGD_INDEX_SIZE_L4_64K_4_12 8
+#define PUD_INDEX_SIZE_L4_64K_4_17 10
 #define PTE_INDEX_SIZE_RADIX_64K  5
 #define PMD_INDEX_SIZE_RADIX_64K  9
 #define PUD_INDEX_SIZE_RADIX_64K  9


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
