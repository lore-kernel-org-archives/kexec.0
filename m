Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B560C61D9D
	for <kexec@archiver.kernel.org>; Sat, 25 Nov 2023 06:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+c55ph8vPPZFcPNjP0dmuZyUp3yLpzorxQYFBw38VR8=; b=yeSunVmyIXYNs3
	lnQtMaX+4VMh24h/Go6UUMXAEZ5HydruJLNi+gIpwA38WT3mQ0dNs0Oh9EtCLdcWWDGAJfEbrJE2X
	4OX7oM4EF+y2tUumaMmYSPRDiRSOgqqFTcYUdTasb4Wa9vpNlQK9OL0bE210walYxFJvuSmpT2Lou
	bkbti/Vmw80AT/YmTSY8OAhOcd3allm6goVoe2yu7N5Q832nJ7GMFynlk7OIEBAYQjaObMzA6wnOx
	rZYrjSdhvnFks180F92ASMN4Z6FeSAvKzSYWYOIWLPw/nNSBsnfsvEXLdF3CIS1d4/vafa/nggxZR
	h2yCZQFVhJUjB5ZgUJzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6mXL-008iWW-2N;
	Sat, 25 Nov 2023 06:53:07 +0000
Received: from mail.loongson.cn ([114.242.206.163])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6mXH-008iW1-2g
	for kexec@lists.infradead.org;
	Sat, 25 Nov 2023 06:53:06 +0000
Received: from loongson.cn (unknown [112.22.232.197])
	by gateway (Coremail) with SMTP id _____8BxnuvEmWFloL08AA--.52673S3;
	Sat, 25 Nov 2023 14:52:52 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.232.197])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxL921mWFlUARMAA--.39693S2;
	Sat, 25 Nov 2023 14:52:50 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: kexec@lists.infradead.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	hev <r@hev.cc>,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH v2] LoongArch: Load vmlinux.efi to the link address
Date: Sat, 25 Nov 2023 14:52:32 +0800
Message-ID: <20231125065232.116319-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8BxL921mWFlUARMAA--.39693S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw15WF4ruF1xXF17Zw43Jwc_yoW5Wr1fpr
	y7ZF15Gr4rJrn8tr97t3s09wn8J3s3uF42qF1SkF9akan8Wr1xXa18ta9ruFWUtw4rGr1j
	gr97ta4YqF4UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_225304_284679_AD205E02 
X-CRM114-Status: GOOD (  12.24  )
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
  pei_loongarch_load: kernel_entry:   00000000013f1000
  pei_loongarch_load: image_size:     0000000001ca0000
  pei_loongarch_load: text_offset:    0000000000200000
  pei_loongarch_load: phys_offset:    0000000000000000
  pei_loongarch_load: PE format:      yes
  loongarch_load_other_segments:333: command_line: kexec console=ttyS0,115200
  kexec_load: entry = 0x13f1000 flags = 0x1020000
  nr_segments = 2
  segment[0].buf   = 0x7fffeea38010
  segment[0].bufsz = 0x1b55200
  segment[0].mem   = (nil)
  segment[0].memsz = 0x1ca0000
  segment[1].buf   = 0x5555570940b0
  segment[1].bufsz = 0x200
  segment[1].mem   = 0x1ca0000
  segment[1].memsz = 0x4000

This patch constrains the range of the kernel segment by `hole_min`
and `hole_max` to place vmlinux.efi exactly at the link address.

  pei_loongarch_load: kernel_segment: 0000000000200000
  pei_loongarch_load: kernel_entry:   00000000013f1000
  pei_loongarch_load: image_size:     0000000001ca0000
  pei_loongarch_load: text_offset:    0000000000200000
  pei_loongarch_load: phys_offset:    0000000000000000
  pei_loongarch_load: PE format:      yes
  loongarch_load_other_segments:339: command_line: kexec console=ttyS0,115200
  kexec_load: entry = 0x13f1000 flags = 0x1020000
  nr_segments = 2
  segment[0].buf   = 0x7ffff2028010
  segment[0].bufsz = 0x1b55200
  segment[0].mem   = 0x200000
  segment[0].memsz = 0x1ca0000
  segment[1].buf   = 0x555557498098
  segment[1].bufsz = 0x200
  segment[1].mem   = 0x1ea0000
  segment[1].memsz = 0x4000

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---

v1->v2:
 * Fix the issue preventing it from working on the physical machine.

 kexec/arch/loongarch/kexec-loongarch.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index 62ff8fd..32a42d2 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -265,9 +265,13 @@ unsigned long loongarch_locate_kernel_segment(struct kexec_info *info)
 			hole = ULONG_MAX;
 		}
 	} else {
-		hole = locate_hole(info,
-			loongarch_mem.text_offset + loongarch_mem.image_size,
-			MiB(1), 0, ULONG_MAX, 1);
+		unsigned long hole_min;
+		unsigned long hole_max;
+
+		hole_min = loongarch_mem.text_offset;
+		hole_max = hole_min + loongarch_mem.image_size;
+		hole = locate_hole(info, loongarch_mem.image_size,
+			MiB(1), hole_min, hole_max, 1);
 
 		if (hole == ULONG_MAX)
 			dbgprintf("%s: locate_hole failed\n", __func__);
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
