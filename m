Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAO-00056T-LQ
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:16 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 7DA0A245A4
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121320.754858384@vergenet.net>
Date: Mon, 01 Feb 2010 23:11:58 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 02/27] Remove unused parameters from build_mem() and related
	functions
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=build_mem-remove-unused-parameters.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/kexec-elf.c
===================================================================
--- kexec-tools.orig/kexec/kexec-elf.c	2010-02-01 23:06:41.000000000 +1100
+++ kexec-tools/kexec/kexec-elf.c	2010-02-01 23:07:16.000000000 +1100
@@ -302,8 +302,7 @@ static int build_mem_ehdr(const char *bu
 	return 0;
 }
 
-static int build_mem_elf32_phdr(const char *buf, off_t len,
-	struct mem_ehdr *ehdr, int idx)
+static int build_mem_elf32_phdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 {
 	struct mem_phdr *phdr;
 	const char *pbuf;
@@ -335,8 +334,7 @@ static int build_mem_elf32_phdr(const ch
 	return 0;
 }
 
-static int build_mem_elf64_phdr(const char *buf, off_t len,
-	struct mem_ehdr *ehdr, int idx)
+static int build_mem_elf64_phdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 {
 	struct mem_phdr *phdr;
 	const char *pbuf;
@@ -407,11 +405,11 @@ static int build_mem_phdrs(const char *b
 		int result;
 		result = -1;
 		if (ehdr->ei_class == ELFCLASS32) {
-			result = build_mem_elf32_phdr(buf, len, ehdr, i);
+			result = build_mem_elf32_phdr(buf, ehdr, i);
 
 		}
 		else if (ehdr->ei_class == ELFCLASS64) {
-			result = build_mem_elf64_phdr(buf, len, ehdr, i);
+			result = build_mem_elf64_phdr(buf, ehdr, i);
 		}
 		if (result < 0) {
 			return result;
@@ -443,8 +441,7 @@ static int build_mem_phdrs(const char *b
 	return 0;
 }
 
-static int build_mem_elf32_shdr(const char *buf, off_t len,
-	struct mem_ehdr *ehdr, int idx)
+static int build_mem_elf32_shdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 {
 	struct mem_shdr *shdr;
 	const char *sbuf;
@@ -513,8 +510,7 @@ static int build_mem_elf32_shdr(const ch
 	return 0;
 }
 
-static int build_mem_elf64_shdr(const char *buf, off_t len,
-	struct mem_ehdr *ehdr, int idx)
+static int build_mem_elf64_shdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 {
 	struct mem_shdr *shdr;
 	const char *sbuf;
@@ -622,10 +618,10 @@ static int build_mem_shdrs(const char *b
 		int result;
 		result = -1;
 		if (ehdr->ei_class == ELFCLASS32) {
-			result = build_mem_elf32_shdr(buf, len, ehdr, i);
+			result = build_mem_elf32_shdr(buf, ehdr, i);
 		}
 		else if (ehdr->ei_class == ELFCLASS64) {
-			result = build_mem_elf64_shdr(buf, len, ehdr, i);
+			result = build_mem_elf64_shdr(buf, ehdr, i);
 		}
 		if (result < 0) {
 			return result;
@@ -667,7 +663,7 @@ static void read_nhdr(const struct mem_e
 	hdr->n_type   = elf32_to_cpu(ehdr, hdr->n_type);
 
 }
-static int build_mem_notes(const char *buf, off_t len, struct mem_ehdr *ehdr)
+static int build_mem_notes(struct mem_ehdr *ehdr)
 {
 	const unsigned char *note_start, *note_end, *note;
 	size_t note_size;
@@ -769,7 +765,7 @@ int build_elf_info(const char *buf, off_
 			return result;
 		}
 	}
-	result = build_mem_notes(buf, len, ehdr);
+	result = build_mem_notes(ehdr);
 	if (result < 0) {
 		free_elf_info(ehdr);
 		return result;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
