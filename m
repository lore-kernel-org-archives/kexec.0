Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C21FD0049
	for <kexec@archiver.kernel.org>; Sun,  1 Mar 2026 02:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ks7GClyPuA34jCa6+RXigsy25rfdekjp5tm7VudJ0r0=; b=fqcChrJIfDj+3Kkw9qUj3StmGM
	VkWSrfzB2D0y8RkE64oeHQdjsoSPdOm6qzAu2Abl/VllQVGiHQQ6Mk1ArCdmg0gBweA9p46eFP+Ro
	QdSSuvRuEyF4NhaWKYHwbj/11c/cxqvGCgMehC0RAyBzFMyyGLbo7m6KNTLKKbV96NQHefqqo/fd0
	APzyWEJUauO2FNWKZs9dvNbtwEYuH0vNtuSTGj2zId9TMgXV7QgjctIbvhOQUtAIhqAIg2IPWa4gn
	ucbK8hhF0ThQYzPEndQH/6CSnDGVknfGvNOv727P9An0befwbTd4/0QID9lxTWL1IxLAygDjAR5i3
	0j4hv/tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwW9A-0000000Ait6-2lRi;
	Sun, 01 Mar 2026 02:03:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwW97-0000000Airq-3vcZ
	for kexec@lists.infradead.org;
	Sun, 01 Mar 2026 02:03:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 734CF41879;
	Sun,  1 Mar 2026 02:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DACC19421;
	Sun,  1 Mar 2026 02:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330581;
	bh=VIirExjuTsJcudi9KQqQIGuDAvwU/Z+Z7acipKVjnm0=;
	h=From:To:Cc:Subject:Date:From;
	b=eIdjR6YE3x+po6EsrITpJjbSdVLu1dV1X0QnTqyT3nIAK1EL/JljoSneWxD/BRkLu
	 7IGAG0/Jg66JzmZsGrlOmgUD+1GylnAAzj0Xmyc6T47dbuF2ilPjfyJRkNuzlGHmu4
	 33E3SzAUIsQS4l+cyk9w2r81wxvTS1IG6s5LAW/ANpgPs74mbrsGtaUm9F7y9+cVCA
	 kmHlCO/fOhcTvkQddYX/mIZwh9Brh/8b+MI8IBQVJ4kVX+bfoA2Y1Z457gPkS3lNtj
	 Hi2ajfC16l3RHDy2uTxCKpfcnjveJx94kDb4H0JoSjbKDfiA67MHl/FLfRdE0vt2i/
	 be5hmG0+gYGRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	me@linux.beauty
Cc: Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Ricardo Ribalda Delgado <ribalda@chromium.org>,
	Ross Zwisler <zwisler@google.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org
