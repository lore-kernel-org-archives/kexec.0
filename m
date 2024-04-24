Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D835C19F53
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IUJ4qjRDRChAWgNYEjQOkgAJcc/XzSyUqUsqXz8t7+8=; b=0Gwo+5u3BHU+GT6ZsaWRKblky6
	ZcU9dh7MKNRoi7dcfNw3fWwtAtp+wT5vKKRU2kOjtxa2EarJARU3jNoQHdPfdd12RAts9n3g78EtU
	4Jf4CoGlCd9I+xz4ELIyGitpYrxzO1Je8fgbki/+2TOSwTAjBNcdZpdkgwAsVphCKhhKbqbSHubnp
	Y4y5UYR3pBCk+m8qVWsSyqd4g5dJ/4g2fXrzUri9LklxiMYcqgSef7xoPSa77ABj08MtEbEiuYHOJ
	AuhjTfZ8Oge8fG0S/CWJDk1wVt9t9n0CbxcrgXSjB/YQIB35CIEL1scpunX25l2EWPhIo91XxtUTb
	h6raJNPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzfzc-000000053GC-02HT;
	Wed, 24 Apr 2024 17:01:12 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewR-00000004q1g-19WS
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:57 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-34a4ded7d49so6008689f8f.1
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974029; x=1714578829; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa45zJF/AbMRvdTbOV/4UEGhBCAI225hQ2s7T3i+Ooo=;
        b=IFFPVJOQBAqoHSMd8W1IPOFfTFb+SJ+9hH5Q6zGJ0ecuXVf3mrfRGaaYwefEFR2ekD
         CD1GIx+NQzoJaHq9M0+dzcm772qUTRab4nCsM5iYeks02H/PJWAKZ7ftsVE7tMYYoO7G
         rSQUZex0uu2Vbvb2wJw77oG9eXMmTs/hEPxeS+sktrgUCOZQnVmtqaEKOxT8o+VjTvoV
         bDhhVbus2Ksp5K5pOl2nkyO9RkufuSkg08zVO21DtHqn1mVMNzlJ33Zct+Sts7Q65vWB
         +6Iq1ip/2AZQiQIcp5MmL6r2wzzDmboDExe6yWDYwQUovTNaeFKrNoG2BFaq6dd96fOX
         GPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974029; x=1714578829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa45zJF/AbMRvdTbOV/4UEGhBCAI225hQ2s7T3i+Ooo=;
        b=o6D6y2jFmwGBVLLqjiNYr9eHdIzr9RZce7w7SM30Apt3OoK3lIBOGDUem+Nfxkxr8F
         xIsaZUKFpDe/B16AVMvisrgoMkmsclT/+OjR+L6Oqr93JsPvaKQAZugfI/JO2+T+SdTn
         qlC5jn9zEzSq/qutG92PTDoc5B0PN7n0aYuJlKc+ksIfQHKWUGsro5H1rnWSmjg5lnO7
         IiOOVy5Z22hzODQq/4jkr5P1GFxhRSMWS11VabQ2Mt5FD9cVUq37G8bsKvji3tcUuDYy
         0k7T1HmmUSUDvYdRW9gF6gqRxR+PrjTETlScPJw0rjTc9Vj5fURP9jimR1VHA2B6jciS
         50Pg==
X-Forwarded-Encrypted: i=1; AJvYcCULZHsruepnvx59192E85JMwORyeERrl8mC4/U+H7BmuppDbtuvvhC8kqLOCQFrnrGfqnQ4/WNsE/zlF/DUzPg4EM7XUAiQ1wz1
X-Gm-Message-State: AOJu0Yxd7QWeSsBw1pccIw8omPwILbrOVhQECmIM+3UcXTJGEqVzftFp
	dUPyN6cdllkcEDEyZCUK+enFMijdzaHmKH/I6+PqNvn49YkDU1Fn0UqgqDzzRDLCz4PEMw==
