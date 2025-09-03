Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1DFCA1013
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Y/9kZHekM+gIBRRUe68eDicKpPDtNyELOaDeeOu0CE=; b=UEUUSoQSp+N35satLpS3i+Lt9F
	XD3VYUbo6AwyxfplHqzp6eh5wYNN9jv5+MnU/vlzrNRDwcRSYem80Gl66z1/SO3AFQ5O5IqQU5K3u
	RxaseXMGTKWZUPIgXT3mL4b+Et0Kszo3TQhff+QDwJrm4PAHtnrssViYIMxY6a5ORa///O2UxXgIQ
	jDEFGi9iR54jFn9cf52DC0yUx7f283u2468XJ8YGT7dDZTu3wmH45KpNehoTAy2aSG47YbC9Pn7HZ
	DAIzBKRf7vw1wGhw8klU4HYoEpB6u1qu2lGCGbigh2W6cypygq+F7vaBRL5dIfpse1K7vAuiNuVKG
	/+IefJzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlS-00000003R1n-12ui;
	Wed, 03 Sep 2025 03:02:26 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlP-00000003QyY-2yil
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 03:02:25 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y/9kZHekM+gIBRRUe68eDicKpPDtNyELOaDeeOu0CE=;
	b=VthOXtS91xS1dwsI7nuJzwzt7lhGfFY3j33cNwgTp64x7gCkivNXJwTi4G8iB9N8gEoMBE
	ffVKs54+iChzx6YS1RvXAeYHuszCM7hNfRvXHdnZjky6dpzMZKCPw47NVlKro57ZNGe/Kh
	NknhUZ1S70FseA816Wy9fc8gIVpkAtg=
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
Subject: [PATCH v4 3/7] LoongArch/kexec_file: Support loading EFI binary file
Date: Wed,  3 Sep 2025 11:00:56 +0800
Message-Id: <20250903030100.196744-4-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_200223_911359_A47E5C35 
X-CRM114-Status: GOOD (  22.20  )
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

This patch creates kexec_efi_ops to load EFI binary file for
kexec_file_load() syscall.

The efi_kexec_load() as two parts:
- the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
- the second part loads other segments (eg: initrd, cmdline)

Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are
supported.

The basic usage (vmlinuz.efi or vmlinux.efi):
1) Load second kernel image:
 # kexec -s -l vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Startup second kernel:
 # kexec -e

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/include/asm/image.h         |  17 +++
 arch/loongarch/include/asm/kexec.h         |   1 +
 arch/loongarch/kernel/Makefile             |   2 +-
 arch/loongarch/kernel/kexec_efi.c          | 114 +++++++++++++++++++++
 arch/loongarch/kernel/machine_kexec_file.c |   1 +
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/kexec_efi.c

diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
index ff539711c9ea..982cebd31cac 100644
--- a/arch/loongarch/include/asm/image.h
+++ b/arch/loongarch/include/asm/image.h
@@ -32,5 +32,22 @@ struct loongarch_image_header {
 	uint32_t pe_header;
 };
 
+static const uint8_t loongarch_image_dos_sig[2] = {'M', 'Z'};
+
+/**
+ * loongarch_header_check_dos_sig - Helper to check the loongarch image header.
+ *
+ * Returns non-zero if 'MZ' signature is found.
+ */
+
+static inline int loongarch_header_check_dos_sig(const struct loongarch_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (h->dos_sig[0] == loongarch_image_dos_sig[0]
+		&& h->dos_sig[1] == loongarch_image_dos_sig[1]);
+}
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ASM_IMAGE_H */
diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index ed7e3fc8571e..34799db933fb 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -42,6 +42,7 @@ struct kimage_arch {
 };
 
 #ifdef CONFIG_KEXEC_FILE
+extern const struct kexec_file_ops kexec_efi_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 67b9b214d212..dd6183f353e6 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
-obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
new file mode 100644
index 000000000000..e02fd88cf5d0
--- /dev/null
+++ b/arch/loongarch/kernel/kexec_efi.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Load EFI vmlinux file for the kexec_file_load syscall.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(EFI): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/pe.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+#include <asm/cpufeature.h>
+#include <asm/image.h>
+
+static int efi_kexec_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct loongarch_image_header *h = (const struct loongarch_image_header *)kernel_buf;
+
+	if (!h || (kernel_len < sizeof(*h))) {
+		pr_err("No loongarch image header.\n");
+		return -EINVAL;
+	}
+
+	if (!loongarch_header_check_dos_sig(h)) {
+		pr_warn("No loongarch PE image header.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void *efi_kexec_load(struct kimage *image,
+				char *kernel, unsigned long kernel_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	struct loongarch_image_header *h;
+	struct kexec_buf kbuf;
+	unsigned long text_offset, kernel_segment_number;
+	struct kexec_segment *kernel_segment;
+	int ret;
+
+	h = (struct loongarch_image_header *)kernel;
+	if (!h->kernel_asize)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Load the kernel
+	 * FIXME: Non-relocatable kernel rejected for kexec_file (require CONFIG_RELOCATABLE)
+	 */
+	kbuf.image = image;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = le64_to_cpu(h->kernel_asize);
+	text_offset = le64_to_cpu(h->text_offset);
+	kbuf.buf_min = text_offset;
+	kbuf.buf_align = SZ_2M;
+
+	kernel_segment_number = image->nr_segments;
+
+	/*
+	 * The location of the kernel segment may make it impossible to satisfy
+	 * the other segment requirements, so we try repeatedly to find a
+	 * location that will work.
+	 */
+	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
+		/* Try to load additional data */
+		kernel_segment = &image->segment[kernel_segment_number];
+		ret = load_other_segments(image, kernel_segment->mem,
+					  kernel_segment->memsz, initrd,
+					  initrd_len, cmdline, cmdline_len);
+		if (!ret)
+			break;
+
+		/*
+		 * We couldn't find space for the other segments; erase the
+		 * kernel segment and try the next available hole.
+		 */
+		image->nr_segments -= 1;
+		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	}
+
+	if (ret) {
+		pr_err("Could not find any suitable kernel location!");
+		return ERR_PTR(ret);
+	}
+
+	kernel_segment = &image->segment[kernel_segment_number];
+
+	/* Make sure the second kernel jumps to the correct "kernel_entry". */
+	image->start = kernel_segment->mem + h->kernel_entry - text_offset;
+
+	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kernel_segment->mem, kbuf.bufsz,
+		      kernel_segment->memsz);
+
+	return NULL;
+}
+
+const struct kexec_file_ops kexec_efi_ops = {
+	.probe = efi_kexec_probe,
+	.load = efi_kexec_load,
+};
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 584ce9471e93..a454e9dfc339 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -21,6 +21,7 @@
 #include <asm/bootinfo.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_efi_ops,
 	NULL
 };
 
-- 
2.43.0


