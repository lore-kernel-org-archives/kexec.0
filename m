Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwUOL-0002lC-S4
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 17:44:18 +0000
Received: by mail-pl1-x642.google.com with SMTP id d1so5763209plr.8
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 10:43:24 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 07/13] fs/kernel_read_file: Switch buffer size arg to size_t
Date: Fri, 17 Jul 2020 10:43:02 -0700
Message-Id: <20200717174309.1164575-8-keescook@chromium.org>
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
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
To: Scott Branden <scott.branden@broadcom.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

In preparation for further refactoring of kernel_read_file*(), rename
the "max_size" argument to the more accurate "buf_size", and correct
its type to size_t. Add kerndoc to explain the specifics of how the
arguments will be used. Note that with buf_size now size_t, it can no
longer be negative (and was never called with a negative value). Adjust
callers to use it as a "maximum size" when *buf is NULL.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernel_read_file.c            | 34 +++++++++++++++++++++++---------
 include/linux/kernel_read_file.h |  8 ++++----
 security/integrity/digsig.c      |  2 +-
 security/integrity/ima/ima_fs.c  |  2 +-
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index dc28a8def597..e21a76001fff 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -5,15 +5,31 @@
 #include <linux/security.h>
 #include <linux/vmalloc.h>
 
+/**
+ * kernel_read_file() - read file contents into a kernel buffer
+ *
+ * @file	file to read from
+ * @buf		pointer to a "void *" buffer for reading into (if
+ *		*@buf is NULL, a buffer will be allocated, and
+ *		@buf_size will be ignored)
+ * @buf_size	size of buf, if already allocated. If @buf not
+ *		allocated, this is the largest size to allocate.
+ * @id		the kernel_read_file_id identifying the type of
+ *		file contents being read (for LSMs to examine)
+ *
+ * Returns number of bytes read (no single read will be bigger
+ * than INT_MAX), or negative on error.
+ *
+ */
 int kernel_read_file(struct file *file, void **buf,
-		     loff_t max_size, enum kernel_read_file_id id)
+		     size_t buf_size, enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
 	void *allocated = NULL;
 	int ret;
 
-	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
+	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EINVAL;
 
 	ret = deny_write_access(file);
@@ -29,7 +45,7 @@ int kernel_read_file(struct file *file, void **buf,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
+	if (i_size > INT_MAX || i_size > buf_size) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -75,7 +91,7 @@ int kernel_read_file(struct file *file, void **buf,
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
 int kernel_read_file_from_path(const char *path, void **buf,
-			       loff_t max_size, enum kernel_read_file_id id)
+			       size_t buf_size, enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -87,14 +103,14 @@ int kernel_read_file_from_path(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, max_size, id);
+	ret = kernel_read_file(file, buf, buf_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
 int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t max_size,
+				      size_t buf_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -113,13 +129,13 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, max_size, id);
+	ret = kernel_read_file(file, buf, buf_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
+int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -128,7 +144,7 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, max_size, id);
+	ret = kernel_read_file(f.file, buf, buf_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 0ca0bdbed1bd..910039e7593e 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -36,16 +36,16 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 }
 
 int kernel_read_file(struct file *file,
-		     void **buf, loff_t max_size,
+		     void **buf, size_t buf_size,
 		     enum kernel_read_file_id id);
 int kernel_read_file_from_path(const char *path,
-			       void **buf, loff_t max_size,
+			       void **buf, size_t buf_size,
 			       enum kernel_read_file_id id);
 int kernel_read_file_from_path_initns(const char *path,
-				      void **buf, loff_t max_size,
+				      void **buf, size_t buf_size,
 				      enum kernel_read_file_id id);
 int kernel_read_file_from_fd(int fd,
-			     void **buf, loff_t max_size,
+			     void **buf, size_t buf_size,
 			     enum kernel_read_file_id id);
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 97661ffabc4e..04f779c4f5ed 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -175,7 +175,7 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, 0,
+	rc = kernel_read_file_from_path(path, &data, INT_MAX,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 9ba145d3d6d9..8695170d0e5c 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -284,7 +284,7 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, 0, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, INT_MAX, READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
