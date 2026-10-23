Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005E606A322
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mQLQfWKu;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQaViej9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Cc:To:In-Reply-To:References:Message-Id:
	Content-Type:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TlG44xVznpup3lOSzbOZBN28dlLxETLOHZCj5lrWCFc=; b=mQLQfWKub8+CN1XPt77Xs+yU6D
	qpEsDZYNEe/rheur7pNlXv/p/IJsFajULKzqv74VOfNEnGsdyY7ycCn+6omadlZ1VeiB7StO/2Hia
	aJMwpNkrt4HeUL2/r7KPYh5VUC/1kFFv3zV9aIabwbtpCMbx6490KoCWlNf4mHmDIptSXr7p5jM/M
	FWLgHSxMYnf1L/MeS6s8xpqdc/Rf0na1yFkQ0uep1dHsmvHh1+n0C7bQAn/cbuTadqN1Khz7Mm2NH
	OYousoxiF4YHoH4u0Tq/j/BME+8+Bb2yRTJ3oqyGDAQNMoAr8T35a73Jiezk8dS3M2zssVJ4nD8dL
	Cl6vLBrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mD-0000000Fl4v-0lCg;
	Fri, 23 Oct 2026 07:33:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mB-0000000Fl4G-2zEG;
	Fri, 23 Oct 2026 07:33:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 572E54386D;
	Fri, 23 Oct 2026 07:33:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792740799;
	b=0kajp3cVgqDZGjJBohpG+4BFdYTjy35BgbaytR3UiV+ksjoGqVZ5gKvFp5mIKwckm5Sq
	 eJ0KHv+i2xOHuucINLTGWRw5g81vxrTKspb98MkY8goqfhawa4HymfqZZaDHOdmPkTwTk
	 k53mR2lmzuEBUnns8zJ5ly97Uv05fStH6RCjbt09atJOOpPGDcq+4/700qTDsCr+F4K1y
	 ftc5QLd+RJdZbMHaxfENaki5BxiDheZ0G7d8VOAQ4L9AjWkDJgA1Ux7iyTu9bAe6rLVEN
	 60VDY3r9DLjxcxmHUrkvngpSYCDNPMrQiE3thG663CYoXiNOd+mJ3mXY9d5dkhYrSOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792740799;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TlG44xVznpup3lOSzbOZBN28dlLxETLOHZCj5lrWCFc=;
	b=ZPa6frd5Bi45o+eMTdfl9rvGCL3X9OqoSoYujdo0xhQeWDWirWbFobodJjiQVF/wWSVR
	 CgU0Y0cFTSLFkRfjAuw8R8oYax5DEI2CToVcxCnEhox2OokYvnxjY0fxqDDeTfH2blEA0
	 u0Ah2WkBwk9I/AV/Qpd7rrPGoDnnoBTiq4z8nT2nEiqnQw9P3nNgOmQdDIBASeK9dXpWx
	 XnBoqC1JMXIKuXWthOtnqQ0JtykRSgqq08X37njJiuUYIUhGRgKJEs/579wT6CI+i53V8
	 A7NJpL1XYd6JWR0s3bSv4B4Zqs1B3vmzHkYLswund9w/sNwtSvqCg5Xh7bztDBopopw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DFAB71F031E5;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740799;
	bh=TlG44xVznpup3lOSzbOZBN28dlLxETLOHZCj5lrWCFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AQaViej9/BY1Pb4smjPkTYfDB7l5LCVHLjGl5+7N2hZagZZ7mM37kXF+zh8GmTkXT
	 kqnqZmWPDaIroWVS/tpKiRTY+hg3TfISdfKToRrWLUrgDCMtSnp3/jC3oW8KtZEd7z
	 3F0i4mvnzF4q8cv2CkZiCHufPUsKgJcM9Av/ViPZZuk0w1HssCZiKmOLuaY07ok2ZY
	 La/Rf4pYK0CpuIbNIkdMFaqbqKWVuoxXM7g5zjnSvONubiX0ieQlDAOevzdPo7O4JC
	 BXbAdj6AuKToot7NgY+72dWKAanajbEosfwn8w4JOrnvDHoF5BmGCB5HlisJNBjT3e
	 t/cd2lassAZkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 51B80443EA;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Fri, 23 Oct 2026 15:33:15 +0800
