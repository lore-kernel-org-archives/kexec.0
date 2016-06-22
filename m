Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFiJg-0006Bv-4l
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 13:35:42 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MDTXVj060734
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:23 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q1qnw2ku-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:22 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 23:35:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 749B33578057
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MDZIEh8651150
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MDZI8H001623
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:18 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 1/3] ima: measure other types of data
Date: Wed, 22 Jun 2016 09:35:03 -0400
In-Reply-To: <1466602505-21915-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1466602505-21915-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1466602505-21915-2-git-send-email-zohar@linux.vnet.ibm.com>
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

In addition to files, other data (eg. boot command line) should be
included in the measurement list to attest to the integrity of a running
system.  A new IMA hook named ima_buffer_check() calculates and includes
the buffer hash in the measurement list.  Callers of this hook provide
the buffer, buffer length and a buffer identifier.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/ima.h                 | 11 +++++
 security/integrity/ima/Makefile     |  2 +-
 security/integrity/ima/ima.h        |  2 +
 security/integrity/ima/ima_buffer.c | 82 +++++++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c | 26 ++++++++++++
 5 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_buffer.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0eb7c2e..01319b3 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -13,6 +13,10 @@
 #include <linux/fs.h>
 struct linux_binprm;
 
+enum ima_buffer_id {
+	MEASURING_MAX_BUFFER_ID
+};
+
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
@@ -22,6 +26,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
+extern void ima_buffer_check(void *buf, loff_t size,
+			     enum ima_buffer_id buffer_id);
 
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
@@ -60,6 +66,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline void ima_buffer_check(void *buf, loff_t size,
+				    enum ima_buffer_id buffer_id)
+{
+	return;
+}
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_IMA_APPRAISE
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 9aeaeda..c34599f 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -6,6 +6,6 @@
 obj-$(CONFIG_IMA) += ima.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_buffer.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index db25f54..cc2e77b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -154,6 +154,8 @@ enum ima_hooks {
 	MAX_CHECK
 };
 
+int ima_match_buffer_id(enum ima_hooks func, int *pcr);
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, int mask,
 		   enum ima_hooks func, int *pcr);
diff --git a/security/integrity/ima/ima_buffer.c b/security/integrity/ima/ima_buffer.c
new file mode 100644
index 0000000..84c9494
--- /dev/null
+++ b/security/integrity/ima/ima_buffer.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2016 IBM Corporation
+ *
+ * Author:
+ * Mimi Zohar <zohar@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/ima.h>
+
+#include "ima.h"
+
+struct buffer_idmap {
+	enum ima_hooks func;
+	char *buf;
+};
+
+static struct buffer_idmap _idmap[MEASURING_MAX_BUFFER_ID] = {
+};
+
+static void process_buffer_measurement(void *buf, loff_t size,
+				       enum ima_buffer_id buffer_id, int pcr)
+{
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash;
+	struct ima_template_entry *entry;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = {iint, NULL, NULL, NULL, 0, NULL};
+	int violation = 0;
+	int result;
+
+	memset(&hash, 0, sizeof(hash));
+	hash.hdr.algo = ima_hash_algo;
+	result = ima_calc_buffer_hash(buf, size, &hash.hdr);
+	if (result < 0) {
+		pr_debug("failed calculating buffer hash\n");
+		return;
+	}
+
+	iint->ima_hash = &hash.hdr;
+	event_data.filename = _idmap[buffer_id].buf;
+	result = ima_alloc_init_template(&event_data, &entry);
+	if (result < 0) {
+		pr_debug("failed allocating template\n");
+		return;
+	}
+
+	result = ima_store_template(entry, violation, NULL,
+				    event_data.filename, pcr);
+	if (result < 0) {
+		pr_debug("failed storing buffer measurement\n");
+		ima_free_template_entry(entry);
+	}
+}
+
+/**
+ * ima_buffer_check - based on policy, collect & store buffer measurement
+ * @buf: pointer to buffer
+ * @size: size of buffer
+ * @buffer_id: caller identifier
+ *
+ * Buffers can only be measured, not appraised.
+ */
+void ima_buffer_check(void *buf, loff_t size, enum ima_buffer_id buffer_id)
+{
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+
+	if (buffer_id > MEASURING_MAX_BUFFER_ID)
+		return;
+
+	if (!ima_match_buffer_id(_idmap[buffer_id].func, &pcr))
+		return;
+
+	process_buffer_measurement(buf, size, buffer_id, pcr);
+}
+EXPORT_SYMBOL_GPL(ima_buffer_check);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index aed47b7..521d612 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -370,6 +370,32 @@ int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
 	return action;
 }
 
+/**
+ * ima_match_buffer_id - decision based on policy
+ * @buffer_id: IMA buffer identifier
+ *
+ * Measure decision based the buffer identifier's existence in policy.
+ * Without an inode, buffers can only be measured, not appraised.
+ */
+int ima_match_buffer_id(enum ima_hooks func, int *pcr)
+{
+	struct ima_rule_entry *entry;
+	int result = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, ima_rules, list) {
+		if ((entry->action == MEASURE) && (entry->flags & IMA_FUNC) &&
+		     (entry->func == func)) {
+			if (entry->flags & IMA_PCR)
+				*pcr = entry->pcr;
+			result = 1;
+		}
+	}
+	rcu_read_unlock();
+
+	return result;
+}
+
 /*
  * Initialize the ima_policy_flag variable based on the currently
  * loaded policy.  Based on this flag, the decision to short circuit
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
