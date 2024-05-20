Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C34C25B75
	for <kexec@archiver.kernel.org>; Mon, 20 May 2024 01:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Vk800qHPryCMRyh+dHV/IUR3JDdSuNImh21s1o69Mw4=; b=ZWwxiqqE49idXr
	SDMWJJnaQQIJiU511NLvn8XOKetHlxI0vppMSdUDuhWFxkU/XWAmgMbkeQCKTzr431YfIdPr9PSh+
	5+dCjnNVoYZphb5zJMPDLzF5/YK0ptLpdanOxlmBuYBWqIhbtvcnSEHprqAFfsKBH1Z7DzTCrYjmO
	N3whPRp3uxJacWiDNgh8woq/vhilhHN6ZDLmuLQCrdpsld0cw6psZCiVTf3EtmidJQXyKiLteo5Pe
	kLU4UAls2sot7djyAURZgi4p828UUH5RzRK63pRArAW4U236CJMiqjaVLION+w8Uyp/qDooP55ex9
	dwlgWdF18RZyPF/gGvag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8rtX-0000000D8sw-00hv;
	Mon, 20 May 2024 01:32:55 +0000
Received: from mail.loongson.cn ([114.242.206.163])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8rtS-0000000D8sH-1tcY
	for kexec@lists.infradead.org;
	Mon, 20 May 2024 01:32:52 +0000
Received: from loongson.cn (unknown [10.180.128.250])
	by gateway (Coremail) with SMTP id _____8BxXes6qEpmPXUAAA--.1783S3;
	Mon, 20 May 2024 09:32:42 +0800 (CST)
Received: from crazy.crazy.loongson.org (unknown [10.180.128.250])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axjsc5qEpmwDUBAA--.4308S2;
	Mon, 20 May 2024 09:32:41 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	chenhuacai@loongson.cn,
	gaojuxin@loongson.cn
Subject: [PATCH] kexec: loongarch: add multi crash kernel segment support
Date: Mon, 20 May 2024 09:32:41 +0800
Message-Id: <20240520013241.3787014-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8Axjsc5qEpmwDUBAA--.4308S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQADEmZJWxEC+wABsN
X-Coremail-Antispam: 1Uk129KBj93XoW7tr15CF17GFyDuw1kAr1fuFX_yoW8Aryrpr
	yIyF1DGrWrGwnxC3s7Ja95Z395X34xKFy2qa9Fk348uFZxJr13Xw1rZFy7XF45t3yFgryx
	ZrnIyw1v9Fs8ZwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j88n5U
	UUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240519_183250_938566_BE811F80 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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

Production kernel may reserved multiple crash kernel segments, like:
'crashkernel=4G,high crashkernel=256M,low'.
So we should pass multiple mem=<size>@<address> parameters in capture kernel.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 kexec/arch/loongarch/kexec-loongarch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index 32a42d2..f00027c 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -289,6 +289,7 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 	unsigned long initrd_min, hole_max;
 	char *initrd_buf = NULL;
 	unsigned long pagesize = getpagesize();
+	int i;
 
 	if (arch_options.command_line) {
 		if (strlen(arch_options.command_line) >
@@ -326,9 +327,11 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 		cmdline_add_elfcorehdr(cmdline, elfcorehdr_mem.start,
 				elfcorehdr_mem.end - elfcorehdr_mem.start + 1);
 
-		cmdline_add_mem(cmdline, crash_reserved_mem[usablemem_rgns.size - 1].start,
-			crash_reserved_mem[usablemem_rgns.size - 1].end -
-			crash_reserved_mem[usablemem_rgns.size - 1].start + 1);
+		for(i = 0;i < usablemem_rgns.size; i++) {
+			cmdline_add_mem(cmdline, crash_reserved_mem[i].start,
+			crash_reserved_mem[i].end -
+			crash_reserved_mem[i].start + 1);
+		}
 	}
 
 	cmdline[sizeof(cmdline) - 1] = 0;

base-commit: 2a3e54e9f734ce08dee20b4ff1bdd5037f1b0193
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
