Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2936C6FA83
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 02:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nGwGab19NddXVk9pFnr2eSaXAZVV/hv2sNCALo9Zof8=; b=bhRQKGPvplrxaO
	++F1DmiDIVDqYjksKi8ncb0rn+VA2F57SpQcd67iBe89RsjpcFJREdF3M8gNKJCu0USBgDgE2otHy
	HrNgnnAbTT0Q1wq/UnxTWu8dXATatL3X+auYhkFzXhk5dl2IW2t/ym3w5QAdB3Uld/A4z2TVaKLgq
	Of6MqkR7xSdITCEfSsgZX+TFPMBiyzyjO/bZJknnWnseEUGouQTY9hzN5Q8Ishte6yJqb5SdVicmA
	BA9l9OQ7KoArdrUx7Md1B2cwi46TvS3cZS9xa3Z/zU1djTbVgecYjNForyO28nusba7nghwDPLPPM
	RdscQ6GHJD7APUCL9n5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMpM-00DatS-Lr; Wed, 28 Sep 2022 02:29:36 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMpG-00DanA-8s
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 02:29:34 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJKsTNjXAwjAA--.65269S5;
	Wed, 28 Sep 2022 10:28:30 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 3/5] LoongArch: PE format image loading support
Date: Wed, 28 Sep 2022 10:28:24 +0800
Message-Id: <1664332106-4845-4-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxBOJKsTNjXAwjAA--.65269S5
X-Coremail-Antispam: 1UD129KBjvJXoW3uF15XFWxurWftr1kArWDurg_yoWDuFW7pa
	srZr98tr4rXrnxtrykJas8Zws8X397GF12qF9Igry0kF47Wr1UXry8XryDuF4Utw45KryI
	grn5J3WFvF18Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUY17K3UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_192931_140629_94D761A8 
