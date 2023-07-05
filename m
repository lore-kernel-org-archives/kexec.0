Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7867AEB64D9
	for <kexec@archiver.kernel.org>; Wed,  5 Jul 2023 02:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lWzmcgof/dNy1ud0utDlhm+RpeV/kG9lJC1CkQs5ags=; b=srfcy0qEA4h60p
	aayT/8XrWkhtFGwZ8yrI3j6JcW/yd5XJqtRSSZ1PVTCFnPuTCijQWSz7xw98cvWkIeQffCLxWoBDf
	4CaLZ+bc+9Dwp/j24GEkcxcRrko47Xqm68npvBh+ojwk+CWgGAQGYCyxUw+d1ZakwupyBtmEnQkun
	+r/TQcXrbR4hG9SzQM6N4hvvp8t0rvvp6Wbs4dq8aZh/0ZFRdTHPJ+lLI/JpKWNHCY0C93iDoNnEu
	+OjPge21raN2jtrolesfmpW03dyQYNBChKhWnqJKza3MXER9WmrPP82mryNfI+9R4ja5kXpvN6kgt
	yPLdf4WNooSXHy6j6QNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYf-00Eds4-2g;
	Wed, 05 Jul 2023 02:47:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYc-00Edqf-2A
	for kexec@lists.infradead.org;
	Wed, 05 Jul 2023 02:47:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688525273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqZkAvQOL4q7NgbDy2QxpK6FWFSqdIJzE2vYqnLrTHw=;
	b=gECMk0OpoOzZpkpnqQTPkmJLFVbjyi3vrg86Ppc12LFPOIbFQjREDLl/YCLkDzHeiKXsnS
	VrS4wkAdfF+8gV1HadTemv9lcSQsmTgOE16PvEJbtdhqTIKoiJbQBPv15MINbDX0c2D8cG
	xHlxesQuBLKm/OYRufWY3fYMrHKelX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-M6YoUEBpOSOTxy07dEWHxA-1; Tue, 04 Jul 2023 22:47:51 -0400
X-MC-Unique: M6YoUEBpOSOTxy07dEWHxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 509D88022EF;
	Wed,  5 Jul 2023 02:47:51 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7BCAF1121314;
	Wed,  5 Jul 2023 02:47:48 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv4 4/8] arm64: Transfer from probe() to probe2()
Date: Wed,  5 Jul 2023 10:47:21 +0800
Message-Id: <20230705024725.11741-5-piliu@redhat.com>
In-Reply-To: <20230705024725.11741-1-piliu@redhat.com>
References: <20230705024725.11741-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_194754_779165_171328B7 
X-CRM114-Status: GOOD (  23.68  )
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

Scatter the logic of reading of kernel file into each probe

As more complicated capsule kernel format ,such as zboot, emerge, where
the compressed kernel is stored as a payload. The straight forward
decompression can not meet the demand.

Therefore, introduce a method probe2, which reads in the kernel file and
decides how to unfold the content by itself.

At present, only aarch64 supports zboot image and implements probe2().

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm64/kexec-arm64.c        |  9 +++++----
 kexec/arch/arm64/kexec-arm64.h        |  8 ++++----
 kexec/arch/arm64/kexec-elf-arm64.c    |  7 +++++--
 kexec/arch/arm64/kexec-image-arm64.c  | 15 +++++++++-----
 kexec/arch/arm64/kexec-uImage-arm64.c | 15 ++++++++++----
 kexec/arch/arm64/kexec-zImage-arm64.c | 28 +++++++++------------------
 6 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index ec6df4b..f391f77 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -70,11 +70,12 @@ const struct arch_map_entry arches[] = {
 	{ NULL, 0 },
 };
 
