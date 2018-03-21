Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eybuj-0003ME-1H
 for kexec@lists.infradead.org; Wed, 21 Mar 2018 11:28:36 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LBNZAI141393
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:05 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gumn4d73a-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:05 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 11:28:03 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH v2 04/11] kexec_file: Search symbols in read-only
 kexec_purgatory
Date: Wed, 21 Mar 2018 12:27:44 +0100
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180321112751.22196-5-prudo@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

The stripped purgatory does not contain a symtab. So when looking for
symbols this is done in read-only kexec_purgatory. Highlight this by
marking the corresponding variables as 'const'.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 06fc9fdd2474..2072b288ec53 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -901,20 +901,27 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	return ret;
 }
 
-static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
-					    const char *name)
+/*
+ * kexec_purgatory_find_symbol - find a symbol in the purgatory
+ * @pi:		Purgatory to search in.
+ * @name:	Name of the symbol.
+ *
+ * Return: pointer to symbol in read-only symtab on success, NULL on error.
+ */
+static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
+						  const char *name)
 {
+	const Elf_Shdr *sechdrs;
 	const Elf_Ehdr *ehdr;
-	Elf_Sym *syms;
-	Elf_Shdr *sechdrs;
-	int i, k;
+	const Elf_Sym *syms;
 	const char *strtab;
+	int i, k;
 
-	if (!pi->sechdrs || !pi->ehdr)
+	if (!pi->ehdr)
 		return NULL;
 
-	sechdrs = pi->sechdrs;
 	ehdr = pi->ehdr;
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
 
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (sechdrs[i].sh_type != SHT_SYMTAB)
@@ -923,8 +930,8 @@ static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 		if (sechdrs[i].sh_link >= ehdr->e_shnum)
 			/* Invalid strtab section number */
 			continue;
-		strtab = (char *)sechdrs[sechdrs[i].sh_link].sh_offset;
-		syms = (Elf_Sym *)sechdrs[i].sh_offset;
+		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
+		syms = (void *)ehdr + sechdrs[i].sh_offset;
 
 		/* Go through symbols for a match */
 		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
@@ -952,7 +959,7 @@ static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
-	Elf_Sym *sym;
+	const Elf_Sym *sym;
 	Elf_Shdr *sechdr;
 
 	sym = kexec_purgatory_find_symbol(pi, name);
@@ -975,9 +982,9 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size, bool get_value)
 {
-	Elf_Sym *sym;
-	Elf_Shdr *sechdrs;
 	struct purgatory_info *pi = &image->purgatory_info;
+	const Elf_Sym *sym;
+	Elf_Shdr *sec;
 	char *sym_buf;
 
 	sym = kexec_purgatory_find_symbol(pi, name);
@@ -990,16 +997,15 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 		return -EINVAL;
 	}
 
-	sechdrs = pi->sechdrs;
+	sec = pi->sechdrs + sym->st_shndx;
 
-	if (sechdrs[sym->st_shndx].sh_type == SHT_NOBITS) {
+	if (sec->sh_type == SHT_NOBITS) {
 		pr_err("symbol %s is in a bss section. Cannot %s\n", name,
 		       get_value ? "get" : "set");
 		return -EINVAL;
 	}
 
-	sym_buf = (unsigned char *)sechdrs[sym->st_shndx].sh_offset +
-					sym->st_value;
+	sym_buf = (char *)sec->sh_offset + sym->st_value;
 
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
