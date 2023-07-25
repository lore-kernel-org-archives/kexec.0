Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB0CC001E0
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=anK1sAxmHmkWo7b08GU48K0r1t70o6F79Z/SMRhEhnw=; b=CeTI+kIIBz1GZt
	Vcp779nyxvqbdo5+QhOsJfMFQRsceJ9QFBO+R4SyAII7HnMTk5ZDnlPWOGrwyTzZqY4bDnYCpJY4u
	xn2Stt9WU6crv6OWZdUeulnY7256q14/BNx7aIakPYeprJIdEs1cYzqbQcKO0Pq9nP8Xt+0vVocSw
	WDUEZcHhF8LPDLSYoXQSGWblmtn0L7i7ZESv1Le+ljmF710Op8Jkk/IVnV5ALLCWkWYH79Uu8oM9j
	CcZBEoTm+ONAhcXXLHPc/AIEx1wrOIq2o/t4uMia0YC/NflZobOmLHXrbynbJ5Fc5qeMB+WQ3l5YZ
	j1uoSuhYJ7YV8fDzHhMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOErb-0071uK-2y;
	Tue, 25 Jul 2023 10:01:55 +0000
Received: from [14.137.139.23] (helo=frasgout11.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOErY-0071sT-2M
	for kexec@lists.infradead.org;
	Tue, 25 Jul 2023 10:01:54 +0000
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9C2F4SX4z9xrsD
	for <kexec@lists.infradead.org>; Tue, 25 Jul 2023 17:50:29 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.128.235])
	by APP1 (Coremail) with SMTP id LxC2BwB3AAx3nb9kBvUHBQ--.31143S4;
	Tue, 25 Jul 2023 11:01:43 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: kexec@lists.infradead.org
Subject: [PATCH v1 2/3] riscv/kexec: handle R_RISCV_ADD16 and R_RISCV_SUB16 relocation types
Date: Tue, 25 Jul 2023 12:01:09 +0200
Message-Id: <f75c763d86529a47eb23d46c5ef9bcbaaf118200.1690274483.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
References: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwB3AAx3nb9kBvUHBQ--.31143S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7AF1rGw1DKr1rWr18Grg_yoW8GrW8pw
	4xGr48GFWDGr1Ik34xZaykC34rG3WDu3y3ta9Fy3W5Arn8JFy7CrZ2g3WUXF1jqr1FgFWS
	vFyIgr1rt3W8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5yCJUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_030152_906213_B6B17699 
X-CRM114-Status: UNSURE (   8.21  )
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

16-bit add and subtract relocation types are used by the purgatory code
when the kernel is built with CONFIG_RISCV_ALTERNATIVES. If they are not
handled, kexec_file_load(2) fails with:

 Unknown rela relocation: 34
 kexec_image: Error loading purgatory ret=-8

or later with:

 Unknown rela relocation: 38
 kexec_image: Error loading purgatory ret=-8

Note that alternatives are not yet handled in purgatory code; this patch
merely allows to load it.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: Li Zhengyu <lizhengyu3@huawei.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/kernel/elf_kexec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 38390d3bdcac..f23fd419c402 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -444,6 +444,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		case R_RISCV_SUB32:
 			*(u32 *)loc -= val;
 			break;
+		case R_RISCV_ADD16:
+			*(u16 *)loc += val;
+			break;
+		case R_RISCV_SUB16:
+			*(u16 *)loc -= val;
+			break;
 		/* It has been applied by R_RISCV_PCREL_HI20 sym */
 		case R_RISCV_PCREL_LO12_I:
 		case R_RISCV_ALIGN:
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
