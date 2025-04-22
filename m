Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49507C369D1
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 19:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=up5qPlZUM4aE8oWR4Sb90xbf2Cuk+3RwUwzvTnyWmXM=; b=AEsfmlPqF/0GoazdoQhdj19Ri+
	gQPNaUmItcxWX86rOyNxok2yMbjuhs5T4HjG0n1P6XJ1eCW+KzLE36y1nAcCWAa4oE1Tl4N4YdgNB
	hz0jI82g+URzEW8EqLGR0bvPHYEqRXkBLM/eYNRN2hEoP+TVEMNoWcvE4idHgp8DJ7HF/Dikav5Nn
	dWYtGFWKdwgioNEYHa+oLIZL0+Gd6W6IbRuEJcISQc+SQZ3YCC3ZtI9hwknC55NmALKSCBntoruGT
	Wxop4hAFyPRH6spgrS9hg8bJ+rD6W+qJLbkfXW/rIqPlEBOcmp1w+ueWxNxqL82xp+1jFIiPGvRMl
	ZYvfS7wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7JaU-00000008LaB-3rEI;
	Tue, 22 Apr 2025 19:47:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GOz-00000007tIe-2Sne;
	Tue, 22 Apr 2025 16:23:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CC35A60010;
	Tue, 22 Apr 2025 16:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DB1C4CEEB;
	Tue, 22 Apr 2025 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745338996;
	bh=J+/882wCEYMbD3sKVezVzqnpiAMGLCSuGHfUftjgEJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eP1H4hr8GSDMTgh4HlL5gMq/uKIsQbKxaHXu3TzZDxOgSsXSgUeW2cv+3sPRHXin+
	 kzqpRMEYJSfcjKr9geuKoEg2G4aCy+bJYOgVAEvfa2VsdVCLE+8pTXXRRB7UEQ8bnT
	 WODy5zcxYvRk9WMcpb+7mmWguxHQ1+MX1W/pFMKgZ0E67HmliBNuoihIkEwAcq2Vao
	 HqvqRi9xh9KKSTF6v+k4Ext4hHtTj++XNklkGZSXBfmWG45jmDvI26KrZ0D2+3D1yq
	 Fm+mIQdx/PybXmo+YZe/onz6v4hrc8k/GfNaOcDLDCr9xCRiF4YaF9ZQS/ArD0+XIl
	 aQIK98amEl37w==
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
Subject: [PATCH v2 2/4] RISC-V: Enable kexec_file_load syscall
Date: Tue, 22 Apr 2025 18:22:58 +0200
Message-ID: <20250422162304.169431-3-bjorn@kernel.org>
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

From: Li Zhengyu <lizhengyu3@huawei.com>

Create prepare_kexec_file_options() function to prepare the options
to kexec_file_load syscall, and it would be used in elf_riscv_load()
or the future image_riscv_load().

The patch comes from the RISC-V Linux kernel_file_load support[1],
So its author should be Li Zhengyu.

[1]: https://lore.kernel.org/all/20220408100914.150110-1-lizhengyu3@huawei.com/

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kexec/arch/riscv/kexec-elf-riscv.c |  5 ++--
 kexec/arch/riscv/kexec-riscv.c     | 39 ++++++++++++++++++++++++++++++
 kexec/arch/riscv/kexec-riscv.h     |  1 +
 kexec/kexec-syscall.h              |  3 +++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/riscv/kexec-elf-riscv.c b/kexec/arch/riscv/kexec-elf-riscv.c
index f3c011c4c1dc..2b9f66d782af 100644
--- a/kexec/arch/riscv/kexec-elf-riscv.c
+++ b/kexec/arch/riscv/kexec-elf-riscv.c
@@ -112,6 +112,7 @@ void elf_riscv_usage(void)
 {
 }
 
+
 int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
 		   struct kexec_info *info)
 {
@@ -127,9 +128,7 @@ int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
 	int ret = 0;
 
 	if (info->file_mode) {
-		fprintf(stderr, "kexec_file not supported on this "
-				"architecture\n");
-		return -EINVAL;
+		return prepare_kexec_file_options(info);
 	}
 
 	/* Parse the ELF file */
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index 38d9a394aadd..bbc25c5cba41 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -17,6 +17,12 @@
 #include "kexec-riscv.h"
 #include "iomem.h"
 #include <stdbool.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#ifndef _O_BINARY
+#define _O_BINARY 0
+#endif
 
 const struct arch_map_entry arches[] = {
 	{ "riscv32", KEXEC_ARCH_RISCV },
@@ -141,6 +147,39 @@ void arch_usage(void)
 	printf(riscv_opts_usage);
 }
 
+int prepare_kexec_file_options(struct kexec_info *info)
+{
+	int fd;
+	ssize_t result;
+	struct stat stats;
+
+	if (arch_options.cmdline) {
+		info->command_line = (char *)arch_options.cmdline;
+		info->command_line_len = strlen(info->command_line) + 1;
+	}
+
+	if (!arch_options.initrd_path) {
+		info->initrd_fd = -1;
+		return 0;
+	}
+
+	fd = open(arch_options.initrd_path, O_RDONLY | _O_BINARY);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open `%s': %s\n", arch_options.initrd_path,
+				strerror(errno));
+		return -EINVAL;
+	}
+	result = fstat(fd, &stats);
+	if (result < 0) {
+		close(fd);
+		fprintf(stderr, "Cannot stat: %s: %s\n", arch_options.initrd_path,
+				strerror(errno));
+		return -EINVAL;
+	}
+	info->initrd_fd = fd;
+	return 0;
+}
+
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {
diff --git a/kexec/arch/riscv/kexec-riscv.h b/kexec/arch/riscv/kexec-riscv.h
index c4323a65dacf..f136c7eab561 100644
--- a/kexec/arch/riscv/kexec-riscv.h
+++ b/kexec/arch/riscv/kexec-riscv.h
@@ -23,6 +23,7 @@ extern struct memory_range elfcorehdr_mem;
 int load_elfcorehdr(struct kexec_info *info);
 
 /* kexec-riscv.c */
+int prepare_kexec_file_options(struct kexec_info *info);
 int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 			uint64_t kernel_size, uint64_t max_addr);
 
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 89591ad17e7d..9b1757877a85 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -80,6 +80,9 @@
 #ifdef __hppa__
 #define __NR_kexec_file_load	355
 #endif
+#if defined(__riscv__) || defined(__riscv)
+#define __NR_kexec_file_load	294
+#endif
 
 #ifndef __NR_kexec_file_load
 /* system call not available for the arch */
-- 
2.48.1


