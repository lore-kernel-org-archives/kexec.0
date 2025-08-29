Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65901CA1003
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LESComP+0ddN9KewuaGzD+hQdWOJ+SC6dB5KRGHwsnE=; b=VxLv2JriVwwrqyCajF1DJ6sRzP
	KsA7YcY8aQD63dVvVnxFo11EG1+jKAMujYm1/x3D6lG7WTGu1kZ5MsH8SUxaq7Is41L9rQavEq8Ub
	ATvqcr47k6qSZLV9N4dNbGqnMvSXFRZk/dmeKgu+OnqXgV4xTCVmLFOjyRYTcYUbl1hg+NoG0mpoM
	P1gccFQ1tqDuijb0ToJ43nwv/+aF6XuhH4CdQsc77sQjJCRZnVrNwIbEkOo186ruSIpFhcR8EzFf2
	NVnSfOdQe1weDCBxMEcGgGnrg/wMMsO0KihseNu9Qo4Q1q1sF8YdLRmPNC65BFRkQ4vqNtsmiyUc6
	Y3HdYyTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDF-00000005Iis-1jX6;
	Fri, 29 Aug 2025 10:20:05 +0000
Received: from out-174.mta1.migadu.com ([95.215.58.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urv9S-0000000562A-3S89
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:12:08 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LESComP+0ddN9KewuaGzD+hQdWOJ+SC6dB5KRGHwsnE=;
	b=NLwuGT6acvuWZGtgD5oLLX/hprgiVk/PP4OJ0NdkoRq2kkE/jof9aeEpt25EQTbl4ycJsG
	cajI5kdKEYV2LeXx9Xa7d0DjwWF8oxlUpvc4W5OowwqJb1Q4rn1EK+u/Si/bSRAE+26es4
	iRyXdpvinWBCCy293g3X/nPonLUe1o0=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinios.cn>
Subject: [PATCH 4/7] LoongArch: Enforce relocatable kernel check for crash dump
Date: Fri, 29 Aug 2025 17:10:37 +0800
Message-Id: <20250829091040.35827-5-youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
References: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021207_011037_C937CE38 
X-CRM114-Status: GOOD (  17.59  )
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

From: Youling Tang <tangyouling@kylinios.cn>

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

Signed-off-by: Youling Tang <tangyouling@kylinios.cn>
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