X-Google-Smtp-Source: AGHT+IGPDbNhL5NFJULZL4U66kpbV99fqZ3v34KTMJNmsTCednnzv3CzTgv4ww9xbt+KXw0b9m9aqo3Y
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:dd8a:0:b0:33e:75e5:693b with SMTP id
 x10-20020adfdd8a000000b0033e75e5693bmr8108wrl.9.1713974029215; Wed, 24 Apr
 2024 08:53:49 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:17 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6976; i=ardb@kernel.org;
 h=from:subject; bh=Xy7s/2+HI2gRh+BhIpznzNQEEi4VjcSVENS8njd99EU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T663HrbUJ9971T9u6b+OFpYuP+EVa5DmaaBhkcJe79
 Xo2LtnSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbiUsTIMH3l6Wvn90mZr1gt
 Lrvn5uqsM8sYLnx/WcRY5FS5neMlVwEjwyzJDIYTC4Ks2+67zf1ooX/kIN8M3/IQtym8aoUxxm+ 8mQA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-18-ardb+git@google.com>
Subject: [RFC PATCH 7/9] x86/purgatory: Use fully linked PIE ELF executable
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085351_558596_21ECAF19 
X-CRM114-Status: GOOD (  16.75  )
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

Now that the generic support is in place, switch to a fully linked PIE
ELF executable for the purgatory, so that it can be loaded as a single,
fully relocated image. This allows a lot of ugly post-processing logic
to simply be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/kexec.h       |   7 --
 arch/x86/kernel/machine_kexec_64.c | 127 --------------------
 arch/x86/purgatory/Makefile        |  14 +--
 3 files changed, 5 insertions(+), 143 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ee7b32565e5f..c7cacc2e9dfb 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -191,13 +191,6 @@ void arch_kexec_unprotect_crashkres(void);
 #define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 
 #ifdef CONFIG_KEXEC_FILE
