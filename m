Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAT-00058I-59
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:21 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id D823E24656
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121322.811510343@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:09 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 13/27] Use casts to avoid ambiguity when comparing off_t and
	size_t
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=off-size-comparison.patch
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

Index: kexec-tools/kexec/arch/i386/kexec-bzImage.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:15.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:19.000000000 +1100
@@ -44,7 +44,7 @@ static const int probe_debug = 0;
 int bzImage_probe(const char *buf, off_t len)
 {
 	struct x86_linux_header header;
-	if (len < sizeof(header)) {
+	if ((uintmax_t)len < (uintmax_t)sizeof(header)) {
 		return -1;
 	}
 	memcpy(&header, buf, sizeof(header));
@@ -119,7 +119,7 @@ int do_bzImage_load(struct kexec_info *i
 	/*
 	 * Find out about the file I am about to load.
 	 */
-	if (kernel_len < sizeof(setup_header)) {
+	if ((uintmax_t)kernel_len < (uintmax_t)sizeof(setup_header)) {
 		return -1;
 	}
 	memcpy(&setup_header, kernel, sizeof(setup_header));
@@ -136,7 +136,8 @@ int do_bzImage_load(struct kexec_info *i
 	}
 
 	if (setup_header.protocol_version >= 0x0206) {
-		if (command_line_len > setup_header.cmdline_size) {
+		if ((uintmax_t)command_line_len >
+		    (uintmax_t)setup_header.cmdline_size) {
 			dbgprintf("Kernel command line too long for kernel!\n");
 			return -1;
 		}
Index: kexec-tools/kexec/arch/i386/kexec-beoboot-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-beoboot-x86.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-beoboot-x86.c	2010-02-01 23:07:19.000000000 +1100
@@ -43,7 +43,7 @@ int beoboot_probe(const char *buf, off_t
 	struct beoboot_header bb_header;
 	const char *cmdline, *kernel;
 	int result;
-	if (len < sizeof(bb_header)) {
+	if ((uintmax_t)len < (uintmax_t)sizeof(bb_header)) {
 		return -1;
 	}
 	memcpy(&bb_header, buf, sizeof(bb_header));
Index: kexec-tools/kexec/kexec-elf.c
===================================================================
--- kexec-tools.orig/kexec/kexec-elf.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/kexec-elf.c	2010-02-01 23:07:19.000000000 +1100
@@ -98,7 +98,7 @@ unsigned long elf_max_addr(const struct 
 static int build_mem_elf32_ehdr(const char *buf, off_t len, struct mem_ehdr *ehdr)
 {
 	Elf32_Ehdr lehdr;
-	if (len < sizeof(lehdr)) {
+	if ((uintmax_t)len < (uintmax_t)sizeof(lehdr)) {
 		/* Buffer is to small to be an elf executable */
 		if (probe_debug) {
 			fprintf(stderr, "Buffer is to small to hold ELF header\n");
@@ -170,7 +170,7 @@ static int build_mem_elf32_ehdr(const ch
 static int build_mem_elf64_ehdr(const char *buf, off_t len, struct mem_ehdr *ehdr)
 {
 	Elf64_Ehdr lehdr;
-	if (len < sizeof(lehdr)) {
+	if ((uintmax_t)len < (uintmax_t)sizeof(lehdr)) {
 		/* Buffer is to small to be an elf executable */
 		if (probe_debug) {
 			fprintf(stderr, "Buffer is to small to hold ELF header\n");
@@ -244,7 +244,7 @@ static int build_mem_ehdr(const char *bu
 	unsigned char e_ident[EI_NIDENT];
 	int result;
 	memset(ehdr, 0, sizeof(*ehdr));
-	if (len < sizeof(e_ident)) {
+	if ((uintmax_t)len < (uintmax_t)sizeof(e_ident)) {
 		/* Buffer is to small to be an elf executable */
 		if (probe_debug) {
 			fprintf(stderr, "Buffer is to small to hold ELF e_ident\n");
@@ -387,7 +387,7 @@ static int build_mem_phdrs(const char *b
 		return -1;
 	}
 	phdr_size *= ehdr->e_phnum;
-	if (ehdr->e_phoff + phdr_size > len) {
+	if ((uintmax_t)(ehdr->e_phoff + phdr_size) > (uintmax_t)len) {
 		/* The program header did not fit in the file buffer */
 		if (probe_debug) {
 			fprintf(stderr, "ELF program segment truncated\n");
@@ -420,7 +420,8 @@ static int build_mem_phdrs(const char *b
 		 */
 		phdr = &ehdr->e_phdr[i];
 		if (!(flags & ELF_SKIP_FILESZ_CHECK)
-			&& (phdr->p_offset + phdr->p_filesz) > len) {
+			&& (uintmax_t)(phdr->p_offset + phdr->p_filesz) >
+			   (uintmax_t)len) {
 			/* The segment does not fit in the buffer */
 			if (probe_debug) {
 				fprintf(stderr, "ELF segment not in file\n");
@@ -599,7 +600,7 @@ static int build_mem_shdrs(const char *b
 		return -1;
 	}
 	shdr_size *= ehdr->e_shnum;
-	if (ehdr->e_shoff + shdr_size > len) {
+	if ((uintmax_t)(ehdr->e_shoff + shdr_size) > (uintmax_t)len) {
 		/* The section header did not fit in the file buffer */
 		if (probe_debug) {
 			fprintf(stderr, "ELF section header does not fit in file\n");
@@ -631,7 +632,8 @@ static int build_mem_shdrs(const char *b
 		shdr = &ehdr->e_shdr[i];
 		if (!(flags & ELF_SKIP_FILESZ_CHECK)
 			&& (shdr->sh_type != SHT_NOBITS)
-			&& (shdr->sh_offset + shdr->sh_size) > len) {
+			&& (uintmax_t)(shdr->sh_offset + shdr->sh_size) >
+			   (uintmax_t)len) {
 			/* The section does not fit in the buffer */
 			if (probe_debug) {
 				fprintf(stderr, "ELF section %zd not in file\n",
Index: kexec-tools/kexec/arch/i386/kexec-nbi.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-nbi.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-nbi.c	2010-02-01 23:07:19.000000000 +1100
@@ -74,7 +74,7 @@ int nbi_probe(const char *buf, off_t len
 	struct segheader seg;
 	off_t seg_off;
 	/* If we don't have enough data give up */
-	if ((len < sizeof(hdr)) || (len < 512)) {
+	if (((uintmax_t)len < (uintmax_t)sizeof(hdr)) || (len < 512)) {
 		return -1;
 	}
 	memcpy(&hdr, buf, sizeof(hdr));
Index: kexec-tools/kexec/arch/ppc/kexec-dol-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-dol-ppc.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/kexec-dol-ppc.c	2010-02-01 23:07:19.000000000 +1100
@@ -265,7 +265,8 @@ int dol_ppc_probe(const char *buf, off_t
 		}
 
 		/* end of physical storage must be within file */
-		if (dol_sect_offset(h, i) + dol_sect_size(h, i) > dol_length) {
+		if ((uintmax_t)(dol_sect_offset(h, i) + dol_sect_size(h, i)) >
+		    (uintmax_t)dol_length) {
 			if (debug) {
 				fprintf(stderr,
 					"%s segment past DOL file size\n",
Index: kexec-tools/kexec/arch/sh/kexec-uImage-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-uImage-sh.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-uImage-sh.c	2010-02-01 23:07:19.000000000 +1100
@@ -14,7 +14,7 @@ int uImage_sh_probe(const char *buf, off
 {
 	struct image_header header;
 
-	if (len < sizeof(header))
+	if ((uintmax_t)len < (uintmax_t)sizeof(header))
 		return -1;
 
 	memcpy(&header, buf, sizeof(header));
Index: kexec-tools/kexec/arch/arm/kexec-uImage-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-uImage-arm.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-uImage-arm.c	2010-02-01 23:07:19.000000000 +1100
@@ -12,7 +12,7 @@ int uImage_arm_probe(const char *buf, of
 {
 	struct image_header header;
 
-	if (len < sizeof(header))
+	if ((uintmax_t)len < (uintmax_t)sizeof(header))
 		return -1;
 
 	memcpy(&header, buf, sizeof(header));


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
