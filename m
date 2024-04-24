Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9A5C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cHBKi1/e8v0Rvfeg4cvIMaE1lKOSwa7ux4QatNRVuo0=; b=FQRYoKnoOFixbVR4DMEdPSglzP
	wt1goV95YY4bhoM9Psxhh31B2I9f0N7GUWA8o7cC1vbQHJ1v872GlxBXejYMjZ2jlS71QL5jKUET3
	dMNyVC4OrVO4XvHr1Jia7zvE/ryKXMfn/tSIS2oCy94m0j/GI4RfELW+1mgRszr2RpDpJs2Vg90Mp
	Wj8GYbgjM4LJCcAZ8W/OSlr19c08IQvvFvEgiwnc2t6XrugzD6YtCnVZ9doLvsUvh5x72gy02NFpD
	BOO16HWFCYJhC9bOdxRgK8KD9wUWetNSICS3H9dCgODcj6j43rES1kOGMT1QcG7F8bjimKP96er58
	u3c/PARg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewe-00000004qFw-2tlq;
	Wed, 24 Apr 2024 15:54:04 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewV-00000004q3q-0N7z
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:59 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-41ab7cdccd2so11123175e9.1
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974031; x=1714578831; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vceqt7TifCou1HPRPnwqXwiyHcq6CY32UQFrKskdP68=;
        b=pjgVyfCac4CQl0oLccSztjyaLR/iOE+5MO8T+l8qJHy5RN2aTg2gLZtaVaWWbeHvbn
         hqlYcmVYbuu2rWhEYJ83hSFzro1gRbt3mnl4iy+FkskkCC+He8LNiH0AhDNUyWu6Ll49
         EqW10FhYv5J75UuXOd9VFd/EENwtaNO4Ds5EUZXYUzRH5dKjo620dR7F5oTxoFErXaIz
         jz4ncFBZ6zLmCx/hCJ9gpSE6FaTAj63CpxufDZ2uXbHRdFKdNQ2XiRSHVKYfYw6xl3VK
         J8OOzdCmAmLdAA/Ky2M8ZyI6lo4ahSfrmr8f+Xnq4CjFgvhwQIiiEQm0NBShvgXN+fQd
         cQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974031; x=1714578831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vceqt7TifCou1HPRPnwqXwiyHcq6CY32UQFrKskdP68=;
        b=bUnKG0HaSPBxurUGtNnprVfYDL8JITQ+kQ64VsbjkSmHk0sVrcs8m9KSl15To53kwt
         56+Ow63TFmJZHnR8cz2G7SggjwFriWTlWUv7vmFg7A/ak0AM3KqWwB9M27iuPbG/FJeR
         QlaArRwa0aKzesDX9F52r2Vs8jN5AWh2FlVFBFnbNwSz54d98X73aST9TEN/WU5bwWFJ
         J3M0RFRZGU6CzdFyrgzncHWQ+ng+SEsqpiEjUHYJwQAeQVuelZctbiKoXgSO5Oc0EWPD
         QhSydVHAOolmcDBX6Zt/LbqOTThvwH8pwpsjrTZrAVK/Fz7eBrUl7090i8aZr6TvXZl+
         3trQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvKOGd+WxEZG93v/OsyFzhGAf53MjoI/cumVaVNKx01+/O8iGO1gbhgxxXHb3N+EvmivCHdUsfzegYPFx0E7HLe0GkGFtfw+PE
X-Gm-Message-State: AOJu0YwuZmQZ1vkutzlwOSw3XMVohf/CjkX7kvYpAIPx79NsG+KBz3s3
	GU4je1tyW+qgPvc1zgmvdzVFjaqZDaQ98Gu4u5SG78YTGgg00sgix4jtjdtynFJTcqdoAA==
