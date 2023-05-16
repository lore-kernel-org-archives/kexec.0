Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C52C77B7A
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VkrPymFJ3vfldYAJOpSDvbfh0PjKzi+nvO2QhOft5Vo=; b=Q+w5zdkpBAiENM
	vsjmnCuLFpCxaqGwih6oei4GoWRs3B9Z2gftC8b91fGxXnsud9rQcRyEdKR7Y+xHwo/hdI7xbc1oq
	bVxfmzTSYHwFoffNWpN+cdWO6dBK880+P/9iRYbPYqFd6U0NNtPGx9EaaUN409ne8tm/ZJKiNL1c5
	+kVmywY8lUI1aX7Lx9rJb4o6ue1mdW2T+fhp7j1cj/BtmRqvNKt7rIqCsPMPmLMC2x0Ox+B2zCiDX
	1a3Kc+DjLDSyLpoN2+rUofC675GP3mGPqXhFUbWE741xJ/KUfaKrQZ6GHmkLLE0mpuOxeA/RFpCNy
	kiV39Xs+HOtFr9jMbZRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9x-004eqc-0z;
	Tue, 16 May 2023 07:31:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9t-004eoZ-2q
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 07:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684222305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/97MDCncvp/Pg+dKYC0mE9sFic6MezR7mQBXLGQ9rQ=;
	b=MwXwilt11oqApHyUozpRCs9vq6j5pao9kb3ErLYVtrLE4ATB/dvywXq6YcnU4KK7h5Qa6t
	CJ5Y2zJ1IGVJT2HEXur8VHmsnH0X4lzwXrtDdSypj+g+84gpJC5+Y/TME8h5RoogCeYpqq
	oEG51cWESsvjcomKCOdN/KFj310Q6/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-oZ7I-0PSMwy85gtP0CFYug-1; Tue, 16 May 2023 03:31:43 -0400
X-MC-Unique: oZ7I-0PSMwy85gtP0CFYug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8075288B770;
	Tue, 16 May 2023 07:31:43 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 336A61121314;
	Tue, 16 May 2023 07:31:40 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv2 3/6] arm64: Scatter the logic of reading of kernel file into each probe
Date: Tue, 16 May 2023 15:31:21 +0800
Message-Id: <20230516073124.23531-4-piliu@redhat.com>
In-Reply-To: <20230516073124.23531-1-piliu@redhat.com>
References: <20230516073124.23531-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_003146_004885_68C5D28E 
X-CRM114-Status: GOOD (  28.16  )
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

As more complicated capsule kernel format ,such as zboot, emerge, where
the compressed kernel is stored as a payload. The straight forward
decompression can not meet the demand.

Therefore, let a probe method read in the kernel file and decide how to
unfold the content by the method itself.

