Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F34C369B2
	for <kexec@archiver.kernel.org>; Thu, 17 Apr 2025 08:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=56/OsgBXyr2LuChdOyqkFpn2WPGuq6Zd2RCfcoiCNB8=; b=peFqiPSpFOpVKAINKfHR1/Uch7
	zsDnI8vzEFV0yl/FWwPutfTVqvoZDqxrUFxBoniyBmMWYmX/U9/aXfk8dWZ9FZMObSgu9aa1zbH/E
	QkNZCt1lDhTeYZ62Oe/qC+gTm7FHBOk6OCw6fRNzGlyi6+W3sNaO+C/DogqNtoxHG+FLVKAvp/EoO
	LEsleB+Ws/tlAhVh1rCuj5DK0a+3jxBZwuj+RkIHVrMjlQg0ZoySCEs39wHJQENjCtP3lpG6yAbqc
	zPlIzi4E7gkHTZhAL+teVOGMJSNDbVqcRDmsrLBNfSIiQ3JfHDsxB+T4RpQPRlly7EjSTl+CIJbO0
	mRUbISTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Kf0-0000000CHW5-2miU;
	Thu, 17 Apr 2025 08:31:50 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Key-0000000CHVg-2z6t
	for kexec@lists.infradead.org;
	Thu, 17 Apr 2025 08:31:49 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso74034166b.1
        for <kexec@lists.infradead.org>; Thu, 17 Apr 2025 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1744878706; x=1745483506; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56/OsgBXyr2LuChdOyqkFpn2WPGuq6Zd2RCfcoiCNB8=;
        b=ZOXx//IxFxYZn4UOX21Ceaon9WQelM/M4gJnOY7rvIsqFzQyFi11Kf5wpMqt0X/FTY
         QySrGPI22xpEwLUHLHiMeWP4Pit9hg5fuWjZr4nhBlAP+4cjVxixA0P0cAc1UWHYCxmT
         XnYTsM+orREDJuKfiseNfLiWP0yhZuzWtNufw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744878706; x=1745483506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56/OsgBXyr2LuChdOyqkFpn2WPGuq6Zd2RCfcoiCNB8=;
        b=TLFR6YngoIso55IRcVn/GnKuU4QKW/s5ACu/QVJeAOCFwvuZ6Vzoym7nvUyajkEizJ
         M/LNmNOFYBtkHCWhNgrOON0lTlXm9a+01CI0zw1V+PEl0On40Fhh2s/AFze2CH1bk1FQ
         QYfUv1S44MUuPGhntQVqFAmSA/LUgR+livR7oqDF+FPmYejfe+MloXyJfnPtyDXFtdRT
         u45ZCXC/WvB1vswC1Pr+Afh+54lbRIEfg2DA7mQwuSRrOG4QiNYL706wWDOZLLtm65QP
         ps6NzpzpVBPT+ucD3tXLkG3a37rrhvgnx+M3BYTCBDTZFTtsI+cfHM2OObAOWt4zZpj1
         4IRw==
X-Gm-Message-State: AOJu0Yx3iGwGMER1abKKX+F+zx9qtA9bJ3GYEH2EdX9eRMI2LBEUdrqj
	iuqxftWZ5ubDIz6xpR9ozNEYfwm5TaQJ8fGj0OPUezRZ9Z404R3zfUesXw/gaNEzLlVeGkQ2C0E
	=
X-Gm-Gg: ASbGncvl8z8xeolxgO6hbzjftknoq4tBdZ4rk6gJNJ5VYPX/Sx4c1E0qx4pjG8AFK2O
	T0gvZkbe22dMKYK9uFtDlSzU0NNcUbAqttpvuCxlISnyBqwrg7bCV9ItiZPUt6qH6GKKmWaukGL
	3p0sRDMRDN7AvzNQ/IVaSpq+mcJm1JjvC93MlR68USIZ1iOhU1wiXlhUto9w3qGqkv3ua9+JHRC
	iYJK6HgzTDS3mkgKQcJHyuyEimX1Fn0/4Le3NOSTuR/2qpQ6kENkRdFZHPb6edsHFM8Z78jh9vE
	PuNL0OiQFd99UiQkqFN98RPBYacdgLwBD84NCtxUOL7GaMQTJvw4ccn8SA2QrNHM
X-Google-Smtp-Source: AGHT+IHRpF2Y4rSaoeAigNk8thDMcDVFicLgrLBulco7feZAPhW0ylGJqz0g1COizhlGoND4OWx8KA==
X-Received: by 2002:a17:906:ee87:b0:ac2:9093:6856 with SMTP id a640c23a62f3a-acb42c51e78mr540521766b.54.1744878706173;
        Thu, 17 Apr 2025 01:31:46 -0700 (PDT)
Received: from rossla-pc.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef56de1sm10044770a12.21.2025.04.17.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:31:45 -0700 (PDT)
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] x86_64: Use the x86-64 level for purgatory
Date: Thu, 17 Apr 2025 09:31:40 +0100
Message-ID: <20250417083140.697272-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_013148_747393_1BC50ECA 
X-CRM114-Status: GOOD (  11.65  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The compiler may be configured by default to use a newer
microarchitecture level such as x86-64-v3. Set purgatory to compile
using the baseline x86-64 level since the environment isn't set up
correctly to use SSE and AVX instructions.  At the same time, be a bit
paranoid and add some additional flags to ensure that the compiler
doesn't use any such instructions.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 purgatory/arch/x86_64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index b0e277a365b2..fd19229a2bf4 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -24,5 +24,5 @@ x86_64_PURGATORY_SRCS += purgatory/arch/i386/vga.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/pic.c
 
 ifneq ($(SUBARCH),x32)
-x86_64_PURGATORY_EXTRA_CFLAGS = -mcmodel=large
+x86_64_PURGATORY_EXTRA_CFLAGS = -mcmodel=large -march=x86-64 -mno-mmx -mno-sse -mno-sse2 -mno-avx
 endif
-- 
2.49.0


