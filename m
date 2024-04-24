Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E409C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DNpSAR8AxUPj8L51cIsieMh2Hl9zlY8AZCLrqdTyxuI=; b=qTgozKnplBOgAXVVE2jPmQEGK5
	xzXWnoYfR79/2UaxWaTqtPbuVr5ron5v3xW7OeAS4GJt5IdQ1ibDGG2++xvYlOOK8QjgXBoN3MWQ8
	/0ab+TVQXeZ2itSMCjHMFmQo6mZdaA9rJtHMyT7IE/P+Uas1IQL6WAdcWzAaRs8yA/+jvABmQuGSP
	IWQKSWPvoa6MpJPHiJH2R4mznbqMNvRJWZrbE5b0EZMYKkldFg/fUg942uml/6atWsojTC3384Icj
	eHpJRjosEvdBHjLG9Xs/BmTKYGzWbGAaM2bxf6EGBiqlZ++stSy/chKVWhlWYZkB6Ns07nh2cNtCU
	b7PZZS6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewS-00000004q4f-337Z;
	Wed, 24 Apr 2024 15:53:52 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewO-00000004pzV-1aDx
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:53:50 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so1465605276.1
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974027; x=1714578827; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEfb48Zw4FzaI31A4Yvo9b2JQcLeZ9Sid/iFgPsmsBc=;
        b=pl347uOa4iBh6Y6E54ssaOBibeDdjAPW4p0Rtidmp/RbwDBe/p/dHwxfFPTBWk8DOm
         jX0/Xy8VK1rkRkSeWEjKzJUBdvOqWa3jpUi+Ayp25Js9LuJzKCXnEDzlhNC5d7OKT8r1
         XX73ZkIdjRPIGsVVKviNj79uS55Ci1eRKRkOm2oI6iwFUNGYIgPhDPFaNHzkS6EunPlJ
         DCXWoU5yKdFjf2tdvemzlKbkiBWtwRem0NK6CHcc55D7jhHLy/kgtTMMqU9CbWkhnLCa
         he7ldvX9rCMcx41wugkh9ZI+RK/b49o7bSVTUfMtbJaOOAdrqMq06CncPoKH/qRSbGXm
         3VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974027; x=1714578827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEfb48Zw4FzaI31A4Yvo9b2JQcLeZ9Sid/iFgPsmsBc=;
        b=j5XlRkleuEzPzQYQ9X7sfL6CN0RLyfbEP3133ubvMgbGvapUpKmindCz88VSY/MyDE
         4jfS5ugIJ4ESHb0G8FnjlU5CT8GqEQdwY/I7tpDaTvrpTqE7pIiDh7D7f9ZhQx8UExe3
         9PHnucchAMrZ0Rj9ejHz1uP+LgJYofQhhZspy72UfCJ8xHLqyqdpZGZm7wV0rI4aPd4D
         huotJCgdKCZWZI0lSZHv/hWUYggu1569v8fM++2jKqKTZky/aRXTzcNdSx1X7TIhYFcu
         o3vI5bSPDUI44Ts/lUMXUqLrOJegQWIU5SHii6n2V702J59OnvTFVR9N0efR0KOh65oe
         5ceg==
X-Forwarded-Encrypted: i=1; AJvYcCVfqnEemOLx86cFZNZhW0PXyIPszvyzatQK3+CnpSx0jShpd53+Yg7I1M6tL2I3jc58YBef6Q6G+y8Us27DprnrRCV4MJUEZyTf
X-Gm-Message-State: AOJu0YyPjlhcol1n0Q7e5vELCKI0V7iEITLHXMktFZzuPCPvdTCXW5+f
	fUcG9BQ7xHAHX065VkuNSEIr6gIVxWwVepVIzA3Rt0Z+tDnznzAfJqh2rLvFYaPhOHKlOw==
X-Google-Smtp-Source: AGHT+IHbg4wJywEqzUt2+8hQS3ObQVSgRyNrAL3sr6Ik+6p7Atan3Jg90qVh+XsYqwBQa0qziPF/Vb/1
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:c789:0:b0:dc6:b7c2:176e with SMTP id
 w131-20020a25c789000000b00dc6b7c2176emr4995ybe.4.1713974026968; Wed, 24 Apr
 2024 08:53:46 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:16 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5039; i=ardb@kernel.org;
 h=from:subject; bh=KbB2fMI6RaaNb9qTs1/na+POkGeoOZURr4jcCaqB+Qw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T682aCbcVWayP97etXvKAe1Jmc/WfuFq7S1nTRTJ6I
 l8KH37YUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYS3sbIMD2FX52rem5U7pXq
 ytRHu2telH5M9vvg/i9Rb8nzrNCCIIb//kdzNfTuXL6vFdr7TXl/9bSzqhs+GpQ9eRf68MvGBJ4 +fgA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-17-ardb+git@google.com>
Subject: [RFC PATCH 6/9] kexec: Add support for fully linked purgatory executables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085348_565499_E4F0DFF9 
X-CRM114-Status: GOOD (  22.09  )
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

