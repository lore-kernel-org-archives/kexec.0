Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B31FCA1000
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZP0FPe5+WdlsqF2h+UwCb5iawUsQjs4vKfAqeaXm64=; b=cNJ5rlU8E6QO7oFHza2K8iyQXf
	ZC5OiEbNUe3mARqvRaopUTav9XjFlFBa4AecNy7Db5JBqFuMGgsPe2gnuKFXwizcmt9zkSQV9vVDu
	sPovpm/sWpqsJ6RzXYdp0LUoj8AsueqOx+wwmNvijNWths6G0bheH10itBXLQwmVHN+gXfugRlcV0
	efnkaHH6whW2SmF1tTTxzSSiskJaCIE8atxNo8U/0DB7Vma0haXHt2pj5P+2134DJkUQeZy8BclrK
	v8lvZSLbl2HLmevX8e732yCUbW9nKs2V2GhZ+sA0WBZJffkdzYudszJVooxR1YQhL1hzoLho4+itP
	weL24uTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDD-00000005Igu-1ozT;
	Fri, 29 Aug 2025 10:20:03 +0000
Received: from out-179.mta1.migadu.com ([95.215.58.179])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urv9K-0000000562W-1F9E
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:11:59 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZP0FPe5+WdlsqF2h+UwCb5iawUsQjs4vKfAqeaXm64=;
	b=nQ81IfQbCx1FsZNXEyzb9aIY+JcJ8a295c7MMdl2QbNfnaSjgczioUx6lJOGJpHnXB7hob
	LwJTQjiuzO+mWCbjJfEppEAl8e2/TVJhE3P8EQOszPevFZkCxLG0HRWgoZ7e4VQ9vspeBj
	X42+zACDhJD92RfBc27qdf0rAB03XQE=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinios.cn>
Subject: [PATCH 6/7] LoongArch: Fix the use of loongarch_image_header in ELF format
Date: Fri, 29 Aug 2025 17:10:39 +0800
Message-Id: <20250829091040.35827-7-youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
References: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021158_477214_29652118 
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

From: Youling Tang <tangyouling@kylinios.cn>

loongarch_image_header should not be used in the ELF format. When the CONFIG_EFI_STUB
configuration is turned off, the ELF kernel image will not add loongarch_image_heade
processing, as can be seen from the kernel code arch/loongarch/kernel/head.S.

Thus, use the elf header content to fix this issue.

Signed-off-by: Youling Tang <tangyouling@kylinios.cn>
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


