Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCC4CA0EFD
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDOGfKAncS3JpdJdcrw8JwTp9Kssefr3qjdwC73xGe8=; b=vH3d+Zy49F+WN495Kku8/rZ7fi
	IByf20V6qcfNHKxqjyYvvIRi8L09pVJMO/JzMBowbhmJODS0O/6Q6mhOvtKVM/wzV+8I39DznHJhO
	gK+ZTO+8et0JoG4SYI/BJ5OYNdmAGGDCdu/D5QCRbBAiLubkC0gCN/76e0y2YKStooH0OuAYgT5l0
	6QWw2ypve3Uo04J7UaoUsPlXLhu67ikGAb4Pm7bYrkpY4jJcy1oOdIaqUigeIqe9Pqbbz75nCpEy8
	tsynXGACvV637GxyBeSPBM4FE/X/TVoLuT7KQ2GzpGKO/btbLmddI0BPAVR7ifdFHfm1rZhexMd4V
	2IuucVpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobqB-0000000CSeo-19vn;
	Wed, 20 Aug 2025 05:58:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobpg-0000000CSZF-3jtq
	for kexec@bombadil.infradead.org;
	Wed, 20 Aug 2025 05:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NDOGfKAncS3JpdJdcrw8JwTp9Kssefr3qjdwC73xGe8=; b=a5JNqAJqQRRtnGT5tEUi1Z/dw1
	eqe0e/k/YDLl+chgUtf3WozO1eI5yukKf/5h/DoVQE8xAOb6t2fwz71HqlpHyUv7q1I7Akd5njAix
	kQMdVZo/qTYszk4p6/LtQoRLOAKCtBOE7t7qxVjZ0RO7d42821adrgjq7F4pqUObCoQ9LKQxRoHav
	Q5cS2PiHFHobRZsLR9q/CQvVwsRoYu587RKPGW3PjkhSO7ulpjFHq6xgZEQCkwVeNtSwt3qC1mbbX
	iY1JXHUUdw74aaZV+D7mgmslfIUT8ierh4+14Cm5xhYyVYc+87ZgZpATFhlJeEI2bVA2DZD8R+fBG
	uG6CUp8g==;
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobpd-00000000BlM-3JLr
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 05:57:59 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDOGfKAncS3JpdJdcrw8JwTp9Kssefr3qjdwC73xGe8=;
	b=H4Kz/d7BkucqkiL8X/BdzyV6B7Q9H/UpIIVlMCfANdSN3mhZSl835uvTegrLLi/T0pLmtm
	ztTXtOzOmTCOaSkJcvgVRdxBRETiuhfW7C0UIctQz7AQMS+OoJsDLTeE56XznyeD8+Kh8v
	qTeOzK7Gu4RRmP3JHZfWRwrB+WzjjzM=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 3/5] LoongArch/kexec_file: Support loading ELF binary file
Date: Wed, 20 Aug 2025 13:56:58 +0800
Message-Id: <20250820055700.24344-4-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-1-youling.tang@linux.dev>
References: <20250820055700.24344-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_065758_241168_297EFE40 
X-CRM114-Status: GOOD (  18.92  )
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

From: Youling Tang <tangyouling@kylinos.cn>

This patch creates kexec_elf_ops to load ELF binary file
for kexec_file_load() syscall.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/Kconfig                     |   1 +
 arch/loongarch/include/asm/kexec.h         |   1 +
 arch/loongarch/kernel/Makefile             |   2 +-
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++++++++++++++
 arch/loongarch/kernel/machine_kexec_file.c |   1 +
 5 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/kexec_elf.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 490dc6eed749..bf2664ed7ce3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -632,6 +632,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
+	select KEXEC_ELF
 	select RELOCATABLE
 
 config ARCH_SUPPORTS_CRASH_DUMP
diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index 34799db933fb..fecfb3015abc 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -43,6 +43,7 @@ struct kimage_arch {
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_efi_ops;
+extern const struct kexec_file_ops kexec_elf_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index dd6183f353e6..001924877772 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
-obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o kexec_elf.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/loongarch/kernel/kexec_elf.c b/arch/loongarch/kernel/kexec_elf.c
new file mode 100644
index 000000000000..d41ee5fd7cef
--- /dev/null
+++ b/arch/loongarch/kernel/kexec_elf.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Load ELF vmlinux file for the kexec_file_load syscall.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(ELF): " fmt
+
+#include <linux/elf.h>
+#include <linux/kexec.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/memblock.h>
+#include <asm/image.h>
+#include <asm/setup.h>
+
+static int loongarch_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
+			 struct kexec_elf_info *elf_info,
+			 struct kexec_buf *kbuf,
+			 unsigned long *text_offset)
+{
+	int ret = -1;
+	size_t i;
+
+	/* Read in the PT_LOAD segments. */
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		size_t size;
+		const struct elf_phdr *phdr;
+		struct loongarch_image_header *header;
+
+		phdr = &elf_info->proghdrs[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		size = phdr->p_filesz;
+		if (size > phdr->p_memsz)
+			size = phdr->p_memsz;
+
+		kbuf->buffer = (void *)elf_info->buffer + phdr->p_offset;
+		kbuf->bufsz = size;
+		kbuf->buf_align = phdr->p_align;
+		header = (struct loongarch_image_header *)kbuf->buffer;
+		*text_offset = le64_to_cpu(header->text_offset);
+		kbuf->buf_min = *text_offset;
+		kbuf->memsz = le64_to_cpu(header->image_size);
+		kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
+		ret = kexec_add_buffer(kbuf);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
+			    unsigned long kernel_len, char *initrd,
+			    unsigned long initrd_len, char *cmdline,
+			    unsigned long cmdline_len)
+{
+	int ret;
+	unsigned long text_offset = 0, kernel_segment_number;
+	struct elfhdr ehdr;
+	struct kexec_elf_info elf_info;
+	struct kexec_segment *kernel_segment;
+	struct kexec_buf kbuf;
+
+	ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Load the kernel */
+	kbuf.image = image;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kernel_segment_number = image->nr_segments;
+
+	ret = loongarch_kexec_elf_load(image, &ehdr, &elf_info, &kbuf, &text_offset);
+	if (ret)
+		goto out;
+
+	/* Load additional data */
+	kernel_segment = &image->segment[kernel_segment_number];
+	ret = load_other_segments(image, kernel_segment->mem, kernel_segment->memsz,
+				  initrd, initrd_len, cmdline, cmdline_len);
+	if (ret)
+		goto out;
+
+	/* Make sure the second kernel jumps to the correct "kernel_entry". */
+	image->start = kernel_segment->mem + __pa(ehdr.e_entry) - text_offset;
+
+	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kernel_segment->mem, kbuf.bufsz, kernel_segment->memsz);
+
+out:
+	kexec_free_elf_info(&elf_info);
+	return ret ? ERR_PTR(ret) : NULL;
+}
+
+const struct kexec_file_ops kexec_elf_ops = {
+	.probe = kexec_elf_probe,
+	.load  = elf_kexec_load,
+};
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index a713acf32db8..dc6e37457559 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -22,6 +22,7 @@
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_efi_ops,
+	&kexec_elf_ops,
 	NULL
 };
 
-- 
2.43.0


