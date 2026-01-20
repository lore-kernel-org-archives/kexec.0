Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB052D2ECF7
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RsbdtOmIV/sS2UcajTt/rwz3vGSUI4SRa4q2OoUAI2Y=; b=PmCkYbZnEtz16PuEI2+0iHE4u9
	m7N4kmT88wRrhLucwxC9avuvX/6K2oedqitlJGpjOm6v+fh2dT7H7RaPXbaDUxRQj4XNy6eODUX4G
	czvcQ4HErSlYsy88+J+/r4mOKjeEBGHtmoRf8Id3J4czecb/5SGbQeeCyWn1+yTjMqPMowx1sh/tS
	gu606OpyFSfB4qExzk6Ki462uIpizx8/zyncvIAKPG1P7ESuUoO4QW9vrUpzjXmK/zTNS+HE+Jk0a
	SBXdRd2mZov0CvWJx09KpGEMPympNQSFWxxz0KuOl1/r6qxBNO5PCM1VFhj57NCKWi2/C7x9Vg+vj
	/nJEm0Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viB2B-00000003rC6-317A;
	Tue, 20 Jan 2026 12:40:35 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viB29-00000003rBK-3KQo
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 12:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1768912826; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZnjLHik5x00fADycem+PT+TfqtIcsDimnHqkXxTM6EK1gZoGN9lFg9mgARM9u5I405RmeiJ/ZOaSJMLixkkweLh2GYtVcpyJQtzOpQ7Vl68cwOwieCZw1gEyasPe5z9fXzeHFZrHOKQcAU5LUZYudveDmpBneyTvmYmjFW4QbDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768912826; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=RsbdtOmIV/sS2UcajTt/rwz3vGSUI4SRa4q2OoUAI2Y=; 
	b=AoIfl2nS3aPx0d7fK8abAUDy54RYgBdnveYcg6ddil924EfC0qgVmdaGv/9Z2RFuFv/+MTRt5el4h+4jEGNi1aZWK5cuLrbR/WQottVNQ1xoxnzAaJ7wuBrEJHIBPJYcPfZ1ApFn1RyF3XBsCsmjxZK6r0eAY7rcL5hiaIVYKQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768912826;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=RsbdtOmIV/sS2UcajTt/rwz3vGSUI4SRa4q2OoUAI2Y=;
	b=Sx6gfn3J3dVI5pJsTBe+0e4tUY2befYeCcqqQNp6BFLIJi7NpmRwnvKOW7xACyyQ
	Z8+EeDwPfCnBj/jDAPEv5TMsyz3Jw/jy8eYgPVGjZAVwDWV4ab/pPxImzunLd5AG3zX
	KKGgwxQGl0IwgqeVoVvfW6OXGsa3PXIVCYTdQ7XQ=
Received: by mx.zohomail.com with SMTPS id 1768912824593109.50412840274407;
	Tue, 20 Jan 2026 04:40:24 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Steven Chen <chenste@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Li Chen <me@linux.beauty>,
	Philipp Rudo <prudo@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Ross Zwisler <zwisler@google.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: derive purgatory entry from symbol
Date: Tue, 20 Jan 2026 20:40:04 +0800
Message-ID: <20260120124005.148381-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_044033_932983_C065AE7C 
X-CRM114-Status: GOOD (  14.77  )
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
 kernel/kexec_file.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3f1d6c4e8ff2..d3c68c6b4bbc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,6 +880,8 @@ static int kexec_calculate_store_digests(struct kimage *image)
 }
 
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
+static const Elf_Sym * kexec_purgatory_find_symbol(struct purgatory_info *pi,
+			      const char *name);
 /*
  * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
  * @pi:		Purgatory to be loaded.
@@ -958,6 +960,10 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned long offset;
 	size_t sechdrs_size;
 	Elf_Shdr *sechdrs;
+	const Elf_Sym *entry_sym;
+	u16 entry_shndx = 0;
+	unsigned long entry_off = 0;
+	bool start_fixed = false;
 	int i;
 
 	/*
@@ -975,6 +981,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
@@ -992,6 +1004,13 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 
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
@@ -1002,13 +1021,14 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
-- 
2.52.0


