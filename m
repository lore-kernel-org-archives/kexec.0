Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46622C46CD2
	for <kexec@archiver.kernel.org>; Tue, 30 Jan 2024 10:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version
	:Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bsGKnFXg2MrYH/BlOCw16GIlK620F57C7DR+RKrAtzo=; b=qAgnU45uegp6Ts
	drFyfGAVUGIsZpzdsA16ekCfz5kCy/rWvfAHpDB6+YUpjXn6aWaAiSrJa4BQxOt1sFVt3ahK0wk9U
	AyDyOX9lOnMMHTfaNj0UzHavTORpJtW22IDSfrMV7Te/ImQ9XfOPCCRdnwsAgCR0wpSkDnv08gcjl
	jAQzMbq/kwX6xwksHBL0j3TUpjFWHR3wOJSqMp9pHv92DzMb08Hk0Uend6oKTbIoPYbO5taZspDGG
	tUQ7H2vhLG0wVrjKTHTrvLs7+izDMdb9N3BNfcO/NlmMJbF4UXAlbKcR8XyemumeWq5SHF1Bkb5/j
	uZebq4dGNiRHoyXPNDrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUl8a-0000000G8gm-0Kbd;
	Tue, 30 Jan 2024 10:14:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUl8W-0000000G8gB-1yQT
	for kexec@lists.infradead.org;
	Tue, 30 Jan 2024 10:14:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 64AE860906;
	Tue, 30 Jan 2024 10:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 145C2C433F1;
	Tue, 30 Jan 2024 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706609675;
	bh=IPkPBz5AZxMXVfGD5jNqTw8tfXdmZBTQ/hwT3pTHiFI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=R+h0cN03tgGvyyg3ppQpOb66zXsQh1I3dVM69igq5lUkDAQzRLPnlEBeEOmeE5amF
	 m3BAtiROZgJc43F45cgaisbafrQcCpfxzF3ctdsJ/USlNIkfxwuovf0r+5aGmigmvy
	 VSzqTevSQ3sZ2owX0m8UfzrxrV5EQLVaX0Pfv2VlK9XG7DiUGQFshEt9kSw5AUoxK4
	 fgkI8aQK/7z0qzXpt7cvIWQD16jApVIwx5iki8aVO0DC0lS/jZISknMkxUS4pN7rD+
	 nTAKPC+ArwkSXj1s1AIHD2RF6inxsqy33Uk3Km1ER2XNrE7fnHNeHrhfKMt1w4giY3
	 MLw+5fmSh5n9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAAAC46CD2;
	Tue, 30 Jan 2024 10:14:34 +0000 (UTC)
From: Michel Lind via B4 Relay <devnull+michel.michel-slm.name@kernel.org>
Date: Tue, 30 Jan 2024 04:14:31 -0600
Subject: [PATCH] Fix building on x86_64 with binutils 2.41
MIME-Version: 1.0
Message-Id: <20240130-fix-binutils-2-41-v1-1-99ee0fcfb5ce@michel-slm.name>
X-B4-Tracking: v=1; b=H4sIAAbMuGUC/x2MSQqAMAwAv1JyNtANBb8iHlqNGpAqjYog/t3ic
 WBmHhDKTAKteiDTxcJbKmAqBcMS0kzIY2Gw2nptnMaJb4yczoNXQYveYFN7G6KLNVEDpdszFel
 /dv37fthRuOBjAAAA
To: kexec@lists.infradead.org
Cc: Michel Lind <salimma@fedoraproject.org>, 
 Michel Lind <michel@michel-slm.name>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666;
 i=michel@michel-slm.name; h=from:subject:message-id;
 bh=nOBIxomCd1NB/6X96cPgNNfdPJVIUS3lPhJ2O2YpA2Y=;
 b=owGbwMvMwCXWrTRXv+YMyyfG02pJDKk7znC+9whM9a5eyJgefDpPZq6L2qeuIzd2pOtyOfw+s
 ORbW8LcjlIWBjEuBlkxRZbYc3p1c6xl/l82PXgdZg4rE8gQBi5OAZjIY0+GfwZ3me5eMbn3yumC
 BePtIInHWWXLb0gFtaVGcawy+LHFsZKR4btbh3I0Y2gjy4+5Hkd8Oe/Pbbjgm1Cimsax6CjDzxk
 bOAA=