The purgatory ELF object is typically a partially linked object, which
puts the burden on the kexec loader to lay out the executable in memory,
and this involves (among other things) deciding the placement of the
sections in memory, and fixing up all relocations (relative and absolute
ones)

All of this can be greatly simplified by using a fully linked PIE ELF
executable instead, constructed in a way that removes the need for any
relocation processing or layout and allocation of individual sections.

By gathering all allocatable sections into a single PT_LOAD segment, and
relying on RIP-relative references, all relocations will be applied by
the linker, and the segment simply needs to be copied into memory.

So add a linker script and some minimal handling in generic code, which
can be used by architectures to opt into this approach. This will be
wired up for x86 in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/purgatory.lds | 34 ++++++++++
 kernel/kexec_file.c               | 68 +++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/purgatory.lds b/include/asm-generic/purgatory.lds
new file mode 100644
index 000000000000..260c457f7608
--- /dev/null
+++ b/include/asm-generic/purgatory.lds
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+PHDRS
+{
+	text PT_LOAD FLAGS(7) FILEHDR PHDRS;
+}
+
+SECTIONS
+{
+	. = SIZEOF_HEADERS;
+
+	.text : {
+		*(.text .rodata* .kexec-purgatory .data*)
+	} :text
+
+	.bss : {
+		*(.bss .dynbss)
+	} :text
+
+	.rela.dyn : {
+		*(.rela.*)
+	}
+
+	.symtab 0 : { *(.symtab) }
+	.strtab 0 : { *(.strtab) }
+	.shstrtab 0 : { *(.shstrtab) }
+
+	/DISCARD/ : {
+		*(.interp .modinfo .dynsym .dynstr .hash .gnu.* .dynamic .comment)
+		*(.got .plt .got.plt .plt.got .note.* .eh_frame .sframe)
+	}
+}
+
+ASSERT(SIZEOF(.rela.dyn) == 0, "Absolute relocations detected");
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bef2f6f2571b..6379f8dfc29f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1010,6 +1010,62 @@ static int kexec_apply_relocations(struct kimage *image)
 	return 0;
 }
 
+/*
+ * kexec_load_purgatory_pie - Load the position independent purgatory object.
+ * @pi:		Purgatory info struct.
+ * @kbuf:	Memory parameters to use.
+ *
+ * Load a purgatory PIE executable. This is a fully linked executable
+ * consisting of a single PT_LOAD segment that does not require any relocation
+ * processing.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int kexec_load_purgatory_pie(struct purgatory_info *pi,
+				    struct kexec_buf *kbuf)
+{
+	const Elf_Phdr *phdr = (void *)pi->ehdr + pi->ehdr->e_phoff;
+	int ret;
+
+	if (pi->ehdr->e_phnum != 1)
+		return -EINVAL;
+
+	kbuf->bufsz = phdr->p_filesz;
+	kbuf->memsz = phdr->p_memsz;
+	kbuf->buf_align = phdr->p_align;
+
+	kbuf->buffer = vzalloc(kbuf->bufsz);
+	if (!kbuf->buffer)
+		return -ENOMEM;
+
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		goto out_free_kbuf;
+
+	kbuf->image->start = kbuf->mem + pi->ehdr->e_entry;
+
+	pi->sechdrs = vcalloc(pi->ehdr->e_shnum, pi->ehdr->e_shentsize);
+	if (!pi->sechdrs)
+		goto out_free_kbuf;
+
+	pi->purgatory_buf = memcpy(kbuf->buffer,
+				   (void *)pi->ehdr + phdr->p_offset,
+				   kbuf->bufsz);
+
+	memcpy(pi->sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
+	       pi->ehdr->e_shnum * pi->ehdr->e_shentsize);
+
+	for (int i = 0; i < pi->ehdr->e_shnum; i++)
+		if (pi->sechdrs[i].sh_flags & SHF_ALLOC)
+			pi->sechdrs[i].sh_addr += kbuf->mem;
+
+	return 0;
+
+out_free_kbuf:
+	vfree(kbuf->buffer);
+	return ret;
+}
+
 /*
  * kexec_load_purgatory - Load and relocate the purgatory object.
  * @image:	Image to add the purgatory to.
@@ -1031,6 +1087,9 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 
 	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 
+	if (pi->ehdr->e_type != ET_REL)
+		return kexec_load_purgatory_pie(pi, kbuf);
+
 	ret = kexec_purgatory_setup_kbuf(pi, kbuf);
 	if (ret)
 		return ret;
@@ -1087,7 +1146,8 @@ static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 
 		/* Go through symbols for a match */
 		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
-			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+			if (pi->ehdr->e_type == ET_REL &&
+			    ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
 				continue;
 
 			if (strcmp(strtab + syms[k].st_name, name) != 0)
@@ -1159,6 +1219,12 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	sym_buf = (char *)pi->purgatory_buf + sec->sh_offset + sym->st_value;
 
+	if (pi->ehdr->e_type != ET_REL) {
+		const Elf_Shdr *shdr = (void *)pi->ehdr + pi->ehdr->e_shoff;
+
+		sym_buf -= shdr[sym->st_shndx].sh_addr;
+	}
+
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
 	else
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
