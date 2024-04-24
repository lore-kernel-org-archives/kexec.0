Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F231BC4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bQscPp0QfDIqv/DisCDUcbh3wE3wFA361qpi0Vbhl3Y=; b=uyPB93zP79GH8PMq1W+4W5ymVZ
	wMNgXGEbxIcNeHKpof6L3AWb6JIPGorID1YwlSHvZ2Wuz1THHXt4WPnSm7T9nkl7v63CHcBmGwowk
	4dBWx96dvTSFe2sH13P6rUbEFPJ2MSqUsdb2Sp1i8ba0xPe/QsSTPirsujGbka0mxW0wiusU15+eA
	cpICrseiwtdk1G9HOCIoWoRFCyPSeTRocDO6y/qkgU3HrGUvNK1POkKkHbCcVUClTFOGHLs4HvMQw
	dqx8aDPAeRZswAT7UoRKBJV6FpXRwnVOiN447ahqzCysiHDxCMLJsjMBtL4iO4NelxTghirfdqexK
	qQicNY2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewi-00000004qIF-06i2;
	Wed, 24 Apr 2024 15:54:08 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzewV-00000004q5n-31Hs
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 15:54:02 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-343f5059c5fso4592029f8f.2
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974033; x=1714578833; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vx6XnSqF1Kz2IsX9yxzKAYxIyEUUs8kiNXLrQoQM9lM=;
        b=HFTg4NKW96W+V18WogbAOhFwVVTavaJV5oNHcYsjT0VNxkInbSFVUxLwiLJqj5y4nk
         0FYVCbJsGmuwh3LtZbsIhA4JL6NiLxuKIBVFYFR7AyMJMS+YmfmnyvUAX1FpSR10J2o4
         4apuqvfMCs/BP4ATYGfdT4fHf3AXfX2x9JbdyyJYwPkD/IOAu1YrLdGQkbBkXKVA+93Z
         SSs2erW99WIOnyQupQufH2LE4gG82QLIl+mK+c3l89WwTaGBEr9Z3jdvRwQk3VNyusZ1
         U4yNzIR5rGm7+Da6R/ZtTAoGQp67wieQhgRYtgLxhjC5lP/zEHZUYGxRdJb30N5wNXVm
         ywrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974033; x=1714578833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vx6XnSqF1Kz2IsX9yxzKAYxIyEUUs8kiNXLrQoQM9lM=;
        b=cP3VDiT2iR+objq8F8rMIjpvJsogZvq3l7dz/i1VoFSDsIR9KmSCGHzbQAYlu+qt/w
         82rEvdODmQoDQ36EOwulH1iP8YBGcENGuTLH2PDv4CfNMA1oNt99nnCqeK41JPBHogxj
         auxWL9vXJq3c9864S2+xY3JynDmFYwZG++YlHAPe6Uf4awdFjmA6UdAz1MueG/RsVbdT
         95cKrPulP7gVYAliDw+F6SizbVFfArgBnp2ZcSRbN9AlIzLMlfdFxquk9GLfmWsakEX2
         PpKgvYol8DKK/0U23xara4ptZgZ3l9Coqw0T2LMw3T3KckcFVJLNj8u9lZbUmmOq3J5A
         V9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUpehhpUNKPFg/R1ZqlZZKXMPeTG9LTrHq2pPr+wU2BQlQaNuEDy62cqTUYrFnf89rCOdPsPjIPYlfvlKC5cnRD3LMhnTOYOMdc
X-Gm-Message-State: AOJu0YwpwldwljaFc8XoGMBz189lMModhdPTxmUZS72Ex1VA+NrlBs2F
	11nUnSw9PfziJrvKZ1MltlW2vPTYgWbI8vgsbq+ZJtwlKWqBN5niE9v+CpxOCak1vylw2w==
X-Google-Smtp-Source: AGHT+IEAw+x687kZdSsqQxNNZ4oSNk26SZm4X/GaIroPEpe6v9Zhf+oDF0wkctwNqpKcENKbKDTRHVrO
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:44c8:0:b0:346:aee6:d2a6 with SMTP id
 z8-20020a5d44c8000000b00346aee6d2a6mr9419wrr.12.1713974033489; Wed, 24 Apr
 2024 08:53:53 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:19 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9229; i=ardb@kernel.org;
 h=from:subject; bh=wGoJfBQak6AeMag7lP1HCofCwaJfihP0rQ/I/VLLrnA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T6/3kbMFIkdytJRcLLnhwKgmJRLhvjv6xOEXKvPFu7
 m5H1p8dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCL9qQz/fdY6Xk4zZ8s+E5Gv
 uZIpRtH/uO/cxuP8y56UiHZFhsw7xchwSnCKeMZt8XMRBhKenxY+nleZP6Vl31HVuZF/Tky6v9m HGQA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-20-ardb+git@google.com>
