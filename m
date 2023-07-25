Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5E7C04A6A
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5quVd2HZcabVyJJO1rWV6MLJy11gp/iSwLFOWLW847g=; b=tA8lhmOjNwjEAd
	MXIEXt+Q6kj9pl4N1QrtOoYkXr+B97aahX5KS7IxPjoYhPJgOdRBc54BpN0ITVFA342lXzNcSEHl0
	KusxBza2w2EoTHLeAjLifzjVWaDfyqLXeDP716cYUZCRE/dL2gcs7XWzyn+xJd3BzLc+xuuQpQ6oJ
	pPJnuKHi+6I51eqLenjFaWTT6oGoVQ6bXdWsng6L7X/euCETl7wvlvpW7pKiDOVJc+V4j9MszwRz+
	Kjt7JWFScxJ6GFcDnFrRkeoF+hZHt7SJn2+ZInAzd2zRlJ+rhxblKExmJSnYCizwuK/fMqpKg+i8E
	EbswsMlKeEaGXnd1KStg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOEre-0071vY-11;
	Tue, 25 Jul 2023 10:01:58 +0000
Received: from [14.137.139.154] (helo=frasgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOErb-0071ti-2A
	for kexec@lists.infradead.org;
	Tue, 25 Jul 2023 10:01:57 +0000
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9C063Pqrz9xxnV
	for <kexec@lists.infradead.org>; Tue, 25 Jul 2023 17:48:38 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.128.235])
	by APP1 (Coremail) with SMTP id LxC2BwB3AAx3nb9kBvUHBQ--.31143S5;
	Tue, 25 Jul 2023 11:01:46 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: kexec@lists.infradead.org
Subject: [PATCH v1 3/3] riscv/purgatory: do not link with string.o
Date: Tue, 25 Jul 2023 12:01:10 +0200
Message-Id: <a083f38c7c3acd6ac9542228e36947be30b58188.1690274483.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
References: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwB3AAx3nb9kBvUHBQ--.31143S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfuw15GrWfGF4xXw18Krg_yoW8tw1Dpa
	yxKayDK3s8Aw1kKrZ7XF1Uuw17Z3yUKrWFqF42grW5AFy5JF9IvryfXrWDAFWUJr1Ik3s8
	AryIgFyUt3WFkwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07joMKZUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_030155_991797_32A44E83 
X-CRM114-Status: UNSURE (   8.56  )
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

Linking with this object file it makes kexec_file_load(2) fail with:

 kexec_image: Unknown rela relocation: 20
 kexec_image: Error loading purgatory ret=-8

This is R_RISCV_GOT_HI20, generated by the linker to handle references to
the global variable _ctype from strcasecmp() and strncasecmp().

Rather than implementing GOT for the purgatory, remove the object file,
because it is not needed by the purgatory code.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: Li Zhengyu <lizhengyu3@huawei.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/purgatory/Makefile | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index dc20e166983e..497bb72b6ba8 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,15 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
 
-purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
+purgatory-y := purgatory.o sha256.o entry.o ctype.o memcpy.o memset.o
 purgatory-y += strcmp.o strlen.o strncmp.o
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
-$(obj)/string.o: $(srctree)/lib/string.c FORCE
-	$(call if_changed_rule,cc_o_c)
-
 $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
@@ -32,7 +29,6 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
-CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
 # When profile-guided optimization is enabled, llvm emits two different
@@ -83,9 +79,6 @@ CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 CFLAGS_REMOVE_sha256.o		+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
 
-CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
-CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
-
 CFLAGS_REMOVE_ctype.o		+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_ctype.o			+= $(PURGATORY_CFLAGS)
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
