Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAX-0005C8-KO
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:26 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 263E72465C
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121323.753648398@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:14 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 18/27] Make purgatory a signed char buffer
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=char-purgatory.patch
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

The consumer of the purgatory buffer, elf_rel_build_load()
expects a signed char buffer.

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/util/bin-to-hex.c
===================================================================
--- kexec-tools.orig/util/bin-to-hex.c	2010-02-01 23:06:39.000000000 +1100
+++ kexec-tools/util/bin-to-hex.c	2010-02-01 23:07:21.000000000 +1100
@@ -6,7 +6,7 @@ int main(int argc, char **argv)
 	int i;
 	const char *name = argv[1];
 	printf("#include <stddef.h>\n");
-	printf("const unsigned char %s[] = {\n", name);
+	printf("const char %s[] = {\n", name);
 	i = 0;
 	while((c = getchar()) != EOF) {
 		if ((i % 16) != 0) {
Index: kexec-tools/kexec/arch/i386/kexec-bzImage.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:21.000000000 +1100
@@ -200,10 +200,10 @@ int do_bzImage_load(struct kexec_info *i
 	 * overflow takes place while applying relocations.
 	 */
 	if (!real_mode_entry && relocatable_kernel)
-		elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size,
+		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 					0x3000, 0x7fffffff, -1, 0);
 	else
-		elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size,
+		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 					0x3000, 640*1024, -1, 0);
 	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
 	/* The argument/parameter segment */
Index: kexec-tools/kexec/arch/i386/kexec-elf-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-elf-x86.c	2010-02-01 23:07:15.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-elf-x86.c	2010-02-01 23:07:21.000000000 +1100
@@ -191,7 +191,7 @@ int elf_x86_load(int argc, char **argv, 
 	/* Do we want arguments? */
 	if (arg_style != ARG_STYLE_NONE) {
 		/* Load the setup code */
-		elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size,
+		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 			0, ULONG_MAX, 1, 0);
 	}
 	if (arg_style == ARG_STYLE_NONE) {
Index: kexec-tools/kexec/arch/i386/kexec-multiboot-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-multiboot-x86.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-multiboot-x86.c	2010-02-01 23:07:21.000000000 +1100
@@ -217,7 +217,7 @@ int multiboot_x86_load(int argc, char **
 	elf_exec_build_load(info, &ehdr, buf, len, 0);
 
 	/* Load the setup code */
-	elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size, 0,
+	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size, 0,
 				ULONG_MAX, 1, 0);
 	
 	/* The first segment will contain the multiboot headers:
Index: kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2010-02-01 23:07:21.000000000 +1100
@@ -207,7 +207,7 @@ int elf_ppc64_load(int argc, char **argv
 	}
 
 	/* Add v2wrap to the current image */
-	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
+	elf_rel_build_load(info, &info->rhdr, purgatory,
 				purgatory_size, 0, max_addr, 1, 0);
 
 	/* Add a ram-disk to the current image
Index: kexec-tools/kexec/kexec.h
===================================================================
--- kexec-tools.orig/kexec/kexec.h	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/kexec.h	2010-02-01 23:07:21.000000000 +1100
@@ -226,7 +226,7 @@ extern void arch_reuse_initrd(void);
 
 extern int ifdown(void);
 
-extern unsigned char purgatory[];
+extern char purgatory[];
 extern size_t purgatory_size;
 
 #define BOOTLOADER "kexec"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
