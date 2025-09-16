Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0141CAC59B
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhJ5qOHL1B3gSrLW3rOFDUlO+oSmBwEEW/Pw0yzDy4w=; b=vkk4MMCIfBIqP+ZV6Pib6h1uGG
	SvN00FAVdSJxXLDV7otGY3GEprQkPPAj6II2EJ6m4DflEqXjfBXYmTSdWvHkFswMAf3aw24n8XsfK
	WV7hRH8bZb/ZdGVBmOF0w52WWK4xafxeHMzNERK8d10Pwm8WK/DjL1uvK0eTPUQM75/ocJbIj9bNb
	iQ4oQyI0kTXKNP7MeU6FSxiAYzdz3CIWxdqN1H/SIvEDxqNcokU62LrJWJYd4k4GVJ7EqYPGFgY9t
	kCAB0ZdnLlbvnGEK3S15FdunhfkqWYIjVK2/nXLzOCfdHSIB8AvuiamFJJ9geJqAR1RKZPAwPBbO2
	QmQfTkpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKt1-00000006Caw-0LI4;
	Tue, 16 Sep 2025 01:53:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsy-00000006CZ1-0pBg
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rhJ5qOHL1B3gSrLW3rOFDUlO+oSmBwEEW/Pw0yzDy4w=; b=n1gxsLLV9h6NMZXV44O7rQWvjp
	B/T5TOVcKHohioAAUhC8SmQV0q+plZptDQDNGwtF1kz/b5FKq5YOG3UhypzZNg1PzksdnhnlLwxBS
	BqMJt9DqLb/eBxwRumsempvRQ8+NeoP91ZI6hwpDAflf7mkbePkXohKm27ukWPMnb50AL8fQm9hHr
	tY0MZ5tRuj/bC6p37Zj7SPW0ZNhomFEBhBNO07TpL0UgOhJwx+GSWXaB5ubU66NHrZO20AaH9YZtT
	quOWWt/6xdj5u7VQhGiz9RZ8hWr5w+0je62SmWNyzis7ET2TcCcylKAc1Dljgo/mo0rf0yUvMxFkg
	GNk23kJQ==;
Received: from out-172.mta0.migadu.com ([2001:41d0:1004:224b::ac])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsu-000000077kk-1E5b
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:53:34 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhJ5qOHL1B3gSrLW3rOFDUlO+oSmBwEEW/Pw0yzDy4w=;
	b=X43uQrDnA41KMaZGSC5GIY5EcAynf25NKK0sfsnKvirKfQeLpp64/uYz6f8Pl+2G/7byJU
	JAhCVH4lxT9W8kUaPdtuekEcmd7Z6+NRtr/BvjwjZR7KyIEAx7uZE7qE9fV0lJym51Hz++
	9krRTpbDU/o8p6txg6PMeOYWdvkAos0=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 09/10] LoongArch: Add kexec_file_load syscall
Date: Tue, 16 Sep 2025 09:46:54 +0800
Message-Id: <20250916014655.841632-10-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025333_128141_F6BFEA5C 
X-CRM114-Status: GOOD (  14.35  )
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

Create prepare_kexec_file_options() function to prepare the options
to kexec_file_load syscall, and it would be used in pei_loongarch_load().

Currently, pez(vmlinuz.efi), pei(vmlinux.efi) and elf(vmlinux) format
images are supported.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-elf-loongarch.c |  3 ++
 kexec/arch/loongarch/kexec-loongarch.c     | 39 ++++++++++++++++++++++
 kexec/arch/loongarch/kexec-loongarch.h     |  1 +
 kexec/arch/loongarch/kexec-pei-loongarch.c |  3 ++
 kexec/kexec-syscall.h                      |  5 ++-
 5 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
index 92fa9f8..1cc6212 100644
--- a/kexec/arch/loongarch/kexec-elf-loongarch.c
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -77,6 +77,9 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 	int result;
 	int i;
 
+	if (info->file_mode)
+		return prepare_kexec_file_options(info);
+
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
 
 	if (result < 0) {
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index 32cd484..eb60ef0 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -10,12 +10,14 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <getopt.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/types.h>
 #include <sys/stat.h>
 #include <linux/elf-em.h>
 #include <elf.h>
@@ -29,6 +31,10 @@
 #include "mem_regions.h"
 #include "arch/options.h"
 
+#ifndef _O_BINARY
+#define _O_BINARY 0
+#endif
+
 #define CMDLINE_PREFIX "kexec "
 static char cmdline[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
 
@@ -201,6 +207,39 @@ struct arch_options_t arch_options = {
 	.core_header_type = CORE_TYPE_ELF64,
 };
 
+int prepare_kexec_file_options(struct kexec_info *info)
+{
+	int fd;
+	ssize_t result;
+	struct stat stats;
+
+	if (arch_options.command_line) {
+		info->command_line = (char *)arch_options.command_line;
+		info->command_line_len = strlen(info->command_line) + 1;
+	}
+
+	if (!arch_options.initrd_file) {
+		info->initrd_fd = -1;
+		return 0;
+	}
+
+	fd = open(arch_options.initrd_file, O_RDONLY | _O_BINARY);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open `%s': %s\n", arch_options.initrd_file,
+				strerror(errno));
+		return -EINVAL;
+	}
+	result = fstat(fd, &stats);
+	if (result < 0) {
+		close(fd);
+		fprintf(stderr, "Cannot stat: %s: %s\n", arch_options.initrd_file,
+				strerror(errno));
+		return -EINVAL;
+	}
+	info->initrd_fd = fd;
+	return 0;
+}
+
 int arch_process_options(int argc, char **argv)
 {
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
index 2c7624f..2bffa47 100644
--- a/kexec/arch/loongarch/kexec-loongarch.h
+++ b/kexec/arch/loongarch/kexec-loongarch.h
@@ -37,6 +37,7 @@ int loongarch_process_image_header(const struct loongarch_image_header *h);
 unsigned long loongarch_locate_kernel_segment(struct kexec_info *info);
 int loongarch_load_other_segments(struct kexec_info *info,
 	unsigned long hole_min);
+int prepare_kexec_file_options(struct kexec_info *info);
 
 struct arch_options_t {
 	char *command_line;
diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index e0a82b6..10f79c1 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -70,6 +70,9 @@ int pei_loongarch_load(int argc, char **argv, const char *buf,
 
 	header = (const struct loongarch_image_header *)(buf);
 
+	if (info->file_mode)
+		return prepare_kexec_file_options(info);
+
 	if (loongarch_process_image_header(header))
 		return EFAILED;
 
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 9b17578..e9bb7de 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -59,7 +59,7 @@
 #endif
 #endif /*ifndef __NR_kexec_load*/
 
-#if defined(__arm__) || defined(__loongarch__)
+#if defined(__arm__)
 #undef __NR_kexec_file_load
 #endif
 
@@ -83,6 +83,9 @@
 #if defined(__riscv__) || defined(__riscv)
 #define __NR_kexec_file_load	294
 #endif
+#ifdef __loongarch__
+#define __NR_kexec_file_load	294
+#endif
 
 #ifndef __NR_kexec_file_load
 /* system call not available for the arch */
-- 
2.34.1