Subject: [RFC PATCH 9/9] kexec: Drop support for partially linked purgatory executables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_085356_240546_9FA81B72 
X-CRM114-Status: GOOD (  23.55  )
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

Remove the handling of purgatories that are allocated, loaded and
relocated as individual ELF sections, which requires a lot of
post-processing on the part of the kexec loader. This has been
superseded by the use of fully linked PIE executables, which do not
require such post-processing.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 kernel/kexec_file.c | 271 +-------------------
 1 file changed, 14 insertions(+), 257 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 6379f8dfc29f..782a1247558c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -808,228 +808,31 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 /*
- * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
- * @pi:		Purgatory to be loaded.
- * @kbuf:	Buffer to setup.
- *
- * Allocates the memory needed for the buffer. Caller is responsible to free
- * the memory after use.
- *
- * Return: 0 on success, negative errno on error.
- */
-static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
-				      struct kexec_buf *kbuf)
-{
-	const Elf_Shdr *sechdrs;
-	unsigned long bss_align;
-	unsigned long bss_sz;
-	unsigned long align;
-	int i, ret;
-
-	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
-	kbuf->buf_align = bss_align = 1;
-	kbuf->bufsz = bss_sz = 0;
-
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			if (kbuf->buf_align < align)
-				kbuf->buf_align = align;
-			kbuf->bufsz = ALIGN(kbuf->bufsz, align);
-			kbuf->bufsz += sechdrs[i].sh_size;
-		} else {
-			if (bss_align < align)
-				bss_align = align;
-			bss_sz = ALIGN(bss_sz, align);
-			bss_sz += sechdrs[i].sh_size;
-		}
-	}
-	kbuf->bufsz = ALIGN(kbuf->bufsz, bss_align);
-	kbuf->memsz = kbuf->bufsz + bss_sz;
-	if (kbuf->buf_align < bss_align)
-		kbuf->buf_align = bss_align;
-
-	kbuf->buffer = vzalloc(kbuf->bufsz);
-	if (!kbuf->buffer)
-		return -ENOMEM;
-	pi->purgatory_buf = kbuf->buffer;
-
-	ret = kexec_add_buffer(kbuf);
-	if (ret)
-		goto out;
-
-	return 0;
-out:
-	vfree(pi->purgatory_buf);
-	pi->purgatory_buf = NULL;
-	return ret;
-}
-
-/*
- * kexec_purgatory_setup_sechdrs - prepares the pi->sechdrs buffer.
- * @pi:		Purgatory to be loaded.
- * @kbuf:	Buffer prepared to store purgatory.
- *
- * Allocates the memory needed for the buffer. Caller is responsible to free
- * the memory after use.
- *
- * Return: 0 on success, negative errno on error.
- */
-static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
-					 struct kexec_buf *kbuf)
-{
-	unsigned long bss_addr;
-	unsigned long offset;
-	size_t sechdrs_size;
-	Elf_Shdr *sechdrs;
-	int i;
-
-	/*
-	 * The section headers in kexec_purgatory are read-only. In order to
-	 * have them modifiable make a temporary copy.
-	 */
-	sechdrs_size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
-	sechdrs = vzalloc(sechdrs_size);
-	if (!sechdrs)
-		return -ENOMEM;
-	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, sechdrs_size);
-	pi->sechdrs = sechdrs;
-
-	offset = 0;
-	bss_addr = kbuf->mem + kbuf->bufsz;
-	kbuf->image->start = pi->ehdr->e_entry;
-
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		unsigned long align;
-		void *src, *dst;
-
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type == SHT_NOBITS) {
-			bss_addr = ALIGN(bss_addr, align);
-			sechdrs[i].sh_addr = bss_addr;
-			bss_addr += sechdrs[i].sh_size;
-			continue;
-		}
-
-		offset = ALIGN(offset, align);
-
-		/*
-		 * Check if the segment contains the entry point, if so,
-		 * calculate the value of image->start based on it.
-		 * If the compiler has produced more than one .text section
-		 * (Eg: .text.hot), they are generally after the main .text
-		 * section, and they shall not be used to calculate
-		 * image->start. So do not re-calculate image->start if it
-		 * is not set to the initial value, and warn the user so they
-		 * have a chance to fix their purgatory's linker script.
-		 */
-		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
-		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
-		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size) &&
-		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
-			kbuf->image->start -= sechdrs[i].sh_addr;
-			kbuf->image->start += kbuf->mem + offset;
-		}
-
-		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
-		dst = pi->purgatory_buf + offset;
-		memcpy(dst, src, sechdrs[i].sh_size);
-
-		sechdrs[i].sh_addr = kbuf->mem + offset;
-		sechdrs[i].sh_offset = offset;
-		offset += sechdrs[i].sh_size;
-	}
-
-	return 0;
-}
-
-static int kexec_apply_relocations(struct kimage *image)
-{
-	int i, ret;
-	struct purgatory_info *pi = &image->purgatory_info;
-	const Elf_Shdr *sechdrs;
-
-	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
-
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		const Elf_Shdr *relsec;
-		const Elf_Shdr *symtab;
-		Elf_Shdr *section;
-
-		relsec = sechdrs + i;
-
-		if (relsec->sh_type != SHT_RELA &&
-		    relsec->sh_type != SHT_REL)
-			continue;
-
-		/*
-		 * For section of type SHT_RELA/SHT_REL,
-		 * ->sh_link contains section header index of associated
-		 * symbol table. And ->sh_info contains section header
-		 * index of section to which relocations apply.
-		 */
-		if (relsec->sh_info >= pi->ehdr->e_shnum ||
-		    relsec->sh_link >= pi->ehdr->e_shnum)
-			return -ENOEXEC;
-
-		section = pi->sechdrs + relsec->sh_info;
-		symtab = sechdrs + relsec->sh_link;
-
-		if (!(section->sh_flags & SHF_ALLOC))
-			continue;
-
-		/*
-		 * symtab->sh_link contain section header index of associated
-		 * string table.
-		 */
-		if (symtab->sh_link >= pi->ehdr->e_shnum)
-			/* Invalid section number? */
-			continue;
-
-		/*
-		 * Respective architecture needs to provide support for applying
-		 * relocations of type SHT_RELA/SHT_REL.
-		 */
-		if (relsec->sh_type == SHT_RELA)
-			ret = arch_kexec_apply_relocations_add(pi, section,
-							       relsec, symtab);
-		else if (relsec->sh_type == SHT_REL)
-			ret = arch_kexec_apply_relocations(pi, section,
-							   relsec, symtab);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-/*
- * kexec_load_purgatory_pie - Load the position independent purgatory object.
- * @pi:		Purgatory info struct.
+ * kexec_load_purgatory - Load and relocate the purgatory object.
+ * @image:	Image to add the purgatory to.
  * @kbuf:	Memory parameters to use.
  *
- * Load a purgatory PIE executable. This is a fully linked executable
- * consisting of a single PT_LOAD segment that does not require any relocation
- * processing.
+ * Allocates the memory needed for image->purgatory_info.sechdrs and
+ * image->purgatory_info.purgatory_buf/kbuf->buffer. Caller is responsible
+ * to free the memory after use.
  *
  * Return: 0 on success, negative errno on error.
  */
-static int kexec_load_purgatory_pie(struct purgatory_info *pi,
-				    struct kexec_buf *kbuf)
+int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 {
-	const Elf_Phdr *phdr = (void *)pi->ehdr + pi->ehdr->e_phoff;
+	struct purgatory_info *pi = &image->purgatory_info;
+	const Elf_Phdr *phdr;
 	int ret;
 
+	if (kexec_purgatory_size <= 0)
+		return -EINVAL;
+
+	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 	if (pi->ehdr->e_phnum != 1)
 		return -EINVAL;
 
+	phdr = (void *)pi->ehdr + pi->ehdr->e_phoff;
+
 	kbuf->bufsz = phdr->p_filesz;
 	kbuf->memsz = phdr->p_memsz;
 	kbuf->buf_align = phdr->p_align;
@@ -1066,52 +869,6 @@ static int kexec_load_purgatory_pie(struct purgatory_info *pi,
 	return ret;
 }
 
-/*
- * kexec_load_purgatory - Load and relocate the purgatory object.
- * @image:	Image to add the purgatory to.
- * @kbuf:	Memory parameters to use.
- *
- * Allocates the memory needed for image->purgatory_info.sechdrs and
- * image->purgatory_info.purgatory_buf/kbuf->buffer. Caller is responsible
- * to free the memory after use.
- *
- * Return: 0 on success, negative errno on error.
- */
-int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
-{
-	struct purgatory_info *pi = &image->purgatory_info;
-	int ret;
-
-	if (kexec_purgatory_size <= 0)
-		return -EINVAL;
-
-	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
-
-	if (pi->ehdr->e_type != ET_REL)
-		return kexec_load_purgatory_pie(pi, kbuf);
-
-	ret = kexec_purgatory_setup_kbuf(pi, kbuf);
-	if (ret)
-		return ret;
-
-	ret = kexec_purgatory_setup_sechdrs(pi, kbuf);
-	if (ret)
-		goto out_free_kbuf;
-
-	ret = kexec_apply_relocations(image);
-	if (ret)
-		goto out;
-
-	return 0;
-out:
-	vfree(pi->sechdrs);
-	pi->sechdrs = NULL;
-out_free_kbuf:
-	vfree(pi->purgatory_buf);
-	pi->purgatory_buf = NULL;
-	return ret;
-}
-
 /*
  * kexec_purgatory_find_symbol - find a symbol in the purgatory
  * @pi:		Purgatory to search in.
-- 
2.44.0.769.g3c40516874-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
