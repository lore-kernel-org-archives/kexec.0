Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFiJl-0006I1-06
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 13:35:46 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MDTWdk060709
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:27 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q1qnw2pn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:27 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 23:35:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 22D5B2CE8054
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MDZMd99961820
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MDZLDb001713
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:21 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] kexec: measure boot command line
Date: Wed, 22 Jun 2016 09:35:04 -0400
In-Reply-To: <1466602505-21915-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1466602505-21915-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1466602505-21915-3-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>, linux-ima-devel <linux-ima-devel@lists.sourceforge.net>
Cc: kexec@lists.infradead.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

This patch defines the buffer identifier "KEXEC_CMDLINE_CHECK" for
measuring the boot command line.

eg: echo -n -e `cat /proc/cmdline | sed 's/^.*root=/root=/'` | sha256sum

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy | 1 +
 include/linux/ima.h                  | 1 +
 kernel/kexec_file.c                  | 4 ++++
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_buffer.c  | 2 ++
 security/integrity/ima/ima_policy.c  | 9 ++++++++-
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index bb0f9a1..5a99c6f 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -28,6 +28,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
+				[KEXEC_CMDLINE_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 01319b3..88203f9 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -14,6 +14,7 @@
 struct linux_binprm;
 
 enum ima_buffer_id {
+	MEASURING_KEXEC_CMDLINE,
 	MEASURING_MAX_BUFFER_ID
 };
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 503bc2d..acc8dad1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
+#include <linux/ima.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <linux/syscalls.h>
@@ -178,6 +179,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_buffer_check(image->cmdline_buf, cmdline_len - 1,
+				 MEASURING_KEXEC_CMDLINE);
 	}
 
 	/* Call arch image load handlers */
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc2e77b..5f21a9a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -150,6 +150,7 @@ enum ima_hooks {
 	FIRMWARE_CHECK,
 	KEXEC_KERNEL_CHECK,
 	KEXEC_INITRAMFS_CHECK,
+	KEXEC_CMDLINE_CHECK,
 	POLICY_CHECK,
 	MAX_CHECK
 };
diff --git a/security/integrity/ima/ima_buffer.c b/security/integrity/ima/ima_buffer.c
index 84c9494..e74131b 100644
--- a/security/integrity/ima/ima_buffer.c
+++ b/security/integrity/ima/ima_buffer.c
@@ -20,6 +20,8 @@ struct buffer_idmap {
 };
 
 static struct buffer_idmap _idmap[MEASURING_MAX_BUFFER_ID] = {
+	[MEASURING_KEXEC_CMDLINE].func = KEXEC_CMDLINE_CHECK,
+	[MEASURING_KEXEC_CMDLINE].buf = "boot-cmdline",
 };
 
 static void process_buffer_measurement(void *buf, loff_t size,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 521d612..8e53f84 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -663,6 +663,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if (strcmp(args[0].from, "KEXEC_INITRAMFS_CHECK")
 				 == 0)
 				entry->func = KEXEC_INITRAMFS_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_CMDLINE_CHECK")
+				 == 0)
+				entry->func = KEXEC_CMDLINE_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
 			else
@@ -926,7 +929,7 @@ enum {
 	func_file = 0, func_mmap, func_bprm,
 	func_module, func_firmware, func_post,
 	func_kexec_kernel, func_kexec_initramfs,
-	func_policy
+	func_kexec_cmdline, func_policy
 };
 
 static char *func_tokens[] = {
@@ -938,6 +941,7 @@ static char *func_tokens[] = {
 	"POST_SETATTR",
 	"KEXEC_KERNEL_CHECK",
 	"KEXEC_INITRAMFS_CHECK",
+	"KEXEC_CMDLINE_CHECK",
 	"POLICY_CHECK"
 };
 
@@ -1009,6 +1013,9 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 	case KEXEC_INITRAMFS_CHECK:
 		seq_printf(m, pt(Opt_func), ft(func_kexec_initramfs));
 		break;
+	case KEXEC_CMDLINE_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_kexec_cmdline));
+		break;
 	case POLICY_CHECK:
 		seq_printf(m, pt(Opt_func), ft(func_policy));
 		break;
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
