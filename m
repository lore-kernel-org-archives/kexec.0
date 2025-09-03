Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71115CA0FED
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83PuVuFgr80Y4Y/zYHwpjQEYSpCD6sDbiyfLT6lkmLg=; b=HhI3UQZYT+D+kHmdsvgIWBQieH
	b3ejB0+tZoyUEflL03Th4d/Ujzcw+SCw7Ue1088gTojrUB9I2cCuy0yUImf2tgJWZV6bpPRP9wMve
	3BpGloc2MTwvG4Dhei3g0hTejaf6LH2Az93FcrwAO/zIn8ba+UC4p1an86VISe62is18850bdvInX
	BEDZ/TktUiwXm3RNOapp/zJCpmx2Xv9qkpVhuYYyWkNx0PcHW7+bupQnSN3smT7TsPpEpnZGCyay8
	KmF0nTYoMc4StUR4Hk9bPSpSwt//GkcTuqAzLVUtVmhs7SN2v7+aHcuveZlo2LB1VLUjpW6yhNxnd
	oD5yIMvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlU-00000003R55-3ttN;
	Wed, 03 Sep 2025 03:02:28 +0000
Received: from out-172.mta0.migadu.com ([2001:41d0:1004:224b::ac])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlS-00000003R0U-2h3b
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 03:02:27 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83PuVuFgr80Y4Y/zYHwpjQEYSpCD6sDbiyfLT6lkmLg=;
	b=d68UxUnIXjvuVa5rxu2nU6DO7egzUULtp+BtNzj3zbtN9KhkF3t8AtWpp+Gviys0zLUzdq
	kLxhIXbepBg3bh44dg7whRy6yqKN3B6aRu7Y0yK4R6Fka0QjhMV+jZAM1lyK1WkoI7+CvR
	RbfNyyD7gxlJID4K5akBEgfIkqNCdyc=
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
Subject: [PATCH v4 4/7] LoongArch/kexec_file: Support loading ELF binary file
Date: Wed,  3 Sep 2025 11:00:57 +0800
Message-Id: <20250903030100.196744-5-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_200226_832449_3AC7B14E 
X-CRM114-Status: GOOD (  25.13  )
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

This patch creates kexec_elf_ops to load ELF binary file for
kexec_file_load() syscall.

However, for `kbuf->memsz` and `kbuf->buf_min`, special handling is required,
and the generic `kexec_elf_load()` cannot be used directly.

$ readelf -l vmlinux
...
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags Align
   LOAD           0x0000000000010000 0x9000000000200000 0x9000000000200000
                  0x0000000002747a00 0x000000000287a0d8  RWE 0x10000
   NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
                  0x0000000000000000 0x0000000000000000  R      0x8

phdr->p_paddr should have been a physical address, but it is a virtual
address on the current LoongArch. This will cause kexec_file to fail
when loading the kernel and need to be converted to a physical address.

From the above MemSiz, it can be seen that 0x287a0d8 has not been aligned.
Although kexec_add_buffer() will perform PAGE_SIZE alignment on kbuf->memsz,
there is still a stampeding in the loaded kernel space and initrd space.
The initrd resolution failed when starting the second kernel.

It can be known from the link script vmlinux.lds.S that,
    BSS_SECTION(0, SZ_64K, 8)
    . = ALIGN(PECOFF_SEGMENT_ALIGN);

It needs to be aligned according to the SZ_64K size, so that after
alignment, its size is consistent with _kernel_asize.

The basic usage (vmlinux):
1) Load second kernel image:
 # kexec -s -l vmlinux --initrd=initrd.img --reuse-cmdline

2) Startup second kernel:
 # kexec -e

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
index 000000000000..175d8d935e11
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
+		*text_offset = __pa(phdr->p_paddr);
+		kbuf->buf_min = *text_offset;
+		kbuf->memsz = ALIGN(phdr->p_memsz, SZ_64K);
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
+	/*
+	 * Load the kernel
+	 * FIXME: Non-relocatable kernel rejected for kexec_file (require CONFIG_RELOCATABLE)
+	 */
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
index a454e9dfc339..81913359b7a1 100644
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


