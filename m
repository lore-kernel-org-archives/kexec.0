Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F607C07E8E
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cN8DzSWxDp4lrzjTA2PRmHdtEy4AAgjccGTeaODihe0=; b=mLBHqnzBWjcdlsIRzjcX0VassD
	lw8NHjicB8Yzm4CTogrR9oihdxXPpGjwTP5BQUf+Q/Xdrug79Q/evYxmsw1rLvxl7bickecKCHRgm
	IjOyynl7R+MI6QIc4Vfj6iozTqIsOWXql36+txRXiUjry03nOxyrjWlB3152no/XIQ3Kjh2ofo0R1
	JWpCAOOYN7tp04oGDtzXfte98sGDabDFMDiHQI9LU6QtobFid0LzYS04YbYKBQp7z6HNcghvu9Hqi
	40/b61Z88O3yvXDxPG4i7w5bOxTqMEGl6rQb0+uYsI9XM6rbVc+aTA6mEoq7AbJSkQib2D40C/Bnz
	NOoq+GIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewN-00000004pzu-3Vln;
	Wed, 24 Apr 2024 15:53:47 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewJ-00000004pv4-2Rpv
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:45 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-de4645bee83so26556276.3
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974022; x=1714578822; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1uZvGOJrDJyNyZbDNRiP2qZHG8ZyjcmYdwIIxk4UA4=;
        b=Ax3BM0oPTUqeAPwv73UAiixkb4mXZQ8fsTZoZrJ6mc9RKGMpa4VvwsFVQq3RThU4wY
         MKYG20vTXtR/TmM3gXW6GLiIi8tvdqiCjstXwYgi8g49nIf0985crHDFUE20E6zhCkZL
         TqfRgXYoKKMwW4dYiPwF6wzh5YqcKM66dka9tQJ4F/thDtSFFfkHRa41N6o/GxFrh/0b
         ITXasbX/qN9xicZJPitnTtxUaGpD48zAtnsZijrU1rJq1x2V84RN5aoWUXLwFfzk+yIM
         +OIi5B2TnNcGQT6dO6ROSO3T9o2NkDx0THAGHBUuU7r87HashTZTvG9l0KAAC8qn08RH
         0oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974022; x=1714578822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1uZvGOJrDJyNyZbDNRiP2qZHG8ZyjcmYdwIIxk4UA4=;
        b=lf2G17voU+8LBEPc47tm6V6osk+SmazbA8CcVjqkZHysCPH0zRefPjrFH+53YPU+FZ
         SzXVUZEpI0AKn3vkuFk3Cacs7168DjgYK1IfuDmFf76I+mh1hK78OCoIiZm3Pz7/EW1Q
         EuqcHmLwuMyjp4Sor2wy36jvSa2WImussHg7Ijfzn7wyTePUUMTP3ZDyahZmNBjwM93t
         dHoSihQhLL78Ku/5j6tiqFKIiPo5uuibCAjQOu9ihPmfIke1ZLrG1i+eG7DXIxSrZ4GE
         pBZs0rWjKzHN2Z6QFJpCR9cGqLZE93w3GyOwHE8fZp0T74IbBxQ1tMePWBQKHO6XQSvF
         /mlw==
X-Forwarded-Encrypted: i=1; AJvYcCWAj3dg0Y6gE+BRPHlytujJX5qqTAqpNLNpOyKmNPxKjsyzbHbihzntg67+2ZPoCk09jHX+pOkthZ38znaBDu2qURtckReQCGqu
X-Gm-Message-State: AOJu0YwkrtS9dHS1zx01J3AuvRK9W27hZOrc/MA+Med9ZFdlXRwionpM
	MUFF3m15bs+pjX8rkBYaAaraNwihNsTHSwEFfR1GWdNxXkn0MsdtP+njO66Jq1HzKfV4bw==
X-Google-Smtp-Source: AGHT+IFEGGFxfMnQooqXA71tEBTY29NX0MUA7pIaduK0k76YjwQ4bXrhWlZuNWvOPSLJ1YLTC5jr9V+A
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:120b:b0:de4:67d9:a2c6 with SMTP id
 s11-20020a056902120b00b00de467d9a2c6mr203644ybu.2.1713974022222; Wed, 24 Apr
 2024 08:53:42 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:14 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=ardb@kernel.org;
 h=from:subject; bh=XNDtlXNqERbrKnet8kKgoeintaNkpRS0TQFFAtyMk8M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T69WP2+KSbU965hyyfHHbMubHPOZrK1Ia1xxZZPv4e
 ocgr9GmjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRgzGMDDOOXfadUMz1Y5e7
 1Eej2e0P/GS3/Nw2R0dVO2trpJaVz3SG//FvfZ746Kprbm2vkwqLLn3/d4XNfJnneuvDPfcZZ/1 4xAQA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-15-ardb+git@google.com>
Subject: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085343_813291_77B8B64B 
X-CRM114-Status: GOOD (  12.68  )
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

The purgatory is almost entirely position independent, without any need
for any relocation processing at load time except for the reference to
the GDT in the entry code. Generate this reference at runtime instead,
to remove the last R_X86_64_64 relocation from this code.

While the GDT itself needs to be preserved in memory as long as it is
live, the GDT descriptor that is used to program the GDT can be
discarded so it can be allocated on the stack.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/entry64.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 9913877b0dbe..888661d9db9c 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -16,7 +16,11 @@
 
 SYM_CODE_START(entry64)
 	/* Setup a gdt that should be preserved */
-	lgdt gdt(%rip)
+	leaq	gdt(%rip), %rax
+	pushq	%rax
+	pushw	$gdt_end - gdt - 1
+	lgdt	(%rsp)
+	addq	$10, %rsp
 
 	/* load the data segments */
 	movl    $0x18, %eax     /* data segment */
@@ -83,8 +87,8 @@ SYM_DATA_START_LOCAL(gdt)
 	 * 0x08 unused
 	 * so use them as gdt ptr
 	 */
-	.word gdt_end - gdt - 1
-	.quad gdt
+	.word 0
+	.quad 0
 	.word 0, 0, 0
 
 	/* 0x10 4GB flat code segment */
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
