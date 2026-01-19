Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0686BD4A5EB
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 03:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pv0T+x9AR2PJROBQmbxh+6k2mKN+f/nip4Zou9Zi7Ow=; b=EcIs/2ysxB4IfdKTGWuL+tjoK4
	dCbdhEtSKm+bNxdXHiD+Q5OjNh/yDFwA9VlOY7whAug4VB14XN+0AY2hArBjZoZ26GIr2OFagSLCy
	K46E02ozay1Y9YkOw34lmaYUbWwvqMqY6hqV80ck7wsKEZcKDNiQIPYVjaeFNsmFuXgBgV5UsWnNz
	kRhm8H0F+lJ50lBNBhPR3HlxSqSBlgeOQ4wF1Dn2kBAchzh74tQJFCE58wXw+uz6JbFGgG1Bwe6+o
	15mQp9hsc63PkB25sdENpZdrZrNFiXYQITI3KN7iUJmTSqi/IsO4UoPZI7vqYJXQOA1nYAaaTC1Pq
	uYot8lFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhfuK-00000001JVm-2APg;
	Mon, 19 Jan 2026 03:26:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhfu8-00000001JU2-1OAl
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 03:26:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pv0T+x9AR2PJROBQmbxh+6k2mKN+f/nip4Zou9Zi7Ow=;
	b=ABFcD2PPhsjKtWYs2HMABKG4fuKHpXu7/zNv2zw3bEl5Jk5rdYU5Vt6qAhX7ND2hUcamOz
	zKGcR73kmDRDdvkce7Z8f7veXVYiwao9oV8ITo860E4UJZWHtaov182Xn4HQCYd6MkUlYv
	5QuRrYJpD6n8hodRVx6EACo9mbfjMQ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-KVDeXZCXNESpvZ0icQjNMg-1; Sun,
 18 Jan 2026 22:26:05 -0500
X-MC-Unique: KVDeXZCXNESpvZ0icQjNMg-1
X-Mimecast-MFC-AGG-ID: KVDeXZCXNESpvZ0icQjNMg_1768793163
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E4E6180044D;
	Mon, 19 Jan 2026 03:26:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6F521955F22;
	Mon, 19 Jan 2026 03:25:51 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 04/13] kexec_file: Use bpf-prog to decompose image
Date: Mon, 19 Jan 2026 11:24:15 +0800
Message-ID: <20260119032424.10781-5-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_192622_256683_5DE48296 
X-CRM114-Status: GOOD (  34.04  )
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

As UEFI becomes popular, a few architectures support to boot a PE format
kernel image directly. But the internal of PE format varies, which means
each parser for each format.

This patch (with the rest in this series) introduces a common skeleton
to all parsers, and leave the format parsing in
bpf-prog, so the kernel code can keep relative stable.

History, the syscall
SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
                unsigned long, cmdline_len, const char __user *, cmdline_ptr,
                unsigned long, flags)
complies with the kernel protocol: bootable kernel, initramfs, cmdline.

But the occurrence of UKI images challenges the traditional model. The
image itself contains the kernel, initrd, and cmdline. To be compatible
with both the old and new models, kexec_file_load can be reorganized into
two stages. In the first stage, "decompose_kexec_image()" breaks down the
passed-in image into the components required by the kernel boot protocol.
In the second stage, the traditional image loader
"arch_kexec_kernel_image_load()" prepares the switch to the next kernel.

During the decomposition stage, the decomposition process can be nested.
In each sub-process, BPF bytecode is extracted from the '.bpf' section
to parse the current PE file. If the data section in the PE file contains
another PE file, the sub-process is repeated. This is designed to handle
the zboot format embedded in UKI format on the arm64 platform.

There are some placeholder functions in this patch. (They will take effect
after the introduction of kexec BPF light skeleton and BPF helpers.)

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/Kconfig.kexec      |   8 ++
 kernel/Makefile           |   2 +-
 kernel/kexec_bpf_loader.c | 161 ++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c       |   9 ++-
 kernel/kexec_internal.h   |   1 +
 5 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 kernel/kexec_bpf_loader.c

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf71..0c5d619820bcd 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -46,6 +46,14 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by kexec system call.
 
