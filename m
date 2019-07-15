Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hmwKc-00054H-9L
 for kexec@lists.infradead.org; Mon, 15 Jul 2019 08:27:43 +0000
From: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v4 7/7] kexec_elf: support 32 bit ELF files
Date: Mon, 15 Jul 2019 10:27:02 +0200
Message-Id: <20190715082702.27308-8-svens@stackframe.org>
In-Reply-To: <20190715082702.27308-1-svens@stackframe.org>
References: <20190715082702.27308-1-svens@stackframe.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Sven Schnelle <svens@stackframe.org>, deller@gmx.de, linuxppc-dev@lists.ozlabs.org

The powerpc version only supported 64 bit. Add some
code to switch decoding of fields during runtime so
we can kexec a 32 bit kernel from a 64 bit kernel and
vice versa.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 kernel/kexec_elf.c | 57 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 9421eebbacf0..a39d01154829 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -8,8 +8,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#define elf_addr_to_cpu	elf64_to_cpu
-
 static inline bool elf_is_elf_file(const struct elfhdr *ehdr)
 {
 	return memcmp(ehdr->e_ident, ELFMAG, SELFMAG) == 0;
@@ -139,9 +137,6 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
 	ehdr->e_type      = elf16_to_cpu(ehdr, buf_ehdr->e_type);
 	ehdr->e_machine   = elf16_to_cpu(ehdr, buf_ehdr->e_machine);
 	ehdr->e_version   = elf32_to_cpu(ehdr, buf_ehdr->e_version);
-	ehdr->e_entry     = elf_addr_to_cpu(ehdr, buf_ehdr->e_entry);
-	ehdr->e_phoff     = elf_addr_to_cpu(ehdr, buf_ehdr->e_phoff);
-	ehdr->e_shoff     = elf_addr_to_cpu(ehdr, buf_ehdr->e_shoff);
 	ehdr->e_flags     = elf32_to_cpu(ehdr, buf_ehdr->e_flags);
 	ehdr->e_phentsize = elf16_to_cpu(ehdr, buf_ehdr->e_phentsize);
 	ehdr->e_phnum     = elf16_to_cpu(ehdr, buf_ehdr->e_phnum);
@@ -149,6 +144,24 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
 	ehdr->e_shnum     = elf16_to_cpu(ehdr, buf_ehdr->e_shnum);
 	ehdr->e_shstrndx  = elf16_to_cpu(ehdr, buf_ehdr->e_shstrndx);
 
+	switch (ehdr->e_ident[EI_CLASS]) {
+	case ELFCLASS64:
+		ehdr->e_entry     = elf64_to_cpu(ehdr, buf_ehdr->e_entry);
+		ehdr->e_phoff     = elf64_to_cpu(ehdr, buf_ehdr->e_phoff);
+		ehdr->e_shoff     = elf64_to_cpu(ehdr, buf_ehdr->e_shoff);
+		break;
+
+	case ELFCLASS32:
+		ehdr->e_entry     = elf32_to_cpu(ehdr, buf_ehdr->e_entry);
+		ehdr->e_phoff     = elf32_to_cpu(ehdr, buf_ehdr->e_phoff);
+		ehdr->e_shoff     = elf32_to_cpu(ehdr, buf_ehdr->e_shoff);
+		break;
+
+	default:
+		pr_debug("Unknown ELF class.\n");
+		return -EINVAL;
+	}
+
 	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
 }
 
@@ -179,6 +192,7 @@ static int elf_read_phdr(const char *buf, size_t len,
 {
 	/* Override the const in proghdrs, we are the ones doing the loading. */
 	struct elf_phdr *phdr = (struct elf_phdr *) &elf_info->proghdrs[idx];
+	const struct elfhdr *ehdr = elf_info->ehdr;
 	const char *pbuf;
 	struct elf_phdr *buf_phdr;
 
@@ -186,18 +200,31 @@ static int elf_read_phdr(const char *buf, size_t len,
 	buf_phdr = (struct elf_phdr *) pbuf;
 
 	phdr->p_type   = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_type);
-	phdr->p_offset = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_offset);
-	phdr->p_paddr  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_paddr);
-	phdr->p_vaddr  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_vaddr);
 	phdr->p_flags  = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_flags);
 
-	/*
-	 * The following fields have a type equivalent to Elf_Addr
-	 * both in 32 bit and 64 bit ELF.
-	 */
-	phdr->p_filesz = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_filesz);
-	phdr->p_memsz  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_memsz);
-	phdr->p_align  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_align);
+	switch (ehdr->e_ident[EI_CLASS]) {
+	case ELFCLASS64:
+		phdr->p_offset = elf64_to_cpu(ehdr, buf_phdr->p_offset);
+		phdr->p_paddr  = elf64_to_cpu(ehdr, buf_phdr->p_paddr);
+		phdr->p_vaddr  = elf64_to_cpu(ehdr, buf_phdr->p_vaddr);
+		phdr->p_filesz = elf64_to_cpu(ehdr, buf_phdr->p_filesz);
+		phdr->p_memsz  = elf64_to_cpu(ehdr, buf_phdr->p_memsz);
+		phdr->p_align  = elf64_to_cpu(ehdr, buf_phdr->p_align);
+		break;
+
+	case ELFCLASS32:
+		phdr->p_offset = elf32_to_cpu(ehdr, buf_phdr->p_offset);
+		phdr->p_paddr  = elf32_to_cpu(ehdr, buf_phdr->p_paddr);
+		phdr->p_vaddr  = elf32_to_cpu(ehdr, buf_phdr->p_vaddr);
+		phdr->p_filesz = elf32_to_cpu(ehdr, buf_phdr->p_filesz);
+		phdr->p_memsz  = elf32_to_cpu(ehdr, buf_phdr->p_memsz);
+		phdr->p_align  = elf32_to_cpu(ehdr, buf_phdr->p_align);
+		break;
+
+	default:
+		pr_debug("Unknown ELF class.\n");
+		return -EINVAL;
+	}
 
 	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;
 }
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
