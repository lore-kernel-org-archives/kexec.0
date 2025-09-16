Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF282CAC597
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eW9UOLDOXvWZFhdCr4JNsDqRYp0P9CFi1ffg4fJpABo=; b=1s8eLfhNQtIyvknOpsH+GptKUg
	YFBAQctItGgPCDhNIzISwtbhIZB+Ix4+W+C8yIE8twF7tn+CPAg4XkufHfrU3/knB330Vuqpwqppp
	rW06wXcp/+3Ou/ZiFCovC0yon5Q2SQ1oT2KYHJLeFNNLUB9l8qXBnqBxrOfs0C1Rf2CkvkKy2ueCB
	mzysUQHlyFUYJCsPMmz6ClYSqNR5nMxtsHplT84pbsaoq+obIz0hi9LE5HbtgS/5fzzTd5P6EWGTg
	F6GJ4Elv8lY0SZ2gKmmge2U0N9TxoJkwveT4LEXj0xEDX5/BI9HBFcMEV234+N2r8LdlLonwGtZ+u
	qAGuUxhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsv-00000006CYO-4A0m;
	Tue, 16 Sep 2025 01:53:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsu-00000006CY4-3jyC
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eW9UOLDOXvWZFhdCr4JNsDqRYp0P9CFi1ffg4fJpABo=; b=Bp7to2IEcS7POHgz5Vs0QWWx5t
	Wc1tV1wF8V3FNv71To7uKE9elNKFwnFUC1BV/JAMKPnoLaxU+noK+UqutNw+fgKI+iiIb4X+SS0of
	lRZIsON5jHDrqNdwv9biWKVL8KPw9fROd1I9PO7cR8U2PlVdcrWIYWxvEWbQ7dNRSLdI/23DGlexm
	SQ1n2r26S+6seUv6ydeZKU33KMz/fXTdlmCmYyuq1T/DvoqeGHc69AAN1xcnbTJCadwa1kEglSoU5
	XDVOZmSUISguPhfd7mpZHJHkCBwjw7Qzc4YPlfbZc8bu2Q88hOCN0k4cgvIM69CDQ/UhAwqzTlt8G
	TztUZU6w==;
Received: from out-184.mta0.migadu.com ([2001:41d0:1004:224b::b8])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsp-000000077kD-0o4W
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:53:31 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW9UOLDOXvWZFhdCr4JNsDqRYp0P9CFi1ffg4fJpABo=;
	b=WPcu0TBLXfVqgsqQV555qf59/VY1cSSvmK7Chs5+/KIDvkRmDccqnG5qX3htI2AX2husNK
	OG9xmOLyhDozdCbTdbDmh7rkFek259NQkzN6nZWk71B4fGUcWyiq+mbDC8wI3d+WJczDWk
	nXSg64tvJphzN5SOs4rsuSnc/9wQjcU=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 06/10] LoongArch: Fix the use of loongarch_image_header in ELF format
Date: Tue, 16 Sep 2025 09:46:51 +0800
Message-Id: <20250916014655.841632-7-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025328_637696_0B74F2C5 
X-CRM114-Status: GOOD (  14.48  )
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

loongarch_image_header should not be used in the ELF format. When the CONFIG_EFI_STUB
configuration is turned off, the ELF kernel image will not add loongarch_image_heade
processing, as can be seen from the kernel code arch/loongarch/kernel/head.S.

Thus, use the elf header content to fix this issue.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/image-header.h        |  2 +-
 kexec/arch/loongarch/kexec-elf-loongarch.c | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/loongarch/image-header.h b/kexec/arch/loongarch/image-header.h
index 223d81f..0db7615 100644
--- a/kexec/arch/loongarch/image-header.h
+++ b/kexec/arch/loongarch/image-header.h
@@ -1,5 +1,5 @@
 /*
- * LoongArch binary image header.
+ * LoongArch binary image header. (for pei/pez format)
  */
 
 #if !defined(__LOONGARCH_IMAGE_HEADER_H)
diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
index 44b63a9..92fa9f8 100644
--- a/kexec/arch/loongarch/kexec-elf-loongarch.c
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -72,7 +72,6 @@ static bool laabs_section(const struct mem_ehdr *ehdr)
 int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info)
 {
-	const struct loongarch_image_header *header = NULL;
 	unsigned long kernel_segment;
 	struct mem_ehdr ehdr;
 	int result;
@@ -95,22 +94,19 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 		}
 	}
 
-	/* Find and process the loongarch image header. */
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		struct mem_phdr *phdr = &ehdr.e_phdr[i];
 
 		if (phdr->p_type != PT_LOAD)
 			continue;
 
-		header = (const struct loongarch_image_header *)(
-			kernel_buf + phdr->p_offset);
-
-		if (!loongarch_process_image_header(header))
-			break;
+		loongarch_mem.text_offset = virt_to_phys(phdr->p_paddr);
+		loongarch_mem.image_size = _ALIGN_UP(phdr->p_memsz, KiB(64));
+		break;
 	}
 
 	if (i == ehdr.e_phnum) {
-		dbgprintf("%s: Valid loongarch image header not found\n", __func__);
+		dbgprintf("%s: Valid loongarch phdr not found\n", __func__);
 		result = EFAILED;
 		goto exit;
 	}
-- 
2.34.1


