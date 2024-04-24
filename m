Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6267C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=J2O36+1+Q6NlU4dRixk3J/NvfKipcqokkw8IEvQhhEI=; b=aFwRDH3+FKnXAnzE/f5vRjLHDL
	14VA+V42WDrxaVEdN+3TYaLrb43cnUt50ozdM3HU2vMseDYrk/0yFV3xcZh4V5n4cbpxVwsubGjha
	wx9IwxfSlHetEnNHJ0TegKqgd3gF9mZRqaXZT0P3yP3Ic7Y+hw6SNLwq6ad6CLWSqL3W11ruWjhRT
	sfkqHT93ApUItkqLlYoceCBO43mYW3QTFMtQ393YFUABSePzP4Mmd1uakB6aPiVhZ0Jhwp+d+zhsC
	ibffAAE1ubtE3aYmSbKaaqA9zj5n1wOHoKDJi/VjGoRJvScLFZtv7MA00m7InMtZ3WKOjh5CY7E9n
	c+x1J9fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewP-00000004q1d-454a;
	Wed, 24 Apr 2024 15:53:49 +0000
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewM-00000004pxC-0aNR
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:47 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-343e46df264so4671289f8f.1
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974024; x=1714578824; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjdGmdFWunSakeQxhcxmHXUAnMO8coypY8ElDRJZN3Y=;
        b=mWmsKGN6SylhnOZp389J4x98etpgSebshv3rXE8+1hA+EC2jMClpNFsvHfoKANBArk
         R8llgi0X9tgxJkT2jrtzGo9jBbGoQku+QUNCSqTE5SW+3PTiliM9p2qIelu7LSyhQY5U
         OBrnICucsuRIMLz+R+RjEnxRheh8SpJwAhElUwbFqm3hBQBCoYARPAREFV9oa0MH8AVp
         bfXvslcpr+bL6D5UTS0oXu/XuDr2GpnGY65+t2fi5RvnVsO5wYx+6WIvZh5S862oHUL9
         NWe3ZsgwekfXS6A08xRkjU040A5VJJKQ/1AgJHnf6u/ldVfmgf32bAxBCQOS0P2iIWE/
         uhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974024; x=1714578824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjdGmdFWunSakeQxhcxmHXUAnMO8coypY8ElDRJZN3Y=;
        b=cpO9PvGzVyNizkiNzvdgZ9NqogzVMVonBgyvrgX7e6bAL7RHyJBWR78ov6Pzcqk14A
         3tymKlBm9JClu81YPyaSAYFJ+7J5jpgDaEb206pwcR2WyySPeRsclIuLfAn/+Y2ZsGh1
         vEGsuriJ1lq2Q+ZDAOXEldOEO2Idx0YJtkUFV2uEF8TwdHT1dhdGwhmFH2Q+FTZjB3/p
         X0HhK/n0kaNnzG7jAfQdaIiMLPVzQanR/V0p/o/zkK+MFYgVoruCqfVZqsr0MAZY0YJG
         ZpoHqg3ERpnRMFyyHMKHTtN/FnyOtdVhAk6hESWv8cnHcbyafylh9XH6UzMcp5z+wS9T
         dRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf046oePA0lqnBLE52XKe+0FIhu0dsmlccsOL2wDajgE5NVGWc87D8+i0+QZCnE3YWU+ytjWeqrG8Regrh80SFAZn9H71lytza
X-Gm-Message-State: AOJu0YyaT8DiNjbpfZ+YIH58ufWOlGnR0U5nejvfBDDXsqZUb5I64s/k
	mkatwHtPXVp2huH1/ZTNJPEMssaGAc2ePUrOe+2EPppP1sLZAyN8bNF8b3sPmfp8sWAYYg==
X-Google-Smtp-Source: AGHT+IEn5r/4qBnC8xtfim3xmOpYM/A60T3wlnxZ2weMiVXGxLyNbc4Y6I4sKkBsnHH/JjZQDh3D0l4v
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:50ce:0:b0:343:c41b:3e37 with SMTP id
 f14-20020a5d50ce000000b00343c41b3e37mr9280wrt.10.1713974024525; Wed, 24 Apr
 2024 08:53:44 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:15 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=ardb@kernel.org;
 h=from:subject; bh=2RmgWaHe6lR2Ojq2O13NtFX0a3tx2m9Gxd1ampluXaw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T63V+yN3dj+1yefbxClw7U8dWc36DtjWPV4Vvk3hy4
 rIoFtWOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJF/Hxj+J1tPOL1Z+ZCU+OHW
 BUX5N72YqiKDmRXT9jrfLt2yzGyvPiPDKSv2rLCc1k8cUhqBbEFmB59k3/r8QWv9dnsRi6jqRUW 8AA==
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-16-ardb+git@google.com>
Subject: [RFC PATCH 5/9] x86/purgatory: Simplify GDT and drop data segment
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085346_265893_6F4CCB63 
X-CRM114-Status: GOOD (  11.16  )
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

From: Ard Biesheuvel <ardb@kernel.org>

Data segment selectors are ignored in long mode so there is no point in
programming them. So clear them instead. This only leaves the code
segment entry in the GDT, which can be moved up a slot now that the
second slot is no longer used as the GDT descriptor.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/entry64.S | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 888661d9db9c..3d09781d4f9a 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -23,14 +23,14 @@ SYM_CODE_START(entry64)
 	addq	$10, %rsp
 
 	/* load the data segments */
-	movl    $0x18, %eax     /* data segment */
+	xorl    %eax, %eax     /* data segment */
 	movl    %eax, %ds
 	movl    %eax, %es
 	movl    %eax, %ss
 	movl    %eax, %fs
 	movl    %eax, %gs
 
-	pushq   $0x10 /* CS */
+	pushq   $0x8 /* CS */
 	leaq    new_cs_exit(%rip), %rax
 	pushq   %rax
 	lretq
@@ -84,16 +84,9 @@ SYM_DATA_END(entry64_regs)
 SYM_DATA_START_LOCAL(gdt)
 	/*
 	 * 0x00 unusable segment
-	 * 0x08 unused
-	 * so use them as gdt ptr
 	 */
-	.word 0
 	.quad 0
-	.word 0, 0, 0
 
-	/* 0x10 4GB flat code segment */
+	/* 0x8 4GB flat code segment */
 	.word 0xFFFF, 0x0000, 0x9A00, 0x00AF
-
-	/* 0x18 4GB flat data segment */
-	.word 0xFFFF, 0x0000, 0x9200, 0x00CF
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
