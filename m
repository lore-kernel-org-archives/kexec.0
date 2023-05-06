Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66E8C77B7C
	for <kexec@archiver.kernel.org>; Sat,  6 May 2023 03:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FeUvra7aBLaUKeiIazpkfTy19qZwyPNyUdEDgnXSwIs=; b=MpW3gQZbVCsbAm
	sevdSA4Oam7atqBunVePN26FZ6BaVll601f5n0KOrJkM+R7r5weoskKEasebwDUv2c+6LIWbyuARd
	k+Wg0VPMbkyp8pUuSND6W7dpf8NvTk3uO3KqHj0XbxVLIW0GPg4rPzlYNfauYsLj5RZjIbfF5zm7M
	Pw3iMp0/RhZ4aCMDcOKW4RdwHNo421GZi+GG/YSVszqg/Sa5Y7CfcNLWzRWUB/8b2UmncV9gulc+R
	4NzubTf5N9NQvWJ79cdUTvGxoFyqKDEMaQbKc2v4eyDDLmHWCOKgtilNoy0B7OlJs7BJKUJ/ISCpn
	PdeTtUzJw/yf0bImL6jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8Ey-00CPep-1r;
	Sat, 06 May 2023 03:05:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8Et-00CPeA-1D
	for kexec@lists.infradead.org;
	Sat, 06 May 2023 03:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683342335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZXPepF9TFgK936jkG6H+LtcfL/C1Xj7TOMCE9RUUAk=;
	b=WU0uNHapn0ImOUmOStZGhpQ9+01JafcH/acAOupvLYjF+wz06Nie3XFwkKjygSW0zv2xMc
	Y1oo6vz4hX7tgYWXiFW4k14fvGK/sMceqVzixoI56udNy3zolwac3jZ4kT74khT9CYF/XX
	eQ3FCOCFsvgYOPF/16mH6irjSa+iUdw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-wbE_5H10Nnq_SILAoVQ9yA-1; Fri, 05 May 2023 23:05:32 -0400
X-MC-Unique: wbE_5H10Nnq_SILAoVQ9yA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33DCF2807D63;
	Sat,  6 May 2023 03:05:32 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0519F2166B31;
	Sat,  6 May 2023 03:05:28 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCH 5/5] arm64: add support for zboot image
Date: Sat,  6 May 2023 11:05:21 +0800
Message-Id: <20230506030521.12323-1-piliu@redhat.com>
In-Reply-To: <20230505025438.11943-1-piliu@redhat.com>
References: <20230505025438.11943-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_200539_632661_398BC262 
X-CRM114-Status: GOOD (  28.38  )
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

zboot image consists of zboot_header and Image.gz. And the compressed
payload should be located and parsed with extra effort. Most of
important, the kernel can only work with Image, so the final fd should
point to a temporary file, which contains Image.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com

---
 kexec/arch/arm64/Makefile            |   3 +-
 kexec/arch/arm64/kexec-arm64.c       |   1 +
 kexec/arch/arm64/kexec-arm64.h       |   5 +
 kexec/arch/arm64/kexec-zboot-arm64.c | 261 +++++++++++++++++++++++++++
 kexec/arch/arm64/zboot.h             |  26 +++
 5 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 kexec/arch/arm64/kexec-zboot-arm64.c
 create mode 100644 kexec/arch/arm64/zboot.h

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index d27c8ee..7826a36 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -16,7 +16,8 @@ arm64_KEXEC_SRCS += \
 	kexec/arch/arm64/kexec-elf-arm64.c \
 	kexec/arch/arm64/kexec-uImage-arm64.c \
 	kexec/arch/arm64/kexec-image-arm64.c \
