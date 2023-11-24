Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92732C61DF4
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JLmFgWz3mhF+lZV28340eHs3i6xno7FjWfQVQIXcBEc=; b=Q3CDzL7A0zI8ox
	eETqxzPOsK+mIJKjehHPe9CwXMCU29/goJ8ORl38qCB7CQYkYaFYYSH+3AuKA5PjAC+l5Ohj5CsDe
	20ny3VTslCMgnsHcqBSVsgCjhttc4YIdujOwFAnOnFzMiywnMOyDcVSJYd+E55XRJmo9DYiZIMy5j
	sIFgH6bosc6vgfEaRGHI4owgx8qoHhpadSNWOjOVTZEzvJ412QPCY5Z6KbakCrBbGjfTBS9LDXXW2
	HaKMuufAVz83G0E9pkKUW8KCwn9F1gv4i+je4H9+16DoPSyttTH4okxEAaI9L4RrS73EzhxmLag43
	05fcKsbjTSzoSDfIHyJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6YOk-007Zk9-10;
	Fri, 24 Nov 2023 15:47:18 +0000
Received: from mail.loongson.cn ([114.242.206.163])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6YOe-007Zis-0z
	for kexec@lists.infradead.org;
	Fri, 24 Nov 2023 15:47:15 +0000
Received: from loongson.cn (unknown [112.22.232.197])
	by gateway (Coremail) with SMTP id _____8Bxnut5xWBlV5w8AA--.52384S3;
	Fri, 24 Nov 2023 23:47:05 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.232.197])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxvdx2xWBlwKxLAA--.36669S2;
	Fri, 24 Nov 2023 23:47:03 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: kexec@lists.infradead.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Load vmlinux.efi to the link address
Date: Fri, 24 Nov 2023 23:46:58 +0800
Message-ID: <20231124154658.114579-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8Cxvdx2xWBlwKxLAA--.36669S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw43tFWfGryDuw4rGF4xZrc_yoW5AryDpr
	y7ZFy8Gr4fJrn8AFyDtas09wn8J3sa9a12qF1akFyxCa1rWr1xXrW8XasruF4Uta15Wr1Y
	grn7tw1YqF4UtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzpBTUUUUU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_074712_719007_EC8C01AC 
X-CRM114-Status: GOOD (  10.98  )
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

Currently, kexec loads vmlinux.efi to address 0 instead of the link
address. This causes kexec to fail to boot the new vmlinux.efi on qemu.

  pei_loongarch_load: kernel_segment: 0000000000000000
  pei_loongarch_load: kernel_entry:   00000000015dc000
  pei_loongarch_load: image_size:     0000000001f30000
  pei_loongarch_load: text_offset:    0000000000200000
  pei_loongarch_load: phys_offset:    0000000000000000
  pei_loongarch_load: PE format:      yes
  loongarch_load_other_segments:333: command_line: kexec console=ttyS0,115200
  kexec_load: entry = 0x15dc000 flags = 0x1020000
  nr_segments = 2
  segment[0].buf   = 0x7fffef664010
  segment[0].bufsz = 0x1de9a00
  segment[0].mem   = (nil)
  segment[0].memsz = 0x1f30000
  segment[1].buf   = 0x555555e480b0
  segment[1].bufsz = 0x200
  segment[1].mem   = 0x1f30000
  segment[1].memsz = 0x4000

This patch adds `text_offset` when adding kernel segment to load
vmlinux.efi to the link address.

  pei_loongarch_load: kernel_segment: 0000000000000000
  pei_loongarch_load: kernel_entry:   00000000015dc000
  pei_loongarch_load: image_size:     0000000001f30000
  pei_loongarch_load: text_offset:    0000000000200000
  pei_loongarch_load: phys_offset:    0000000000000000
  pei_loongarch_load: PE format:      yes
  loongarch_load_other_segments:335: command_line: kexec console=ttyS0,115200
  kexec_load: entry = 0x15dc000 flags = 0x1020000
  nr_segments = 2
  segment[0].buf   = 0x7ffff1a04010
  segment[0].bufsz = 0x1de9a00
  segment[0].mem   = 0x200000
  segment[0].memsz = 0x1f30000
  segment[1].buf   = 0x555555b28098
  segment[1].bufsz = 0x200
  segment[1].mem   = 0x2130000
  segment[1].memsz = 0x4000

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 kexec/arch/loongarch/kexec-pei-loongarch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index 1a11103..0ee00d9 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -87,7 +87,8 @@ int pei_loongarch_load(int argc, char **argv, const char *buf,
 	/* Get kernel entry point */
 	info->entry = (void *)kernel_entry;
 
-	hole_min = kernel_segment + loongarch_mem.image_size;
+	hole_min = kernel_segment + loongarch_mem.text_offset +
+		loongarch_mem.image_size;
 
 	/* Create and initialize elf core header segment */
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
@@ -100,7 +101,8 @@ int pei_loongarch_load(int argc, char **argv, const char *buf,
 	}
 
 	/* Load the kernel */
-	add_segment(info, buf, len, kernel_segment, loongarch_mem.image_size);
+	add_segment(info, buf, len, kernel_segment + loongarch_mem.text_offset,
+				loongarch_mem.image_size);
 
 	/* Prepare and load dtb and initrd data */
 	result = loongarch_load_other_segments(info, hole_min);
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
