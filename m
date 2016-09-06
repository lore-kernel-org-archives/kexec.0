Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bhGyl-0006xl-4I
 for kexec@lists.infradead.org; Tue, 06 Sep 2016 14:04:01 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u86E3DVQ062287
 for <kexec@lists.infradead.org>; Tue, 6 Sep 2016 10:03:42 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259w3j037f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 06 Sep 2016 10:03:42 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 00:03:40 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C32F2CE8046
 for <kexec@lists.infradead.org>; Wed,  7 Sep 2016 00:03:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u86E3cDu59375696
 for <kexec@lists.infradead.org>; Wed, 7 Sep 2016 00:03:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u86E3bEn028120
 for <kexec@lists.infradead.org>; Wed, 7 Sep 2016 00:03:37 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 6/9] ima: store the builtin/custom template definitions in
 a list
Date: Tue,  6 Sep 2016 10:03:01 -0400
In-Reply-To: <1473170584-15094-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1473170584-15094-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1473170584-15094-7-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

The builtin and single custom templates are currently stored in an
array.  In preparation for being able to restore a measurement list
containing multiple builtin/custom templates, this patch stores the
builtin and custom templates as a linked list.  This will permit
defining more than one custom template per boot.

Changelog v2:
- fix lookup_template_desc() preemption imbalance (kernel test robot)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h          |  2 ++
 security/integrity/ima/ima_main.c     |  1 +
 security/integrity/ima/ima_template.c | 43 +++++++++++++++++++++++++++--------
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 634d140..e8303c9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -81,6 +81,7 @@ struct ima_template_field {
 
 /* IMA template descriptor definition */
 struct ima_template_desc {
+	struct list_head list;
 	char *name;
 	char *fmt;
 	int num_fields;
@@ -136,6 +137,7 @@ int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
+void ima_init_template_list(void);
 
 #ifdef CONFIG_KEXEC_FILE
 void ima_load_kexec_buffer(void);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 596ef61..592f318 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -418,6 +418,7 @@ static int __init init_ima(void)
 {
 	int error;
 
+	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
 	error = ima_init();
 	if (!error) {
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7c90075..e1f9ce7 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -15,16 +15,20 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/rculist.h>
 #include "ima.h"
 #include "ima_template_lib.h"
 
-static struct ima_template_desc defined_templates[] = {
+static struct ima_template_desc builtin_templates[] = {
 	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
 	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
+static LIST_HEAD(defined_templates);
+spinlock_t template_list;
+
 static struct ima_template_field supported_fields[] = {
 	{.field_id = "d", .field_init = ima_eventdigest_init,
 	 .field_show = ima_show_template_digest},
@@ -81,7 +85,7 @@ __setup("ima_template=", ima_template_setup);
 
 static int __init ima_template_fmt_setup(char *str)
 {
-	int num_templates = ARRAY_SIZE(defined_templates);
+	int num_templates = ARRAY_SIZE(builtin_templates);
 
 	if (ima_template)
 		return 1;
@@ -92,22 +96,28 @@ static int __init ima_template_fmt_setup(char *str)
 		return 1;
 	}
 
-	defined_templates[num_templates - 1].fmt = str;
-	ima_template = defined_templates + num_templates - 1;
+	builtin_templates[num_templates - 1].fmt = str;
+	ima_template = builtin_templates + num_templates - 1;
+
 	return 1;
 }
 __setup("ima_template_fmt=", ima_template_fmt_setup);
 
 static struct ima_template_desc *lookup_template_desc(const char *name)
 {
-	int i;
+	struct ima_template_desc *template_desc;
+	int found = 0;
 
-	for (i = 0; i < ARRAY_SIZE(defined_templates); i++) {
-		if (strcmp(defined_templates[i].name, name) == 0)
-			return defined_templates + i;
+	rcu_read_lock();
+	list_for_each_entry_rcu(template_desc, &defined_templates, list) {
+		if ((strcmp(template_desc->name, name) == 0) ||
+		    (strcmp(template_desc->fmt, name) == 0)) {
+			found = 1;
+			break;
+		}
 	}
-
-	return NULL;
+	rcu_read_unlock();
+	return found ? template_desc : NULL;
 }
 
 static struct ima_template_field *lookup_template_field(const char *field_id)
@@ -183,6 +193,19 @@ static int template_desc_init_fields(const char *template_fmt,
 	return 0;
 }
 
+void __init ima_init_template_list(void)
+{
+	int i;
+
+	spin_lock(&template_list);
+	for (i = 0; i < ARRAY_SIZE(builtin_templates); i++) {
+		list_add_tail_rcu(&builtin_templates[i].list,
+				  &defined_templates);
+	}
+	spin_unlock(&template_list);
+	synchronize_rcu();
+}
+
 struct ima_template_desc *ima_template_desc_current(void)
 {
 	if (!ima_template)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
