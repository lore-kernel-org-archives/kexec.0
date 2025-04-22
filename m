Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C253C369D9
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQabGHzMCs7RuwNEx4OH/5EAdSKmD6vLTNw8A6YusIs=; b=LkjEVD9ancy4QzexzNnn7HH5ek
	2uddwUCBxu/phvgrt3LBspRz0GdthE0o4rWJx0lUFQhNkYpyzsRmeSo1v0WZDWGqQRFIIzW94RYNc
	i5WmpW26zIMyXRgu1VvfqCzH6PyQgDdFGSqyYz4DkCCNdyfUB3heD3gPnUU0T61h23Ae/t3HfK55T
	yDGJdo/Kz2Nlakn6VCZhR9kLcvWgFykpw50gpNGql8K+sCq0bc/yJT2Zzw8Yyt/jbNgjxg2RN9H+1
	E+uOsyMbzPWQXfRdNPpyKwsmi40W1cvhJcly9IwEHzNG5wU0KXjKp/93NBUmCiPZQaFb+HhE+ZWbL
	W4nKCXVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7JaX-00000008LcR-17ul;
	Tue, 22 Apr 2025 19:47:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GP4-00000007tKt-372M;
	Tue, 22 Apr 2025 16:23:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0CB8561567;
	Tue, 22 Apr 2025 16:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22F7C4CEEE;
	Tue, 22 Apr 2025 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745339001;
	bh=LSbWEpO496jBcYmmf8qHEKw1KX6lsrhT7fcTWBmi6Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNR4A8AkZpZSGvtt303sXbD5yyu5wc1IoL1GtMBa0MoudMs8pEMqAJyD9p2mberVP
	 N9gYNJgfjVm8f2YoteV6cblO3tRPChuGYM6Jc9ImZnWwCeq3vOLaxjy2c+la5y9FFQ
	 9GgNNhEFeQInv7TRJM0AFBmlJa5rmxSaE5OGWY5y/FT6greb5bL/SijtCG2GUUTS/4
	 Dfv/AYmfhzWMVF0pFsOBr8tRxwjBLdqamUMY2QSqpmIeQ8zqWoVRCr3MrraoawET38
	 VJBvjkOn/2HESCvfMe66KgjpwzNz6i9JXWUu2caj08KqcwhluiN1Q8P19eHH/T/jaA
	 k67mbk25LmnJQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Simon Horman <horms@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	kexec@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>,
	Yixun Lan <yixun.lan@gmail.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 4/4] RISC-V: Support loading Image binary file
Date: Tue, 22 Apr 2025 18:23:00 +0200
Message-ID: <20250422162304.169431-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250422162304.169431-1-bjorn@kernel.org>
References: <20250422162304.169431-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Song Shuai <songshuaishuai@tinylab.org>

Add image-riscv file_type to probe/load Image file type,

As for kexec_load, find the pbase aligned text_offset from image header
and prepare segments for this syscall.

for kexec_file_load, setup the related options and let kernel part to
deal with the Image.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kexec/arch/riscv/Makefile            |  2 +
 kexec/arch/riscv/image-header.h      | 88 ++++++++++++++++++++++++++
 kexec/arch/riscv/kexec-image-riscv.c | 95 ++++++++++++++++++++++++++++
 kexec/arch/riscv/kexec-riscv.c       |  1 +
 kexec/arch/riscv/kexec-riscv.h       |  7 ++
 5 files changed, 193 insertions(+)
 create mode 100644 kexec/arch/riscv/image-header.h
 create mode 100644 kexec/arch/riscv/kexec-image-riscv.c

diff --git a/kexec/arch/riscv/Makefile b/kexec/arch/riscv/Makefile
index 9937fbb5724f..18a997b0785c 100644
--- a/kexec/arch/riscv/Makefile
+++ b/kexec/arch/riscv/Makefile
@@ -3,6 +3,7 @@
 #
 riscv_KEXEC_SRCS = kexec/arch/riscv/crashdump-riscv.c
 riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-elf-riscv.c
+riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-image-riscv.c
 riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-riscv.c
 
 riscv_DT_OPS += kexec/dt-ops.c
@@ -14,6 +15,7 @@ riscv_ARCH_REUSE_INITRD =
 riscv_CPPFLAGS += -I $(srcdir)/kexec/
 
 dist += $(riscv_KEXEC_SRCS)				\
+	kexec/arch/riscv/image-header.h			\
 	kexec/arch/riscv/include/arch/options.h		\
 	kexec/arch/riscv/iomem.h			\
 	kexec/arch/riscv/kexec-riscv.h			\
