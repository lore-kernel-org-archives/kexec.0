Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04750C10F15
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5esV0WWbx31/am1Fp+RuWbivEk615d/sTCWvi5/ysDc=; b=yFTX4Mrw/EGYfH2K8FIbrWbdRs
	mEEWG5jEzkLrxeX1Ajl5qzz0/Jyuu+7FY1HvIoH3U0DFgzjAt/leZizYabmnMn0RW/zHtJEJSCZLj
	/bgWEhzBQE6ZRLPdv9VZ+0A2c/GyPWdDsqSWI8CmtjVO28hcgS2RY/TBbXVL76rdXnC7cBBsdv3ag
	SfOZVxLVHn0POt3yx9qJaxa2Iefv6TSOdhBs2kUsWUB+zjhkfoUkytC0dwZvz54ZJse5Lv9JplBft
	OSH2ldGgYQPn3o211jQJa1SejbIn2U5LowvGjmy5EftEOqrCSzaIHg/3/OMEwVyYQR7TvlEpf90MJ
	aEtwUUkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewF-00000004psE-2BQc;
	Wed, 24 Apr 2024 15:53:39 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewC-00000004pqB-32iV
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:38 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-34bb415008bso687416f8f.3
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974015; x=1714578815; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlS0+cvMo5zMRt+lvNzaEDG8xl2twGLOFdcuQLafjaw=;
        b=JsPeUCTjzBWUkwo0sDF6AgyMQizMoyAIZDWZyogxNWO8JEKxUMiCWxrKI/fdP3H21U
         MfF6/2PiiTDbdv8ulxESUFt+vsNMWUOtSIY6z9z3U6t9TlK+N3FuFGPdrHRm3Sb+4yYl
         wqouK1N6e+gMO64IfvTgqkbN8dQJd0J+SEWk7OAV7pnrXbIXTyKgFSHuN/Dpe3W/P/Eg
         phVy9aavSIp9Fq5BEfay2c0AO804Y5qh3OUgoY3x9wHRwfVUoXEVfu3NAGPzl25HoIm3
         h2LSGUAgWaYGN1DKKu0fFpfBRUYNmdqFF8f/ppe8HNme6pEBWvsELZcVYkK8tYg5T+bT
         +3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974015; x=1714578815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlS0+cvMo5zMRt+lvNzaEDG8xl2twGLOFdcuQLafjaw=;
        b=VaLzSqOM8BbLPBgxQY/+jPj9a5DFMkYxhmVxUKYoHLhmyXrfTcMG3iayjzWGMr76Tu
         fEcQFwKLkAbWQIS0DqapAYSwudNTDu0x20HAf5GpZrQXLY2cxhbwIVL6Fy9THsruf8pl
         YP7/2eEAaRaYL9/CLo6NagB9o4E0mWh0Zi7K3WP8jREAO+Kn9n+lDnzv77D+DvYUAZLk
         SKnkH65VNl6KhTQ5ebCc0vPPGNMUxgM3xu8Ud9DGXRPMxGvzvKF3ImMdizVSaM0wn8yN
         67bEpEbneU1UZfm+nmdlOYDlczJKfVzBQjYPIVCG80rxmPAxlfcxppRCpwbNBHzvwDzl
         zb7A==
X-Forwarded-Encrypted: i=1; AJvYcCW1w+pYgWIN43wOWGTSi+3dZzOwMRKwUtE8p8Bz2ty3JzP2tFS0b2ZKkVnubMTzPnXWo6hAC7N5xOAfBFp8TQVS1/wqfuQ+Hm+7
X-Gm-Message-State: AOJu0YxZa7l8iLv/X3uLv0j5gLdZ7uMJsZ5EwGxyjToPGYtwkIgRDAaj
	zfMss1TOV8+y/0t1uIaM628gRPeVHIC9XHfgXV8UKuUUVO+mduHaqbcNZ5RbLtuL23KpwQ==
X-Google-Smtp-Source: AGHT+IGdReIKcVqTmsjuDAVslzZAccKtLHNzyXx0qgTd2rLJHThwDcZZRtw1DQYovTmom98A66XiByap
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:781:b0:34b:dc21:68ec with SMTP id
 bu1-20020a056000078100b0034bdc2168ecmr4901wrb.9.1713974015005; Wed, 24 Apr
 2024 08:53:35 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:11 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=ardb@kernel.org;
 h=from:subject; bh=2ikJfd8f4pAURymCVR9go150qMtXp0OQeEdxwp9Wypg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T65ntYp8TdyL5pxwV/ZH44NfCqh3aAYlC7p0TOo/Zr
 3Htk2XuKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNJjGD4796iLXfp1vWmuawZ
 nVd9znufiuq/0XBxdihjRND1SpWLhxgZLvifCrg22y3+17RYH94fXbuTQtMSwr5/F7jEnxZ9z/k aMwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-12-ardb+git@google.com>
Subject: [RFC PATCH 1/9] x86/purgatory: Drop function entry padding from purgatory
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085336_809029_6448947A 
X-CRM114-Status: GOOD (  10.69  )
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

The purgatory is a completely separate ELF executable carried inside the
kernel as an opaque binary blob. This means that function entry padding
and the associated ELF metadata are not exposed to the branch tracking
and code patching machinery, and can there be dropped from the purgatory
binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index a18591f6e6d9..2df4a4b70ff5 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -23,6 +23,9 @@ KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CF
 # by kexec. Remove -flto=* flags.
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
 
+# Drop the function entry padding, which is not needed here
+KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
