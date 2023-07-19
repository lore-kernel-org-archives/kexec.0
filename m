Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617A3C001DC
	for <kexec@archiver.kernel.org>; Wed, 19 Jul 2023 06:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=75LzCJzeyq1f7sc7cOMZAyJ+DYNFnX0cryKZ/k0dBrE=; b=L34dSLoEcdBvaU
	ZFTTQO+mD7Qd6wJhbDh4ovgQqJKa3q1b9hRBBrASG3wOoKrVlC6rhIb0kbcCKJFUfZRy6ZrGsDZ9b
	envnCLL5L0Y0nz62a96IJFSWkICkP/+fslcPxsxIVUZOgrQQkbpJ3FiDkawwwCMIX5HOuQnyiDIhW
	1aRTn/Iz4wydf9k1AZhBW8cxkkMeiJMEZq8pcI/Lhx93oAvY2mZcaWw4bWe53dk3Zgm/gcmBEPAUa
	Jxzu+VkURj+dDYSLLbDb9ASYR70bP4BAM5TF+jWvDUjAbdG2BzmBHf2iPX/Sgh0B8tDfWhp2LGMRr
	LKpoJX1NarJATQg2LBHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM15i-005yDM-0M;
	Wed, 19 Jul 2023 06:55:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM15g-005yB9-1b
	for kexec@bombadil.infradead.org;
	Wed, 19 Jul 2023 06:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9vP2PddVnjrvv0c1cRBrDK6rOieBX/lLqHSjMrd00ZU=; b=ft5AC0Hr2NooRZvnW2imGaQ/PN
	+3IFPLlNQE30EIp17r7bIZtaaOIHdfN1TSBf++oAtUZnGccxKEcCz6kvvTyMCEQC/1dcMYP71Py6a
	0cewN3fmqcBVxp37fh+9mG86oG+4pFEbS0Gzs/gNPzd2VXvuuAgjy+hz2qcScqAKrquFGwkQlK85/
	l8+vIUmmLA4Su5S3hx0OaoLL4np21xBRJ7mRwOY1tFYXgwwnHfVsIEOU32aICeihADWO8Cy0WYctN
	IBSmlLXBIIg0oIeu6r6pFTraORymxg02/NSoiwWQEOuYHOd8CBi8GJ/sfEWdSVwT7wj9KKZwtdUFF
	FVUO2xqg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLxQe-00ChCu-22
	for kexec@lists.infradead.org;
	Wed, 19 Jul 2023 03:00:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689735635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vP2PddVnjrvv0c1cRBrDK6rOieBX/lLqHSjMrd00ZU=;
	b=WBOiY3UUwKAEFo/ZdO/OhH5WSBMD3VqFA0fHOO3nzuujymXFiYMXX6YpEvc2e17ZpsfQ2w
	Y3cww7N5IvlhnQDPtoTaBBj7ZoJep2suE84XRpFBdjdv02ouZD/T+54wXlFf9dV2c3Sb7w
	hW9WmvoOwT6nR8E/cG+tZSk6D/G2ri4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689735637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vP2PddVnjrvv0c1cRBrDK6rOieBX/lLqHSjMrd00ZU=;
	b=PIF6/HuxFDqr8hylbJ0YJrKUCZrTb61UK71sdOR/4HKWeHq4iXWYr89xRJCVWEhFR/md/Y
	76NHHLpSLyC1oq8XJAUMmonlanWA8yACbtx2e1zZSg5Sd/hRaM/4wZJC58wOAMiiuM122K
	MaX0QGHEjMdd9DJF2pO2qOiBPukxfFw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-mJI82IufPEy1RDCTa7edZQ-1; Tue, 18 Jul 2023 23:00:30 -0400
X-MC-Unique: mJI82IufPEy1RDCTa7edZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B45C8936D22;
	Wed, 19 Jul 2023 03:00:29 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CC3A71454142;
	Wed, 19 Jul 2023 03:00:24 +0000 (UTC)
Date: Wed, 19 Jul 2023 11:02:08 +0800
From: Dave Young <dyoung@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org,
	jeremy.linton@arm.com
Subject: Re: [PATCHv5 0/8] arm64: zboot support
Message-ID: <ZLdSMPJ9LxxFHCrO@darkstar.users.ipa.redhat.com>
References: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230717130732.22710-1-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_040041_052228_0837573A 
X-CRM114-Status: GOOD (  41.18  )
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

Hi Pingfan, Simon,

On 07/17/23 at 09:07pm, Pingfan Liu wrote:
> As more complicated capsule kernel format occurs like zboot, where the
> compressed kernel is stored as a payload. The straight forward
> decompression can not meet the demand.
> 
> As the first step, on aarch64, reading in the kernel file in a probe
> method and decide how to unfold the content by the method itself.
> 
> This series introduce a new image probe interface probe2(), which
> returns three factors: kernel buffer, kernel size and kernel fd through
> a struct parsed_info.
> -1. the parsed kernel_buf should be returned so that it can be used by
> the image load method later.
> -2. the final fd passed to sys_kexec_file_load, since aarch64 kernel can
> only work with Image format, the outer payload should be stripped and a
> temporary file of Image should be created.

I took a look at the Image.gz file load code, the current code can be
simplified with passing a fd directly instead of creating temp files via
memfd_create with the already decompressed kernel_buf. 

The current file load is like below:

do_kexec_file_load():
  1.slurp_decompress_file
    2. probe
      3. load
        4. kexec_file_load

In step 1, the Image.gz has been decompressed to kernel_buf, so just
create a virtual memfd copy to it, then save the virtual fd for step 4
use.

