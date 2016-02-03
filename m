Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aR2nm-0003mA-1P
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 19:09:23 +0000
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 05:08:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D69752CE8055
 for <kexec@lists.infradead.org>; Thu,  4 Feb 2016 06:08:52 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13J8iE966781296
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:08:52 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13J8Jij010800
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:08:20 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 20/22] ima: load policy using path
Date: Wed,  3 Feb 2016 14:06:28 -0500
Message-Id: <1454526390-19792-21-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-modules@vger.kernel.org, fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Kees Cook <keescook@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Dmitry Kasatkin <d.kasatkin@samsung.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

From: Dmitry Kasatkin <d.kasatkin@samsung.com>

We currently cannot do appraisal or signature vetting of IMA policies
since we currently can only load IMA policies by writing the contents
of the policy directly in, as follows:

cat policy-file > <securityfs>/ima/policy

If we provide the kernel the path to the IMA policy so it can load
the policy itself it'd be able to later appraise or vet the file
signature if it has one.  This patch adds support to load the IMA
policy with a given path as follows:

echo /etc/ima/ima_policy > /sys/kernel/security/ima/policy

Changelog v3:
- moved kernel_read_file_from_path() to a separate patch
v2:
- after re-ordering the patches, replace calling integrity_kernel_read()
  to read the file with kernel_read_file_from_path() (Mimi)
- Patch description re-written by Luis R. Rodriguez

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/fs.h              |  1 +
 security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d4d556e..b648e6d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2531,6 +2531,7 @@ enum kernel_read_file_id {
 	READING_MODULE,
 	READING_KEXEC_IMAGE,
 	READING_KEXEC_INITRAMFS,
+	READING_POLICY,
 	READING_MAX_ID
 };
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index f355231..00ccd67 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
+#include <linux/vmalloc.h>
 
 #include "ima.h"
 
@@ -258,6 +259,41 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
+static ssize_t ima_read_policy(char *path)
+{
+	void *data;
+	char *datap;
+	loff_t size;
+	int rc, pathlen = strlen(path);
+
+	char *p;
+
+	/* remove \n */
+	datap = path;
+	strsep(&datap, "\n");
+
+	rc = kernel_read_file_from_path(path, &data, &size, 0, READING_POLICY);
+	if (rc < 0)
+		return rc;
+
+	datap = data;
+	while (size > 0 && (p = strsep(&datap, "\n"))) {
+		pr_debug("rule: %s\n", p);
+		rc = ima_parse_add_rule(p);
+		if (rc < 0)
+			break;
+		size -= rc;
+	}
+
+	vfree(data);
+	if (rc < 0)
+		return rc;
+	else if (size)
+		return -EINVAL;
+	else
+		return pathlen;
+}
+
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
@@ -286,9 +322,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	result = mutex_lock_interruptible(&ima_write_mutex);
 	if (result < 0)
 		goto out_free;
-	result = ima_parse_add_rule(data);
-	mutex_unlock(&ima_write_mutex);
 
+	if (data[0] == '/')
+		result = ima_read_policy(data);
+	else
+		result = ima_parse_add_rule(data);
+	mutex_unlock(&ima_write_mutex);
 out_free:
 	kfree(data);
 out:
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
