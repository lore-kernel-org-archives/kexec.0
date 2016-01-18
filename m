Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([125.16.236.8])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLBkd-0006Ru-IH
 for kexec@lists.infradead.org; Mon, 18 Jan 2016 15:29:52 +0000
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 18 Jan 2016 20:50:27 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0IFIxJA4391306
 for <kexec@lists.infradead.org>; Mon, 18 Jan 2016 20:48:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0IFGpJv007000
 for <kexec@lists.infradead.org>; Mon, 18 Jan 2016 20:48:59 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 10/11] ima: measure and appraise the IMA policy itself
Date: Mon, 18 Jan 2016 10:11:25 -0500
Message-Id: <1453129886-20192-11-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

This patch adds support for measuring and appraising the IMA policy
itself.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_fs.c     |  9 ++++++++-
 security/integrity/ima/ima_policy.c | 14 ++++++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fc31ba2..e8f111b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -185,6 +185,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_LOG	0x04
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
+#define IMA_APPRAISE_POLICY	0x20
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(int func, struct integrity_iint_cache *iint,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fe8b16b..57c6b2e 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -325,7 +325,14 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 
 	if (data[0] == '/')
 		result = ima_read_policy(data);
-	else
+	else if (ima_appraise & IMA_APPRAISE_POLICY) {
+		pr_err("IMA: signed policy required\n");
+		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+				    "policy_update", "signed policy required",
+				    1, 0);
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			result = -EACCES;
+	} else
 		result = ima_parse_add_rule(data);
 	mutex_unlock(&ima_write_mutex);
 out_free:
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index dbfd26b..7a63760 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -118,6 +118,7 @@ static struct ima_rule_entry default_measurement_rules[] = {
 	{.action = MEASURE, .hooks.func = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .hooks.policy_id = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.policy_id = POLICY_CHECK, .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_appraise_rules[] = {
@@ -618,6 +619,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->hooks.policy_id = FIRMWARE_CHECK;
 			else if (strcmp(args[0].from, "MODULE_CHECK") == 0)
 				entry->hooks.policy_id = MODULE_CHECK;
+			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
+				entry->hooks.policy_id = POLICY_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -776,6 +779,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		temp_ima_appraise |= IMA_APPRAISE_MODULES;
 	else if (entry->hooks.policy_id == FIRMWARE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
+	else if (entry->hooks.policy_id == POLICY_CHECK)
+		temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
@@ -862,7 +867,8 @@ static char *mask_tokens[] = {
 enum {
 	func_file = 0, func_mmap, func_bprm,
 	func_module, func_post,
-	func_kexec, func_initramfs, func_firmware
+	func_kexec, func_initramfs, func_firmware,
+	func_policy
 };
 
 static char *func_tokens[] = {
@@ -873,7 +879,8 @@ static char *func_tokens[] = {
 	"POST_SETATTR",
 	"KEXEC_CHECK",
 	"INITRAMFS_CHECK",
-	"FIRMWARE_CHECK"
+	"FIRMWARE_CHECK",
+	"POLICY_CHECK"
 };
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
@@ -961,6 +968,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 			case MODULE_CHECK:
 				seq_printf(m, pt(Opt_func), ft(func_module));
 				break;
+			case POLICY_CHECK:
+				seq_printf(m, pt(Opt_func), ft(func_policy));
+				break;
 			default:
 				snprintf(tbuf, sizeof(tbuf), "%d",
 					 entry->hooks.func);
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
