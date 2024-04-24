Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F2EC4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TmbBYudmyHOBkpV0CNg+f1v86ZBE+Eh/2WK0jv7Rxow=; b=XXeKPAnWULrKmnlUbTdoaRl0u5
	F0p0GWu+/GBScoCYc2vBifJi8Q2FAwJzOWfvssKy6fYFx5sqa1Jt04T6TPWQDlj45CSJwyUgq+4DV
	QzmHmLmUrHrAVeB4HXPZqSsUpyDAKQFT76ahw6KAgfTtM8gXr7uRv+lrzfDzgdhi041GZBBSk8/Se
	FddCSsOZDzQDcb0j/pBaGxMk6Ny/5QjlvXjscCLi2Fkuuh71SzrbYrCBhB3WBVsZ2CegtSGe6Tr30
	8+XikblgGvhjGT8mIRNYtjY+lqHyO1EF+ZYebzM9L8ytYGoG1QH5dBZcdwAckVlipzj76blAdkRfO
	kQ5GIm/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewL-00000004pxv-3pP9;
	Wed, 24 Apr 2024 15:53:45 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewH-00000004psj-2Gii
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:42 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-de465062289so27544276.2
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974020; x=1714578820; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONwyVskTWQHpslgTZw8hf4C4K9cIt0E7xmJFnUiDsPw=;
        b=Sw+OolUiXZ+E7CKaRrVddVteS7Znh4WplzSy2fao8tFMTjbNzFWky5UcXqXwzbigLa
         Rt5a7IfbIK6qK2dFKdW7OS0HPiXilRPcj7bnRz51KrsYPyZs4XzGN5mOxn/GWpf8We8y
         2KWhCqVRVKKfZmUczCLJuS9WfJX2mz55NTrcZKWVmeXF8TJoR0lKqiqCgiGUM6MdA/B1
         pxKs3Yz4NZ1POfKENhBJ9a8aM5W+PQ1jLSNT7wAm3EXhwtr3T9gciNDAaHweBmDa63pE
         gzF6JbpsITSH8jY5/L4WrC7+rYhR6vLvb//STW/N4X+xwwU5k5BP8fvdL4MXzZ2qWCG0
         K8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974020; x=1714578820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONwyVskTWQHpslgTZw8hf4C4K9cIt0E7xmJFnUiDsPw=;
        b=GFJB2R3skMyH1L/qxyRMBmkDzpHTF6r4CngE4r/UchuxQdtayI7lybzzllcGkWKyJQ
         TQT4cBbzjzOVifPI2JC6ul1SqmVdbLNx5vYcEn8uTZxUdOSaMAwAmXSoa0wVK5YsUgnf
         ueMICT1LRYxeE9YntbmBk63mVahoI1kiGKYhCTg5LqKlA17qpYvDkqN+NAES3F42zmDT
         BcyWaNZ3I7/a7pna4ZxwqVjTeWkQ1hyzCHNGteOInTSbJiIFuotfBpti2naQXq9xKJH0
         uouQZE6Y2vpJIKdeDDwYqBbVbZMYAzJblrzxy0Hv+DURhIy7TsQ2B3MBVTtJrVOJs1Te
         dlfA==
X-Forwarded-Encrypted: i=1; AJvYcCXr+KAmWeTOtJ06aeqpVkUCBW/yRd/pKi/QHX5leXx3c0YII6n8GUCPpOzGD0Ux1UUEVW98xFpS9DAoLxRkFlvEvz9VmUf7LEIb
X-Gm-Message-State: AOJu0Yy+YVRTAF9d4A7oPxlsGy1wS1HjNGGiRv9CNQFmU9+ue6p643Ds
	JUg/m+2aBcNY/tuSa6tqb3NuNKnq5dbvU9NSgfYQ/zPFiBnEFniTnbLPJBK+B2rRqv3aEw==
X-Google-Smtp-Source: AGHT+IHX7WtsVsNqwNKvhI+To4SnGawKByTnzbSwsG/s5eCZ1zrHonsgJl1jG+GXDbRYbFRHkYOwz1DB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2b0a:b0:de5:319b:a226 with SMTP id
 fi10-20020a0569022b0a00b00de5319ba226mr985183ybb.1.1713974019817; Wed, 24 Apr
 2024 08:53:39 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:13 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=ardb@kernel.org;
 h=from:subject; bh=KmSF5Zvyw7fE7ONhepC4hKKyoNQsKlI4bUs+BgqWQzY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T60VG8aksjVwf35OnVyknZLtwrJ/zuvg3i411QMi0z
 M/NWw51lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIn8aWNk2NaTLt+veqD2RfKL
 BpeprI7nRbYvNzii87FxgfgRvslalowMax45Sl90CNyqsOWg9boPYoyVed3yfrNkVm/f909/WoY yJwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-14-ardb+git@google.com>
Subject: [RFC PATCH 3/9] x86/purgatory: Drop pointless GDT switch
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085341_647332_59D74A19 
X-CRM114-Status: GOOD (  11.21  )
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

The x86 purgatory switches to a new GDT twice, and the first time, it
doesn't even bother to switch to the new code segment. Given that data
segment selectors are ignored in long mode, and the fact that the GDT is
reprogrammed again after returning from purgatory(), the first switch is
entirely pointless and can just be dropped altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/setup-x86_64.S | 29 --------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index 2d10ff88851d..f160fc729cbe 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -15,17 +15,6 @@
 	.code64
 
 SYM_CODE_START(purgatory_start)
-	/* Load a gdt so I know what the segment registers are */
-	lgdt	gdt(%rip)
-
-	/* load the data segments */
-	movl	$0x18, %eax	/* data segment */
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
-	movl	%eax, %fs
-	movl	%eax, %gs
-
 	/* Setup a stack */
 	leaq	lstack_end(%rip), %rsp
 
@@ -34,24 +23,6 @@ SYM_CODE_START(purgatory_start)
 	jmp	entry64
 SYM_CODE_END(purgatory_start)
 
-	.section ".rodata"
-	.balign 16
-SYM_DATA_START_LOCAL(gdt)
-	/* 0x00 unusable segment
-	 * 0x08 unused
-	 * so use them as the gdt ptr
-	 */
-	.word	gdt_end - gdt - 1
-	.quad	gdt
-	.word	0, 0, 0
-
-	/* 0x10 4GB flat code segment */
-	.word	0xFFFF, 0x0000, 0x9A00, 0x00AF
-
-	/* 0x18 4GB flat data segment */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
-
 	.bss
 	.balign 16
 SYM_DATA_START_LOCAL(lstack)
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
