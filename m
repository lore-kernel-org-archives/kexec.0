Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFiJu-0005cQ-LK
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 13:35:55 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MDTZU5006450
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:32 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23qcxeb8wr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:32 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 23:35:29 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 365B12CE8046
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:26 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MDZQEn7012834
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:26 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MDZPFr001816
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:25 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 3/3] ima: add pre-calculated measurements (experimental)
Date: Wed, 22 Jun 2016 09:35:05 -0400
In-Reply-To: <1466602505-21915-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1466602505-21915-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1466602505-21915-4-git-send-email-zohar@linux.vnet.ibm.com>
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

This patch defines a new IMA hook named ima_add_measurement_check()
for including pre-calculated measurements in the IMA measurement list.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy |   2 +-
 include/linux/ima.h                  |  12 ++++
 security/integrity/ima/Kconfig       |   8 +++
 security/integrity/ima/ima.h         |   1 +
 security/integrity/ima/ima_buffer.c  | 116 +++++++++++++++++++++++++++++------
 security/integrity/ima/ima_policy.c  |  18 +++++-
 6 files changed, 136 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5a99c6f..e5a137e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -28,7 +28,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[KEXEC_CMDLINE_CHECK]
+				[KEXEC_CMDLINE_CHECK] [PRECALC_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 88203f9..797de51 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -15,6 +15,7 @@ struct linux_binprm;
 
 enum ima_buffer_id {
 	MEASURING_KEXEC_CMDLINE,
+	MEASURING_PRECALC_DATA,
 	MEASURING_MAX_BUFFER_ID
 };
 
@@ -29,6 +30,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_buffer_check(void *buf, loff_t size,
 			     enum ima_buffer_id buffer_id);
+extern void ima_add_measurement_check(const char *hashname, u8 *digest,
+				      loff_t size, enum ima_buffer_id buffer_id,
+				      char *hint);
 
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
@@ -72,6 +76,14 @@ static inline void ima_buffer_check(void *buf, loff_t size,
 {
 	return;
 }
+
+static inline void ima_add_measurement_check(const char *hashname, u8 *digest,
+					     loff_t size,
+					     enum ima_buffer_id buffer_id,
+					     char *hint)
+{
+	return;
+}
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_IMA_APPRAISE
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 5487827..0fb54d3 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -44,6 +44,14 @@ config IMA_LSM_RULES
 	help
 	  Disabling this option will disregard LSM based policy rules.
 
+config IMA_PRECALC_RULES
+	bool "Permit pre-calculated measurements (EXPERIMENTAL)"
+	depends on IMA
+	default n
+	help
+	  Enabling this option will permit pre-calculated measurements
+	  to be added to the IMA measurement list.
+
 choice
 	prompt "Default template"
 	default IMA_NG_TEMPLATE
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5f21a9a..ccad21d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -152,6 +152,7 @@ enum ima_hooks {
 	KEXEC_INITRAMFS_CHECK,
 	KEXEC_CMDLINE_CHECK,
 	POLICY_CHECK,
+	PRECALC_CHECK,
 	MAX_CHECK
 };
 
diff --git a/security/integrity/ima/ima_buffer.c b/security/integrity/ima/ima_buffer.c
index e74131b..ad49f6c 100644
--- a/security/integrity/ima/ima_buffer.c
+++ b/security/integrity/ima/ima_buffer.c
@@ -11,6 +11,8 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ima.h>
+#include <crypto/hash_info.h>
+#include <linux/string_helpers.h>
 
 #include "ima.h"
 
@@ -21,9 +23,37 @@ struct buffer_idmap {
 
 static struct buffer_idmap _idmap[MEASURING_MAX_BUFFER_ID] = {
 	[MEASURING_KEXEC_CMDLINE].func = KEXEC_CMDLINE_CHECK,
-	[MEASURING_KEXEC_CMDLINE].buf = "boot-cmdline",
+	[MEASURING_KEXEC_CMDLINE].buf = "kexec-boot-cmdline",
+	[MEASURING_PRECALC_DATA].func = PRECALC_CHECK,
+	[MEASURING_PRECALC_DATA].buf = "precalc",
 };
 
+#define IMA_MAX_BUFFER_HINT_SIZE 255
+
+static int store_buffer_measurement(struct ima_digest_data *hash, int pcr,
+				    char *buffer_hint)
+{
+	struct ima_template_entry *entry;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = {iint, NULL, NULL, NULL, 0, NULL};
+	int violation = 0;
+	int result;
+
+	iint->ima_hash = hash;
+	event_data.filename = buffer_hint;
+
+	result = ima_alloc_init_template(&event_data, &entry);
+	if (result < 0)
+		return result;
+
+	result = ima_store_template(entry, violation, NULL,
+				    event_data.filename, pcr);
+	if (result < 0)
+		ima_free_template_entry(entry);
+
+	return result;
+}
+
 static void process_buffer_measurement(void *buf, loff_t size,
 				       enum ima_buffer_id buffer_id, int pcr)
 {
@@ -31,10 +61,6 @@ static void process_buffer_measurement(void *buf, loff_t size,
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash;
-	struct ima_template_entry *entry;
-	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
-	struct ima_event_data event_data = {iint, NULL, NULL, NULL, 0, NULL};
-	int violation = 0;
 	int result;
 
 	memset(&hash, 0, sizeof(hash));
@@ -45,20 +71,10 @@ static void process_buffer_measurement(void *buf, loff_t size,
 		return;
 	}
 
-	iint->ima_hash = &hash.hdr;
-	event_data.filename = _idmap[buffer_id].buf;
-	result = ima_alloc_init_template(&event_data, &entry);
-	if (result < 0) {
-		pr_debug("failed allocating template\n");
-		return;
-	}
-
-	result = ima_store_template(entry, violation, NULL,
-				    event_data.filename, pcr);
-	if (result < 0) {
+	result = store_buffer_measurement(&hash.hdr, pcr,
+					  _idmap[buffer_id].buf);
+	if (result < 0)
 		pr_debug("failed storing buffer measurement\n");
-		ima_free_template_entry(entry);
-	}
 }
 
 /**
@@ -82,3 +98,67 @@ void ima_buffer_check(void *buf, loff_t size, enum ima_buffer_id buffer_id)
 	process_buffer_measurement(buf, size, buffer_id, pcr);
 }
 EXPORT_SYMBOL_GPL(ima_buffer_check);
+
+/**
+ * ima_add_measurement_check - add pre-calculated hash measurement
+ * @hashname: pointer to hash algorithm name
+ * @digest: pointer to hash digest
+ * @size: hash digest size
+ * @buffer_id: caller identifier
+ * @hint: measurement identifier
+ *
+ * Include pre-calculated hash measurements in the IMA measurement list.
+ */
+void ima_add_measurement_check(const char *hashname, u8 *digest, loff_t size,
+			      enum ima_buffer_id buffer_id, char *hint)
+{
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	char buffer_hint[IMA_MAX_BUFFER_HINT_SIZE];
+	char *buf;
+	int result, i;
+
+	if (buffer_id > MEASURING_MAX_BUFFER_ID)
+		return;
+
+	if (!ima_match_buffer_id(_idmap[buffer_id].func, &pcr))
+		return;
+
+	if (!hint) {
+		pr_debug("missing buffer hint\n");
+		return;
+	}
+
+	buf = kstrdup_quotable(hint, GFP_KERNEL);
+	if (!buf) {
+		pr_debug("failed quoting buffer hint\n");
+		return;
+	}
+
+	/* Limit the total measurement hint to IMA_MAX_BUFFER_HINT_SIZE. */
+	snprintf(buffer_hint, sizeof(buffer_hint), "(%s) %s",
+		 _idmap[buffer_id].buf, buf);
+	kfree(buf);
+
+	memset(&hash, 0, sizeof(hash));
+	for (i = 1; i < HASH_ALGO__LAST; i++) {
+		if (strcmp(hashname, hash_algo_name[i]) != 0)
+			continue;
+		hash.hdr.algo = i;
+		break;
+	}
+	if (hash.hdr.algo == 0) {
+		pr_debug("invalid hash algorithm (%d)\n", hash.hdr.algo);
+		return;
+	}
+
+	hash.hdr.length = size;
+	memcpy(&hash.hdr.digest, digest, size);
+	result = store_buffer_measurement(&hash.hdr, pcr, buffer_hint);
+	if (result < 0)
+		pr_debug("failed to store buffer measurement\n");
+}
+EXPORT_SYMBOL_GPL(ima_add_measurement_check);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8e53f84..4094dd7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -20,6 +20,7 @@
 #include <linux/rculist.h>
 #include <linux/genhd.h>
 #include <linux/seq_file.h>
+#include <linux/ima.h>
 
 #include "ima.h"
 
@@ -54,6 +55,12 @@ enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
 
 enum policy_types { ORIGINAL_TCB = 1, DEFAULT_TCB };
 
+#ifdef CONFIG_MEASURING_PRECALC_RULES
+static int permit_measuring_precalc_rules = 1;
+#else
+static int permit_measuring_precalc_rules;
+#endif
+
 struct ima_rule_entry {
 	struct list_head list;
 	int action;
@@ -668,6 +675,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_CMDLINE_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
+			else if ((strcmp(args[0].from, "PRECALC_CHECK") == 0)
+				 && permit_measuring_precalc_rules)
+				entry->func = PRECALC_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -929,7 +939,7 @@ enum {
 	func_file = 0, func_mmap, func_bprm,
 	func_module, func_firmware, func_post,
 	func_kexec_kernel, func_kexec_initramfs,
-	func_kexec_cmdline, func_policy
+	func_kexec_cmdline, func_policy, func_precalc
 };
 
 static char *func_tokens[] = {
@@ -942,7 +952,8 @@ static char *func_tokens[] = {
 	"KEXEC_KERNEL_CHECK",
 	"KEXEC_INITRAMFS_CHECK",
 	"KEXEC_CMDLINE_CHECK",
-	"POLICY_CHECK"
+	"POLICY_CHECK",
+	"PRECALC_CHECK"
 };
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
@@ -1019,6 +1030,9 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 	case POLICY_CHECK:
 		seq_printf(m, pt(Opt_func), ft(func_policy));
 		break;
+	case PRECALC_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_precalc));
+		break;
 	default:
 		snprintf(tbuf, sizeof(tbuf), "%d", func);
 		seq_printf(m, pt(Opt_func), tbuf);
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