X-Developer-Key: i=michel@michel-slm.name; a=openpgp;
 fpr=5DCE2E7E9C3B1CFFD335C1D78B229D2F7CCC04F2
X-Endpoint-Received: by B4 Relay for michel@michel-slm.name/default with auth_id=119
X-Original-From: Michel Lind <michel@michel-slm.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_021436_639822_5CC1C87A 
X-CRM114-Status: GOOD (  10.38  )
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
Reply-To: michel@michel-slm.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Michel Lind <salimma@fedoraproject.org>

Newer versions of the GNU assembler (observed with binutils 2.41) will
complain about the ".arch i386" in files assembled with "as --64",
with the message "Error: 64bit mode not supported on 'i386'".

Fix by moving ".arch i386" below the relevant ".code32" directive, so
that the assembler is no longer expecting 64-bit instructions to be used
by the time that the ".arch i386" directive is encountered.

Based on similar iPXE fix:
https://github.com/ipxe/ipxe/commit/6ca597eee

Signed-off-by: Michel Lind <michel@michel-slm.name>
---
 purgatory/arch/i386/entry32-16-debug.S | 2 +-
 purgatory/arch/i386/entry32-16.S       | 2 +-
 purgatory/arch/i386/entry32.S          | 2 +-
 purgatory/arch/i386/setup-x86.S        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
index 5167944..12e1164 100644
--- a/purgatory/arch/i386/entry32-16-debug.S
+++ b/purgatory/arch/i386/entry32-16-debug.S
@@ -25,10 +25,10 @@
 	.globl entry16_debug_pre32
 	.globl entry16_debug_first32
 	.globl entry16_debug_old_first32
-	.arch i386
 	.balign 16
 entry16_debug:
 	.code32
+	.arch i386
 	/* Compute where I am running at (assumes esp valid) */
 	call	1f
 1:	popl	%ebx
diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
index c051aab..eace095 100644
--- a/purgatory/arch/i386/entry32-16.S
+++ b/purgatory/arch/i386/entry32-16.S
@@ -20,10 +20,10 @@
 #undef i386	
 	.text
 	.globl entry16, entry16_regs
-	.arch i386
 	.balign 16
 entry16:
 	.code32
+	.arch i386
 	/* Compute where I am running at (assumes esp valid) */
 	call	1f
 1:	popl	%ebx
diff --git a/purgatory/arch/i386/entry32.S b/purgatory/arch/i386/entry32.S
index f7a494f..8ce9e31 100644
--- a/purgatory/arch/i386/entry32.S
+++ b/purgatory/arch/i386/entry32.S
@@ -20,10 +20,10 @@
 #undef i386
 
 	.text
-	.arch	i386
 	.globl entry32, entry32_regs
 entry32:
 	.code32
+	.arch	i386
 
 	/* Setup a gdt that should that is generally usefully */
 	lgdt	%cs:gdt
diff --git a/purgatory/arch/i386/setup-x86.S b/purgatory/arch/i386/setup-x86.S
index 201bb2c..a212eed 100644
--- a/purgatory/arch/i386/setup-x86.S
+++ b/purgatory/arch/i386/setup-x86.S
@@ -21,10 +21,10 @@
 #undef i386
 
 	.text
-	.arch	i386
 	.globl purgatory_start
 purgatory_start:
 	.code32
+	.arch	i386
 
 	/* Load a gdt so I know what the segment registers are */
 	lgdt	%cs:gdt

---
base-commit: 94fbe64fb22d61726ca0c0996987574b6c783c19
change-id: 20240130-fix-binutils-2-41-7642ab3b6ee7

Best regards,
-- 
Michel Lind <michel@michel-slm.name>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