X-CRM114-Status: GOOD (  20.77  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The LoongArch kernel will mainly use the vmlinux.efi image in PE format,
so add it support.

I tested this on LoongArch 3A5000 machine and works as expected,

kexec:
  $ sudo kexec -l /boot/vmlinux.efi --reuse-cmdline
  $ sudo kexec -e

kdump:
  $ sudo kexec -p /boot/vmlinux-kdump.efi --reuse-cmdline --append="nr_cpus=1"
  # echo c > /proc/sysrq_trigger

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/arch/loongarch/Makefile              |   2 +
 kexec/arch/loongarch/image-header.h        |  79 ++++++++++++++
 kexec/arch/loongarch/kexec-elf-loongarch.c |   3 +
 kexec/arch/loongarch/kexec-loongarch.c     |  19 ++++
 kexec/arch/loongarch/kexec-loongarch.h     |   9 ++
 kexec/arch/loongarch/kexec-pei-loongarch.c | 117 +++++++++++++++++++++
 6 files changed, 229 insertions(+)
 create mode 100644 kexec/arch/loongarch/image-header.h
 create mode 100644 kexec/arch/loongarch/kexec-pei-loongarch.c

diff --git a/kexec/arch/loongarch/Makefile b/kexec/arch/loongarch/Makefile
index e5e190a..3b33b96 100644
--- a/kexec/arch/loongarch/Makefile
+++ b/kexec/arch/loongarch/Makefile
@@ -3,6 +3,7 @@
 #
 loongarch_KEXEC_SRCS =  kexec/arch/loongarch/kexec-loongarch.c
 loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-elf-loongarch.c
+loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-pei-loongarch.c
 loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-elf-rel-loongarch.c
 loongarch_KEXEC_SRCS += kexec/arch/loongarch/crashdump-loongarch.c
 
@@ -16,5 +17,6 @@ loongarch_VIRT_TO_PHYS =
 
 dist += kexec/arch/loongarch/Makefile $(loongarch_KEXEC_SRCS)			\
 	kexec/arch/loongarch/kexec-loongarch.h					\
+	kexec/arch/loongarch/image-header.h					\
 	kexec/arch/loongarch/crashdump-loongarch.h				\
 	kexec/arch/loongarch/include/arch/options.h
diff --git a/kexec/arch/loongarch/image-header.h b/kexec/arch/loongarch/image-header.h
new file mode 100644
index 0000000..3b75765
--- /dev/null
+++ b/kexec/arch/loongarch/image-header.h
@@ -0,0 +1,79 @@
+/*
+ * LoongArch binary image header.
+ */
+
+#if !defined(__LOONGARCH_IMAGE_HEADER_H)
+#define __LOONGARCH_IMAGE_HEADER_H
+
+#include <endian.h>
+#include <stdint.h>
+
+/**
+ * struct loongarch_image_header
+ *
+ * @pe_sig: Optional PE format 'MZ' signature.
+ * @reserved_1: Reserved.
+ * @kernel_entry: Kernel image entry pointer.
+ * @image_size: An estimated size of the memory image size in LSB byte order.
+ * @text_offset: The image load offset in LSB byte order.
+ * @reserved_2: Reserved.
+ * @reserved_3: Reserved.
+ * @pe_header: Optional offset to a PE format header.
+ **/
+
+struct loongarch_image_header {
+	uint8_t pe_sig[2];
+	uint16_t reserved_1[3];
+	uint64_t kernel_entry;
+	uint64_t image_size;
+	uint64_t text_offset;
+	uint64_t reserved_2[3];
+	uint32_t reserved_3;
+	uint32_t pe_header;
+};
+
+static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
+
+/**
+ * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
+ *
+ * Returns non-zero if 'MZ' signature is found.
+ */
+
+static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (h->pe_sig[0] == loongarch_image_pe_sig[0]
+		&& h->pe_sig[1] == loongarch_image_pe_sig[1]);
+}
+
+static inline uint64_t loongarch_header_text_offset(
+	const struct loongarch_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return le64toh(h->text_offset);
+}
+
+static inline uint64_t loongarch_header_image_size(
+	const struct loongarch_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return le64toh(h->image_size);
+}
+
+static inline uint64_t loongarch_header_kernel_entry(
+	const struct loongarch_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return le64toh(h->kernel_entry);
+}
+
+#endif
diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
index a5ec356..2bf128f 100644
--- a/kexec/arch/loongarch/kexec-elf-loongarch.c
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -50,6 +50,7 @@ out:
 int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info)
 {
+	const struct loongarch_image_header *header = NULL;
 	unsigned long kernel_segment;
 	struct mem_ehdr ehdr;
 	int result;
@@ -76,6 +77,8 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 		loongarch_mem.text_offset);
 	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
 		loongarch_mem.phys_offset);
+	dbgprintf("%s: PE format:      %s\n", __func__,
+		(loongarch_header_check_pe_sig(header) ? "yes" : "no"));
 
 	/* create and initialize elf core header segment */
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index ce7db2c..3fdba01 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -165,6 +165,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 
 struct file_type file_type[] = {
 	{"elf-loongarch", elf_loongarch_probe, elf_loongarch_load, elf_loongarch_usage},
+	{"pei-loongarch", pei_loongarch_probe, pei_loongarch_load, pei_loongarch_usage},
 };
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
@@ -172,6 +173,24 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
 struct loongarch_mem loongarch_mem;
 
+/**
+ * loongarch_process_image_header - Process the loongarch image header.
+ */
+
+int loongarch_process_image_header(const struct loongarch_image_header *h)
+{
+
+	if (!loongarch_header_check_pe_sig(h))
+		return EFAILED;
+
+	if (h->image_size) {
+		loongarch_mem.text_offset = loongarch_header_text_offset(h);
+		loongarch_mem.image_size = loongarch_header_image_size(h);
+	}
+
+	return 0;
+}
+
 void arch_usage(void)
 {
 	printf(loongarch_opts_usage);
diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
index cb9b79a..5120a26 100644
--- a/kexec/arch/loongarch/kexec-loongarch.h
+++ b/kexec/arch/loongarch/kexec-loongarch.h
@@ -3,6 +3,8 @@
 
 #include <sys/types.h>
 
+#include "image-header.h"
+
 #define BOOT_BLOCK_VERSION 17
 #define BOOT_BLOCK_LAST_COMP_VERSION 16
 
@@ -21,6 +23,13 @@ int elf_loongarch_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_loongarch_usage(void);
 
+int pei_loongarch_probe(const char *buf, off_t len);
+int pei_loongarch_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info);
+void pei_loongarch_usage(void);
+
+int loongarch_process_image_header(const struct loongarch_image_header *h);
+
 unsigned long loongarch_locate_kernel_segment(struct kexec_info *info);
 int loongarch_load_other_segments(struct kexec_info *info,
 	unsigned long hole_min);
diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
new file mode 100644
index 0000000..f86ac61
--- /dev/null
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -0,0 +1,117 @@
+/*
+ * LoongArch kexec PE format binary image support.
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited.
+ *   Youling Tang <tangyouling@loongson.cn>
+ *
+ * derived from kexec-image-arm64.c
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#define _GNU_SOURCE
+
+#include <limits.h>
+#include <errno.h>
+#include <elf.h>
+
+#include "kexec.h"
+#include "kexec-elf.h"
+#include "image-header.h"
+#include "kexec-syscall.h"
+#include "crashdump-loongarch.h"
+#include "kexec-loongarch.h"
+#include "arch/options.h"
+
+int pei_loongarch_probe(const char *kernel_buf, off_t kernel_size)
+{
+	const struct loongarch_image_header *h;
+
+	if (kernel_size < sizeof(struct loongarch_image_header)) {
+		dbgprintf("%s: No loongarch image header.\n", __func__);
+		return -1;
+	}
+
+	h = (const struct loongarch_image_header *)(kernel_buf);
+
+	if (!loongarch_header_check_pe_sig(h)) {
+		dbgprintf("%s: Bad loongarch PE image header.\n", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+int pei_loongarch_load(int argc, char **argv, const char *buf,
+	off_t len, struct kexec_info *info)
+{
+	int result;
+	unsigned long hole_min = 0;
+	unsigned long kernel_segment, kernel_entry;
+	const struct loongarch_image_header *header;
+
+	header = (const struct loongarch_image_header *)(buf);
+
+	if (loongarch_process_image_header(header))
+		return EFAILED;
+
+	kernel_segment = loongarch_locate_kernel_segment(info);
+
+	if (kernel_segment == ULONG_MAX) {
+		dbgprintf("%s: Kernel segment is not allocated\n", __func__);
+		result = EFAILED;
+		goto exit;
+	}
+
+	kernel_entry = virt_to_phys(loongarch_header_kernel_entry(header));
+
+	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
+	dbgprintf("%s: kernel_entry:   %016lx\n", __func__, kernel_entry);
+	dbgprintf("%s: image_size:     %016lx\n", __func__,
+		loongarch_mem.image_size);
+	dbgprintf("%s: text_offset:    %016lx\n", __func__,
+		loongarch_mem.text_offset);
+	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
+		loongarch_mem.phys_offset);
+	dbgprintf("%s: PE format:      %s\n", __func__,
+		(loongarch_header_check_pe_sig(header) ? "yes" : "no"));
+
+	/* Get kernel entry point */
+	info->entry = (void *)kernel_entry;
+
+	hole_min = kernel_segment + loongarch_mem.image_size;
+
+	/* Create and initialize elf core header segment */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info);
+		if (result) {
+			dbgprintf("%s: Creating eflcorehdr failed.\n",
+								__func__);
+			goto exit;
+		}
+	}
+
+	/* Load the kernel */
+	add_segment(info, buf, len, kernel_segment, loongarch_mem.image_size);
+
+	/* Prepare and load dtb and initrd data */
+	result = loongarch_load_other_segments(info, hole_min);
+	if (result) {
+		fprintf(stderr, "kexec: Load dtb and initrd segments failed.\n");
+		goto exit;
+	}
+
+exit:
+	if (result)
+		fprintf(stderr, "kexec: load failed.\n");
+
+	return result;
+}
+
+void pei_loongarch_usage(void)
+{
+	printf(
+"     An LoongArch PE format binary image, uncompressed, little endian.\n"
+"     Typically a vmlinux.efi file.\n\n");
+}
-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
