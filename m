Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD075C25B79
	for <kexec@archiver.kernel.org>; Mon, 20 May 2024 01:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NIvlQxj3n9DT8rxb/Bw/EoXsXonkXg0Jzt7PNWgrMiM=; b=mnTZOzYo7JlCUp
	2J05pCms2GvAlQAoHZx/QGroHB/M6nR6NVhcic3ni+TNn1pmsV14yFQQDUzTJjMdXRnJ6aydIFpZJ
	T1kJWUPSwThYXobuV/WjRrpV8I492O3za0kjFiuIDURjmYtaG5tn+m7nu7S5YB9feUKYdP0J6Iw4J
	xWK9mfYDFU10PhA5Fuxwz9LPThA9i84P7lTR+eWVhuxDg1ZVv7PsNEmhMoO72JRJFNWarrGKLbfm/
	JGR+DgMUGzQLZHhag0DBad8ErzCMXTRCT8xjzQslCZo2KLpcCY5eIfroqH3y4NVqQLwGTCXCpeM+w
	bw/5cWG+OOP92nyJ48AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8s6R-0000000D9ve-0phg;
	Mon, 20 May 2024 01:46:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8s6O-0000000D9vL-3X3x
	for kexec@bombadil.infradead.org;
	Mon, 20 May 2024 01:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BIBVc3ldENVIQ8m2OEu1/lU4Ofy6GLG0SuYOF4/i5r0=; b=KmVIGa+VxITcAk03NQ6gErR8Oa
	oaLbMENUySLW30ggdAaAijwbMQcmNsO/0CtzS8jwvD4ZjqLE642x9phKBpL7fgpbejLJMhDgJ3XBx
	zQ4WRZCrz2MCMo0bxns0kyLPziDooqtK4o21D0tV6vrYN3Y7rfvOm9zSgZEDKzj5NC5pzGvHQD0yf
	Xch/ZLT2kDPNLlN9FdQ9Fg5Cv0VJ3fI4suvHVaXsCxNDtlZENkhUZrs/+Phd/ZBlStWUc+C0WA8Na
	glwb//lDK0fdzRKid1wpcDEEqipvjScu3hR553hojw8xlXNmgWkVdHbuysrrOl0PoCCGZZx1xuFAm
	kBMmdf/Q==;
Received: from mail.loongson.cn ([114.242.206.163])
	by desiato.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8s6H-00000006MXH-3zac
	for kexec@lists.infradead.org;
	Mon, 20 May 2024 01:46:10 +0000
Received: from loongson.cn (unknown [10.180.128.250])
	by gateway (Coremail) with SMTP id _____8AxDOtUq0pmanYAAA--.437S3;
	Mon, 20 May 2024 09:45:56 +0800 (CST)
Received: from crazy.crazy.loongson.org (unknown [10.180.128.250])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDMdRq0pmPzgBAA--.4338S2;
	Mon, 20 May 2024 09:45:53 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	chenhuacai@loongson.cn,
	gaojuxin@loongson.cn
Subject: [PATCH] kexec: loongarch: fix load command line segment error
Date: Mon, 20 May 2024 09:45:53 +0800
Message-Id: <20240520014553.3787578-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8AxDMdRq0pmPzgBAA--.4338S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQADEmZJWxEC+wACsO
X-Coremail-Antispam: 1Uk129KBj93XoWrKr17WF4UKrykCF1xKr4Utrc_yoW8JF4Upr
	y7AryDJw4rGrnFyrykJa4ruw4kX3s3G3sFqayIyry8JFsrJ3WSqF4fXa4DXF1vkw4YyF4I
	grsxta4jqFWkZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07U_-B_U
	UUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_024608_499763_A818A11A 
X-CRM114-Status: UNSURE (   8.13  )
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

When kernel cmdline reserved multiple crash kernel segments, like:
"crashkernel=4G,high crashkernel=256M,low".
Cmdline segment may be loaded in locations larger than 4G of memory.
So the parameter 'buf_max' of add_buffer function should be
'hole_max'.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 kexec/arch/loongarch/kexec-loongarch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index f00027c..ac75030 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -337,7 +337,7 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 	cmdline[sizeof(cmdline) - 1] = 0;
 	add_buffer(info, cmdline, sizeof(cmdline), sizeof(cmdline),
 		sizeof(void *), _ALIGN_UP(hole_min, getpagesize()),
-		0xffffffff, 1);
+		hole_max, 1);
 
 	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__, cmdline);
 

base-commit: 2a3e54e9f734ce08dee20b4ff1bdd5037f1b0193
prerequisite-patch-id: 773329268ca8ca42f7b6aeafce0e83aceb75888d
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
