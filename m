Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D8CC04A94
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 02:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dsJkzfnNcRFIwC1t5mYkNMMEm7bEl5bgaF1R2FFmKN8=; b=Zbe07HIcBlpc3W
	UN5gON2SPLvDTBYaOr1iX+euADjSMQ5Allw9vJCtcOWfFjCof2+NfdTKeNYIsX5LqvqX+FDlzNaZq
	XkmTL+rHyUl7nipMEc+xBQbr2zm5idsiwIiw1NqDHyC6ktRaPkZa55Ly63UjWVfymeMDcm9CoYosY
	UvE6oEt6TzFdxWg5cRHmBhamAqwI6gYqTTJKytaIRKfHYpYyJLHuNzrfEL4X77qK/ErhGup66bLJ2
	t571VICeXe+SLeDPTo+oLyVbnnIziZR9JQvb9lV+9jaKOgkyIJSym5HNqiQSnmssvqNXDRyasbt+r
	05Gia0ZtTTRRjRx4ghxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qROIC-006Ths-1u;
	Thu, 03 Aug 2023 02:42:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qROI7-006Tgb-2I
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 02:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691030538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjDoAqX3FoKO2S3UkbWkJKnGlDBiPfdSFpZOxGXjdPg=;
	b=WX6c40uRVMFicGnIv8i8WriTBIYaXRic9HHQjOLi3XrSUvwrpxM8hfknxVF8GSwsDEjyDO
	Oxf1hUoCAAcsPYptOshlQxan+bZbL1yIg1aXjAE0/9b4H6wIAAPkMefUrAD1K8itzH9Pya
	OAzdUqv2OCMeHlDR4RcfSOKi8rQ814M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-HS_ckUesNcqCO4Uj6aA4lg-1; Wed, 02 Aug 2023 22:42:15 -0400
X-MC-Unique: HS_ckUesNcqCO4Uj6aA4lg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88CF4803FDC;
	Thu,  3 Aug 2023 02:42:15 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 497E71454143;
	Thu,  3 Aug 2023 02:42:11 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv7 1/5] kexec/arm64: Simplify the code for zImage
Date: Thu,  3 Aug 2023 10:41:48 +0800
Message-Id: <20230803024152.11663-2-piliu@redhat.com>
In-Reply-To: <20230803024152.11663-1-piliu@redhat.com>
References: <20230803024152.11663-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_194219_822252_60C2C60A 
X-CRM114-Status: GOOD (  30.96  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Inside zimage_probe(), it uncompresses the kernel and performs some
check, similar to image_probe(). Taking a close look, the uncompressing
has already executed before the image probe is called. What is missing
here is to provide a fd, pointing to an uncompressed kernel image.

This patch creates a memfd based on the result produced by
slurp_decompress_file(), and finally simplify the logical of the probe
for aarch64.

The credit goes to the Dave Young, who contributes the original code.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Co-authored-by: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm64/Makefile             |   3 +-
 kexec/arch/arm64/kexec-arm64.c        |   1 -
 kexec/arch/arm64/kexec-arm64.h        |   6 -
 kexec/arch/arm64/kexec-image-arm64.c  |   2 +-
 kexec/arch/arm64/kexec-zImage-arm64.c | 226 --------------------------
 kexec/kexec.c                         |  42 +++--
 6 files changed, 26 insertions(+), 254 deletions(-)
 delete mode 100644 kexec/arch/arm64/kexec-zImage-arm64.c

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index d27c8ee..9d9111c 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -15,8 +15,7 @@ arm64_KEXEC_SRCS += \
 	kexec/arch/arm64/kexec-arm64.c \
 	kexec/arch/arm64/kexec-elf-arm64.c \
 	kexec/arch/arm64/kexec-uImage-arm64.c \
-	kexec/arch/arm64/kexec-image-arm64.c \
-	kexec/arch/arm64/kexec-zImage-arm64.c
+	kexec/arch/arm64/kexec-image-arm64.c
 
 arm64_UIMAGE = kexec/kexec-uImage.c
 
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index ec6df4b..a830ec7 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -74,7 +74,6 @@ struct file_type file_type[] = {
 	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
 	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
-	{"zImage", zImage_arm64_probe, zImage_arm64_load, zImage_arm64_usage},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 5eb9fc0..d29b1b3 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -44,12 +44,6 @@ int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		      struct kexec_info *info);
 void uImage_arm64_usage(void);
 
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size);
-int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
-	off_t kernel_size, struct kexec_info *info);
-void zImage_arm64_usage(void);
-
-
 extern off_t initrd_base;
 extern off_t initrd_size;
 
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index aa8f2e2..a196747 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -114,6 +114,6 @@ exit:
 void image_arm64_usage(void)
 {
 	printf(
-"     An ARM64 binary image, uncompressed, big or little endian.\n"
+"     An ARM64 binary image, compressed or not, big or little endian.\n"
 "     Typically an Image file.\n\n");
 }
diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
deleted file mode 100644
index 6ee82ff..0000000
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ /dev/null
@@ -1,226 +0,0 @@
-/*
- * ARM64 kexec zImage (Image.gz) support.
- *
- * Several distros use 'make zinstall' rule inside
- * 'arch/arm64/boot/Makefile' to install the arm64
- * Image.gz compressed file inside the boot destination
- * directory (for e.g. /boot).
- *
- * Currently we cannot use kexec_file_load() to load vmlinuz
- * (or Image.gz).
- *
- * To support Image.gz, we should:
- * a). Copy the contents of Image.gz to a temporary file.
- * b). Decompress (gunzip-decompress) the contents inside the
- *     temporary file.
- * c). Pass the 'fd' of the temporary file to the kernel space.
- *
- * So basically the kernel space still gets a decompressed
- * kernel image to load via kexec-tools.
- */
-
-#define _GNU_SOURCE
-
-#include <errno.h>
-#include <fcntl.h>
-#include <limits.h>
-#include <stdlib.h>
-#include "crashdump-arm64.h"
-#include "image-header.h"
-#include "kexec.h"
-#include "kexec-arm64.h"
-#include "kexec-syscall.h"
-#include "kexec-zlib.h"
-#include "arch/options.h"
-
-#define FILENAME_IMAGE		"/tmp/ImageXXXXXX"
-
-/* Returns:
- * -1 : in case of error/invalid format (not a valid Image.gz format.
- * fd : File descriptor of the temp file containing the decompressed
- *      Image.
- */
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
-{
-	int ret = -1;
-	int fd = 0;
-	int kernel_fd = 0;
-	char *fname = NULL;
-	char *kernel_uncompressed_buf = NULL;
-	const struct arm64_image_header *h;
-
-	if (!is_zlib_file(kernel_buf, &kernel_size)) {
-		dbgprintf("%s: Not an zImage file (Image.gz).\n", __func__);
-		return -1;
-	}
-
-	if (!(fname = strdup(FILENAME_IMAGE))) {
-		dbgprintf("%s: Can't duplicate strings %s\n", __func__,
-				fname);
-		return -1;
-	}
-
-	if ((fd = mkstemp(fname)) < 0) {
-		dbgprintf("%s: Can't open file %s\n", __func__,
-				fname);
-		ret = -1;
-		goto fail_mkstemp;
-	}
-
-	kernel_uncompressed_buf =
-		(char *) calloc(kernel_size, sizeof(off_t));
-	if (!kernel_uncompressed_buf) {
-		dbgprintf("%s: Can't calloc %ld bytes\n",
-				__func__, kernel_size);
-		ret= -ENOMEM;
-		goto fail_calloc;
-	}
-
-	/* slurp in the input kernel */
-	dbgprintf("%s: ", __func__);
-	kernel_uncompressed_buf = slurp_decompress_file(kernel_buf,
-							&kernel_size);
-
-	/* check for correct header magic */
-	if (kernel_size < sizeof(struct arm64_image_header)) {
-		dbgprintf("%s: No arm64 image header.\n", __func__);
-		ret = -1;
-		goto fail_bad_header;
-	}
-
-	h = (const struct arm64_image_header *)(kernel_uncompressed_buf);
-
-	if (!arm64_header_check_magic(h)) {
-		dbgprintf("%s: Bad arm64 image header.\n", __func__);
-		ret = -1;
-		goto fail_bad_header;
-	}
-
-	if (write(fd, kernel_uncompressed_buf,
-				kernel_size) != kernel_size) {
-		dbgprintf("%s: Can't write the uncompressed file %s\n",
-				__func__, fname);
-		ret = -1;
-		goto fail_bad_header;
-	}
-
-	close(fd);
-
-	/* Open the tmp file again, this time in O_RDONLY mode, as
-	 * opening the file in O_RDWR and calling kexec_file_load()
-	 * causes the kernel to return -ETXTBSY
-	 */
-	kernel_fd = open(fname, O_RDONLY);
-	if (kernel_fd == -1) {
-		dbgprintf("%s: Failed to open file %s\n",
-				__func__, fname);
-		ret = -1;
-		goto fail_bad_header;
-	}
-
-	unlink(fname);
-
-	free(kernel_uncompressed_buf);
-	free(fname);
-
-	return kernel_fd;
-
-fail_bad_header:
-	free(kernel_uncompressed_buf);
-
-fail_calloc:
-	if (fd >= 0)
-		close(fd);
-
-	unlink(fname);
-
-fail_mkstemp:
-	free(fname);
-
-	return ret;
-}
-
-int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
-	off_t kernel_size, struct kexec_info *info)
-{
-	const struct arm64_image_header *header;
-	unsigned long kernel_segment;
-	int result;
-
-	if (info->file_mode) {
-		if (arm64_opts.initrd) {
-			info->initrd_fd = open(arm64_opts.initrd, O_RDONLY);
-			if (info->initrd_fd == -1) {
-				fprintf(stderr,
-					"Could not open initrd file %s:%s\n",
-					arm64_opts.initrd, strerror(errno));
-				result = EFAILED;
-				goto exit;
-			}
-		}
-
-		if (arm64_opts.command_line) {
-			info->command_line = (char *)arm64_opts.command_line;
-			info->command_line_len =
-					strlen(arm64_opts.command_line) + 1;
-		}
-
-		return 0;
-	}
-
-	header = (const struct arm64_image_header *)(kernel_buf);
-
-	if (arm64_process_image_header(header))
-		return EFAILED;
-
-	kernel_segment = arm64_locate_kernel_segment(info);
-
-	if (kernel_segment == ULONG_MAX) {
-		dbgprintf("%s: Kernel segment is not allocated\n", __func__);
-		result = EFAILED;
-		goto exit;
-	}
-
-	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
-	dbgprintf("%s: text_offset:    %016lx\n", __func__,
-		arm64_mem.text_offset);
-	dbgprintf("%s: image_size:     %016lx\n", __func__,
-		arm64_mem.image_size);
-	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
-		arm64_mem.phys_offset);
-	dbgprintf("%s: vp_offset:      %016lx\n", __func__,
-		arm64_mem.vp_offset);
-	dbgprintf("%s: PE format:      %s\n", __func__,
-		(arm64_header_check_pe_sig(header) ? "yes" : "no"));
-
-	/* create and initialize elf core header segment */
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		result = load_crashdump_segments(info);
-		if (result) {
-			dbgprintf("%s: Creating eflcorehdr failed.\n",
-								__func__);
-			goto exit;
-		}
-	}
-
-	/* load the kernel */
-	add_segment_phys_virt(info, kernel_buf, kernel_size,
-			kernel_segment + arm64_mem.text_offset,
-			arm64_mem.image_size, 0);
-
-	/* load additional data */
-	result = arm64_load_other_segments(info, kernel_segment
-		+ arm64_mem.text_offset);
-
-exit:
-	if (result)
-		fprintf(stderr, "kexec: load failed.\n");
-	return result;
-}
-
-void zImage_arm64_usage(void)
-{
-	printf(
-"     An ARM64 zImage, compressed, big or little endian.\n"
-"     Typically an Image.gz or Image.lzma file.\n\n");
-}
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 36bb2ad..d132eb5 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -638,6 +638,21 @@ char *slurp_decompress_file(const char *filename, off_t *r_size)
 	return kernel_buf;
 }
 