X-Google-Smtp-Source: AGHT+IEgIce6FPBXR6zGeN4ZV5e/jTyyGjrZ6o4ezBolJ8kjLZr2gRR3t4yw5Tk8N83KwMIeS+t+nCjf
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:fb01:0:b0:33d:5804:7f6e with SMTP id
 c1-20020adffb01000000b0033d58047f6emr11165wrr.4.1713974031332; Wed, 24 Apr
 2024 08:53:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:18 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=ardb@kernel.org;
 h=from:subject; bh=oIYWiPazWt0a3ZXKk6EjdN5wcBfWVZ3Z+EicqDLij6o=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T651wYZulH1f2qRa5GSoKb76+01Bdt6Vp4d3Zn+a3e
 suc8HLvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5fIyR4Wli15yznFPOrDh7
 WuK76io2sVyftOqDHJVuKmpSQuwT0xkZXs8/diLx6dm55mrHZe6/zJixP2mzo7iHFvchmVUzvhd sYAMA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-19-ardb+git@google.com>
Subject: [RFC PATCH 8/9] x86/purgatory: Simplify references to regs array
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085355_634478_59952EA8 
X-CRM114-Status: GOOD (  10.89  )
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

Use a single symbol reference and offset addressing to load the contents
of the register file from memory, instead of using a symbol reference
for each, which results in larger code and more ELF overhead. While at
it, rename the individual labels with an .L prefix so they are omitted
from the ELF symbol table.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/entry64.S | 67 ++++++++++----------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 3d09781d4f9a..56487fb7fa1d 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -37,45 +37,46 @@ SYM_CODE_START(entry64)
 new_cs_exit:
 
 	/* Load the registers */
-	movq	rax(%rip), %rax
-	movq	rbx(%rip), %rbx
-	movq	rcx(%rip), %rcx
-	movq	rdx(%rip), %rdx
-	movq	rsi(%rip), %rsi
-	movq	rdi(%rip), %rdi
-	movq	rbp(%rip), %rbp
-	movq	r8(%rip), %r8
-	movq	r9(%rip), %r9
-	movq	r10(%rip), %r10
-	movq	r11(%rip), %r11
-	movq	r12(%rip), %r12
-	movq	r13(%rip), %r13
-	movq	r14(%rip), %r14
-	movq	r15(%rip), %r15
+	leaq	entry64_regs(%rip), %r15
+	movq	0x00(%r15), %rax
+	movq	0x08(%r15), %rcx
+	movq	0x10(%r15), %rdx
+	movq	0x18(%r15), %rbx
+	movq	0x20(%r15), %rbp
+	movq	0x28(%r15), %rsi
+	movq	0x30(%r15), %rdi
+	movq	0x38(%r15), %r8
+	movq	0x40(%r15), %r9
+	movq	0x48(%r15), %r10
+	movq	0x50(%r15), %r11
+	movq	0x58(%r15), %r12
+	movq	0x60(%r15), %r13
+	movq	0x68(%r15), %r14
+	movq	0x70(%r15), %r15
 
 	/* Jump to the new code... */
-	jmpq	*rip(%rip)
+	jmpq	*.Lrip(%rip)
 SYM_CODE_END(entry64)
 
 	.section ".rodata"
-	.balign 4
+	.balign	8
 SYM_DATA_START(entry64_regs)
-rax:	.quad 0x0
-rcx:	.quad 0x0
-rdx:	.quad 0x0
-rbx:	.quad 0x0
-rbp:	.quad 0x0
-rsi:	.quad 0x0
-rdi:	.quad 0x0
-r8:	.quad 0x0
-r9:	.quad 0x0
-r10:	.quad 0x0
-r11:	.quad 0x0
-r12:	.quad 0x0
-r13:	.quad 0x0
-r14:	.quad 0x0
-r15:	.quad 0x0
-rip:	.quad 0x0
+.Lrax:	.quad	0x0
+.Lrcx:	.quad	0x0
+.Lrdx:	.quad	0x0
+.Lrbx:	.quad	0x0
+.Lrbp:	.quad	0x0
+.Lrsi:	.quad	0x0
+.Lrdi:	.quad	0x0
+.Lr8:	.quad	0x0
+.Lr9:	.quad	0x0
+.Lr10:	.quad	0x0
+.Lr11:	.quad	0x0
+.Lr12:	.quad	0x0
+.Lr13:	.quad	0x0
+.Lr14:	.quad	0x0
+.Lr15:	.quad	0x0
+.Lrip:	.quad	0x0
 SYM_DATA_END(entry64_regs)
 
 	/* GDT */
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
