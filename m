Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aHcdf-0005lU-Fh
 for kexec@lists.infradead.org; Fri, 08 Jan 2016 19:23:56 +0000
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 9 Jan 2016 05:23:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8803D3578054
 for <kexec@lists.infradead.org>; Sat,  9 Jan 2016 06:23:28 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u08JNK5k39256074
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:23:28 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u08JMtf2018775
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:22:56 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/5] kexec: replace call to copy_file_from_fd() with
 kernel version
Date: Fri,  8 Jan 2016 14:22:02 -0500
Message-Id: <1452280924-28774-4-git-send-email-zohar@linux.vnet.ibm.com>
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

This patch defines kernel_read_file_from_fd(), a wrapper for the VFS
common kernel_read_file(), and replaces the kexec copy_file_from_fd()
calls with the kernel_read_file_from_fd() wrapper.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c           | 15 +++++++++++
 include/linux/fs.h  |  1 +
 kernel/kexec_file.c | 76 +++++------------------------------------------------
 3 files changed, 23 insertions(+), 69 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3c48a19..4ad2fca 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -887,6 +887,21 @@ out:
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     int policy_id)
+{
+	struct fd f = fdget(fd);
+	int ret = -ENOEXEC;
+
+	if (!f.file)
+		goto out;
+
+	ret = kernel_read_file(f.file, buf, size, max_size, policy_id);
+out:
+	fdput(f);
+	return ret;
+}
+
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9b1468c..9642623 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2528,6 +2528,7 @@ extern int do_pipe_flags(int *, int);
 
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t, int);
+extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t, int);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 81d20e8..f7c3ce4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -34,69 +34,6 @@ size_t __weak kexec_purgatory_size = 0;
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
-static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len,
-			     enum ima_policy_id policy_id)
-{
-	struct fd f = fdget(fd);
-	int ret;
-	struct kstat stat;
-	loff_t pos;
-	ssize_t bytes = 0;
-
-	if (!f.file)
-		return -EBADF;
-
-	ret = vfs_getattr(&f.file->f_path, &stat);
-	if (ret)
-		goto out;
-
-	if (stat.size > INT_MAX) {
-		ret = -EFBIG;
-		goto out;
-	}
-
-	/* Don't hand 0 to vmalloc, it whines. */
-	if (stat.size == 0) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	*buf = vmalloc(stat.size);
-	if (!*buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	pos = 0;
-	while (pos < stat.size) {
-		bytes = kernel_read(f.file, pos, (char *)(*buf) + pos,
-				    stat.size - pos);
-		if (bytes < 0) {
-			ret = bytes;
-			goto out_free;
-		}
-
-		if (bytes == 0)
-			break;
-		pos += bytes;
-	}
-
-	if (pos != stat.size)
-		ret = -EBADF;
-
-	ret = ima_hash_and_process_file(f.file, *buf, stat.size, policy_id);
-	if (!ret)
-		*buf_len = pos;
-out_free:
-	if (ret < 0) {
-		vfree(*buf);
-		*buf = NULL;
-	}
-out:
-	fdput(f);
-	return ret;
-}
-
 /* Architectures can provide this probe function */
 int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 					 unsigned long buf_len)
@@ -185,16 +122,17 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 {
 	int ret = 0;
 	void *ldata;
+	loff_t size;
 
-	ret = copy_file_from_fd(kernel_fd, &image->kernel_buf,
-				&image->kernel_buf_len, KEXEC_CHECK);
+	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
+				       &size, INT_MAX, KEXEC_CHECK);
 	if (ret)
 		return ret;
+	image->kernel_buf_len = size;
 
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
-
 	if (ret)
 		goto out;
 
@@ -209,11 +147,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-		ret = copy_file_from_fd(initrd_fd, &image->initrd_buf,
-					&image->initrd_buf_len,
-					INITRAMFS_CHECK);
+		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
+					       &size, INT_MAX, INITRAMFS_CHECK);
 		if (ret)
 			goto out;
+		image->initrd_buf_len = size;
 	}
 
 	if (cmdline_len) {
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
