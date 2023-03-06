Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48FBC61DA4
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 03:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gH7/Vg4WcirpSQtWvaTO9M+abhPj2VRdipWMFoEOnJw=; b=M56PXworjAjKmZ
	YjUtFdTs7Vw88qT3f6layJFZB/GSbfZEeUYR2mTu57MbMXkmWI02/w1aZkfNfOWU9WAPAd7gKXJyw
	mH2kYlztUU1dTCvthZ5KD1JV1DY4n9cyELOct/g1KSVGZ/ut6/y+XPJXZ6wapr2CqV/FrGA+Aemzx
	/uiv6BOmNJVPYQxXEeb3U9+BvTLlEPnTRX9GzF8zh0MkN7qOQq3F3zlte2eRDZesyXUTORCLTzELg
	7jD4h2unQVJxeMmJ1r/iMSLRK41OmMPsgPOcqw+h8czbRT681ERo0KIlZOofEBOpSWRW39ZbxFuja
	ZIYQL86ELIPdNlVf6/UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ1AU-00B3mh-DN; Mon, 06 Mar 2023 03:05:42 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18f-00B2aV-KY; Mon, 06 Mar 2023 03:03:51 +0000
Received: by mail-pj1-x1035.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso11771567pjr.5;
        Sun, 05 Mar 2023 19:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5avoOc2LsVwG6FVeumV4bYgF8SZE6ZZN8iKqNWFSzks=;
        b=IxJYLpptdt+bORdBe4KXuFk2YwppFfWSKz51NfUP3p2FR5RsIbew/xtJAA+eAmorFe
         Zx+gik8oy6uNP5/YwV0vRdxOzwYTPUm/cEBa6yyvnt50hong8Bt7/iBtclCYGbnL6xHN
         6qUVtQcPIfXhiwgYNcEDALIwayPef8vSg23mtY8Zj/sTos8++e7t2fGmRfObXplHTl9r
         vVAO3mpJMgSRxyBWjkR5U0HjsLaW4GTUJzV25BVBDNRjugQohiOuj5Rt8TNq8+ibc83G
         x+OqkF5dpKJQgV5NIqkSKkp/vXa0YSLP9u49flK7dV+ugAiKM6rC27VT3GZ1RsGRb6hf
         QQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5avoOc2LsVwG6FVeumV4bYgF8SZE6ZZN8iKqNWFSzks=;
        b=t89L6x24uSzW1uq6ETqpAx/Ah0RAjxFpK+v3fvkNoiYiBQmzv99vO8unEOXqNkA/gr
         BG97QfpJpiG8TYKv4jndJ2YL5DCwHPy3skxc52Y1JPgK6iZ5aYdY8XGWe1bzN3ZGTcT7
         9uwblWCx+Qq4V3VSB/4Ncvg8EMj/yLq/dJTqGDY4tGqJQ7glGieSZoeLOzGR0WSOJAHv
         Zxi2awPDSdxIqoKzfoMX3/nxhHbMoryboFzblPFOUq4ztW0c5eZI6/tSHry/ho9touvI
         ikziKGpf11WrjXXmvxRDtErGEt7jFMZY7aXqp2xElZxzCTbGWgp43JTHgrBXaXJUARIm
         Iy5g==
X-Gm-Message-State: AO0yUKXqFJoHfJ/24xJAL5vtaTDBGqDv9rdJGEnUkJ4FYjPDZCyT49i0
	yFEN3H56tHm7uyTdHLhuV20T999u6Q==
X-Google-Smtp-Source: AK7set9G19B259z8e2En7cYqTvVLBJRvkbJLo/yYJytfFSLPIUdMWYKshf31YUgtGNK582TmnZF7sg==
X-Received: by 2002:a17:902:da90:b0:19a:a0d0:10f0 with SMTP id j16-20020a170902da9000b0019aa0d010f0mr11803770plx.23.1678071827511;
        Sun, 05 Mar 2023 19:03:47 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:46 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Michal Suchanek <msuchanek@suse.de>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org
Subject: [PATCH 5/6] arm64: kexec: Introduce zboot image loader
Date: Mon,  6 Mar 2023 11:03:04 +0800
Message-Id: <20230306030305.15595-6-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_190349_737751_3ED19F28 
X-CRM114-Status: GOOD (  28.27  )
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

The EFI zboot kernel format can decompress and boot the vmlinux, but it
relies on the EFI service, which is not available when kexec jumps to
the new entry.

To tackle this issue, parsing zboot image and decompressing the Image.gz
part at the file loading time. But this way, in essential, the kexec
boots up Image.

As for decompression, it can be done either in the user space or the
kernel. But due to the signature verification in kernel, it should be
achieved in the kernel space.