-struct purgatory_info;
-int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-				     Elf_Shdr *section,
-				     const Elf_Shdr *relsec,
-				     const Elf_Shdr *symtab);
-#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
-
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index bc0a5348b4a6..ded924423e50 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -371,133 +371,6 @@ void machine_kexec(struct kimage *image)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-/*
- * Apply purgatory relocations.
- *
- * @pi:		Purgatory to be relocated.
- * @section:	Section relocations applying to.
- * @relsec:	Section containing RELAs.
- * @symtabsec:	Corresponding symtab.
- *
- * TODO: Some of the code belongs to generic code. Move that in kexec.c.
- */
-int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-				     Elf_Shdr *section, const Elf_Shdr *relsec,
-				     const Elf_Shdr *symtabsec)
-{
-	unsigned int i;
-	Elf64_Rela *rel;
-	Elf64_Sym *sym;
-	void *location;
-	unsigned long address, sec_base, value;
-	const char *strtab, *name, *shstrtab;
-	const Elf_Shdr *sechdrs;
-
-	/* String & section header string table */
-	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
-	strtab = (char *)pi->ehdr + sechdrs[symtabsec->sh_link].sh_offset;
-	shstrtab = (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_offset;
-
-	rel = (void *)pi->ehdr + relsec->sh_offset;
-
-	pr_debug("Applying relocate section %s to %u\n",
-		 shstrtab + relsec->sh_name, relsec->sh_info);
-
-	for (i = 0; i < relsec->sh_size / sizeof(*rel); i++) {
-
-		/*
-		 * rel[i].r_offset contains byte offset from beginning
-		 * of section to the storage unit affected.
-		 *
-		 * This is location to update. This is temporary buffer
-		 * where section is currently loaded. This will finally be
-		 * loaded to a different address later, pointed to by
-		 * ->sh_addr. kexec takes care of moving it
-		 *  (kexec_load_segment()).
-		 */
-		location = pi->purgatory_buf;
-		location += section->sh_offset;
-		location += rel[i].r_offset;
-
-		/* Final address of the location */
-		address = section->sh_addr + rel[i].r_offset;
-
-		/*
-		 * rel[i].r_info contains information about symbol table index
-		 * w.r.t which relocation must be made and type of relocation
-		 * to apply. ELF64_R_SYM() and ELF64_R_TYPE() macros get
-		 * these respectively.
-		 */
-		sym = (void *)pi->ehdr + symtabsec->sh_offset;
-		sym += ELF64_R_SYM(rel[i].r_info);
-
-		if (sym->st_name)
-			name = strtab + sym->st_name;
-		else
-			name = shstrtab + sechdrs[sym->st_shndx].sh_name;
-
-		pr_debug("Symbol: %s info: %02x shndx: %02x value=%llx size: %llx\n",
-			 name, sym->st_info, sym->st_shndx, sym->st_value,
-			 sym->st_size);
-
-		if (sym->st_shndx == SHN_UNDEF) {
-			pr_err("Undefined symbol: %s\n", name);
-			return -ENOEXEC;
-		}
-
-		if (sym->st_shndx == SHN_COMMON) {
-			pr_err("symbol '%s' in common section\n", name);
-			return -ENOEXEC;
-		}
-
-		if (sym->st_shndx == SHN_ABS)
-			sec_base = 0;
-		else if (sym->st_shndx >= pi->ehdr->e_shnum) {
-			pr_err("Invalid section %d for symbol %s\n",
-			       sym->st_shndx, name);
-			return -ENOEXEC;
-		} else
-			sec_base = pi->sechdrs[sym->st_shndx].sh_addr;
-
-		value = sym->st_value;
-		value += sec_base;
-		value += rel[i].r_addend;
-
-		switch (ELF64_R_TYPE(rel[i].r_info)) {
-		case R_X86_64_NONE:
-			break;
-		case R_X86_64_64:
-			*(u64 *)location = value;
-			break;
-		case R_X86_64_32:
-			*(u32 *)location = value;
-			if (value != *(u32 *)location)
-				goto overflow;
-			break;
-		case R_X86_64_32S:
-			*(s32 *)location = value;
-			if ((s64)value != *(s32 *)location)
-				goto overflow;
-			break;
-		case R_X86_64_PC32:
-		case R_X86_64_PLT32:
-			value -= (u64)address;
-			*(u32 *)location = value;
-			break;
-		default:
-			pr_err("Unknown rela relocation: %llu\n",
-			       ELF64_R_TYPE(rel[i].r_info));
-			return -ENOEXEC;
-		}
-	}
-	return 0;
-
-overflow:
-	pr_err("Overflow in relocation type %d value 0x%lx\n",
-	       (int)ELF64_R_TYPE(rel[i].r_info), value);
-	return -ENOEXEC;
-}
-
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
 	vfree(image->elf_headers);
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 2df4a4b70ff5..acc09799af2a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -26,12 +26,11 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
 # Drop the function entry padding, which is not needed here
 KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS),$(KBUILD_CFLAGS))
 
-# When linking purgatory.ro with -r unresolved symbols are not checked,
-# also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
-LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
-targets += purgatory.ro purgatory.chk
+PURGATORY_LDFLAGS += -T $(srctree)/include/asm-generic/purgatory.lds -pie
+PURGATORY_LDFLAGS += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
+LDFLAGS_purgatory.ro := $(PURGATORY_LDFLAGS)
+targets += purgatory.ro
 
 # Sanitizer, etc. runtimes are unavailable and cannot be linked here.
 GCOV_PROFILE	:= n
@@ -87,9 +86,6 @@ asflags-remove-y		+= $(foreach x, -g -gdwarf-4 -gdwarf-5, $(x) -Wa,$(x))
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
-$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
-		$(call if_changed,ld)
-
-$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro $(obj)/purgatory.chk
+$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro
 
 obj-y += kexec-purgatory.o
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