Otherwise in step 2 it is some sanity checking, step 3 is setting
something else eg. initrd_fd, cmdline. With the changes below Image and
Image.gz will share same code. I think you can add the zboot
detection/checking code in the Image probe, load functions, with a new
info->kernel_fd, you can decompress the zboot kernel_buf and save to
another virtual memfd, and set to the info->kernel_fd.  Then in step 4
the kexec_file_load can just use it.

The kernel_buf itself is only used for sanity checking of the formats,
kernel only needs a file fd, so I think it should be fine and easier
than the original ways.

Thoughts?

---
 kexec/arch/arm64/Makefile             |    3 
 kexec/arch/arm64/kexec-arm64.c        |    1 
 kexec/arch/arm64/kexec-arm64.h        |    6 
 kexec/arch/arm64/kexec-image-arm64.c  |    2 
 kexec/arch/arm64/kexec-zImage-arm64.c |  226 ----------------------------------
 kexec/kexec.c                         |   55 +++++---
 kexec/kexec.h                         |    1 
 7 files changed, 39 insertions(+), 255 deletions(-)

Index: kexec-tools/kexec/arch/arm64/Makefile
===================================================================
--- kexec-tools.orig/kexec/arch/arm64/Makefile
+++ kexec-tools/kexec/arch/arm64/Makefile
@@ -15,8 +15,7 @@ arm64_KEXEC_SRCS += \
 	kexec/arch/arm64/kexec-arm64.c \
 	kexec/arch/arm64/kexec-elf-arm64.c \
 	kexec/arch/arm64/kexec-uImage-arm64.c \
-	kexec/arch/arm64/kexec-image-arm64.c \
-	kexec/arch/arm64/kexec-zImage-arm64.c
+	kexec/arch/arm64/kexec-image-arm64.c
 
 arm64_UIMAGE = kexec/kexec-uImage.c
 
Index: kexec-tools/kexec/arch/arm64/kexec-arm64.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm64/kexec-arm64.c
+++ kexec-tools/kexec/arch/arm64/kexec-arm64.c
@@ -74,7 +74,6 @@ struct file_type file_type[] = {
 	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
 	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
-	{"zImage", zImage_arm64_probe, zImage_arm64_load, zImage_arm64_usage},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
Index: kexec-tools/kexec/arch/arm64/kexec-arm64.h
===================================================================
--- kexec-tools.orig/kexec/arch/arm64/kexec-arm64.h
+++ kexec-tools/kexec/arch/arm64/kexec-arm64.h
@@ -44,12 +44,6 @@ int uImage_arm64_load(int argc, char **a
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
 
Index: kexec-tools/kexec/arch/arm64/kexec-image-arm64.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm64/kexec-image-arm64.c
+++ kexec-tools/kexec/arch/arm64/kexec-image-arm64.c
@@ -114,6 +114,6 @@ exit:
 void image_arm64_usage(void)
 {
 	printf(
-"     An ARM64 binary image, uncompressed, big or little endian.\n"
+"     An ARM64 binary image, compressed or not, big or little endian.\n"
 "     Typically an Image file.\n\n");
 }
Index: kexec-tools/kexec/arch/arm64/kexec-zImage-arm64.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm64/kexec-zImage-arm64.c
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
Index: kexec-tools/kexec/kexec.c
===================================================================
--- kexec-tools.orig/kexec/kexec.c
+++ kexec-tools/kexec/kexec.c
@@ -638,6 +638,21 @@ char *slurp_decompress_file(const char *
 	return kernel_buf;
 }
 
+int copybuf_memfd(const char *kernel_buf, size_t size)
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
@@ -1263,7 +1278,7 @@ static int do_kexec_file_load(int filein
 			unsigned long flags) {
 
 	char *kernel;
-	int kernel_fd, i;
+	int kernel_fd, i, fd;
 	struct kexec_info info;
 	int ret = 0;
 	char *kernel_buf;
@@ -1277,6 +1292,7 @@ static int do_kexec_file_load(int filein
 	info.kexec_flags = flags;
 
 	info.file_mode = 1;
+	info.kernel_fd = -1;
 	info.initrd_fd = -1;
 
 	if (!is_kexec_file_load_implemented())
@@ -1299,22 +1315,16 @@ static int do_kexec_file_load(int filein
 
 	/* slurp in the input kernel */
 	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
+	fd = copybuf_memfd(kernel_buf, kernel_size);
+	if (fd < 0)
+		fprintf(stderr, "Failed to copy decompressed buf\n");
+	else {
+		kernel_fd = fd;
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
@@ -1324,12 +1334,19 @@ static int do_kexec_file_load(int filein
 		return EFAILED;
 	}
 
-	ret = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
-	if (ret < 0) {
-		fprintf(stderr, "Cannot load %s\n", kernel);
-		close(kernel_fd);
-		return ret;
-	}
+       ret = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
+       if (ret < 0) {
+               fprintf(stderr, "Cannot load %s\n", kernel);
+               close(kernel_fd);
+               return ret;
+       }
+
+       /*
+	* image type specific load functioin detect the capsule kernel type
+	* and create another fd for file load. For example the zboot kernel.
+	*/
+	if (info.kernel_fd != -1)
+		kernel_fd = info.kernel_fd;
 
 	/*
 	 * If there is no initramfs, set KEXEC_FILE_NO_INITRAMFS flag so that
Index: kexec-tools/kexec/kexec.h
===================================================================
--- kexec-tools.orig/kexec/kexec.h
+++ kexec-tools/kexec/kexec.h
@@ -164,6 +164,7 @@ struct kexec_info {
 	unsigned long file_mode :1;
 
 	/* Filled by kernel image processing code */
+	int kernel_fd;
 	int initrd_fd;
 	char *command_line;
 	int command_line_len;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
