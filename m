Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F42DC61D9D
	for <kexec@archiver.kernel.org>; Sat, 25 Nov 2023 07:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ubz00JvFS/lsJ+vk2lFPLqkkVEGPEJxMXGNGHMcabO0=; b=OZzmI3BbpVtExo
	rt/FNAEp+fgXnztKAFeHyoHZefzHPLN+Qk1xqga6nnyHTK3WHg0J69PvYUr97pLMm6feHMoY7IPpg
	lEle3i+ODtF8qZgaeSG3v/b2TnnJAqHsOAFj4titASO4H1H/14hfKjpbqpyKSliRU+htv2suVsCfU
	YGVSJgnhOss3QFawrGh2KxjolUukJ34i/BRwQm6dFvV+OMxOrYPejE5+vKmI2u0S5V1nMpiEM0W1q
	2x0D+PH8yjFZsQL/GDZ1d40Pn9Uzk7IttgE2LfbPx1/I+yNc6HYG/7UCWt3Vn/9t+efT3+1K8LuJM
	mR0YNu0m0wpykmX0T4ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6n4R-008m4b-1q;
	Sat, 25 Nov 2023 07:27:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6n4Q-008m3v-1D
	for kexec@bombadil.infradead.org;
	Sat, 25 Nov 2023 07:27:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=cZfWzFzNxdWlLhBkAQrYcVUYFOMe9vW9SvSdpLCSxNc=; b=f7atmRdCxLx+UpLIfvyIirZTPr
	2bhYfNjfvLO8KKdqyBKAucQXBve7zgbhKvh8F6vxxYs5/0YqlZxyHI0cqvd4YYDs7opHC6h/OVB28
	YJQfp3XfEJp6UZ0cfVRrUIrANUo9FI6hnP3KrYis3yDDQcR4RpyekxOzOuUqBTmHphi7XM1YamfEA
	LN9nEYLvdTf70aFPHClHm4DMvHvAG128jlJkme+38ZZl5MtYvu90sCBA0eUYfcmPMYWTpZ0C5k4FA
	ZGHthGBoprdE2iGvTT7Cb8AbmSzsKq+S4RGPVtd3mZDzVfwYkfgYYp8KS2jG5bOXNxQBnjU5RqtXc
	xsRh97lQ==;
Received: from mail.loongson.cn ([114.242.206.163])
	by casper.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r6n4I-009X8P-HQ
	for kexec@lists.infradead.org; Sat, 25 Nov 2023 07:27:15 +0000
Received: from loongson.cn (unknown [112.22.232.197])
	by gateway (Coremail) with SMTP id _____8Cx5_G5oWFln748AA--.54755S3;
	Sat, 25 Nov 2023 15:26:49 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.232.197])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axji+2oWFldwdMAA--.37331S2;
	Sat, 25 Nov 2023 15:26:49 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: kexec@lists.infradead.org
Cc: Florian Fainelli <florian@openwrt.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	hev <r@hev.cc>,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] lzma: Relax memory limit for lzma decompressor
Date: Sat, 25 Nov 2023 15:26:43 +0800
Message-ID: <20231125072643.116681-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8Axji+2oWFldwdMAA--.37331S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFyUZFyUAFyUZrWDurW8Xwc_yoWDGrc_W3
	W8X3y0qF15WFnF9w47C3sa9F90qrykXan3Z34Iya45Xa4UJws8Xr95XayrZr9Fgr98ta47
	C34qqF4YyrnxWosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231125_072712_087405_464C6732 
X-CRM114-Status: UNSURE (   7.73  )
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

The kexec cannot load LZMA compressed vmlinuz.efi on LoongArch.

  Try LZMA decompression.
  lzma_decompress_file: read on /tmp/Image4yyfhM of 65536 bytes failed
  pez_prepare: decompressed size 8563960
  pez_prepare: done
  Cannot load vmlinuz.efi

The root cause is that lzma decompressor requires more memory usage,
which exceeds the current 64M limit.

Reported-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 kexec/lzma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/lzma.c b/kexec/lzma.c
index 2fc07e6..56778d1 100644
--- a/kexec/lzma.c
+++ b/kexec/lzma.c
@@ -73,7 +73,7 @@ static LZFILE *lzopen_internal(const char *path, const char *mode, int fd)
 		ret = lzma_alone_encoder(&lzfile->strm, &opt_lzma);
 	} else {
 		ret = lzma_auto_decoder(&lzfile->strm,
-					UINT64_C(64) * 1024 * 1024, 0);
+					UINT64_C(128) * 1024 * 1024, 0);
 	}
 	if (ret != LZMA_OK) {
 		fclose(fp);
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