+static int copybuf_memfd(const char *kernel_buf, size_t size)
+{
+	int fd, count;
+
+	fd = memfd_create("kernel", MFD_ALLOW_SEALING);
+	if (fd == -1)
+		return fd;
+
+	count = write(fd, kernel_buf, size);
+	if (count < 0)
+		return -1;
+
+	return fd;
+}
+
 static void update_purgatory(struct kexec_info *info)
 {
 	static const uint8_t null_buf[256];
@@ -1290,31 +1305,22 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	kernel = argv[fileind];
 
-	kernel_fd = open(kernel, O_RDONLY);
-	if (kernel_fd == -1) {
-		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
+	/* slurp in the input kernel */
+	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
+	if (!kernel_buf) {
+		fprintf(stderr, "Failed to decompress file %s:%s\n", kernel,
 				strerror(errno));
 		return EFAILED;
 	}
-
-	/* slurp in the input kernel */
-	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
+	kernel_fd = copybuf_memfd(kernel_buf, kernel_size);
+	if (kernel_fd < 0) {
+		fprintf(stderr, "Failed to copy decompressed buf\n");
+		return EFAILED;
+	}
 
 	for (i = 0; i < file_types; i++) {
-#ifdef __aarch64__
-		/* handle Image.gz like cases */
-		if (is_zlib_file(kernel, &kernel_size)) {
-			if ((ret = file_type[i].probe(kernel, kernel_size)) >= 0) {
-				kernel_fd = ret;
-				break;
-			}
-		} else
-			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
-				break;
-#else
 		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
 			break;
-#endif
 	}
 
 	if (i == file_types) {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
