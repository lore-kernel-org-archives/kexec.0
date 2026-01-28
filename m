Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8D6D35672
	for <kexec@archiver.kernel.org>; Wed, 28 Jan 2026 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RJLog9pwWlh0Lb/QETgZDkyv5EZvOUryY5iGkIHTsDA=; b=c302VVMVoFQylKz6w4/lXY+DtP
	rv8zoD/VyMdjLalfg6TQhey+5oP7J5A2NSIvJu5aoiYg2ge0pepRDdWQKN6qM+tQaNEoqlngrPeRn
	UhXLUQC6aMiO8fhJZm476QjWP6Q1DRxtHGI+BbXnCONbu+vTwRlOskxw/pS4GXybWkLFi4dABUAuO
	iarQ5R8+T2zq7KuzQMy0g4nIxtGzt8D+LCzfaxwzmV9xEYkiu6IYevJQnuXV6G2Bp7w73c9iYf1L+
	rc16CZRw+VXJOSHlTHDcrCTwlQnskYHU4UCWq5mihHsSDsJe+jcWwVuexeqf3DwAL8qDtb7xmNKCo
	t29C++vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxHB-0000000FQfs-3mjY;
	Wed, 28 Jan 2026 04:35:33 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxH8-0000000FQfX-41qi
	for kexec@lists.infradead.org;
	Wed, 28 Jan 2026 04:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1769574924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ljBIPtDTlVj/zVt0UVP9FiWrmE9LtNw1LIMNYSThgfcWVsdD604r35u3dhMuN/DDCmdR/4mSnTAgC27p4cVNrBz6LbDsjgBqwvBYYesJL39FuiV5zOxM8VlcswU7HHIsH02ftcMxNwTsHntSmOmE07A1MCHMnzcZrKTlC6PkYWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769574924; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=RJLog9pwWlh0Lb/QETgZDkyv5EZvOUryY5iGkIHTsDA=; 
	b=hP6LEgymSEZWYGf7IGvPfHe+DTkPew5F8e+bQaF3IAKXVslJGVX+2XAxtp1yjsU6wtZKeQMQygiwN6RGMCGiuReIjhMfQCQTsP8/CY7z9BDqNNMeJLzo0p956LtY6/6GJoRk33zDPmcYgdAiCJue8nfFQsbvvqQ2QRuMrfn/4uE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769574923;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=RJLog9pwWlh0Lb/QETgZDkyv5EZvOUryY5iGkIHTsDA=;
	b=YE9RXlMalpXdQPqyiV0lG1GedhE2AFn7Bl3nXlrJ8Sc6RnP8CRFUqHZtR3FLuFOq
	pr03NVKuaFh22cj8GXIwsfyGpYgTmRH+MPk09aCjiylCfipY2V8D5IrtrXtcLt8YVAb
	0FgmPv4sssdIpLiwXLmP2BaDDVPoD5tfbgaAhals=
Received: by mx.zohomail.com with SMTPS id 1769574921334574.8281592616415;
	Tue, 27 Jan 2026 20:35:21 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Tushar Sugandhi <tusharsu@linux.microsoft.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Coiby Xu <coxu@redhat.com>,
	Li Chen <me@linux.beauty>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Ross Zwisler <zwisler@google.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kexec: derive purgatory entry from symbol
Date: Wed, 28 Jan 2026 12:35:10 +0800
Message-ID: <20260128043511.316860-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_203531_037031_6BEDB785 
X-CRM114-Status: GOOD (  19.12  )
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

kexec_load_purgatory() derives image->start by locating e_entry inside an
SHF_EXECINSTR section. If the purgatory object contains multiple executable
sections with overlapping sh_addr, the entrypoint check can match more than
once and trigger a WARN.

Derive the entry section from the purgatory_start symbol when present and
compute image->start from its final placement. Keep the existing e_entry
fallback for purgatories that do not expose the symbol.

WARNING: kernel/kexec_file.c:1009 at kexec_load_purgatory+0x395/0x3c0, CPU#10: kexec/1784
Call Trace:
 <TASK>
 bzImage64_load+0x133/0xa00
 __do_sys_kexec_file_load+0x2b3/0x5c0
 do_syscall_64+0x81/0x610
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
Signed-off-by: Li Chen <me@linux.beauty>
---
clangelog:
v2: move the helper body above kexec_purgatory_setup_sechdrs() in v2 to avoid
the forward declaration, as suggested by Baoquan.

 kernel/kexec_file.c | 131 +++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 57 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3f1d6c4e8ff2..e9550bfbd02e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,6 +880,60 @@ static int kexec_calculate_store_digests(struct kimage *image)
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
@@ -958,6 +1012,10 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned long offset;
 	size_t sechdrs_size;
 	Elf_Shdr *sechdrs;
+	const Elf_Sym *entry_sym;
+	u16 entry_shndx = 0;
+	unsigned long entry_off = 0;
+	bool start_fixed = false;
 	int i;
 
 	/*
@@ -975,6 +1033,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
@@ -992,6 +1056,13 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 
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
@@ -1002,13 +1073,14 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
@@ -1126,61 +1198,6 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
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
2.52.0


