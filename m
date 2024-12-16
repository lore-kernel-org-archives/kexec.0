Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D41E7717F
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4+hbfmOKjnlASf4EoCiuUoXr7Qw32w/Un/7tGNMOLBU=; b=qN7IZMWl+GaF4JKQi6GMC1OdvE
	4ot9XFWEcCO87g69cojAvkXIIwiPQM379ZKlYveNREM+XmkdBBzaJ+ifvxovqR486JsSDTIYaEC0n
	NYLc5DCT7qsA3I2LOd9X2jQk2HotS2EsfYOC5mRjYAJmdyXqaMo0Lv3eQMgfEx95+f9dCaazI6+Gu
	zdG/2t3o1+tquu4Zm7ZjYxTTo49LeeKwXhTPjLOikUORqliBwsinRJuhcVscvQOi/HwBa4yXmFKPP
	zaBKHksi7xZ5OvhWt10PRx463hYjaG6Qng93BdBEi2rcO1I2Me3ztf2By/4lgvCUjtRoWYMb4nsFX
	GrEOFeZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF0i-0000000An0F-2pGK;
	Mon, 16 Dec 2024 17:36:00 +0000
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF0g-0000000AmzF-2zpS
	for kexec@lists.infradead.org;
	Mon, 16 Dec 2024 17:36:00 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1734370532; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vp0Iu6WdbMoF1nXM5SnCyiFrgm+BDTTNnovEHr3eLz0NQKz/zfx5bJiDUaqTLXmjF/IrctuEI+gH9FH2yuTHr4mKE8vjWNgQLdOCcNLlLWX+VuREs3+vFPezAQ+a5uG0QzMVqUs7PHKCSEJaPqKy8BNTNMxyxicXMqB09eHc/6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734370532; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4+hbfmOKjnlASf4EoCiuUoXr7Qw32w/Un/7tGNMOLBU=; 
	b=HQDuLCTZ4BGk/ey1MN57Y7Uzrf95t624UDRepS6W8RrQVfOU9woYFYU0R3qBb0gOXyNncdwA0eqyXxb9oCR31KMAlDpIzGDGEafpS98PielASxILX6jmfdmIdN6TK+rtOTHo79tGZKKWCn9IXklj8/zyig50B8OqEbNnYVnPasU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734370532;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4+hbfmOKjnlASf4EoCiuUoXr7Qw32w/Un/7tGNMOLBU=;
	b=MSxLuYEpwZ0O8h0j+Rypp0FGvTc0pvs9ZgT8QwNZx7mgRBcUDkFoHWWd74rwVB+v
	39XLkxIwAO6l4YoVHfRwn4Szqs4S1o9C8AvY0DNWbzlw+QbSluj72kknxpDK4vd0HsW
	RlsqBp4epFR4A7FlQHsZf009W4uGWKV48qja8Y5XdL+0r/vGdV73AJE9PQq8LKQQpy5
	BfjICz3nSFvNtAfyZhW5vRsvjc+VWJLE+h6hTX9leRL+rMI+IL86anX1HpdP6svU7Kr
	JLDL/FWN8jViUZgWBukOTqDWUJLKQsIuvI1jx1nggx9XNk9/ALdSIayuGvyj02fadTf
	z+qwqyv/Vw==
Received: by mx.zohomail.com with SMTPS id 1734370530165398.6022361701732;
	Mon, 16 Dec 2024 09:35:30 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] mips: disable CRASH_DUMP by default
Date: Tue, 17 Dec 2024 01:35:14 +0800
Message-ID: <20241216173514.495638-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_093558_809087_4233FBCE 
X-CRM114-Status: UNSURE (   7.07  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On MIPS, the space of a crash dump kernel needs to be manually specified
by both the debugee and the crash dump kernel PHYSICAL_START config
option, and the default PHYSICAL_START config will make the kernel
load quite higher, which isn't acceptable when using as a daily use
kernel (and will even confuse some naive Loongson-3 bootloaders).

So I don't think a MIPS kernel should be built as a crash dump kernel by
default, therefore this patch disables selecting CRASH_DUMP by default.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/mips/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a33f05e1ad6d3..f80ea80d792f5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2873,9 +2873,6 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded"
 	default "0xffffffff84000000"
-- 
2.47.1