Besides this, kexec faces a situation a little different from
efi_zboot_entry(), where the latter has knowledge of the system memory
through EFI services, while kexec can do it through the kernel's mm.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/kexec.h         |   2 +
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/kexec_zboot_image.c  | 186 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c      |   1 +
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 include/linux/zboot.h                  |  26 ++++
 6 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
 create mode 100644 include/linux/zboot.h

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 3f3d5a6830b7..8b820088323c 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -114,6 +114,7 @@ void arch_kexec_unprotect_crashkres(void);
 
 struct kimage_arch {
 	void *dtb;
+	void *decompressed_kernel;
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
 	phys_addr_t el2_vectors;
@@ -126,6 +127,7 @@ struct kimage_arch {
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_raw_ops;
+extern const struct kexec_file_ops kexec_zboot_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 99b52710606a..ec4d3c17ef70 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_raw_image.o
+obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_raw_image.o kexec_zboot_image.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/kexec_zboot_image.c b/arch/arm64/kernel/kexec_zboot_image.c
new file mode 100644
index 000000000000..4629091666b7
--- /dev/null
+++ b/arch/arm64/kernel/kexec_zboot_image.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec zboot image loader.
+ * Code is based on kexec_raw_image.c
+ */
+
+#define pr_fmt(fmt)	"kexec_file(zboot): " fmt
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
+#include <asm/memory.h>
+#include <linux/zboot.h>
+#include <linux/decompress/generic.h>
+
+static int zboot_image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	struct zboot_image_header *h =
+		(struct zboot_image_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h)))
+		return -EINVAL;
+
+	if (memcmp(&h->magic, (char *)MZ_MAGIC, sizeof(h->magic)))
+		return -EINVAL;
+	if (strncmp(h->zimg, "zimg", 4))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void error(char *x)
+{
+	pr_err("%s\n", x);
+}
+
+static void *zboot_image_load(struct kimage *image,
+				char *kernel, unsigned long kernel_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	struct zboot_image_header *zh;
+	struct arm64_image_header *h;
+	char *decompressed_buf;
+	u32 sz;
+	long out_sz;
+	u64 flags, value;
+	bool be_image, be_kernel;
+	struct kexec_buf kbuf;
+	unsigned long text_offset, kernel_segment_number;
+	struct kexec_segment *kernel_segment;
+	int ret;
+	decompress_fn decompressor;
+
+	zh = (struct zboot_image_header *)kernel;
+	/*
+	 * zboot has SizeOfCode, SizeOfImage, SizeOfHeaders appended at the end. And
+	 * each occupies 4 bytes.
+	 */
+	sz = *(u32 *)(kernel + zh->gzdata_offset + zh->gzdata_size + 4);
+	out_sz = sz;
+	/* freed in machine_kexec_post_load() */
+	decompressed_buf = kmalloc(sz, GFP_KERNEL);
+	if (!decompressed_buf) {
+		pr_info("Can not get enough memory to decompress the zboot image\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	decompressor = decompress_method_by_name(zh->comp_type);
+	if (!decompressor) {
+		pr_info("Invalid compress-format:%s\n", zh->comp_type);
+		ret = -EINVAL;
+		goto err;
+	}
+	ret = decompressor(kernel + zh->gzdata_offset, zh->gzdata_size, NULL, NULL,
+			   (void *)decompressed_buf, &out_sz, error);
+
+	if (ret) {
+		pr_info("Fail to decompress the zboot image\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	h = (struct arm64_image_header *)decompressed_buf;
+	if (!h->image_size) {
+		kfree(decompressed_buf);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Check cpu features */
+	flags = le64_to_cpu(h->flags);
+	be_image = arm64_image_flag_field(flags, ARM64_IMAGE_FLAG_BE);
+	be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	if ((be_image != be_kernel) && !system_supports_mixed_endian()) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	value = arm64_image_flag_field(flags, ARM64_IMAGE_FLAG_PAGE_SIZE);
+	if (((value == ARM64_IMAGE_FLAG_PAGE_SIZE_4K) &&
+			!system_supports_4kb_granule()) ||
+	    ((value == ARM64_IMAGE_FLAG_PAGE_SIZE_64K) &&
+			!system_supports_64kb_granule()) ||
+	    ((value == ARM64_IMAGE_FLAG_PAGE_SIZE_16K) &&
+			!system_supports_16kb_granule())) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Load the kernel */
+	kbuf.image = image;
+	kbuf.buf_min = 0;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kbuf.buffer = decompressed_buf;
+	kbuf.bufsz = sz;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = le64_to_cpu(h->image_size);
+	text_offset = le64_to_cpu(h->text_offset);
+	kbuf.buf_align = MIN_KIMG_ALIGN;
+
+	/* Adjust kernel segment with TEXT_OFFSET */
+	kbuf.memsz += text_offset;
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
+					  initrd_len, cmdline);
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
+		goto err;
+	}
+
+	kernel_segment = &image->segment[kernel_segment_number];
+	kernel_segment->mem += text_offset;
+	kernel_segment->memsz -= text_offset;
+	image->start = kernel_segment->mem;
+	image->arch.decompressed_kernel = decompressed_buf;
+
+	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				kernel_segment->mem, kbuf.bufsz,
+				kernel_segment->memsz);
+
+	return NULL;
+
+err:
+	kfree(decompressed_buf);
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_zboot_ops = {
+	.probe = zboot_image_probe,
+	.load = zboot_image_load,
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+	.verify_sig = kexec_kernel_verify_pe_sig,
+#endif
+};
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index ce3d40120f72..866c1c27a9ea 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -166,6 +166,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	icache_inval_pou((uintptr_t)reloc_code,
 			 (uintptr_t)reloc_code + reloc_size);
 	kexec_image_info(kimage);
+	kfree(kimage->arch.decompressed_kernel);
 
 	return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 0738020507d1..02d7e4004cfb 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -24,6 +24,7 @@
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_raw_ops,
+	&kexec_zboot_ops,
 	NULL
 };
 
diff --git a/include/linux/zboot.h b/include/linux/zboot.h
new file mode 100644
index 000000000000..abefcb92e1ad
--- /dev/null
+++ b/include/linux/zboot.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ZBOOT_H
+#define ZBOOT_H
+
+struct zboot_image_header {
+	union {
+		struct {
+			u32 magic;
+			/* image type, .ascii "zimg" */
+			char zimg[4];
+			s32 gzdata_offset;
+			s32 gzdata_size;
+			s32 reserved[2];
+			/* compression type, .asciz */
+			char comp_type[];
+		};
+		struct {
+			char pad[56];
+		};
+	};
+	/* 0x818223cd */
+	u32 linux_pe_magic;
+	s32 pe_header_offset;
+} __packed;
+
+#endif
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
