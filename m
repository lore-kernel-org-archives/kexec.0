Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B51C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5Yqc6UqZAIRlpxAgIsEE8jyfEmROBy1zC/hHToap8HA=; b=gir
	Eq5c3bJKePvL3MZdFJ2mpu+BjaR8JDqtnWJEmerNfzq4DUbq8FToM6LDE1aB3gj4v9awZSOStR8Ma
	XsQ4MtvKeCzZA8O8xYalKPJJxJMzgoPEnPXS/5lwYU+hYr8cIC4NiDiOjPXck2pMpOOwadDYxhFPy
	SoZIGTH6uF3Z7/rOM0PcOkdHR97RoHCjBqD5tMfEHYHhiJ/RvviuvBOgarXdbsg/OKK2Ptadn7AkN
	Y60aTP+k4TTB6MB994WGlQex7Ms0YVPrsR8MnibpGE+JFAWoMFoFhf5ACQdgqqc0RYuyVrOZEBBHV
	DOR/4qlamsVSya7BToEpe25eA/wK+7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewE-00000004pro-1an0;
	Wed, 24 Apr 2024 15:53:38 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewB-00000004poe-1GrQ
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:36 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-34a49f5a6baso4727648f8f.3
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974013; x=1714578813; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qhjj4lZ1BD8EjRsdlA75QEwqazDOqFi5p2t0e/m1hPo=;
        b=U5efMMrYC9BZXoWvToe1CGWnaZpaepqqL5QDEdLjLuLrs/eoRfVhZzXfkXHX52u/ri
         fLg2pqB7locRhl9C3YZBowNGHqadlSx1UTqkjkoLfHTBuKjoHdDreL9TM8ZvXF7ZYIkh
         370GDSwGlmQobAp3da+6m59Ebp4gviQqtAZZn1VxfhcovNCduLHYqV00OFInTJTu4P/z
         qgvgdugrpwY94isDHeMY+Ae0pgcOZb4S4V2Ct7h26MsU1xRGiRmAFVedj6ZD4NrPBX2d
         XdzAUJTPRbUnOhb/LI+Idf1uxkdMI/gMTrmSQ1MacfjHYIc1DgsVv3F1eXEV0Fqw7I3i
         2V4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974013; x=1714578813;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhjj4lZ1BD8EjRsdlA75QEwqazDOqFi5p2t0e/m1hPo=;
        b=jJBsHN+EfkjH3WCxMKYJhexlVbO81zO/1OFKyVQTRwC7gPQUnFlycWqXT33FWUWVM1
         t4adz94VwcH3vhZvMa12O6ZUBOWhf80cEm5GPICnPsDW2dMCjJtSTzHu7gDgd9bFiWfD
         R2CnwHkMwY6IK75IKwtn5Yb4/Mt6a8w1BDRRGZIxsFVEEBt5Zz4NPHvhaJ2u9zd6Z5Kj
         L87GspYaJWm6HXmtCZxMJD1KiFqUBMBJ3YkT3KyNtKq508jWO1RHpz8cx6Jdx2bij92z
         VwtrQ2uUduZ+oxgaV/EO9kVNueS9KnYIngmnMzPxPqEdMc1zgewXXlwseDZNpzKt65fT
         WG1g==
X-Forwarded-Encrypted: i=1; AJvYcCWE107Tz7j3OcBdGJvVm7lWz+WosIN11uKcowhks4NqFR96aJAg6i/J6Z7eiGdPwYX3zpjj27CMSUlPQ9k/Ly1CN0UHc4yCfrlI
X-Gm-Message-State: AOJu0YypoOx5U2vGiCwqqDnj8xHeh4TafTbAsnzRkajC7dCxglRhIEYn
	fHIa9HajnCqveXrytRAGl39W7+OG3bgiyjGKIHWVWr/HwTC543oa5HPVAR9bo3o6Hfba9A==
