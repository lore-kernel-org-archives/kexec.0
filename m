Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6509FCD6119
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 08:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F1RmnFVKOqEUMnOA6RCL060tfJPNE9AL5/MeihNFa0E=; b=NrUrnmAyXgzMZC
	/L1bciv+Rz/Yf5Jr+lpVG69s5xWoFW4XGvNOCHWS795U6pV+8op93xgA1pDzC0HeAgxZZN32T1s7/
	7+wzcz/vVxxGAg6Sw9wmh6J9oJYqWbEd462o5iS1E6wguHk6gHFxFYbfNDFzxlujJhLBR0rfeCJEi
	PMbppsotN6qgGLzrEhgdGTDKvJnpp3kbmVd5IMFkXRgSWwmSR8zv+vh1JoC83cx0kYVd0oGi1nLyP
	xt5uaFUTHzHXd4yIuSyR9fWaKy7+XQjGTsKxC745W0DSqTOg2lfudnA0f3s1P+psAqejOJtOFKjnM
	+bEMdD5p+7WGXYe+mmag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUgg-00FElD-0N;
	Wed, 11 Oct 2023 08:35:26 +0000
Received: from bg2.exmail.qq.com ([114.132.224.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUga-00FEkQ-2d
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 08:35:24 +0000
X-QQ-mid: bizesmtp71t1697013251tdcqqafe
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Oct 2023 16:34:09 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: FwowAM4HOqAVKxvoHOg+FFtkzyhqthXdQT4dyvq8RM0ldk9sx097/DTTVtTym
	zDrumLi3wKzCr8HeAtYLjJAO0L0+aIbGeOa415C5O9jPe7FMnKkoUVvHuiA9aKuYc+9Q1aM
	9cJ/snUP8/szBAD7Bjs3eaWzuqEX+BnI7N+51e2OV79N001z7CTBNMWbJqV+bykxn7ic2Q7
	RRHq54a8wsMzE6aZmUluVyilqnAsv/dg/rJUBkGm4OBESBJw3+EzrA5i0dRI+0hK+/Dazvv
	F6v2yTOubJMkx7Sf6/j1qLEQN3zoG54wpS3sggddPKE3seMGmKHz2Dx4zAl25vrsVzJFfqU
	bs1DClkTvFRJjSLK+rmaGFnDXt4enoq7xPY3bzlojOIb1ZqDxL5jep7gSIHFg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10839386821577447536
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
	alexghiti@rivosinc.com,
	schwab@suse.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH 2/2] riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS
Date: Wed, 11 Oct 2023 16:31:32 +0800
Message-Id: <20231011083132.2428720-3-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011083132.2428720-1-songshuaishuai@tinylab.org>
References: <20231011083132.2428720-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_013521_185691_CBE9577E 
X-CRM114-Status: UNSURE (   8.43  )
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
index 9e6476719abb..982fc8e77108 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -81,6 +81,10 @@ ifdef CONFIG_CFI_CLANG
 PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
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
