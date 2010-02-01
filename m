Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAX-00056S-3e
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:28 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 0EC9C2465A
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121323.368952751@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:12 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 16/27] Use C99 initialisers
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=c99-initializer.patch
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

Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c	2010-02-01 23:07:20.000000000 +1100
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c	2010-02-01 23:07:20.000000000 +1100
@@ -171,7 +171,7 @@ static int exclude_crash_reserve_region(
 {
 	int i, j, tidx = -1;
 	unsigned long long cstart, cend;
-	struct memory_range temp_region = { };
+	struct memory_range temp_region = {0, 0, 0};
 
 	/* Crash reserved region. */
 	cstart = crash_reserved_mem.start;
Index: kexec-tools/kexec/kexec-elf-rel.c
===================================================================
--- kexec-tools.orig/kexec/kexec-elf-rel.c	2010-02-01 23:06:39.000000000 +1100
+++ kexec-tools/kexec/kexec-elf-rel.c	2010-02-01 23:07:20.000000000 +1100
@@ -58,7 +58,7 @@ static size_t elf_rela_size(struct mem_e
 
 static struct mem_sym elf_sym(struct mem_ehdr *ehdr, const unsigned char *ptr)
 {
-	struct mem_sym sym = { };
+	struct mem_sym sym = { 0, 0, 0, 0, 0, 0 };
 	if (ehdr->ei_class == ELFCLASS32) {
 		Elf32_Sym lsym;
 		memcpy(&lsym, ptr, sizeof(lsym));
@@ -87,7 +87,7 @@ static struct mem_sym elf_sym(struct mem
 
 static struct mem_rela elf_rel(struct mem_ehdr *ehdr, const unsigned char *ptr)
 {
-	struct mem_rela rela = { };
+	struct mem_rela rela = { 0, 0, 0, 0 };
 	if (ehdr->ei_class == ELFCLASS32) {
 		Elf32_Rel lrel;
 		memcpy(&lrel, ptr, sizeof(lrel));
@@ -112,7 +112,7 @@ static struct mem_rela elf_rel(struct me
 
 static struct mem_rela elf_rela(struct mem_ehdr *ehdr, const unsigned char *ptr)
 {
-	struct mem_rela rela = { };
+	struct mem_rela rela = { 0, 0, 0, 0 };
 	if (ehdr->ei_class == ELFCLASS32) {
 		Elf32_Rela lrela;
 		memcpy(&lrela, ptr, sizeof(lrela));
Index: kexec-tools/kexec/arch/x86_64/kexec-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/kexec-x86_64.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/kexec-x86_64.c	2010-02-01 23:07:20.000000000 +1100
@@ -145,7 +145,7 @@ const struct arch_map_entry arches[] = {
 	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_X86_64 here.
 	 */
 	{ "x86_64", KEXEC_ARCH_DEFAULT },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
Index: kexec-tools/kexec/arch/ppc/kexec-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-ppc.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/kexec-ppc.c	2010-02-01 23:07:20.000000000 +1100
@@ -82,7 +82,7 @@ const struct arch_map_entry arches[] = {
 	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_PPC here.
 	 */
 	{ "ppc", KEXEC_ARCH_DEFAULT },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
Index: kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2010-02-01 23:07:20.000000000 +1100
@@ -802,7 +802,7 @@ const struct arch_map_entry arches[] = {
 	 * So pass KEXEC_ARCH_PPC64 here
 	 */
 	{ "ppc64", KEXEC_ARCH_PPC64 },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
Index: kexec-tools/kexec/arch/ia64/kexec-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:20.000000000 +1100
@@ -208,7 +208,7 @@ int arch_process_options(int argc, char 
 
 const struct arch_map_entry arches[] = {
 	{ "ia64", KEXEC_ARCH_IA_64 },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
Index: kexec-tools/kexec/arch/s390/kexec-s390.c
===================================================================
--- kexec-tools.orig/kexec/arch/s390/kexec-s390.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/s390/kexec-s390.c	2010-02-01 23:07:20.000000000 +1100
@@ -98,7 +98,7 @@ int arch_process_options(int UNUSED(argc
 const struct arch_map_entry arches[] = {
 	{ "s390", KEXEC_ARCH_S390 },
 	{ "s390x", KEXEC_ARCH_S390 },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
Index: kexec-tools/kexec/arch/sh/kexec-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-sh.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-sh.c	2010-02-01 23:07:20.000000000 +1100
@@ -135,7 +135,7 @@ const struct arch_map_entry arches[] = {
 	{ "sh4", KEXEC_ARCH_DEFAULT },
 	{ "sh4a", KEXEC_ARCH_DEFAULT },
 	{ "sh4al-dsp", KEXEC_ARCH_DEFAULT },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
Index: kexec-tools/kexec/arch/arm/kexec-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-arm.c	2010-02-01 23:07:18.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-arm.c	2010-02-01 23:07:20.000000000 +1100
@@ -110,7 +110,7 @@ int arch_process_options(int argc, char 
 
 const struct arch_map_entry arches[] = {
 	{ "arm", KEXEC_ARCH_ARM },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
Index: kexec-tools/kexec/arch/mips/kexec-mips.c
===================================================================
--- kexec-tools.orig/kexec/arch/mips/kexec-mips.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/mips/kexec-mips.c	2010-02-01 23:07:20.000000000 +1100
@@ -127,7 +127,7 @@ const struct arch_map_entry arches[] = {
 	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_MIPS here.
 	 */
 	{ "mips", KEXEC_ARCH_DEFAULT },
-	{ 0 },
+	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
