Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9AFC001DE
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LaoDDYpR2Gh5WAc9Z2Czkmft43mzaZFNJSWbPyBWWS4=; b=44KdoT4tJgIIO0
	j1ZzxSyeEPGXHQ5zObeVlJ132SK/+bozLb+mqi0etgKzCtNBE/RejmeBLMkYdlpq2JbVKXoZjBxg1
	GIBgRAylGD7nQYeZJ7bQx9NuR0fH87CBdbBDSAHW7LWBssmm+C8fuAq1nVHyysJtaCCOw9At+I+pp
	pQDwLj+p5WP2puZnOWHsUMUV7/SEeEHtdNAV4b3HL73HH7mxNyjxNxBcDowFTvyLx7rBCHzfUWKL7
	XqwRQYrNi/YJiD3rUEDYic3yBx8AtdQ57j7dmmAdFjPlWsJAwzILPxSDCDRiSquPHQv/IqNktaAmZ
	+NhJ2FmP3fCjx9sb9gUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOErZ-0071tG-1T;
	Tue, 25 Jul 2023 10:01:53 +0000
Received: from [14.137.139.154] (helo=frasgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOErW-0071rb-1w
	for kexec@lists.infradead.org;
	Tue, 25 Jul 2023 10:01:52 +0000
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9Bzw6kdPz9xxnW
	for <kexec@lists.infradead.org>; Tue, 25 Jul 2023 17:48:28 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.128.235])
	by APP1 (Coremail) with SMTP id LxC2BwB3AAx3nb9kBvUHBQ--.31143S2;
	Tue, 25 Jul 2023 11:01:35 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: kexec@lists.infradead.org
Subject: [PATCH v1 0/3] RISC-V: Fix a few kexec_file_load(2) failures
Date: Tue, 25 Jul 2023 12:01:07 +0200
Message-Id: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwB3AAx3nb9kBvUHBQ--.31143S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1fGr48Cw17uFW3XFWrKrg_yoW3AFbEgF
	W8trZYqr1UtFn8XFZrKw4FqFW0krs5tFyjgwn8trW7t34UWry5Z3ZY9Fn2vr1UZrZ3W3sx
	ZrZ8Zr95Jr17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8G2NtUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_030150_784882_C08022C1 
X-CRM114-Status: UNSURE (   6.46  )
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

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The kexec_file_load(2) syscall does not work at least in some kernel
builds. For details see the relevant section in this blog post:

https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html

This patch series handles additional relocation types and removes the need
to implement a Global Offset Table (GOT) for the purgatory.

Petr Tesarik (2):
  riscv/kexec: handle R_RISCV_ADD16 and R_RISCV_SUB16 relocation types
  riscv/purgatory: do not link with string.o

Torsten Duwe (1):
  riscv/kexec: handle R_RISCV_CALL_PLT relocation type

 arch/riscv/kernel/elf_kexec.c | 7 +++++++
 arch/riscv/purgatory/Makefile | 9 +--------
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
