Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E1C77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 02:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Tb+lgY52y8gUDSDep4BVuUySV7TnLytVGs4kUFlcPI=; b=Lglv12r9/TSfhv
	SIE/54WlYV2rsG6MBJ5h9OvgRPJS/raeEtWiKkgHhTgLJIqW67X+AX69HDxrVsiMQ5d+VdnaN5pR0
	MBCLQPpFncn3nbZG2fRARUvuzWjvQlhnX+J40CLF07UNGLryYoSaUIgIKrdqyly80LZVbITXLgdqQ
	ICdoum8/Xcr7s7/GtAKKkIdiLtcqC8cbMdidXXn+UlwvR/p9OLUM7uGcCSBP4B+fiRjh0zIV8kdRN
	s34zx4CLmA1X+VWlEK1VHoQIbtGvMiza+g02Xc4OHrMgFiQmHY2ni7ycG4V6WP4XZSKSU5RD9Xkqt
	Uja26xxmbc8SFoV1yjxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pulck-009aQb-0p;
	Fri, 05 May 2023 02:56:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pulch-009aQ3-1r
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 02:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683255402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mswp4mh8u/gWjoBs7X8hffiwM3oQR4AeCisKg7sHx8Q=;
	b=Vuu6VxuBaKS1QhJeEXDXMGm66FhTTXO/rVg7m+rMPay5hSdZxVph/ZWNRQ0/vrHllItbXu
	Y+am7YxtHztgH83zLXkxOrkordsjsS/eQbnhPDo0jFrZTGSk6hXKkvZGYaVUazyVHNAscM
	CffgvP/1aSOV12BLLqGuFZaEw6VBjCI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-bwf2TuC_OZ-558wbnMq2ww-1; Thu, 04 May 2023 22:55:10 -0400
X-MC-Unique: bwf2TuC_OZ-558wbnMq2ww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 696D5800B35;
	Fri,  5 May 2023 02:55:10 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10558407D450;
	Fri,  5 May 2023 02:55:07 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCH 4/5] arm64: Scatter the reading of kernel file into each probe
Date: Fri,  5 May 2023 10:54:37 +0800
Message-Id: <20230505025438.11943-6-piliu@redhat.com>
In-Reply-To: <20230505025438.11943-1-piliu@redhat.com>
References: <20230505025438.11943-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_195643_686480_BF362CCB 
X-CRM114-Status: GOOD (  27.41  )
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

As more complicated capsule kernel format occurs like zboot, where the
compressed kernel is stored as a payload. The straight forward
decompression can not meet the demand.

So reading in the kernel file in a probe file and decide how to unfold
the content by the method itself.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com

---
 kexec/arch/arm64/kexec-elf-arm64.c    |  7 ++++-
 kexec/arch/arm64/kexec-image-arm64.c  |  6 +++-
 kexec/arch/arm64/kexec-uImage-arm64.c | 17 ++++++++---
 kexec/arch/arm64/kexec-zImage-arm64.c | 13 ++++-----
 kexec/kexec.c                         | 42 ++++++++++++++++++---------
 kexec/kexec.h                         |  2 ++
 6 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 9238dd5..cedf3c6 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -16,11 +16,13 @@
 #include "kexec-elf.h"
 #include "kexec-syscall.h"
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info)
+int elf_arm64_probe(const char *kern_fname, off_t kernel_size, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
+	char *kernel_buf;
 	int result;
 
+	kernel_buf = slurp_file(kern_fname, &kernel_size);
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
 
 	if (result < 0) {
@@ -34,8 +36,11 @@ int elf_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info
 		goto on_exit;
 	}
 
+	info->kernel_fd = open(kern_fname, O_RDONLY);
+	info->kernel_buf = kernel_buf;
 	result = 0;
 on_exit:
+	free(kernel_buf);
 	free_elf_info(&ehdr);
 	return result;
 }
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index 84aca72..90cd40a 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -14,10 +14,12 @@
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info)
+int image_arm64_probe(const char *kern_fname, off_t kernel_size, struct kexec_info *info)
 {
 	const struct arm64_image_header *h;
+	char *kernel_buf;
 
+	kernel_buf = slurp_file(kern_fname, &kernel_size);
 	if (kernel_size < sizeof(struct arm64_image_header)) {
 		dbgprintf("%s: No arm64 image header.\n", __func__);
 		return -1;
@@ -29,6 +31,8 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_in
 		dbgprintf("%s: Bad arm64 image header.\n", __func__);
 		return -1;
 	}
+	info->kernel_fd = open(kern_fname, O_RDONLY);
+	info->kernel_buf = kernel_buf;
 
 	return 0;
 }
diff --git a/kexec/arch/arm64/kexec-uImage-arm64.c b/kexec/arch/arm64/kexec-uImage-arm64.c
index f5b94c8..cce1c76 100644
--- a/kexec/arch/arm64/kexec-uImage-arm64.c
+++ b/kexec/arch/arm64/kexec-uImage-arm64.c
@@ -3,26 +3,35 @@
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
 
