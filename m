Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aHcdi-0005ls-12
 for kexec@lists.infradead.org; Fri, 08 Jan 2016 19:23:59 +0000
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 9 Jan 2016 05:23:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 034AE3578052
 for <kexec@lists.infradead.org>; Sat,  9 Jan 2016 06:23:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u08JN23S32112746
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:23:10 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u08JMxhw018815
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:22:59 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH 4/5] ima: replace call to integrity_read_file() with
 kernel version
Date: Fri,  8 Jan 2016 14:22:03 -0500
Message-Id: <1452280924-28774-5-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

This patch defines kernel_read_file_from_path(), a wrapper for the VFS
common kernel_read_file(), and replaces the integrity_read_file() with
a call to the kernel_read_file_from_path() wrapper.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c                       | 21 +++++++++++++++++++++
 include/linux/fs.h              |  1 +
 security/integrity/ima/ima_fs.c | 15 +++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4ad2fca..f79c845 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -902,6 +902,27 @@ out:
 	return ret;
 }
 
+int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
+			       loff_t max_size, int policy_id)
+{
+	struct file *file;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		pr_err("Unable to open file: %s (%d)", path, ret);
+		return ret;
+	}
+
+	ret = kernel_read_file(file, buf, size, max_size, policy_id);
+	fput(file);
+	return ret;
+}
+
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9642623..79b1172 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2529,6 +2529,7 @@ extern int do_pipe_flags(int *, int);
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t, int);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t, int);
+extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t, int);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 685fdca..80bc30b 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
+#include <linux/vmalloc.h>
 
 #include "ima.h"
 
@@ -260,20 +261,22 @@ static const struct file_operations ima_ascii_measurements_ops = {
 
 static ssize_t ima_read_policy(char *path)
 {
-	char *data, *datap;
-	int rc, size, pathlen = strlen(path);
+	void *data;
+	char *datap;
+	loff_t size;
+	int rc, pathlen = strlen(path);
+
 	char *p;
 
 	/* remove \n */
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = integrity_read_file(path, &data, POLICY_CHECK);
+	rc = kernel_read_file_from_path(path, &data, &size, 0, POLICY_CHECK);
 	if (rc < 0)
 		return rc;
 
-	size = rc;
-	datap = data;
+	datap = (char *)data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
 		rc = ima_parse_add_rule(p);
@@ -282,7 +285,7 @@ static ssize_t ima_read_policy(char *path)
 		size -= rc;
 	}
 
-	kfree(data);
+	vfree(data);
 	if (rc < 0)
 		return rc;
 	else if (size)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