+config KEXEC_BPF
+	bool "Enable bpf-prog to parse the kexec image"
+	depends on KEXEC_FILE
+	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	help
+	  This is a feature to run bpf section inside a kexec image file, which
+	  parses the image properly and help kernel set up kexec boot protocol
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on ARCH_SUPPORTS_KEXEC_SIG
diff --git a/kernel/Makefile b/kernel/Makefile
index f9e85c4a0622b..05177a867690d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -83,7 +83,7 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
-obj-$(CONFIG_KEXEC_BPF) += kexec_uefi_app.o
+obj-$(CONFIG_KEXEC_BPF) += kexec_bpf_loader.o kexec_uefi_app.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
new file mode 100644
index 0000000000000..dc59e1389da94
--- /dev/null
+++ b/kernel/kexec_bpf_loader.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec image bpf section helpers
+ *
+ * Copyright (C) 2025, 2026 Red Hat, Inc
+ */
+
+#define pr_fmt(fmt)	"kexec_file(Image): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
+#include <linux/elf.h>
+#include <linux/string.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <asm/byteorder.h>
+#include <asm/image.h>
+#include <asm/memory.h>
+#include "kexec_internal.h"
+
+/* Load a ELF */
+static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
+{
+	return 0;
+}
+
+static void disarm_bpf_prog(void)
+{
+}
+
+struct kexec_context {
+	bool kdump;
+	char *kernel;
+	int kernel_sz;
+	char *initrd;
+	int initrd_sz;
+	char *cmdline;
+	int cmdline_sz;
+};
+
+void kexec_image_parser_anchor(struct kexec_context *context,
+		unsigned long parser_id);
+
+/*
+ * optimize("O0") prevents inline, compiler constant propagation
+ *
+ * Let bpf be the program context pointer so that it will not be spilled into
+ * stack.
+ */
+__attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
+		struct kexec_context *context,
+		unsigned long parser_id)
+{
+	/*
+	 * To prevent linker from Identical Code Folding (ICF) with kexec_image_parser_anchor,
+	 * making them have different code.
+	 */
+	volatile int dummy = 0;
+
+	dummy += 1;
+}
+
+
+BTF_KFUNCS_START(kexec_modify_return_ids)
+BTF_ID_FLAGS(func, kexec_image_parser_anchor, KF_SLEEPABLE)
+BTF_KFUNCS_END(kexec_modify_return_ids)
+
+static const struct btf_kfunc_id_set kexec_modify_return_set = {
+	.owner = THIS_MODULE,
+	.set = &kexec_modify_return_ids,
+};
+
+static int __init kexec_bpf_prog_run_init(void)
+{
+	return register_btf_fmodret_id_set(&kexec_modify_return_set);
+}
+late_initcall(kexec_bpf_prog_run_init);
+
+static int kexec_buff_parser(struct bpf_parser_context *parser)
+{
+	return 0;
+}
+
+/* At present, only PE format file with .bpf section is supported */
+#define file_has_bpf_section	pe_has_bpf_section
+#define file_get_section	pe_get_section
+
+int decompose_kexec_image(struct kimage *image, int extended_fd)
+{
+	struct kexec_context context = { 0 };
+	struct bpf_parser_context *bpf;
+	unsigned long kernel_sz, bpf_sz;
+	char *kernel_start, *bpf_start;
+	int ret = 0;
+
+	if (image->type != KEXEC_TYPE_CRASH)
+	        context.kdump = false;
+	else
+	        context.kdump = true;
+
+	kernel_start = image->kernel_buf;
+	kernel_sz = image->kernel_buf_len;
+
+	while (file_has_bpf_section(kernel_start, kernel_sz)) {
+
+		bpf = alloc_bpf_parser_context(kexec_buff_parser, &context);
+		if (!bpf)
+			return -ENOMEM;
+		file_get_section((const char *)kernel_start, ".bpf", &bpf_start, &bpf_sz);
+		if (!!bpf_sz) {
+			/* load and attach bpf-prog */
+			ret = arm_bpf_prog(bpf_start, bpf_sz);
+			if (ret) {
+				put_bpf_parser_context(bpf);
+				pr_err("Fail to load .bpf section\n");
+				goto err;
+			}
+		}
+		context.kernel = kernel_start;
+		context.kernel_sz = kernel_sz;
+		/* bpf-prog fentry, which handle above buffers. */
+		kexec_image_parser_anchor(&context, (unsigned long)bpf);
+
+		/*
+		 * Container may be nested and should be unfold one by one.
+		 * The former bpf-prog should prepare 'kernel', 'initrd',
+		 * 'cmdline' for the next phase by calling kexec_buff_parser()
+		 */
+		kernel_start = context.kernel;
+		kernel_sz = context.kernel_sz;
+
+		/*
+		 * detach the current bpf-prog from their attachment points.
+		 */
+		disarm_bpf_prog();
+		put_bpf_parser_context(bpf);
+	}
+
+	/*
+	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
+	 * be updated to the new content.
+	 */
+	image->kernel_buf = context.kernel;
+	image->kernel_buf_len = context.kernel_sz;
+	image->initrd_buf = context.initrd;
+	image->initrd_buf_len = context.initrd_sz;
+	image->cmdline_buf = context.cmdline;
+	image->cmdline_buf_len = context.cmdline_sz;
+
+	return 0;
+err:
+	vfree(context.kernel);
+	vfree(context.initrd);
+	vfree(context.cmdline);
+	return ret;
+}
+
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0222d17072d40..f9674bb5bd8db 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -238,7 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		goto out;
 #endif
 
-	/* Call arch image probe handlers */
+	if (IS_ENABLED(CONFIG_KEXEC_BPF))
+		decompose_kexec_image(image, initrd_fd);
+
+	/*
+	 * From this point, the kexec subsystem handle the kernel boot protocol.
+	 *
+	 * Call arch image probe handlers
+	 */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
 	if (ret)
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 8e5e5c1237732..ee01d0c8bb377 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -39,6 +39,7 @@ extern size_t kexec_purgatory_size;
 extern bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
 extern int pe_get_section(const char *file_buf, const char *sect_name,
 		char **sect_start, unsigned long *sect_sz);
+extern int decompose_kexec_image(struct kimage *image, int extended_fd);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
-- 
2.49.0