-int uImage_arm64_probe(const char *buf, off_t len, struct kexec_info *info)
+int uImage_arm64_probe(const char *kern_fname, off_t len, struct kexec_info *info)
 {
 	int ret;
+	char *kernel_buf;
 
-	ret = uImage_probe_kernel(buf, len, IH_ARCH_ARM64);
+	kernel_buf = slurp_file(kern_fname, &len);
+	ret = uImage_probe_kernel(kernel_buf, len, IH_ARCH_ARM64);
 
 	/*  0 - valid uImage.
 	 * -1 - uImage is corrupted.
 	 *  1 - image is not a uImage.
 	 */
-	if (!ret)
+	if (!ret) {
+		info->kernel_fd = open(kern_fname, O_RDONLY);
+		info->kernel_buf = kernel_buf;
 		return 0;
-	else
+	}
+	else {
+		free(kernel_buf);
 		return -1;
+	}
 }
 
 int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
index 7877741..450a915 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -40,7 +40,7 @@
  * fd : File descriptor of the temp file containing the decompressed
  *      Image.
  */
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info)
+int zImage_arm64_probe(const char *kernel, off_t kernel_size, struct kexec_info *info)
 {
 	int ret = -1;
 	int fd = 0;
@@ -49,7 +49,7 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_i
 	char *kernel_uncompressed_buf = NULL;
 	const struct arm64_image_header *h;
 
-	if (!is_zlib_file(kernel_buf, &kernel_size)) {
+	if (!is_zlib_file(kernel, &kernel_size)) {
 		dbgprintf("%s: Not an zImage file (Image.gz).\n", __func__);
 		return -1;
 	}
@@ -69,7 +69,7 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_i
 
 	/* slurp in the input kernel */
 	dbgprintf("%s: ", __func__);
-	kernel_uncompressed_buf = slurp_decompress_file(kernel_buf,
+	kernel_uncompressed_buf = slurp_decompress_file(kernel,
 							&kernel_size);
 
 	/* check for correct header magic */
@@ -108,13 +108,12 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_i
 		ret = -1;
 		goto fail_bad_header;
 	}
-
+	info->kernel_fd = kernel_fd;
+	info->kernel_buf = kernel_uncompressed_buf;
 	unlink(fname);
-
-	free(kernel_uncompressed_buf);
 	free(fname);
 
-	return kernel_fd;
+	return 0;
 
 fail_bad_header:
 	free(kernel_uncompressed_buf);
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 116fb4a..dbd24aa 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -720,12 +720,13 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		return -1;
 	}
 	kernel = argv[fileind];
+#ifndef __aarch64__
 	/* slurp in the input kernel */
 	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
 
 	dbgprintf("kernel: %p kernel_size: %#llx\n",
 		  kernel_buf, (unsigned long long)kernel_size);
-
+#endif
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
 		info.kexec_flags) < 0 || info.memory_ranges == 0) {
 		fprintf(stderr, "Could not get memory layout\n");
@@ -742,13 +743,17 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 			return -1;
 		} else {
 			/* make sure our file is really of that type */
+
 #ifndef __aarch64__
 			if (file_type[i].probe(kernel_buf, kernel_size) < 0)
 				guess_only = 1;
 #else
-			if (file_type[i].probe(kernel_buf, kernel_size, &info) < 0)
+			if (file_type[i].probe(kernel_buf, kernel_size, &info) < 0) {
 				guess_only = 1;
-
+			} else {
+				if (info.kernel_buf != NULL)
+					kernel_buf = info.kernel_buf;
+			}
 #endif
 		}
 	}
@@ -758,8 +763,11 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 			if (file_type[i].probe(kernel_buf, kernel_size) == 0)
 				break;
 #else
-			if (file_type[i].probe(kernel_buf, kernel_size, &info) == 0)
+			if (file_type[i].probe(kernel, kernel_size, &info) >= 0) {
+				if (info.kernel_buf != NULL)
+					kernel_buf = info.kernel_buf;
 				break;
+			}
 #endif
 		}
 		if (i == file_types) {
@@ -1289,6 +1297,8 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	info.file_mode = 1;
 	info.initrd_fd = -1;
+	info.kernel_fd = -1;
+	info.kernel_buf = NULL;
 
 	if (!is_kexec_file_load_implemented())
 		return EFALLBACK;
@@ -1301,6 +1311,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	kernel = argv[fileind];
 
+#ifndef __aarch64__
 	kernel_fd = open(kernel, O_RDONLY);
 	if (kernel_fd == -1) {
 		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
@@ -1310,21 +1321,24 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	/* slurp in the input kernel */
 	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
+#endif
 
 	for (i = 0; i < file_types; i++) {
-#ifdef __aarch64__
-		/* handle Image.gz like cases */
-		if (is_zlib_file(kernel, &kernel_size)) {
-			if ((ret = file_type[i].probe(kernel, kernel_size, &info)) >= 0) {
-				kernel_fd = ret;
-				break;
-			}
-		} else
-			if (file_type[i].probe(kernel_buf, kernel_size, &info) >= 0)
+#ifndef __aarch64__
+		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
 				break;
 #else
-		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
+		if (file_type[i].probe(kernel, kernel_size, &info) >= 0) {
+			if (info.kernel_fd != -1) {
+				close(kernel_fd);
+				kernel_fd = info.kernel_fd;
+			}
+			if (info.kernel_buf != NULL) {
+				free(kernel_buf);
+				kernel_buf = info.kernel_buf;
+			}
 			break;
+		}
 #endif
 	}
 
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 6e8430e..3349d16 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -164,7 +164,9 @@ struct kexec_info {
 	unsigned long file_mode :1;
 
 	/* Filled by kernel image processing code */
+	int kernel_fd;
 	int initrd_fd;
+	char *kernel_buf;
 	char *command_line;
 	int command_line_len;
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