Subject: [PATCH 2/5] riscv: kexec_file: Pair PC-relative low parts with
 their high parts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-riscv-kexec-cma-fixes-v1-2-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Yao Zi <me@ziyao.cc>
Cc: Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kexec@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792740795; l=5648;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=bOm4TbcnSAEPQfN5+cnnFizeKypwOxZ4lNJZE7FgYSM=;
 b=fxAsWUSwgRnk03I3rVsQDn6YsmCvR+WfDZc0R3qUDBycOCoTQCyTVEj93BHKoYRFr5Tjj04FC
 X/q/xSGP5GJCjSKWq3LNFC+AMnQTH/zOOdBFdSy2y8zAJDPkAWg1OXD
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: gaohan@iscas.ac.cn
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Han Gao <gaohan@iscas.ac.cn>

The purgatory relocation code applies R_RISCV_PCREL_HI20 to the auipc
and to the instruction after it, and ignores R_RISCV_PCREL_LO12_I. This
assumes that the low part immediately follows its high part. Compilers
may schedule several auipc instructions before their users; clang does
so in sha256_init(), which corrupts the hash and leaves purgatory
spinning on a digest mismatch.

Apply the high part to the auipc only. Resolve each R_RISCV_PCREL_LO12_I
and R_RISCV_PCREL_LO12_S through the R_RISCV_PCREL_HI20 at the address
its symbol labels, as the module loader does.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/kernel/machine_kexec_file.c | 84 ++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 26cd2a8bd0cd..1d7636acd382 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -104,6 +104,8 @@ static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 
 #define ENCODE_ITYPE_IMM(x) \
 	(RV_X(x, 0, 12) << 20)
+#define ENCODE_STYPE_IMM(x) \
+	((RV_X(x, 0, 5) << 7) | (RV_X(x, 5, 7) << 25))
 #define ENCODE_BTYPE_IMM(x) \
 	((RV_X(x, 1, 4) << 8) | (RV_X(x, 5, 6) << 25) | \
 	(RV_X(x, 11, 1) << 7) | (RV_X(x, 12, 1) << 31))
