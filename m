Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E19C07E8E
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ShOx1accurlJVHQYNs3Ub9q7VTdaXmiWoEbS2gRKi3Q=; b=cLaQkLIhHtxlnqOtgUxyJ2HrVs
	s26ZX7orF5h6dPLreESjq1AsWviypLIgwHUSqtvO0Mgj/tmLWJS2Mw+Q1GWVQhFfZOscfJfI+hp3M
	mdLEMWq2c4Ex/53h634V5MutBndtwrssSGXCzraQ7u/ii8HbVjhuOO4ROaekVEzibIVbvFnRmzIUh
	u+gcUt6SPiDkilqgoSzrT2rIF27JcDHsAklIk4yyYlMeNDvQ0HWife1WbbQmtltCE8pg1jLTFnsRR
	mwGJzHodqByapRy2mT5ZuIloTxKkShAdXO74n0oSIKDNOgPU3oO8aRsY22k7F1akcH4FW0SuhPBq5
	ArRmTmfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewI-00000004puQ-0ibi;
	Wed, 24 Apr 2024 15:53:42 +0000
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewF-00000004prY-3mfg
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:41 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-343f08542f8so5034693f8f.0
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974017; x=1714578817; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSE6Y9L7llOYPHAz3r3bPOJVA5fqH/Ut+JPxK7SpOhY=;
        b=hD4J7S9utUXc/EW+OBKJAKQmoHsX1CQeLntDisamhZiINSzJGZFpJghqwgdZkY061m
         96y1mqTNyujDP+GHqBIHJ7xQ0qH+t9/HQJ3Y7SprqQZBfm2byK2KV+yDGlYSF7TGFlLu
         EQNM6fyy2ZK1yRibVH3z5NdIt+hBuZi7Zb5W6X8zr0PE2FqIKy5DwHXJkf3db1LJjJQT
         ofoGBUio3WYh0vbIlXWGkuX78pMrWKUKuQrarlZBCeqeTmNOdMBcWeXFF3EDX7CT3sCU
         5+wNjKwhPKGkRq/Ecdnrl3/fIg6PeEgYbDN7NJ6gJ+80pW/ZQtpwtnN6iPZt8sVN9klR
         ildQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974017; x=1714578817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSE6Y9L7llOYPHAz3r3bPOJVA5fqH/Ut+JPxK7SpOhY=;
        b=R0NEU4PamibszeGCMRtUumQunFrzlFqtpBUZsQOI17n/aNZhnC5HjSWyXVRQknZljC
         2s+fkZbm1TqG77GQiOzRxXSn3GLf6IxjOwWN4oWbD4+R+VRn6KUfliunx4K1/SzRqX/5
         /EdjfDXE8aqTnjJEi7NmWoJ9hG+K3EDNY5H6FNwUzSpwWz8aBLBkJ7BGhiSYwcmrLNPI
         p5Hw32hp/IJ2OF1XnVB1vd0qMKfexU0Jfp4UrW6nkZCTW0L/NpbvM/kjbxvL76mO6k/c
         NnXqx+7QOWojffLAOHZS8IhddxPMNBVemqwvdVbOVOe1HWIHnZKLN9iJD5TM2FMuhB8v
         mtjA==
X-Forwarded-Encrypted: i=1; AJvYcCXX+2xMkoTeQLuyD7eG3341ewq8Aov+f/RiFXBQH9mQIsRm6gtmZ/gXO8YSxpLWxY0lc0O919tgDW5f2BDSKD5tHWCv2GDp6NdI
X-Gm-Message-State: AOJu0YxlqnYin+yg95p/4LS1Ggv1r8u5xBdfI0RiJQmLf/CufRqIGR0a
	Al3l44zH+TgZogtWzVp1way1RdsXgoP61aADZzFuxKed7faEzWT7jplyNBYBcFkJpifUDg==
X-Google-Smtp-Source: AGHT+IHdgZ/1scdNqsOsUGU/8rbl3y5ChDBjzKHAuJmkQp2vLW7lbyWqrKe1MbUP5BNj2PMZ2v+By58o
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:120a:b0:34a:6e5b:6c37 with SMTP id
 e10-20020a056000120a00b0034a6e5b6c37mr7967wrx.10.1713974017351; Wed, 24 Apr
 2024 08:53:37 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:12 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4653; i=ardb@kernel.org;
 h=from:subject; bh=UdYv+ny0ilnq/CzBfGtaYL0PFzYJ1VTxddLIDb1PfGU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T67nCweD+3Odn154LP+T386FQ3vcJEoLvuZ6H6ZVvW
 m2pqLmyo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkNhvD/+izvZU7ZxwT13nN
 9Nqwxme2rWdAyA7PdYXVXxWbvmYHxTAytASGi8fes/QNXDApfaVBhs3J+IcOfA+rNh7kkZr5L1K eCwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-13-ardb+git@google.com>
