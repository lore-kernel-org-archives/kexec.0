Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDNI0-0004GJ-Uu
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 07:34:41 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id l67so4163750ybb.7
 for <kexec@lists.infradead.org>; Wed, 02 Sep 2020 00:34:38 -0700 (PDT)
Date: Wed,  2 Sep 2020 00:34:04 -0700
Message-Id: <20200902073404.1067640-1-rburanyi@google.com>
Mime-Version: 1.0
Subject: [PATCH] kexec: remove the 2GB size limit on initrd file
From: Robi Buranyi <rburanyi@google.com>
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
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Greg Thelen <gthelen@google.com>
Cc: Robi Buranyi <rburanyi@google.com>

Enable loading initrd files exceeding the INT_MAX size. Remove the
INT_MAX limit completely, and let any initrd load if it fits in the
memory.

Signed-off-by: Robi Buranyi <rburanyi@google.com>
---
 kernel/kexec_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a61..659a9d165198 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -222,7 +222,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	loff_t size;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
-				       &size, INT_MAX, READING_KEXEC_IMAGE);
+				       &size, 0, READING_KEXEC_IMAGE);
 	if (ret)
 		return ret;
 	image->kernel_buf_len = size;
@@ -242,7 +242,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-					       &size, INT_MAX,
+					       &size, 0,
 					       READING_KEXEC_INITRAMFS);
 		if (ret)
 			goto out;
-- 
2.28.0.402.g5ffc5be6b7-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
