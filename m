Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6361CC25B75
	for <kexec@archiver.kernel.org>; Mon, 20 May 2024 01:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GR4Tj+IV4RUB7PSHIi50rnI522CRnldjqeotpDUYVPQ=; b=z4iyKiiaS8lkVH
	tXvhLe9SEkYXm8zntWWvJSMFnvEdqTjT5joN7RKHUVdFIkDSKMx62dD8nf9zDO2o00g964HryYbiL
	bSYutEyfExu6VCng6ukhMuJwCG3lYDrf4q5EokSD0vs7c4mOdiBYyfamjKs1189UJFssE1K2PPEnS
	GnghOBwdvaX0dmmuPk99r5kq7pqh0oKOoYfYeWZchkOvgt2w12sZw451VBJdxNNIiNKPgqDIDHdKL
	FAONo5G2IzsJfZASOZIyvNFLPhNvU5MWB4GaHSn5Zy5s0GXa2sfAOC0pqpo3GpkTOc1hWI43QhFCd
	OdpQoEKaFaGWBlXQsSDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8rhf-0000000D7er-0IsI;
	Mon, 20 May 2024 01:20:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8rhc-0000000D7ee-1mPs
	for kexec@bombadil.infradead.org;
	Mon, 20 May 2024 01:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Z1jgas71lHhATo5JR3KYxPGA7j9X5GNG9gDR7NH5Nf4=; b=KlucSqD5ynQf08CEd8Z9sBWL3S
	61/5sH63VqBBhmtut8d7bEWZsgWGl7qdQBG1Y1xt23rKwkoD+MY7LbMxnOc/YOCyu942qjplSpkm2
	m2qgENGrrMp7wAYT6rA/DOFMMf5Vpo8wpsV9TwQM7FehPcKmBvu4WeGDD94X9yeg+Wk8mMSs+HktH
	8sm56VUT41OaHbXqB786e/GixpWF7LKuZ49wg1/nkPHhFhh+2zvO4xh/KV4RKpgbQwUNbb/p7E0iU
	bKUqHeamntoqy/tpM3f4u1Yn0sOc9sUzF4tfUhopQbfE6TGkO4FK66/2WKpgj5sUE++b+v7vLXD/k
	ERBMsw6A==;
Received: from mail.loongson.cn ([114.242.206.163])
	by casper.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8rhW-0000000FWlY-26Rc
	for kexec@lists.infradead.org;
	Mon, 20 May 2024 01:20:34 +0000
Received: from loongson.cn (unknown [10.180.133.93])
	by gateway (Coremail) with SMTP id _____8Axz+tTpUpmdHIAAA--.2709S3;
	Mon, 20 May 2024 09:20:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.133.93])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqsZSpUpmJzMBAA--.4236S2;
	Mon, 20 May 2024 09:20:19 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	chenhuacai@loongson.cn,
	Hongchen Zhang <zhanghongchen@loongson.cn>,
	Ming Wang <wangming01@loongson.cn>
Subject: [PATCH] LoongArch: fix kernel image size error
Date: Mon, 20 May 2024 09:20:16 +0800
Message-Id: <20240520012016.6898-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8CxqsZSpUpmJzMBAA--.4236S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQABB2ZHSWwB-AASss
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4ktr1xWF45JrW5Cr4DGFX_yoW5GFW3pw
	17CF1Fqr4rJwnxAr47tas09ws5J3s7W3WaqFsFkryfCrsFgryUX3yrZasrZF4Utw40grn0
	grn5X34F9a1kJabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_022031_255196_F01081F2 
X-CRM114-Status: GOOD (  10.23  )
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

Use kernel_size instead of kernel image size is wrong, we should get
the kernel image size from loongarch image header.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 kexec/arch/loongarch/kexec-elf-loongarch.c | 28 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
index 45387ca77cc2..c87f02282980 100644
--- a/kexec/arch/loongarch/kexec-elf-loongarch.c
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -54,6 +54,7 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 	unsigned long kernel_segment;
 	struct mem_ehdr ehdr;
 	int result;
+	int i;
 
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
 
@@ -62,6 +63,26 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 		goto exit;
 	}
 
+	/* Find and process the loongarch image header. */
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		struct mem_phdr *phdr = &ehdr.e_phdr[i];
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		header = (const struct loongarch_image_header *)(
+			kernel_buf + phdr->p_offset);
+
+		if (!loongarch_process_image_header(header))
+			break;
+	}
+
+	if (i == ehdr.e_phnum) {
+		dbgprintf("%s: Valid loongarch image header not found\n", __func__);
+		result = EFAILED;
+		goto exit;
+	}
+
 	kernel_segment = loongarch_locate_kernel_segment(info);
 
 	if (kernel_segment == ULONG_MAX) {
@@ -72,13 +93,12 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 
 	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
 	dbgprintf("%s: image_size:     %016lx\n", __func__,
-		kernel_size);
+		 loongarch_mem.image_size);
 	dbgprintf("%s: text_offset:    %016lx\n", __func__,
 		loongarch_mem.text_offset);
 	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
 		loongarch_mem.phys_offset);
-	dbgprintf("%s: PE format:      %s\n", __func__,
-		(loongarch_header_check_pe_sig(header) ? "yes" : "no"));
+	dbgprintf("%s: PE format:      no\n", __func__);
 
 	/* create and initialize elf core header segment */
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
@@ -108,7 +128,7 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 	}
 
 	/* load additional data */
-	result = loongarch_load_other_segments(info, kernel_segment + kernel_size);
+	result = loongarch_load_other_segments(info, kernel_segment + loongarch_mem.image_size);
 
 exit:
 	free_elf_info(&ehdr);
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
