Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CCDC36002
	for <kexec@archiver.kernel.org>; Wed,  9 Apr 2025 20:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A0nDGngyDcvLqfBlBQV0zSewDLIKmVRygN60RDl+lEY=; b=ig5q2gQGFzZfKKXXzGnL+TfvKx
	HTY9WjGenGfMc+Gf1ADX6CLQnJbjW2xAaQGaIe7Br4PravSxA0jxlMEc8Q3HiAKkHFrv2gyPWUjhA
	tiLCWyCxa4F7ETrQvFQgmSBRhpuAemE0TLwYVz1pw7HpSpP0JidBRfooqC78LMBhuT5U5cocrBLFa
	8pi0NFtKry2ax5BVzAf5C/Ji+Svja3xvkq65BIQy6UyhGhlJI6HxVhrpCDActVflwVGxEWdGh2tLS
	qFB4bExf7pHUAbrr+xFkwHI8NuJ4Ew02JHxbXcFgPD9a8HPdpiwHBU8TB8YKrHUk1Zk/y9pvbAeo+
	q0nO9biw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2bp5-00000008POz-0vfg;
	Wed, 09 Apr 2025 20:14:59 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2bp2-00000008PM2-3MTr;
	Wed, 09 Apr 2025 20:14:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 63F94A48622;
	Wed,  9 Apr 2025 20:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D12C4CEE2;
	Wed,  9 Apr 2025 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744229695;
	bh=DvYEM3nrD8J6iIxw6J1rC5E5/c8/TMhja23sTXKK6D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGZaS3ufHLfBAfO/DJnZg7/VxWPuhIYJOyd8RozHzLQHgoPw8U0KQF12G2DTWMT4u
	 fZizVfS4tMzwZPa0KWKLKfwSbQAeHiSj0ZUpMOSYgorQoSFl359F7YrHbnwyZDml4v
	 ShG3JymBlF1SKmY8j7mYYOTIAj+65THAA79Gp8xQqi6HGEmmwu6c7IAsjxZ05K2xFm
	 Vcd/HZ+/fre7uOUyFFog0Asor9RFHemuJNMbx+9qOpMRJ3DZRDzQ1vL74/qd5WqoRb
	 5Oh8bFGE7IaYsup0aQ+goqI3ZpeSVE/98x2w2JSzTQXDw5VxwNCdRqtdvHM3YVUtVh
	 LIQlLdami2yMA==
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
Subject: [PATCH 4/4] RISC-V: Support loading Image binary file
Date: Wed,  9 Apr 2025 22:14:26 +0200
Message-ID: <20250409201428.648717-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250409201428.648717-1-bjorn@kernel.org>
References: <20250409201428.648717-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_131456_978991_27DF2B71 
X-CRM114-Status: GOOD (  20.61  )
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
index f26cc9025e77..37ef7603fc38 100644
--- a/kexec/arch/riscv/Makefile
+++ b/kexec/arch/riscv/Makefile
@@ -3,6 +3,7 @@
 #
 riscv_KEXEC_SRCS =  kexec/arch/riscv/kexec-riscv.c
 riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-elf-riscv.c
+riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-image-riscv.c
 riscv_KEXEC_SRCS += kexec/arch/riscv/crashdump-riscv.c
 
 riscv_MEM_REGIONS = kexec/mem_regions.c
@@ -15,6 +16,7 @@ riscv_CPPFLAGS += -I $(srcdir)/kexec/
 
 dist += kexec/arch/riscv/Makefile $(riscv_KEXEC_SRCS)			\
 	kexec/arch/riscv/kexec-riscv.h					\
+	kexec/arch/riscv/image-header.h					\
 	kexec/arch/riscv/include/arch/options.h
 
 ifdef HAVE_LIBFDT
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
2.45.2


