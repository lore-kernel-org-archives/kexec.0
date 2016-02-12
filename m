Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([125.16.236.6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUIUq-000783-JV
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 18:31:14 +0000
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 13 Feb 2016 00:00:47 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CIUhjr63242414
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:00:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CIUf78031412
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:00:42 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 05/19] vfs: define kernel_read_file_id enumeration
Date: Fri, 12 Feb 2016 13:29:17 -0500
Message-Id: <1455301771-7703-6-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Kees Cook <keescook@chromium.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

To differentiate between the kernel_read_file() callers, this patch
defines a new enumeration named kernel_read_file_id and includes the
caller identifier as an argument.

Subsequent patches define READING_KEXEC_IMAGE, READING_KEXEC_INITRAMFS,
READING_FIRMWARE, READING_MODULE, and READING_POLICY.

Changelog v3:
- Replace the IMA specific enumeration with a generic one.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exec.c                 | 4 ++--
 include/linux/fs.h        | 7 ++++++-
 include/linux/lsm_hooks.h | 4 +++-
 include/linux/security.h  | 7 +++++--
 security/security.c       | 5 +++--
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6b6668b..1138dc5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -833,7 +833,7 @@ int kernel_read(struct file *file, loff_t offset,
 EXPORT_SYMBOL(kernel_read);
 
 int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size)
+		     loff_t max_size, enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
@@ -871,7 +871,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		goto out;
 	}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size);
+	ret = security_kernel_post_read_file(file, *buf, i_size, id);
 	if (!ret)
 		*size = pos;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9a83d82..aa84bcb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2576,8 +2576,13 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
+enum kernel_read_file_id {
+	READING_MAX_ID
+};
+
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
-extern int kernel_read_file(struct file *, void **, loff_t *, loff_t);
+extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
+			    enum kernel_read_file_id);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f82631c..2337f33 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -567,6 +567,7 @@
  *	by the kernel.
  *	@buf pointer to buffer containing the file contents.
  *	@size length of the file contents.
+ *	@id kernel read file identifier
  *	Return 0 if permission is granted.
  * @task_fix_setuid:
  *	Update the module's state after setting one or more of the user
@@ -1464,7 +1465,8 @@ union security_list_options {
 	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_module_from_file)(struct file *file);
-	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size);
+	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
+				     enum kernel_read_file_id id);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
 				int flags);
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
diff --git a/include/linux/security.h b/include/linux/security.h
index f30f564..b68ce94 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/fs.h>
 
 struct linux_binprm;
 struct cred;
@@ -301,7 +302,8 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_fw_from_file(struct file *file, char *buf, size_t size);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
-int security_kernel_post_read_file(struct file *file, char *buf, loff_t size);
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
+				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
@@ -868,7 +870,8 @@ static inline int security_kernel_module_from_file(struct file *file)
 }
 
 static inline int security_kernel_post_read_file(struct file *file,
-						 char *buf, loff_t size)
+						 char *buf, loff_t size,
+						 enum kernel_read_file_id id)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index ae50730..796a261 100644
--- a/security/security.c
+++ b/security/security.c
@@ -910,9 +910,10 @@ int security_kernel_module_from_file(struct file *file)
 	return ima_module_check(file);
 }
 
-int security_kernel_post_read_file(struct file *file, char *buf, loff_t size)
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
+				   enum kernel_read_file_id id)
 {
-	return call_int_hook(kernel_post_read_file, 0, file, buf, size);
+	return call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
