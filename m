Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vs1-xe49.google.com ([2607:f8b0:4864:20::e49])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxcMW-0000or-Lf
 for kexec@lists.infradead.org; Tue, 13 Aug 2019 19:21:42 +0000
Received: by mail-vs1-xe49.google.com with SMTP id u17so29338946vsq.17
 for <kexec@lists.infradead.org>; Tue, 13 Aug 2019 12:21:39 -0700 (PDT)
Date: Tue, 13 Aug 2019 12:21:23 -0700
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-Id: <20190813192126.122370-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
Subject: [PATCH 3/6] Avoid build warning when !CONFIG_KEXEC_SIG
From: Matthew Garrett <matthewgarrett@google.com>
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
To: jmorris@namei.org
Cc: Jiri Bohac <jbohac@suse.cz>, kexec@lists.infradead.org, Matthew Garrett <matthewgarrett@google.com>, Matthew Garrett <mjg59@google.com>, linux-security-module@vger.kernel.org, Dave Young <dyoung@redhat.com>

Refactor the signature validation and lockdown integration a little in
order to avoid an unused variable.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 72 ++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index be0c13076056..e878587715b9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -177,36 +177,13 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
-/*
- * In file mode list of segments is prepared by kernel. Copy relevant
- * data from user space, do error checking, prepare segment list
- */
+#ifdef CONFIG_KEXEC_SIG
 static int
-kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
-			     const char __user *cmdline_ptr,
-			     unsigned long cmdline_len, unsigned flags)
+kimage_validate_signature(struct kimage *image)
 {
 	const char *reason;
 	int ret;
-	void *ldata;
-	loff_t size;
-
-	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
-				       &size, INT_MAX, READING_KEXEC_IMAGE);
-	if (ret)
-		return ret;
-	image->kernel_buf_len = size;
-
-	/* IMA needs to pass the measurement list to the next kernel. */
-	ima_add_kexec_buffer(image);
 
-	/* Call arch image probe handlers */
-	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
-					    image->kernel_buf_len);
-	if (ret)
-		goto out;
-
-#ifdef CONFIG_KEXEC_SIG
 	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
 					   image->kernel_buf_len);
 	switch (ret) {
@@ -228,7 +205,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	decide:
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
 			pr_notice("%s rejected\n", reason);
-			goto out;
+			break;
 		}
 
 		ret = 0;
@@ -251,9 +228,44 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		 */
 	default:
 		pr_notice("kernel signature verification failed (%d).\n", ret);
-		goto out;
+		break;
 	}
+
+	return ret;
+}
+#endif
+
+/*
+ * In file mode list of segments is prepared by kernel. Copy relevant
+ * data from user space, do error checking, prepare segment list
+ */
+static int
+kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
+			     const char __user *cmdline_ptr,
+			     unsigned long cmdline_len, unsigned flags)
+{
+	int ret;
+	void *ldata;
+	loff_t size;
+
+	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
+				       &size, INT_MAX, READING_KEXEC_IMAGE);
+	if (ret)
+		return ret;
+	image->kernel_buf_len = size;
+
+	/* Call arch image probe handlers */
+	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
+					    image->kernel_buf_len);
+	if (ret)
+		goto out;
+
+#ifdef CONFIG_KEXEC_SIG
+	ret = kimage_validate_signature(image);
+	if (ret)
+		goto out;
 #endif
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
@@ -279,8 +291,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_kexec_cmdline(image->cmdline_buf,
+				  image->cmdline_buf_len - 1);
 	}
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image load handlers */
 	ldata = arch_kexec_kernel_image_load(image);
 
-- 
2.23.0.rc1.153.gdeed80330f-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
