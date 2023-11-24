Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12424C61D97
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 08:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zU0sOdc1g79P77oPXhtzPrzegoS+vLtVZAYXKZL3Ffg=; b=haN0d9ECEQFwz6
	oFPMrAvqY76X+9dO93bDx0ymiFTsK10YmYrsq91aiLud9uWhm8O3diSlJW40rWAa4nugJEr8QAaGl
	u5F+tOiIub7MUkngkk+zsS9KCAjPUiXtpOdQCk8wDUGfc+xUfFmhy8JW32hEX0vVeQ6P3vzwaq764
	425X02jbBaTx55QtXv9TO4rr4PJ52Q0huDNjnUDk+wuGIf+EbLBrhlbbP6iyskC6dMnONH/18wrZ2
	SGngrfnjDKftk9jUenH3w1fZ/Xkeobo/BsjZ7OB+8/clfVR7acupK+5Ta6u264uPHyDtRR+agur6M
	QgvVVcP1QLBMIVeflBTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6RyF-006afD-1z;
	Fri, 24 Nov 2023 08:55:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6RyE-006af0-1Y
	for kexec@bombadil.infradead.org;
	Fri, 24 Nov 2023 08:55:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8Mg8qc77X4hPD75LFXblWAMl8F3z3vGJaU+ArgCN1K0=; b=aHO3Hh1KOmxfPWEB123s6pIO12
	ZKN2q8S5ITOGU22pg9vb1/syx788+EYaNnVOts0YKi4BIEPb3ddY+jnWXC1GyWn3t4PM0f7gBQtQL
	ZiZNtkaGgjc8FzUUqr8bwWvnvst8Yat6GhGAIzxN/nwSer07y0akHW2cON4vr4ZeCjPjh+2QE63CP
	9+xvafqdWm8Mq7PAFkKWMllncFRGFJbmeKJJt91mWqRyd5VgJ9PKhQjZsuFtgC5oo6mpsW1uO4X2c
	UIpvyf/J8h1byjMNjB/804G7aZitNQg+Bq8TEVRsshifaiR3/OxCzyx1KLoNzQB/5rgDqfWqhScm9
	q2g8C4/A==;
Received: from mail.loongson.cn ([114.242.206.163])
	by desiato.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Rxk-00DolV-0m
	for kexec@lists.infradead.org;
	Fri, 24 Nov 2023 08:55:23 +0000
Received: from loongson.cn (unknown [112.22.232.197])
	by gateway (Coremail) with SMTP id _____8BxpPDXZGBlnIc8AA--.54639S3;
	Fri, 24 Nov 2023 16:54:47 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.232.197])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxH93TZGBl4n1LAA--.38097S2;
	Fri, 24 Nov 2023 16:54:46 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: kexec@lists.infradead.org
Cc: Varad Gautam <vrd@amazon.de>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Fix an issue with relocatable vmlinux
Date: Fri, 24 Nov 2023 16:54:10 +0800
Message-ID: <20231124085410.107080-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8AxH93TZGBl4n1LAA--.38097S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar4UKr4rJrWUAFWUWF17urX_yoW8JFyUpF
	srCr45Gw1UJw12kFWjgayDGwn8tws8GryUWFWxG39Ykw1DXry2gwn0g3W3ZFW3WrZ5Ka1I
	qryUZrZ8Ca1UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_085506_188281_20BE9B95 
X-CRM114-Status: UNSURE (   9.58  )
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

Normally vmlinux for LoongArch is of ET_EXEC type, while if built with
CONFIG_RELOCATABLE (this is PIE) and Clang, it will be of ET_DYN type.
Meanwhile, physical address field of segments in vmlinux has actually
the same value as virtual address field.

Similar to arm64, this patch allows to unconditionally skip the check
on LoongArch.

Link: https://github.com/ClangBuiltLinux/linux/issues/1963
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 kexec/kexec-elf-exec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec-elf-exec.c b/kexec/kexec-elf-exec.c
index bea7b3e..b337642 100644
--- a/kexec/kexec-elf-exec.c
+++ b/kexec/kexec-elf-exec.c
@@ -39,12 +39,13 @@ static int get_elf_exec_load_base(struct mem_ehdr *ehdr, struct kexec_info *info
 	unsigned long first, last;
 	size_t i;
 
-	/* Note on arm64:
+	/* Note on arm64 and loongarch64:
 	 * arm64's vmlinux has virtual address in physical address
 	 * field of PT_LOAD segments. So the following validity check
 	 * and relocation makes no sense on arm64.
+	 * This is also applies to LoongArch.
 	 */
-	if (ehdr->e_machine == EM_AARCH64)
+	if (ehdr->e_machine == EM_AARCH64 || ehdr->e_machine == EM_LOONGARCH)
 		return 0;
 
 	first = ULONG_MAX;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