Subject: FAILED: Patch "kexec: derive purgatory entry from symbol" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:02:58 -0500
Message-ID: <20260301020259.1730921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_180302_011887_30F6517B 
X-CRM114-Status: GOOD (  22.94  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 480e1d5c64bb14441f79f2eb9421d5e26f91ea3d Mon Sep 17 00:00:00 2001
From: Li Chen <me@linux.beauty>
Date: Tue, 20 Jan 2026 20:40:04 +0800
Subject: [PATCH] kexec: derive purgatory entry from symbol

kexec_load_purgatory() derives image->start by locating e_entry inside an
SHF_EXECINSTR section.  If the purgatory object contains multiple
executable sections with overlapping sh_addr, the entrypoint check can
match more than once and trigger a WARN.

Derive the entry section from the purgatory_start symbol when present and
compute image->start from its final placement.  Keep the existing e_entry
fallback for purgatories that do not expose the symbol.

WARNING: kernel/kexec_file.c:1009 at kexec_load_purgatory+0x395/0x3c0, CPU#10: kexec/1784
Call Trace:
 <TASK>
 bzImage64_load+0x133/0xa00
 __do_sys_kexec_file_load+0x2b3/0x5c0
 do_syscall_64+0x81/0x610
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

[me@linux.beauty: move helper to avoid forward declaration, per Baoquan]
  Link: https://lkml.kernel.org/r/20260128043511.316860-1-me@linux.beauty
Link: https://lkml.kernel.org/r/20260120124005.148381-1-me@linux.beauty
Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
Signed-off-by: Li Chen <me@linux.beauty>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Li Chen <me@linux.beauty>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Ricardo Ribalda Delgado <ribalda@chromium.org>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/kexec_file.c | 131 +++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 57 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a97942428..2bfbb2d144e69 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -882,6 +882,60 @@ static int kexec_calculate_store_digests(struct kimage *image)
 }
 
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
+/*
+ * kexec_purgatory_find_symbol - find a symbol in the purgatory
+ * @pi:		Purgatory to search in.
+ * @name:	Name of the symbol.
+ *
+ * Return: pointer to symbol in read-only symtab on success, NULL on error.
+ */
+static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
+						  const char *name)
+{
+	const Elf_Shdr *sechdrs;
+	const Elf_Ehdr *ehdr;
+	const Elf_Sym *syms;
+	const char *strtab;
+	int i, k;
+
+	if (!pi->ehdr)
+		return NULL;
+
+	ehdr = pi->ehdr;
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_SYMTAB)
+			continue;
+
+		if (sechdrs[i].sh_link >= ehdr->e_shnum)
+			/* Invalid strtab section number */
+			continue;
+		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
+		syms = (void *)ehdr + sechdrs[i].sh_offset;
+
+		/* Go through symbols for a match */
+		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
+			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+				continue;
+
+			if (strcmp(strtab + syms[k].st_name, name) != 0)
+				continue;
+
+			if (syms[k].st_shndx == SHN_UNDEF ||
+			    syms[k].st_shndx >= ehdr->e_shnum) {
+				pr_debug("Symbol: %s has bad section index %d.\n",
+					name, syms[k].st_shndx);
+				return NULL;
+			}
+
+			/* Found the symbol we are looking for */
+			return &syms[k];
+		}
+	}
+
+	return NULL;
+}
 /*
  * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
  * @pi:		Purgatory to be loaded.
@@ -960,6 +1014,10 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned long offset;
 	size_t sechdrs_size;
 	Elf_Shdr *sechdrs;
+	const Elf_Sym *entry_sym;
+	u16 entry_shndx = 0;
+	unsigned long entry_off = 0;
+	bool start_fixed = false;
 	int i;
 
 	/*
@@ -977,6 +1035,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	bss_addr = kbuf->mem + kbuf->bufsz;
 	kbuf->image->start = pi->ehdr->e_entry;
 
+	entry_sym = kexec_purgatory_find_symbol(pi, "purgatory_start");
+	if (entry_sym) {
+		entry_shndx = entry_sym->st_shndx;
+		entry_off = entry_sym->st_value;
+	}
+
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		unsigned long align;
 		void *src, *dst;
@@ -994,6 +1058,13 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 
 		offset = ALIGN(offset, align);
 
+		if (!start_fixed && entry_sym && i == entry_shndx &&
+		    (sechdrs[i].sh_flags & SHF_EXECINSTR) &&
+		    entry_off < sechdrs[i].sh_size) {
+			kbuf->image->start = kbuf->mem + offset + entry_off;
+			start_fixed = true;
+		}
+
 		/*
 		 * Check if the segment contains the entry point, if so,
 		 * calculate the value of image->start based on it.
@@ -1004,13 +1075,14 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		 * is not set to the initial value, and warn the user so they
 		 * have a chance to fix their purgatory's linker script.
 		 */
-		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
+		if (!start_fixed && sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
 					 + sechdrs[i].sh_size) &&
-		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
+		    kbuf->image->start == pi->ehdr->e_entry) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
+			start_fixed = true;
 		}
 
 		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
@@ -1128,61 +1200,6 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 	return ret;
 }
 
-/*
- * kexec_purgatory_find_symbol - find a symbol in the purgatory
- * @pi:		Purgatory to search in.
- * @name:	Name of the symbol.
- *
- * Return: pointer to symbol in read-only symtab on success, NULL on error.
- */
-static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
-						  const char *name)
-{
-	const Elf_Shdr *sechdrs;
-	const Elf_Ehdr *ehdr;
-	const Elf_Sym *syms;
-	const char *strtab;
-	int i, k;
-
-	if (!pi->ehdr)
-		return NULL;
-
-	ehdr = pi->ehdr;
-	sechdrs = (void *)ehdr + ehdr->e_shoff;
-
-	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type != SHT_SYMTAB)
-			continue;
-
-		if (sechdrs[i].sh_link >= ehdr->e_shnum)
-			/* Invalid strtab section number */
-			continue;
-		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
-		syms = (void *)ehdr + sechdrs[i].sh_offset;
-
-		/* Go through symbols for a match */
-		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
-			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
-				continue;
-
-			if (strcmp(strtab + syms[k].st_name, name) != 0)
-				continue;
-
-			if (syms[k].st_shndx == SHN_UNDEF ||
-			    syms[k].st_shndx >= ehdr->e_shnum) {
-				pr_debug("Symbol: %s has bad section index %d.\n",
-						name, syms[k].st_shndx);
-				return NULL;
-			}
-
-			/* Found the symbol we are looking for */
-			return &syms[k];
-		}
-	}
-
-	return NULL;
-}
-
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
-- 
2.51.0