X-Google-Smtp-Source: AGHT+IHa58cnUIBreoWbfABwf39S/95YKEcQ+NiYVIhE+uBa5KCrBaMAwHWrFcCcQQ5CDkGU5MRf5zbb
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4689:0:b0:33e:d448:987d with SMTP id
 u9-20020a5d4689000000b0033ed448987dmr10048wrq.6.1713974012466; Wed, 24 Apr
 2024 08:53:32 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:10 +0200
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265; i=ardb@kernel.org;
 h=from:subject; bh=idgDjYiAKHOsQh6BKM4ksIPor6eEyvMhl8OTBBlOdlM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T62nHZLEFLnn/7goFXZk7X0zg32aVqSkSCrp9mx0CW
 iq9Nq/sKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZ/JuR4aWxdVvw7dwFEfua
 V5SfUPZ+VSsleLNLaYHDFdfAyz+alzMy3G/ST9E741D48UDWgZrsN1vdT0290aCf+NZ+VqXi3u0 NnAA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-11-ardb+git@google.com>
Subject: [RFC PATCH 0/9] kexec x86 purgatory cleanup
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085335_371881_C29A606F 
X-CRM114-Status: GOOD (  16.91  )
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

The kexec purgatory is built like a kernel module, i.e., a partially
linked ELF object where each section is allocated and placed
individually, and all relocations need to be fixed up, even place
relative ones.

This makes sense for kernel modules, which share the address space with
the core kernel, and contain unresolved references that need to be wired
up to symbols in other modules or the kernel itself.

The purgatory, however, is a fully linked binary without any external
references, or any overlap with the kernel's virtual address space. So
it makes much more sense to create a fully linked ELF executable that
can just be loaded and run anywhere in memory.

The purgatory build on x86 has already switched over to position
independent codegen, which only leaves a handful of absolute references,
which can either be dropped (patch #3) or converted into a RIP-relative
one (patch #4). That leaves a purgatory executable that can run at any
offset in memory with applying any relocations whatsoever.

Some tweaks are needed to deal with the difference between partially
(ET_REL) and fully (ET_DYN/ET_EXEC) linked ELF objects, but with those
in place, a substantial amount of complicated ELF allocation, placement
and patching/relocation code can simply be dropped.

The last patch in the series removes this code from the generic kexec
implementation, but this can only be done once other architectures apply
the same changes proposed here for x86 (powerpc, s390 and riscv all
implement the purgatory using the shared logic)

Link: https://lore.kernel.org/all/CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com/
Link: https://lore.kernel.org/all/20240418201705.3673200-2-ardb+git@google.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>

Ard Biesheuvel (9):
  x86/purgatory: Drop function entry padding from purgatory
  x86/purgatory: Simplify stack handling
  x86/purgatory: Drop pointless GDT switch
  x86/purgatory: Avoid absolute reference to GDT
  x86/purgatory: Simplify GDT and drop data segment
  kexec: Add support for fully linked purgatory executables
  x86/purgatory: Use fully linked PIE ELF executable
  x86/purgatory: Simplify references to regs array
  kexec: Drop support for partially linked purgatory executables

 arch/x86/include/asm/kexec.h       |   8 -
 arch/x86/kernel/kexec-bzimage64.c  |   8 -
 arch/x86/kernel/machine_kexec_64.c | 127 ----------
 arch/x86/purgatory/Makefile        |  17 +-
 arch/x86/purgatory/entry64.S       |  96 ++++----
 arch/x86/purgatory/setup-x86_64.S  |  31 +--
 arch/x86/purgatory/stack.S         |  18 --
 include/asm-generic/purgatory.lds  |  34 +++
 kernel/kexec_file.c                | 255 +++-----------------
 9 files changed, 125 insertions(+), 469 deletions(-)
 delete mode 100644 arch/x86/purgatory/stack.S
 create mode 100644 include/asm-generic/purgatory.lds

-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
