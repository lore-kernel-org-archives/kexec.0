Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CEFC07E9D
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 02:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=foqrVQlu+t0NbXUIpcs5r543OYEUI8YNzes3OWjTRSY=; b=K4XlfDyKJ1eVjV
	DyZIjDJUUZ09BDwE7U+Clj2AFna78+Y7Hidklq1JqJq/2FHsuaU3/gN+53poyVsTvAqxjREQqImmd
	6IpL5yyzcxeOSfmSVf4hhMSyHDiJwUF+3EHoSGNnIdqauM73aoVdC+VEx6OBVwFD02lpZLkROrcyM
	DBCB3LtYv8ZQZhJwnkGrLEBLo5znOTxP26v5IKXScJbxhUw3c6Ljhxxu0Zx3zarIcmEZ4Wh6+qQkC
	jm7lmi4aLgtq16hTIWVAc4LhghsXF5ngXg6RNF/9yrRWH1h9FgbtqxMdo86YovsYqb/D6iJgB90Hy
	VCSOK+ZJXY2Zci3r6mfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoW-00DaNI-Fw; Wed, 28 Sep 2022 02:28:44 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoQ-00DaDA-4X
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 02:28:41 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJKsTNjXAwjAA--.65269S3;
	Wed, 28 Sep 2022 10:28:28 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 1/5] config: Add LoongArch architecture support in config.guess and config.sub files
Date: Wed, 28 Sep 2022 10:28:22 +0800
Message-Id: <1664332106-4845-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxBOJKsTNjXAwjAA--.65269S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry7CryfZw4rZw4DtFWfAFb_yoW8Gr47pF
	WxuF18AF17ZF1fGw4kJa40gw4DCasxKr4UJFyUtr47XFZ0kFyxAr4kZw47Xr1Duayqkw42
	kasYka17KFWjyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8BpB3UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_192838_639122_E9A059D0 
X-CRM114-Status: UNSURE (   6.94  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add configuration files required by LoongArch architecture, including
config.guess and config.sub files.

The source file comes from:
    https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess
  and
    https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 config/config.guess | 3 +++
 config/config.sub   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/config/config.guess b/config/config.guess
index 8d70ec2..c626f7a 100755
--- a/config/config.guess
+++ b/config/config.guess
@@ -983,6 +983,9 @@ EOF
     k1om:Linux:*:*)
 	echo "$UNAME_MACHINE"-unknown-linux-"$LIBC"
 	exit ;;
+    loongarch32:Linux:*:* | loongarch64:Linux:*:* | loongarchx32:Linux:*:*)
+	echo "$UNAME_MACHINE"-unknown-linux-"$LIBC"
+	exit ;;
     m32r*:Linux:*:*)
 	echo "$UNAME_MACHINE"-unknown-linux-"$LIBC"
 	exit ;;
diff --git a/config/config.sub b/config/config.sub
index 9bc49a7..dae00e6 100755
--- a/config/config.sub
+++ b/config/config.sub
@@ -1185,6 +1185,7 @@ case $cpu-$vendor in
 			| k1om \
 			| le32 | le64 \
 			| lm32 \
+			| loongarch32 | loongarch64 | loongarchx32 \
 			| m32c | m32r | m32rle \
 			| m5200 | m68000 | m680[012346]0 | m68360 | m683?2 | m68k \
 			| m6811 | m68hc11 | m6812 | m68hc12 | m68hcs12x \
-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