-	kexec/arch/arm64/kexec-zImage-arm64.c
+	kexec/arch/arm64/kexec-zImage-arm64.c \
+	kexec/arch/arm64/kexec-zboot-arm64.c
 
 arm64_UIMAGE = kexec/kexec-uImage.c
 
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index ec6df4b..88b5f57 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -72,6 +72,7 @@ const struct arch_map_entry arches[] = {
 
 struct file_type file_type[] = {
 	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
+	{"zboot", zboot_arm64_probe, zboot_arm64_load, zboot_arm64_usage},
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
 	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
 	{"zImage", zImage_arm64_probe, zImage_arm64_load, zImage_arm64_usage},
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 88bb508..98e1be9 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -50,6 +50,11 @@ int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
 void zImage_arm64_usage(void);
 
 
+int zboot_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info);
+int zboot_arm64_load(int argc, char **argv, const char *kernel_buf,
+	off_t kernel_size, struct kexec_info *info);
+void zboot_arm64_usage(void);
+
 extern off_t initrd_base;
 extern off_t initrd_size;
 
diff --git a/kexec/arch/arm64/kexec-zboot-arm64.c b/kexec/arch/arm64/kexec-zboot-arm64.c
new file mode 100644
index 0000000..b6c4fe3
--- /dev/null
+++ b/kexec/arch/arm64/kexec-zboot-arm64.c
@@ -0,0 +1,261 @@
+/*
+ * ARM64 kexec zboot Image support.
+ *
+ * Based on kexec-zImage-arm64.c
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdlib.h>
+#include "crashdump-arm64.h"
+#include "image-header.h"
+#include "kexec.h"
+#include "kexec-arm64.h"
+#include "kexec-syscall.h"
+#include "kexec-zlib.h"
+#include "zboot.h"
+#include "arch/options.h"
+
+#define MZ_MAGIC	0x5a4d	/* "MZ" */
+#define FILENAME_IMAGE_GZ		"/tmp/zboot_Image_gzXXXXXX"
+#define FILENAME_IMAGE		"/tmp/zboot_ImageXXXXXX"
+
+
+static struct zboot_image_header *check_zboot_header(char *buf, off_t size)
+{
+
+	uint32_t magic = MZ_MAGIC;
+	struct zboot_image_header *zh =
+		(struct zboot_image_header *)(buf);
+
+	if (!zh || (size < sizeof(*zh)))
+		return NULL;
+
+	if (memcmp(&zh->magic, &magic, sizeof(zh->magic))) {
+		dbgprintf("%s: Not an zboot Image\n", __func__);
+		return NULL;
+	}
+	if (strncmp(zh->zimg, "zimg", 4)) {
+		dbgprintf("%s: Not an zboot Image\n", __func__);
+		return NULL;
+	}
+	return zh;
+}
+
+/* Returns:
+ * -1 : in case of error/invalid format.
+ */
+int zboot_arm64_probe(const char *kern_fname, off_t kernel_size, struct kexec_info *info)
+{
+	int ret = 0;
+	int fd = 0, gz_fd = 0;
+	int kernel_fd = 0;
+	char *fname = NULL, *gz_fname;
+	char *kernel_buf, *uncompressed_buf = NULL;
+	char *compressed_kernel;
+	const struct arm64_image_header *h;
+	struct zboot_image_header *zh;
+
+	kernel_buf = slurp_file(kern_fname, &kernel_size);
+	zh = check_zboot_header(kernel_buf, kernel_size);
+	if (!zh)
+		return -1;
+
+	if (!(gz_fname = strdup(FILENAME_IMAGE_GZ))) {
+		dbgprintf("%s: Can't duplicate strings %s\n", __func__,
+				gz_fname);
+		return -1;
+	}
+
+	if ((gz_fd = mkstemp(gz_fname)) < 0) {
+		dbgprintf("%s: Can't open file %s\n", __func__,
+				gz_fname);
+		ret = -1;
+		goto fail_mkstemp;
+	}
+
+	/* locate the Image.gz and copy it to a temp file */
+
+	/*
+	 * zboot has SizeOfCode, SizeOfImage, SizeOfHeaders appended at the end. And
+	 * each occupies 4 bytes.
+	 */
+	compressed_kernel = (char *)kernel_buf + zh->gzdata_offset;
+	if (write(gz_fd, compressed_kernel, zh->gzdata_size) != zh->gzdata_size) {
+		dbgprintf("%s: Can't write the Image.gz %s\n",
+				__func__, gz_fname);
+		ret = -1;
+		goto fail_bad_header;
+	}
+	free(kernel_buf);
+	close(gz_fd);
+
+	/* slurp in the input kernel */
+	dbgprintf("%s: ", __func__);
+	/*
+	 * If the kernel enables integrity check, the innermost Image should
+	 * be signed.
+	 */
+	uncompressed_buf = slurp_decompress_file(gz_fname,
+							&kernel_size);
+
+
+	/* double checking against internal Image */
+
+	if (kernel_size < sizeof(struct arm64_image_header)) {
+		dbgprintf("%s: No arm64 image header.\n", __func__);
+		ret = -1;
+		goto fail_bad_header;
+	}
+
+	h = (const struct arm64_image_header *)(uncompressed_buf);
+
+	if (!arm64_header_check_magic(h)) {
+		dbgprintf("%s: Bad arm64 image header.\n", __func__);
+		ret = -1;
+		goto fail_bad_header;
+	}
+
+	if (!(fname = strdup(FILENAME_IMAGE))) {
+		dbgprintf("%s: Can't duplicate strings %s\n", __func__,
+				fname);
+		return -1;
+	}
+
+	if ((fd = mkstemp(fname)) < 0) {
+		dbgprintf("%s: Can't open file %s\n", __func__,
+				fname);
+		ret = -1;
+		goto fail_mkstemp;
+	}
+	if (write(fd, uncompressed_buf,	kernel_size) != kernel_size) {
+		dbgprintf("%s: Can't write the uncompressed file %s\n",
+				__func__, fname);
+		ret = -1;
+		goto fail_bad_header;
+	}
+
+	close(fd);
+
+	/* Open the tmp file again, this time in O_RDONLY mode, as
+	 * opening the file in O_RDWR and calling kexec_file_load()
+	 * causes the kernel to return -ETXTBSY
+	 */
+	kernel_fd = open(fname, O_RDONLY);
+	if (kernel_fd == -1) {
+		dbgprintf("%s: Failed to open file %s\n",
+				__func__, fname);
+		ret = -1;
+		goto fail_bad_header;
+	}
+	info->kernel_fd = kernel_fd;
+	info->kernel_buf = uncompressed_buf;
+
+	unlink(gz_fname);
+	free(gz_fname);
+	unlink(fname);
+	free(fname);
+
+	return ret;
+
+fail_bad_header:
+	free(uncompressed_buf);
+
+	if (fd >= 0)
+		close(fd);
+
+	unlink(fname);
+	unlink(gz_fname);
+
+fail_mkstemp:
+	free(fname);
+	free(gz_fname);
+
+	return ret;
+}
+
+int zboot_arm64_load(int argc, char **argv, const char *kernel_buf,
+	off_t kernel_size, struct kexec_info *info)
+{
+	const struct arm64_image_header *header;
+	unsigned long kernel_segment;
+	int result;
+
+	if (info->file_mode) {
+		if (arm64_opts.initrd) {
+			info->initrd_fd = open(arm64_opts.initrd, O_RDONLY);
+			if (info->initrd_fd == -1) {
+				fprintf(stderr,
+					"Could not open initrd file %s:%s\n",
+					arm64_opts.initrd, strerror(errno));
+				result = EFAILED;
+				goto exit;
+			}
+		}
+
+		if (arm64_opts.command_line) {
+			info->command_line = (char *)arm64_opts.command_line;
+			info->command_line_len =
+					strlen(arm64_opts.command_line) + 1;
+		}
+
+		return 0;
+	}
+
+	header = (const struct arm64_image_header *)(kernel_buf);
+
+	if (arm64_process_image_header(header))
+		return EFAILED;
+
+	kernel_segment = arm64_locate_kernel_segment(info);
+
+	if (kernel_segment == ULONG_MAX) {
+		dbgprintf("%s: Kernel segment is not allocated\n", __func__);
+		result = EFAILED;
+		goto exit;
+	}
+
+	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
+	dbgprintf("%s: text_offset:    %016lx\n", __func__,
+		arm64_mem.text_offset);
+	dbgprintf("%s: image_size:     %016lx\n", __func__,
+		arm64_mem.image_size);
+	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
+		arm64_mem.phys_offset);
+	dbgprintf("%s: vp_offset:      %016lx\n", __func__,
+		arm64_mem.vp_offset);
+	dbgprintf("%s: PE format:      %s\n", __func__,
+		(arm64_header_check_pe_sig(header) ? "yes" : "no"));
+
+	/* create and initialize elf core header segment */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info);
+		if (result) {
+			dbgprintf("%s: Creating eflcorehdr failed.\n",
+								__func__);
+			goto exit;
+		}
+	}
+
+	/* load the kernel */
+	add_segment_phys_virt(info, kernel_buf, kernel_size,
+			kernel_segment + arm64_mem.text_offset,
+			arm64_mem.image_size, 0);
+
+	/* load additional data */
+	result = arm64_load_other_segments(info, kernel_segment
+		+ arm64_mem.text_offset);
+
+exit:
+	if (result)
+		fprintf(stderr, "kexec: load failed.\n");
+	return result;
+}
+
+void zboot_arm64_usage(void)
+{
+	printf("An ARM64 zboot Image, compressed, big or little endian.\n");
+}
diff --git a/kexec/arch/arm64/zboot.h b/kexec/arch/arm64/zboot.h
new file mode 100644
index 0000000..fa97aa3
--- /dev/null
+++ b/kexec/arch/arm64/zboot.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ZBOOT_H
+#define ZBOOT_H
+
+struct zboot_image_header {
+	union {
+		struct {
+			uint32_t magic;
+			/* image type, .ascii "zimg" */
+			char zimg[4];
+			int32_t gzdata_offset;
+			int32_t gzdata_size;
+			int32_t reserved[2];
+			/* compression type, .asciz */
+			char comp_type[];
+		};
+		struct {
+			char pad[56];
+		};
+	};
+	/* 0x818223cd */
+	uint32_t linux_pe_magic;
+	int32_t pe_header_offset;
+} __packed;
+
+#endif
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