@@ -128,6 +130,49 @@ static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 #define CLEAN_IMM(type, x) \
 	((~ENCODE_##type##_IMM((uint64_t)(-1))) & (x))
 
+static int riscv_kexec_rela_value(const struct purgatory_info *pi,
+				  const Elf_Shdr *symtab, const Elf64_Rela *rela,
+				  unsigned long *val)
+{
+	const Elf_Sym *sym = (void *)pi->ehdr + symtab->sh_offset;
+
+	sym += ELF64_R_SYM(rela->r_info);
+	if (sym->st_shndx == SHN_ABS)
+		*val = 0;
+	else if (sym->st_shndx < pi->ehdr->e_shnum)
+		*val = pi->sechdrs[sym->st_shndx].sh_addr;
+	else
+		return -ENOEXEC;
+	*val += sym->st_value + rela->r_addend;
+	return 0;
+}
+
+/*
+ * An R_RISCV_PCREL_LO12_* symbol labels its R_RISCV_PCREL_HI20 instruction,
+ * which compilers need not place immediately before the low part.
+ */
+static int riscv_kexec_pcrel_hi20(const struct purgatory_info *pi,
+				  const Elf_Shdr *section, const Elf_Shdr *relsec,
+				  const Elf_Shdr *symtab, unsigned long hi_addr,
+				  long *offset)
+{
+	const Elf64_Rela *relas = (void *)pi->ehdr + relsec->sh_offset;
+	unsigned long val;
+	int i, ret;
+
+	for (i = 0; i < relsec->sh_size / sizeof(*relas); i++) {
+		if (ELF64_R_TYPE(relas[i].r_info) != R_RISCV_PCREL_HI20 ||
+		    section->sh_addr + relas[i].r_offset != hi_addr)
+			continue;
+		ret = riscv_kexec_rela_value(pi, symtab, &relas[i], &val);
+		if (ret)
+			return ret;
+		*offset = val - hi_addr;
+		return 0;
+	}
+	return -ENOEXEC;
+}
+
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
@@ -149,8 +194,8 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		const Elf_Sym *sym;	/* symbol to relocate */
 		unsigned long addr;	/* final location after relocation */
 		unsigned long val;	/* relocated symbol value */
-		unsigned long sec_base;	/* relocated symbol value */
 		void *loc;		/* tmp location to modify */
+		long offset;
 
 		sym = (void *)pi->ehdr + symtab->sh_offset;
 		sym += ELF64_R_SYM(relas[i].r_info);
@@ -164,18 +209,11 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		loc += section->sh_offset;
 		loc += relas[i].r_offset;
 
-		if (sym->st_shndx == SHN_ABS)
-			sec_base = 0;
-		else if (sym->st_shndx >= pi->ehdr->e_shnum) {
+		if (riscv_kexec_rela_value(pi, symtab, &relas[i], &val)) {
 			pr_err("Invalid section %d for symbol %s\n",
 			       sym->st_shndx, name);
 			return -ENOEXEC;
-		} else
-			sec_base = pi->sechdrs[sym->st_shndx].sh_addr;
-
-		val = sym->st_value;
-		val += sec_base;
-		val += relas[i].r_addend;
+		}
 
 		addr = section->sh_addr + relas[i].r_offset;
 
@@ -190,13 +228,25 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 			*(u32 *)loc = CLEAN_IMM(JTYPE, *(u32 *)loc) |
 				 ENCODE_JTYPE_IMM(val - addr);
 			break;
-		/*
-		 * With no R_RISCV_PCREL_LO12_S, R_RISCV_PCREL_LO12_I
-		 * sym is expected to be next to R_RISCV_PCREL_HI20
-		 * in purgatory relsec. Handle it like R_RISCV_CALL
-		 * sym, instead of searching the whole relsec.
-		 */
 		case R_RISCV_PCREL_HI20:
+			*(u32 *)loc = CLEAN_IMM(UTYPE, *(u32 *)loc) |
+				 ENCODE_UTYPE_IMM(RISCV_CONST_HIGH_PART(val - addr));
+			break;
+		case R_RISCV_PCREL_LO12_I:
+		case R_RISCV_PCREL_LO12_S:
+			if (riscv_kexec_pcrel_hi20(pi, section, relsec, symtab,
+						   val, &offset)) {
+				pr_err("No R_RISCV_PCREL_HI20 for %s\n", name);
+				return -ENOEXEC;
+			}
+			offset = RISCV_CONST_LOW_PART(offset);
+			if (r_type == R_RISCV_PCREL_LO12_I)
+				*(u32 *)loc = CLEAN_IMM(ITYPE, *(u32 *)loc) |
+					 ENCODE_ITYPE_IMM(offset);
+			else
+				*(u32 *)loc = CLEAN_IMM(STYPE, *(u32 *)loc) |
+					 ENCODE_STYPE_IMM(offset);
+			break;
 		case R_RISCV_CALL_PLT:
 		case R_RISCV_CALL:
 			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
@@ -222,8 +272,6 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		case R_RISCV_SUB32:
 			*(u32 *)loc -= val;
 			break;
-		/* It has been applied by R_RISCV_PCREL_HI20 sym */
-		case R_RISCV_PCREL_LO12_I:
 		case R_RISCV_ALIGN:
 		case R_RISCV_RELAX:
 			break;

-- 
2.55.0



