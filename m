Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE41CAC597
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T9RR3PU/uUdxRqfTyISu/UhNZFgXmGv+DacIXixvqwo=; b=LKR/H47S5JbjbgDfoBTbPkUpDb
	i5re1TdGm8yHK3a91UMGWFJabKulhVTF8JPmZswA32EFBd6XIq1zQ7K62fs96veYQ0WvI4bN0CUrP
	xHS9zdyZQm4hSqumFIYEoNkubFk7Z9movfQXYBWJ24bdZmetqFR/vozKs+w2EQgOism0BBrdaF3E6
	IdN+bXVhyGeuNml8CjNjlpkxB4/77xLk0TXIXTsu1zdIlDB+H8mK/3P4egdlKvGBfmkvYsiYV9/80
	yM49WLLpf+ix/j2lv4L/Mc6WQIeXOgvuvvNQFgBb6VxpSSfrAxfox58vZc3WZ90hTwOpuqKBBr0uI
	IkTudIVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxh-00000006D4C-2HKC;
	Tue, 16 Sep 2025 01:58:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxf-00000006D2B-3QMR
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=T9RR3PU/uUdxRqfTyISu/UhNZFgXmGv+DacIXixvqwo=; b=cHd2Hn34XIFdyHxF872qCI12Wp
	OaSxKLZ/j76kQ2CSyFK+QZS+imQzDr985Ei+VQu9ETYU7JEEq6cJDX4yfrsfN3T+euXI3NB/13Wb6
	jv5mqkQ6yDzNyYYb32QEMLm2Sc5fouwt9gr7o106UwGOAKPeXf1i3msmH+guo8MeQKhczaxqkhlRz
	arAqFEh3tdyl4EF43RUa6V9obBU/PHDOkf+/5KlP7VUEQM7lsdPHSA8X77AREeED1y15zTcS8clmo
	N1/ypVb50Tev49QS/9VKr37v64KiEjlkYmZi1lS/SrREqGRrlDF+iGAry16PvTH0eGTjRYG8t59+Q
	DwNYQ+UA==;
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxa-000000077z3-1kIb
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:58:26 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9RR3PU/uUdxRqfTyISu/UhNZFgXmGv+DacIXixvqwo=;
	b=YzqyEhE2kc/Z4lfs2nmIvnE71W04h6OxVa23HgCab04uK5ajk1RPjLKw0PKIySovQbMl/p
	W4I5Ks9PHa8axSfoigsJzuRp3JwIFVW1EkLCFK52Y960M7nzD8K19w7FAG4r1DOxHjirlb
	jExrPBz6KgGXerlaYxDDcB7pj6jMpBo=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 04/10] LoongArch: Enforce relocatable kernel check for crash dump
Date: Tue, 16 Sep 2025 09:46:49 +0800
Message-Id: <20250916014655.841632-5-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025824_711066_D5B7B5AD 
X-CRM114-Status: GOOD (  17.87  )
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

Without enabling the RELOCATABLE configuration, LoongArch is a non-PIE kernel
and cannot be loaded to run at any appropriate address. So the CRASH_DUMP
feature depends on RELOCATABLE.

$ cat arch/loongarch/Kconfig
config ARCH_SELECTS_CRASH_DUMP
        def_bool y
        depends on CRASH_DUMP
        select RELOCATABLE

The relocatable kernel is determined by checking if there is a la_abs section.
Currently, only the elf format has been checked, while pei/pez is in the FIXME
state.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-elf-loongarch.c | 32 ++++++++++++++++++++++
 kexec/arch/loongarch/kexec-pei-loongarch.c |  3 ++
 2 files changed, 35 insertions(+)

diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
index c87f022..44b63a9 100644
--- a/kexec/arch/loongarch/kexec-elf-loongarch.c
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -13,6 +13,7 @@
 #include <limits.h>
 #include <errno.h>
 #include <elf.h>
+#include <stdbool.h>
 
 #include "kexec.h"
 #include "kexec-elf.h"
@@ -47,6 +48,27 @@ out:
 	return result;
 }
 
+/*
+ * To determine whether it is a relocatable kernel based on the ".la_abs "section,
+ * the CRASH_DUMP feature depends on CONFIG_RELOCATABLE in LoongArch.
+ */
+static bool laabs_section(const struct mem_ehdr *ehdr)
+{
+	struct mem_shdr *shdr, *shdr_end;
+	unsigned char *strtab;
+
+	strtab = (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh_data;
+	shdr_end = &ehdr->e_shdr[ehdr->e_shnum];
+	for (shdr = ehdr->e_shdr; shdr != shdr_end; shdr++) {
+		if (shdr->sh_size &&
+			strcmp((char *)&strtab[shdr->sh_name], ".la_abs") == 0) {
+			return true;
+		}
+	}
+
+	return false;
+}
+
 int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info)
 {
@@ -63,6 +85,16 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 		goto exit;
 	}
 
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		bool is_relocatable_kernel = laabs_section(&ehdr);
+		if (!is_relocatable_kernel) {
+			dbgprintf("%s: The non-relocation kernel cannot be loaded, "
+				   "CONFIG_RELOCATABLE needs to be enabled\n", __func__);
+			result = EFAILED;
+			goto exit;
+		}
+	}
+
 	/* Find and process the loongarch image header. */
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		struct mem_phdr *phdr = &ehdr.e_phdr[i];
diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index f0e0d09..1a19a39 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -99,6 +99,9 @@ int pei_loongarch_load(int argc, char **argv, const char *buf,
 		}
 	}
 
+	/* Fixme: Loading a non-relocation kernel will cause the second kernel to fail
+	   to start in KEXEC_ON_CRASH */
+
 	/* Load the kernel */
 	add_segment(info, buf, len, kernel_segment, loongarch_mem.image_size);
 
-- 
2.34.1


