From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 27 May 2022 02:55:35 +0000
Subject: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
In-Reply-To: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
Message-ID: <20220527025535.3953665-3-pasha.tatashin@soleen.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

In some case initrd can be large. For example, it could be a netboot
image loaded by u-root, that is kexec'ing into it.

The maximum size of initrd is arbitrary set to 2G. Also, the limit is
not very obvious because it is hidden behind a generic INT_MAX macro.

Theoretically, we could make it LONG_MAX, but it is safer to keep it
sane, and just increase it to 4G.

Increase the size to 4G, and make it obvious by having a new macro
that specifies the maximum file size supported by kexec_file_load()
syscall: KEXEC_FILE_SIZE_MAX.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..f00cf70d82b9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -31,6 +31,9 @@
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
+/* Maximum size in bytes for kernel/initrd files. */
+#define KEXEC_FILE_SIZE_MAX	min_t(s64, 4LL << 30, SSIZE_MAX)
+
 /*
  * Currently this is the only default function that is exported as some
  * architectures need it to do additional handlings.
@@ -223,11 +226,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
 			     unsigned long cmdline_len, unsigned flags)
 {
-	int ret;
+	ssize_t ret;
 	void *ldata;
 
 	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
-				       INT_MAX, NULL, READING_KEXEC_IMAGE);
+				       KEXEC_FILE_SIZE_MAX, NULL,
+				       READING_KEXEC_IMAGE);
 	if (ret < 0)
 		return ret;
 	image->kernel_buf_len = ret;
@@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
-					       INT_MAX, NULL,
+					       KEXEC_FILE_SIZE_MAX, NULL,
 					       READING_KEXEC_INITRAMFS);
 		if (ret < 0)
 			goto out;
-- 
2.36.1.124.g0e6072fb45-goog