+/* On arm64, probe2 is used, probe is abandoned */
 struct file_type file_type[] = {
-	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
-	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
-	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
-	{"zImage", zImage_arm64_probe, zImage_arm64_load, zImage_arm64_usage},
+	{"vmlinux", NULL, elf_arm64_load, elf_arm64_usage, elf_arm64_probe},
+	{"Image", NULL, image_arm64_load, image_arm64_usage, image_arm64_probe},
+	{"uImage", NULL, uImage_arm64_load, uImage_arm64_usage, uImage_arm64_probe},
+	{"zImage", NULL, zImage_arm64_load, zImage_arm64_usage, zImage_arm64_probe},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 5eb9fc0..eeb35ae 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -29,22 +29,22 @@
 #define NOT_KV_ADDR	(0x0)
 #define NOT_PADDR	(ULONGLONG_MAX)
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int elf_arm64_probe(const char *kern_fname, struct parsed_info *info);
 int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void elf_arm64_usage(void);
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int image_arm64_probe(const char *kern_fname, struct parsed_info *info);
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void image_arm64_usage(void);
 
-int uImage_arm64_probe(const char *buf, off_t len);
+int uImage_arm64_probe(const char *kern_fname, struct parsed_info *info);
 int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		      struct kexec_info *info);
 void uImage_arm64_usage(void);
 
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int zImage_arm64_probe(const char *kern_fname, struct parsed_info *info);
 int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void zImage_arm64_usage(void);
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index e14f8e9..4e8f8d9 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -16,12 +16,13 @@
 #include "kexec-elf.h"
 #include "kexec-syscall.h"
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int elf_arm64_probe(const char *kern_fname, struct parsed_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
 
-	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
+	info->kernel_buf = slurp_file(kern_fname, &info->kernel_size);
+	result = build_elf_exec_info(info->kernel_buf, info->kernel_size, &ehdr, 0);
 
 	if (result < 0) {
 		dbgprintf("%s: Not an ELF executable.\n", __func__);
@@ -34,8 +35,10 @@ int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
 		goto on_exit;
 	}
 
+	info->fd = open(kern_fname, O_RDONLY);
 	result = 0;
 on_exit:
+	free(info->kernel_buf);
 	free_elf_info(&ehdr);
 	return result;
 }
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index aa8f2e2..e2e5c20 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -14,23 +14,28 @@
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int image_arm64_probe(const char *kern_fname, struct parsed_info *info)
 {
 	const struct arm64_image_header *h;
 
-	if (kernel_size < sizeof(struct arm64_image_header)) {
+	info->kernel_buf = slurp_file(kern_fname, &info->kernel_size);
+	if (info->kernel_size < sizeof(struct arm64_image_header)) {
 		dbgprintf("%s: No arm64 image header.\n", __func__);
-		return -1;
+		goto err;
 	}
 
-	h = (const struct arm64_image_header *)(kernel_buf);
+	h = (const struct arm64_image_header *)(info->kernel_buf);
 
 	if (!arm64_header_check_magic(h)) {
 		dbgprintf("%s: Bad arm64 image header.\n", __func__);
-		return -1;
+		goto err;
 	}
+	info->fd = open(kern_fname, O_RDONLY);
 
 	return 0;
+error:
+	free(info->kernel_buf);
+	return -1;
 }
 
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
diff --git a/kexec/arch/arm64/kexec-uImage-arm64.c b/kexec/arch/arm64/kexec-uImage-arm64.c
index c466913..2bd4607 100644
--- a/kexec/arch/arm64/kexec-uImage-arm64.c
+++ b/kexec/arch/arm64/kexec-uImage-arm64.c
@@ -3,26 +3,33 @@
  */
 #include <stdint.h>
 #include <string.h>
+#include <stdlib.h>
+#include <fcntl.h>
 #include <sys/types.h>
 #include <image.h>
 #include <kexec-uImage.h>
 #include "../../kexec.h"
 #include "kexec-arm64.h"
 
-int uImage_arm64_probe(const char *buf, off_t len)
+int uImage_arm64_probe(const char *kern_fname, struct parsed_info *info)
 {
 	int ret;
 
-	ret = uImage_probe_kernel(buf, len, IH_ARCH_ARM64);
+	info->kernel_buf = slurp_file(kern_fname, &info->kernel_size);
+	ret = uImage_probe_kernel(info->kernel_buf, info->kernel_size, IH_ARCH_ARM64);
 
 	/*  0 - valid uImage.
 	 * -1 - uImage is corrupted.
 	 *  1 - image is not a uImage.
 	 */
-	if (!ret)
+	if (!ret) {
+		info->fd = open(kern_fname, O_RDONLY);
 		return 0;
-	else
+	}
+	else {
+		free(info->kernel_buf);
 		return -1;
+	}
 }
 
 int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
index 3eb1ad8..4e488a5 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -37,23 +37,15 @@
 
 /* Returns:
  * -1 : in case of error/invalid format (not a valid Image.gz format.
- * fd : File descriptor of the temp file containing the decompressed
- *      Image.
  */
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int zImage_arm64_probe(const char *kern_fname, struct parsed_info *info)
 {
 	int ret = -1;
 	int fd = 0;
-	int kernel_fd = 0;
 	char *fname = NULL;
 	char *kernel_uncompressed_buf = NULL;
 	const struct arm64_image_header *h;
 
-	if (!is_zlib_file(kernel_buf, &kernel_size)) {
-		dbgprintf("%s: Not an zImage file (Image.gz).\n", __func__);
-		return -1;
-	}
-
 	if (!(fname = strdup(FILENAME_IMAGE))) {
 		dbgprintf("%s: Can't duplicate strings\n", __func__);
 		return -1;
@@ -68,11 +60,11 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 
 	/* slurp in the input kernel */
 	dbgprintf("%s: ", __func__);
-	kernel_uncompressed_buf = slurp_decompress_file(kernel_buf,
-							&kernel_size);
+	kernel_uncompressed_buf = slurp_decompress_file(kern_fname,
+							&info->kernel_size);
 
 	/* check for correct header magic */
-	if (kernel_size < sizeof(struct arm64_image_header)) {
+	if (info->kernel_size < sizeof(struct arm64_image_header)) {
 		dbgprintf("%s: No arm64 image header.\n", __func__);
 		ret = -1;
 		goto fail_bad_header;
@@ -87,7 +79,7 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 	}
 
 	if (write(fd, kernel_uncompressed_buf,
-				kernel_size) != kernel_size) {
+				info->kernel_size) != info->kernel_size) {
 		dbgprintf("%s: Can't write the uncompressed file %s\n",
 				__func__, fname);
 		ret = -1;
@@ -100,20 +92,18 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 	 * opening the file in O_RDWR and calling kexec_file_load()
 	 * causes the kernel to return -ETXTBSY
 	 */
-	kernel_fd = open(fname, O_RDONLY);
-	if (kernel_fd == -1) {
+	info->fd = open(fname, O_RDONLY);
+	if (info->fd == -1) {
 		dbgprintf("%s: Failed to open file %s\n",
 				__func__, fname);
 		ret = -1;
 		goto fail_bad_header;
 	}
-
+	info->kernel_buf = kernel_uncompressed_buf;
 	unlink(fname);
-
-	free(kernel_uncompressed_buf);
 	free(fname);
 
-	return kernel_fd;
+	return 0;
 
 fail_bad_header:
 	free(kernel_uncompressed_buf);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
