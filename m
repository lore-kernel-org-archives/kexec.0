Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CCCCD98C8
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 03:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+ID8npPVmssnqRG8Ji1yhntACK+L6DoClGasDVFcWwg=; b=zel+EfvOIfI0fr
	q1iJjKjYxGNnoz6FpSntHDVY0bpqQJPPdbknA2eyR8Ns5FZD0yAxaM1Bfp4uAAU4ApgajHQ1XHVbe
	ydbM258Cf60Rv/A7y6T5LHH3sBln5LJ4kwtYWU6XCAiw2sMZreORGHnx3kD7XfZpfMZ55kwX0qBH1
	NJq9iO5VSfG5rAVObIXbUYlxO1+9rp8+5zrlV6dfuk8JaL2yEc5ZquyXI4+X0IEm0psouRMUf5t5E
	xgw2+URdL7vEPgMtIsG2EQODQdAqUfvSlEeV6tcl6ZSuTzw/jV/U5kl8g3W+fB+J+Bn+MoBLF2RrW
	Eg+PMLiSvUovU3zf9Ymw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqQL4-00Eher-2N;
	Wed, 11 Oct 2023 03:56:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqQL2-00Eheh-2p
	for kexec@bombadil.infradead.org;
	Wed, 11 Oct 2023 03:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=16xgkWyiZ4SbuyoavFb5xFz9KEreESbZT3/v/18RR3w=; b=ZOi+tX4sJ1u4fUR12wlfxOgN7o
	oJslc3lHZTjTvGUyvZqwCi4MD35h2IxI4SeVjrTV96VDdv7TANGPVaRm8GQcZazpiI+cFittX9kDW
	hpDsnrUz++0kG6uxUDsT1Dz/V7O1CFSOC522Y0G5NzMeYqxF/98MKdAPO0zGJYC7404J/KP+puNn4
	oOUEgUD/rOgza7TfxQKB632mtyn+6RYMhe9G9Wfe7agFGn3zwBe57Nc4OFIbvDx1B99y0GLHvDdyk
	Yz6eeN0qdVCW7vpsTTfahO1aLjUbE/FDVZLfKwV0kx2CH22pXhZ29afq1FXTZ2Oimf+KSxWjJX64L
	v54TTytg==;
Received: from mail.loongson.cn ([114.242.206.163])
	by desiato.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqQKv-00HWLg-2b
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 03:56:46 +0000
Received: from loongson.cn (unknown [10.180.128.250])
	by gateway (Coremail) with SMTP id _____8DxRvHnHCZl9eQwAA--.28590S3;
	Wed, 11 Oct 2023 11:56:23 +0800 (CST)
Received: from crazy.crazy.loongson.org (unknown [10.180.128.250])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxjNzlHCZlmrUfAA--.1239S2;
	Wed, 11 Oct 2023 11:56:21 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	chenhuacai@loongson.cn
Subject: [PATCH] kexec/loongarch64: fix 'make dist' file loss issue
Date: Wed, 11 Oct 2023 11:56:21 +0800
Message-Id: <20231011035621.571216-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8DxjNzlHCZlmrUfAA--.1239S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQABEmUmBiUB7gAAsd
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFWfWFykAF4rtr1UGr1Utwc_yoWfAwb_Xa
	43Jw4UGr4rGa1DXw4Y9345tr9Y93W8JFn0yFn0qr4fC3W5Jr15Wr4Ygwn5Ar1UK3yDWFs5
	JFW0vF98Cr1UtosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sj
	jDUUUUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_045644_218353_1766C035 
X-CRM114-Status: UNSURE (   6.65  )
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

The Makefile omits the iomem.h file, causing the archive file
generated by 'make dist' to lose iomem.h. This patch is used to
fix this problem.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 kexec/arch/loongarch/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/loongarch/Makefile b/kexec/arch/loongarch/Makefile
index cee7e56..f91d0ba 100644
--- a/kexec/arch/loongarch/Makefile
+++ b/kexec/arch/loongarch/Makefile
@@ -19,5 +19,6 @@ loongarch_VIRT_TO_PHYS =
 dist += kexec/arch/loongarch/Makefile $(loongarch_KEXEC_SRCS)			\
 	kexec/arch/loongarch/kexec-loongarch.h					\
 	kexec/arch/loongarch/image-header.h					\
+	kexec/arch/loongarch/iomem.h						\
 	kexec/arch/loongarch/crashdump-loongarch.h				\
 	kexec/arch/loongarch/include/arch/options.h

base-commit: 6419b008fde783fd0cc2cc266bd1c9cf35e99a0e
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
