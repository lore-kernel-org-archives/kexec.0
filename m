Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by merlin.infradead.org with esmtps (Exim 4.85 #2 (Red Hat Linux))
 id 1aR2nT-0005hc-4j
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 19:08:59 +0000
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 05:08:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6A34C2CE8055
 for <kexec@lists.infradead.org>; Thu,  4 Feb 2016 06:08:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13J80Oa44695610
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:08:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13J7x4O010223
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:08:00 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 15/22] vfs: define kernel_copy_file_from_fd()
Date: Wed,  3 Feb 2016 14:06:23 -0500
Message-Id: <1454526390-19792-16-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch defines kernel_read_file_from_fd(), a wrapper for the VFS
common kernel_read_file().

Changelog:
- Separated from the kernel modules patch

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c          | 16 ++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 1d39c4e..f3a0ce2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -910,6 +910,22 @@ int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	struct fd f = fdget(fd);
+	int ret = -EBADF;
+
+	if (!f.file)
+		goto out;
+
+	ret = kernel_read_file(f.file, buf, size, max_size, id);
+out:
+	fdput(f);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
+
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a9670a..5ba806b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2536,6 +2536,8 @@ extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
 extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
+				    enum kernel_read_file_id);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
