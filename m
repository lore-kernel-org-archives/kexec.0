Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B757BEE14DB
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4jkeU0Uoczk4CPrgL+DpaUEmLIctYURKHpBuwXyew7k=; b=YgAuo/UDXADgAv
	e0Ss2/fw/FlvBOTcOKP2yFDftGOXj1tSdNLKcvqAwCpyJqsWrbB5lld7p+vvfeS545pLzdKvIa/Fs
	Fx4x9B6H+sYXk0yqI16JlINMmFyypBWi0zH95Y6bCoiMLCRzXQ0Ztqw9rKHC/Bta3KfbwtVjsD3I5
	SLc1+15tG9GvVNtVn/wX6SEGaaurkGTjmVipgnPthlYgpSM9GrHOke3XTeKrSXLLaPKdfY8Ynwe+E
	6ljR3TJb12ujgEYPA2IbNcXckkgdm6OGBaHChoXWyf3aFnmWWyOnL2GrshFlMW4ah4pppi5P7CTdG
	pNQoNYnCQuu0N1tKfIUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeCOo-00BnJz-04;
	Thu, 07 Sep 2023 10:38:10 +0000
Received: from bg2.exmail.qq.com ([114.132.224.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeCOl-00BnJG-0P
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 10:38:08 +0000
X-QQ-mid: bizesmtp65t1694083018t81ozpyf
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Sep 2023 18:36:56 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: znfcQSa1hKYPPlX8KvMpBE/YOlGf71rdNbr35Hj+Pp4vDwY+EzNxgfOHbtbBf
	T51X8y9d9N0Zygz0yvMGhfWbrC5WLd99IOaFL6Y/Rri/9bkIiLZRpvnRb8WpLKV1sOb+PpU
	wIZDQCkF+ggK44JCM3zfbs+/yKTKDvSvonvRGr8WDUg884y7oYRrS6B/6/kAdBNxjHvHJZW
	b95JqKQhxiOeGWWhqSigqYNx6oByILPwHXFd7swnAAhgNvFVr7cgdQuzzLi7bvfZ+Yc1Ef5
	n1M09kUyyLck0pObd1JdLILZ8CkC3LO3V+rTPgBDBaS0hcQg7yOugx889QkVT0ww2J/ch00
	xvTOYt+V6EZMTy7gMbKcuvJjsuefuZ2zXlxPAoHIVKpYXUhhBcISqJt+IP7hA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3081111644831951934
From: Song Shuai <songshuaishuai@tinylab.org>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	lihuafei1@huawei.com,
	songshuaishuai@tinylab.org,
	petr.tesarik.ext@huawei.com,
	duwe@suse.de,
	ribalda@chromium.org,
	akpm@linux-foundation.org,
	keescook@chromium.org,
	hi@alyssa.is,
	heiko@sntech.de,
	lizhengyu3@huawei.com,
	alexghiti@rivosinc.com,
	schwab@suse.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH V1 3/3] riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS
Date: Thu,  7 Sep 2023 18:33:04 +0800
Message-Id: <20230907103304.590739-4-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230907103304.590739-1-songshuaishuai@tinylab.org>
References: <20230907103304.590739-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_033807_501700_66DC4CFB 
X-CRM114-Status: UNSURE (   8.69  )
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

With CONFIG_RELOCATABLE enabled, KBUILD_CFLAGS had a -fPIE option
and then the purgatory/string.o was built to reference _ctype symbol
via R_RISCV_GOT_HI20 relocations which can't be handled by purgatory.

As a consequence, the kernel failed kexec_load_file() with:

[  880.386562] kexec_image: The entry point of kernel at 0x80200000
[  880.388650] kexec_image: Unknown rela relocation: 20
[  880.389173] kexec_image: Error loading purgatory ret=-8

So remove the -fPIE option for PURGATORY_CFLAGS to generate
R_RISCV_PCREL_HI20 relocations type making puragtory work as it was.

Fixes: 39b33072941f ("riscv: Introduce CONFIG_RELOCATABLE")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index dc20e166983e..c2065d63945f 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -77,6 +77,10 @@ ifdef CONFIG_STACKPROTECTOR_STRONG
 PURGATORY_CFLAGS_REMOVE		+= -fstack-protector-strong
 endif
 
+ifdef CONFIG_RELOCATABLE
+PURGATORY_CFLAGS_REMOVE		+= -fPIE
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