diff --git a/kexec/arch/riscv/image-header.h b/kexec/arch/riscv/image-header.h
new file mode 100644
index 000000000000..a6775462358e
--- /dev/null
+++ b/kexec/arch/riscv/image-header.h
@@ -0,0 +1,88 @@
+/*
+ * RISCV64 binary image header.
+ * token from arm64/image-header.h
+ */
+
+#if !defined(__RISCV_IMAGE_HEADER_H)
+#define __RISCV_IMAGE_HEADER_H
+
+#include <endian.h>
+#include <stdint.h>
+
+/**
+ * struct riscv_image_header - riscv kernel image header.
+ *
+ **/
+struct riscv_image_header {
+        uint32_t code0;
+        uint32_t code1;
+        uint64_t text_offset;
+        uint64_t image_size;
+        uint64_t flags;
+        uint32_t version;
+        uint32_t res1;
+        uint64_t res2;
+        uint64_t magic;
+        uint32_t magic2;
+        uint32_t res3;
+};
+
+#define RISCV_IMAGE_MAGIC       0x5643534952
+#define RISCV_IMAGE_MAGIC2      0x05435352
+
+#define RISCV_HEADER_VERSION_MAJOR 0
+#define RISCV_HEADER_VERSION_MINOR 2
+
+#define RISCV_HEADER_VERSION (RISCV_HEADER_VERSION_MAJOR << 16 | \
+		                              RISCV_HEADER_VERSION_MINOR)
+
+
+static const uint64_t riscv_image_flag_be = (1UL << 0);
+
+/**
+ * riscv_header_check_magic - Helper to check the riscv image header.
+ *
+ * Returns non-zero if header is OK.
+ */
+
+static inline int riscv_header_check_magic(const struct riscv_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (h->version >= RISCV_HEADER_VERSION && h->magic2 == RISCV_IMAGE_MAGIC2);
+}
+
+/**
+ * riscv_header_check_endiannes - Helper to check the riscv image header.
+ *
+ * Returns non-zero if the image was built as big endian.
+ */
+
+static inline int riscv_header_check_endiannes(const struct riscv_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (le64toh(h->flags) & riscv_image_flag_be) >> 0;
+}
+
+
+
+static inline uint64_t riscv_header_text_offset(const struct riscv_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return le64toh(h->text_offset);
+}
+
+static inline uint64_t riscv_header_image_size(const struct riscv_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return le64toh(h->image_size);
+}
+
+#endif
diff --git a/kexec/arch/riscv/kexec-image-riscv.c b/kexec/arch/riscv/kexec-image-riscv.c
new file mode 100644
index 000000000000..6ae7e579fd16
--- /dev/null
+++ b/kexec/arch/riscv/kexec-image-riscv.c
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V kexec binary image support.
+ *
+ * Author: Song Shuai <songhshuaishuai@tinylab.org>
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include "image-header.h"
+#include "kexec.h"
+#include "kexec-riscv.h"
+#include "kexec-syscall.h"
+#include "arch/options.h"
+
+int image_riscv_probe(const char *kernel_buf, off_t kernel_size)
+{
+	const struct riscv_image_header *h;
+
+	if (kernel_size < sizeof(struct riscv_image_header)) {
+		dbgprintf("%s: No riscv image header.\n", __func__);
+		return -1;
+	}
+
+	h = (const struct riscv_image_header *)(kernel_buf);
+
+	if (!riscv_header_check_magic(h)) {
+		dbgprintf("%s: Bad riscv image header.\n", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+int image_riscv_load(int argc, char **argv, const char *kernel_buf,
+	off_t kernel_size, struct kexec_info *info)
+{
+	const struct riscv_image_header *h;
+	unsigned long text_offset, image_size;
+	off_t new_base_addr = 0;
+
+	int ret;
+
+	if (info->file_mode) {
+		return prepare_kexec_file_options(info);
+	}
+
+	h = (const struct riscv_image_header *)(kernel_buf);
+
+	/* Check header */
+	if (!h->image_size){
+		dbgprintf("Kernel image size is NULL\n");
+		ret = EFAILED;
+		goto exit;
+	}
+
+	if(riscv_header_check_endiannes(h)){
+		dbgprintf("Kernel image was built as big endian\n");
+		ret = EFAILED;
+		goto exit;
+	}
+
+	text_offset = riscv_header_text_offset(h);
+	image_size = riscv_header_image_size(h);
+
+	/* Setup the entry and segments */
+
+	ret = riscv_find_pbase(info, &new_base_addr, image_size, text_offset);
+	if (ret < 0) {
+		fprintf(stderr, "Could not find a memory region for the "
+				"provided Image\n");
+		goto exit;
+	}
+
+	info->entry = (void *) new_base_addr;
+	dbgprintf("Entry point for the Image: 0x%lX\n", new_base_addr);
+
+	add_segment(info, kernel_buf, kernel_size, new_base_addr, image_size);
+
+	ret = load_extra_segments(info, text_offset, image_size, ULONG_MAX);
+exit:
+        if (ret)
+                fprintf(stderr, "kexec: load failed.\n");
+        return ret;
+}
+
+void image_riscv_usage(void)
+{
+	printf(
+"     An RISC-V binary image, uncompressed, little endian.\n"
+"     Typically an Image file.\n\n");
+}
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index 631659301749..f34b46831160 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -33,6 +33,7 @@ const struct arch_map_entry arches[] = {
 
 struct file_type file_type[] = {
 	{"elf-riscv", elf_riscv_probe, elf_riscv_load, elf_riscv_usage},
+	{"image-riscv", image_riscv_probe, image_riscv_load, image_riscv_usage},
 };
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
diff --git a/kexec/arch/riscv/kexec-riscv.h b/kexec/arch/riscv/kexec-riscv.h
index 618099291117..cfb03779a022 100644
--- a/kexec/arch/riscv/kexec-riscv.h
+++ b/kexec/arch/riscv/kexec-riscv.h
@@ -40,7 +40,14 @@ int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 int riscv_find_pbase(struct kexec_info *info, off_t *addr,
 				off_t size, off_t align);
 
+/* kexec-elf-riscv.c */
 int elf_riscv_probe(const char *buf, off_t len);
 void elf_riscv_usage(void);
 int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
 		   struct kexec_info *info);
+
+/* kexec-image-riscv.c */
+int image_riscv_probe(const char *buf, off_t len);
+void image_riscv_usage(void);
+int image_riscv_load(int argc, char **argv, const char *buf, off_t len,
+		   struct kexec_info *info);
-- 
2.48.1


