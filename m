Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1drrPi-0006Cx-1y
 for kexec@lists.infradead.org; Tue, 12 Sep 2017 20:04:12 +0000
Received: by mail-pf0-f175.google.com with SMTP id q76so6650805pfq.2
 for <kexec@lists.infradead.org>; Tue, 12 Sep 2017 13:03:45 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [Makedumpfile PATCH v2] book3s/ppc64: Lower the max real address to
 53 bits for kernels >= v4.11
Date: Wed, 13 Sep 2017 01:33:31 +0530
Message-Id: <1505246611-7387-1-git-send-email-bhsharma@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, hbathini@linux.vnet.ibm.com
Cc: bhsharma@redhat.com, dyoung@redhat.com, piliu@redhat.com, bhe@redhat.com

Kernel commit 2f18d533757da3899f4bedab0b2c051b080079dc lowered the
max real address on ppc64 to 53 bits.

Make similar changes in makedumpfile (on basis of the underlying kernel
version), without which the makedumpfile will fail to create a dumpfile
and instead throw a SEGV fault as shown below on kernels >= v4.11:

 # makedumpfile --split -d 31 -x vmlinux vmcore dumpfile_{1,2,3} 2>&1

 The kernel version is not supported.
 The makedumpfile operation may be incomplete.
 [ 1196.252094] makedumpfile[2367]: unhandled signal 11 at
 00000100f7011ca8 nip 000000001001eecc lr 000000001001f3c0 code 30001
 Segmentation fault

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Changes since v1:
- As per Atsushi's comments introduced macros for 4_11 directly
  in v2 and use them in arch/ppc64.c

 arch/ppc64.c   | 8 +++++++-
 makedumpfile.h | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index bacac778f73c..2f5a0daa16b2 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -307,11 +307,17 @@ ppc64_vmalloc_init(void)
 	}
 
 	info->pte_rpn_mask = PTE_RPN_MASK_DEFAULT;
-	if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
+	if ((info->kernel_version >= KERNEL_VERSION(4, 6, 0)) &&
+	    (info->kernel_version < KERNEL_VERSION(4, 11, 0))) {
 		info->pte_rpn_mask = PTE_RPN_MASK_L4_4_6;
 		info->pte_rpn_shift = PTE_RPN_SHIFT_L4_4_6;
 	}
 
+	if (info->kernel_version >= KERNEL_VERSION(4, 11, 0)) {
+		info->pte_rpn_mask = PTE_RPN_MASK_L4_4_11;
+		info->pte_rpn_shift = PTE_RPN_SHIFT_L4_4_11;
+	}
+
 	/*
 	 * Compute ptrs per each level
 	 */
diff --git a/makedumpfile.h b/makedumpfile.h
index 7d81bbcf2234..f4ba02d11f09 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -692,6 +692,11 @@ unsigned long get_kvbase_arm64(void);
 #define PUD_MASKED_BITS_4_7  0xc0000000000000ffUL
 #define PMD_MASKED_BITS_4_7  0xc0000000000000ffUL
 
+#define PTE_RPN_SIZE_L4_4_11  53
+#define PTE_RPN_MASK_L4_4_11   \
+	(((1UL << PTE_RPN_SIZE_L4_4_11) - 1) & ~((1UL << info->page_shift) - 1))
+#define PTE_RPN_SHIFT_L4_4_11  info->page_shift
+
 /*
  * Supported MMU types
  */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