Subject: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085339_973715_1C01CCAC 
X-CRM114-Status: GOOD (  19.26  )
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

The x86 purgatory, which does little more than verify a SHA-256 hash of
the loaded segments, currently uses three different stacks:
- one in .bss that is used to call the purgatory C code
- one in .rodata that is only used to switch to an updated code segment
  descriptor in the GDT
- one in .data, which allows it to be prepopulated from the kexec loader
  in theory, but this is not actually being taken advantage of.

Simplify this, by dropping the latter two stacks, as well as the loader
logic that programs RSP.

Both the stacks in .bss and .data are 4k aligned, but 16 byte alignment
is more than sufficient.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/kexec.h      |  1 -
 arch/x86/kernel/kexec-bzimage64.c |  8 --------
 arch/x86/purgatory/entry64.S      |  8 --------
 arch/x86/purgatory/setup-x86_64.S |  2 +-
 arch/x86/purgatory/stack.S        | 18 ------------------
 5 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 91ca9a9ee3a2..ee7b32565e5f 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -163,7 +163,6 @@ struct kexec_entry64_regs {
 	uint64_t rcx;
 	uint64_t rdx;
 	uint64_t rbx;
-	uint64_t rsp;
 	uint64_t rbp;
 	uint64_t rsi;
 	uint64_t rdi;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index cde167b0ea92..f5bf1b7d01a6 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -400,7 +400,6 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	unsigned long bootparam_load_addr, kernel_load_addr, initrd_load_addr;
 	struct bzimage64_data *ldata;
 	struct kexec_entry64_regs regs64;
-	void *stack;
 	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
 	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
@@ -550,14 +549,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	regs64.rbx = 0; /* Bootstrap Processor */
 	regs64.rsi = bootparam_load_addr;
 	regs64.rip = kernel_load_addr + 0x200;
-	stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
-	if (IS_ERR(stack)) {
-		pr_err("Could not find address of symbol stack_end\n");
-		ret = -EINVAL;
-		goto out_free_params;
-	}
 
-	regs64.rsp = (unsigned long)stack;
 	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
 					     sizeof(regs64), 0);
 	if (ret)
diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 0b4390ce586b..9913877b0dbe 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -26,8 +26,6 @@ SYM_CODE_START(entry64)
 	movl    %eax, %fs
 	movl    %eax, %gs
 
-	/* Setup new stack */
-	leaq    stack_init(%rip), %rsp
 	pushq   $0x10 /* CS */
 	leaq    new_cs_exit(%rip), %rax
 	pushq   %rax
@@ -41,7 +39,6 @@ new_cs_exit:
 	movq	rdx(%rip), %rdx
 	movq	rsi(%rip), %rsi
 	movq	rdi(%rip), %rdi
-	movq    rsp(%rip), %rsp
 	movq	rbp(%rip), %rbp
 	movq	r8(%rip), %r8
 	movq	r9(%rip), %r9
@@ -63,7 +60,6 @@ rax:	.quad 0x0
 rcx:	.quad 0x0
 rdx:	.quad 0x0
 rbx:	.quad 0x0
-rsp:	.quad 0x0
 rbp:	.quad 0x0
 rsi:	.quad 0x0
 rdi:	.quad 0x0
@@ -97,7 +93,3 @@ SYM_DATA_START_LOCAL(gdt)
 	/* 0x18 4GB flat data segment */
 	.word 0xFFFF, 0x0000, 0x9200, 0x00CF
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
-
-SYM_DATA_START_LOCAL(stack)
-	.quad   0, 0
-SYM_DATA_END_LABEL(stack, SYM_L_LOCAL, stack_init)
diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index 89d9e9e53fcd..2d10ff88851d 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -53,7 +53,7 @@ SYM_DATA_START_LOCAL(gdt)
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 	.bss
-	.balign 4096
+	.balign 16
 SYM_DATA_START_LOCAL(lstack)
 	.skip 4096
 SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
diff --git a/arch/x86/purgatory/stack.S b/arch/x86/purgatory/stack.S
deleted file mode 100644
index 1ef507ca50a5..000000000000
--- a/arch/x86/purgatory/stack.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * purgatory:  stack
- *
- * Copyright (C) 2014 Red Hat Inc.
- */
-
-#include <linux/linkage.h>
-
-	/* A stack for the loaded kernel.
-	 * Separate and in the data section so it can be prepopulated.
-	 */
-	.data
-	.balign 4096
-
-SYM_DATA_START(stack)
-	.skip 4096
-SYM_DATA_END_LABEL(stack, SYM_L_GLOBAL, stack_end)
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