Since other arches still read the kernel image before probe method,
the purpose of the first argument differs from that in aarch64.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm64/kexec-arm64.h        |  6 ++--
 kexec/arch/arm64/kexec-elf-arm64.c    |  7 +++-
 kexec/arch/arm64/kexec-image-arm64.c  |  6 +++-
 kexec/arch/arm64/kexec-uImage-arm64.c | 17 ++++++---
 kexec/arch/arm64/kexec-zImage-arm64.c | 18 +++-------
 kexec/kexec.c                         | 50 +++++++++++++++++----------
 kexec/kexec.h                         |  2 ++
 7 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 2825c46..bce93a1 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -29,14 +29,14 @@
 #define NOT_KV_ADDR	(0x0)
 #define NOT_PADDR	(ULONGLONG_MAX)
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size,
+int elf_arm64_probe(const char *kern_fname, off_t kernel_size,
 		    struct kexec_info *info);
 
 int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void elf_arm64_usage(void);
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size,
+int image_arm64_probe(const char *kern_fname, off_t kernel_size,
 		      struct kexec_info *info);
 
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
@@ -49,7 +49,7 @@ int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		      struct kexec_info *info);
 void uImage_arm64_usage(void);
 
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
+int zImage_arm64_probe(const char *kern_fname, off_t kernel_size,
 		       struct kexec_info *info);
 
 int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 0299349..38afecf 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -16,12 +16,14 @@
 #include "kexec-elf.h"
 #include "kexec-syscall.h"
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size,
+int elf_arm64_probe(const char *kern_fname, off_t kernel_size,
 		    struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
+	char *kernel_buf;
 	int result;
 
+	kernel_buf = slurp_file(kern_fname, &kernel_size);
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
 
 	if (result < 0) {
@@ -35,8 +37,11 @@ int elf_arm64_probe(const char *kernel_buf, off_t kernel_size,
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
index e8b72f9..668091f 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -14,11 +14,13 @@
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size,
+int image_arm64_probe(const char *kern_fname, off_t kernel_size,
 		      struct kexec_info *info)
 {
 	const struct arm64_image_header *h;
+	char *kernel_buf;
 
+	kernel_buf = slurp_file(kern_fname, &kernel_size);
 	if (kernel_size < sizeof(struct arm64_image_header)) {
 		dbgprintf("%s: No arm64 image header.\n", __func__);
 		return -1;
@@ -30,6 +32,8 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size,
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
index 8a23dea..1c32275 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -37,10 +37,8 @@
 
 /* Returns:
  * -1 : in case of error/invalid format (not a valid Image.gz format.
- * fd : File descriptor of the temp file containing the decompressed
- *      Image.
  */
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
+int zImage_arm64_probe(const char *kern_fname, off_t kernel_size,
 		       struct kexec_info *info)
 {
 	int ret = -1;
@@ -50,11 +48,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
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
@@ -69,7 +62,7 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
 
 	/* slurp in the input kernel */
 	dbgprintf("%s: ", __func__);
-	kernel_uncompressed_buf = slurp_decompress_file(kernel_buf,
+	kernel_uncompressed_buf = slurp_decompress_file(kern_fname,
 							&kernel_size);
 
 	/* check for correct header magic */
@@ -108,13 +101,12 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
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
index f5ea73c..767b173 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -701,7 +701,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		   unsigned long kexec_flags, int skip_checks, void *entry)
 {
 	char *kernel;
-	char *kernel_buf;
+	char *kernel_buf, *probe_buf;
 	off_t kernel_size;
 	int i = 0;
 	int result;
@@ -720,11 +720,15 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		return -1;
 	}
 	kernel = argv[fileind];
+#ifndef __aarch64__
 	/* slurp in the input kernel */
-	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
+	probe_buf = kernel_buf = slurp_decompress_file(kernel, &kernel_size);
 
 	dbgprintf("kernel: %p kernel_size: %#llx\n",
 		  kernel_buf, (unsigned long long)kernel_size);
+#else
+	probe_buf = kernel;
+#endif
 
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
 		info.kexec_flags) < 0 || info.memory_ranges == 0) {
@@ -742,14 +746,21 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 			return -1;
 		} else {
 			/* make sure our file is really of that type */
-			if (file_type[i].probe(kernel_buf, kernel_size, NULL) < 0)
+			if (file_type[i].probe(probe_buf, kernel_size, &info) < 0) {
 				guess_only = 1;
+			} else {
+				if (info.kernel_buf != NULL)
+					kernel_buf = info.kernel_buf;
+			}
 		}
 	}
 	if (!type || guess_only) {
 		for (i = 0; i < file_types; i++) {
-			if (file_type[i].probe(kernel_buf, kernel_size, NULL) == 0)
+			if (file_type[i].probe(probe_buf, kernel_size, &info) == 0) {
+				if (info.kernel_buf != NULL)
+					kernel_buf = info.kernel_buf;
 				break;
+			}
 		}
 		if (i == file_types) {
 			fprintf(stderr, "Cannot determine the file type "
@@ -1266,7 +1277,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	int kernel_fd, i;
 	struct kexec_info info;
 	int ret = 0;
-	char *kernel_buf;
+	char *kernel_buf, *probe_buf;
 	off_t kernel_size;
 
 	memset(&info, 0, sizeof(info));
@@ -1278,6 +1289,8 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	info.file_mode = 1;
 	info.initrd_fd = -1;
+	info.kernel_fd = -1;
+	info.kernel_buf = NULL;
 
 	if (!is_kexec_file_load_implemented())
 		return EFALLBACK;
@@ -1290,6 +1303,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	kernel = argv[fileind];
 
+#ifndef __aarch64__
 	kernel_fd = open(kernel, O_RDONLY);
 	if (kernel_fd == -1) {
 		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
@@ -1298,23 +1312,23 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	}
 
 	/* slurp in the input kernel */
-	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
+	probe_buf = kernel_buf = slurp_decompress_file(kernel, &kernel_size);
+#else
+	probe_buf = kernel;
+#endif
 
 	for (i = 0; i < file_types; i++) {
-#ifdef __aarch64__
-		/* handle Image.gz like cases */
-		if (is_zlib_file(kernel, &kernel_size)) {
-			if ((ret = file_type[i].probe(kernel, kernel_size, NULL)) >= 0) {
-				kernel_fd = ret;
-				break;
+		if (file_type[i].probe(probe_buf, kernel_size, &info) >= 0) {
+			if (info.kernel_fd != -1) {
+				close(kernel_fd);
+				kernel_fd = info.kernel_fd;
+			}
+			if (info.kernel_buf != NULL) {
+				free(kernel_buf);
+				kernel_buf = info.kernel_buf;
 			}
-		} else
-			if (file_type[i].probe(kernel_buf, kernel_size, NULL) >= 0)
-				break;
-#else
-		if (file_type[i].probe(kernel_buf, kernel_size, NULL) >= 0)
 			break;
-#endif
+		}
 	}
 
 	if (i == file_types) {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0706e46..2dca917 100644
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
