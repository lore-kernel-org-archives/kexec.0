Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAU-00056Y-21
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:24 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id E1E4B24657
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121322.623434165@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:08 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 12/27] Avoid possible overflows from signed/unsigned
	comparisons
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=signed-unsigned.patch
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

Index: kexec-tools/kdump/kdump.c
===================================================================
--- kexec-tools.orig/kdump/kdump.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kdump/kdump.c	2010-02-01 23:07:19.000000000 +1100
@@ -188,7 +188,8 @@ static void *generate_new_headers(
 
 static void write_all(int fd, const void *buf, size_t count)
 {
-	ssize_t result, written = 0;
+	ssize_t result;
+	size_t written = 0;
 	const char *ptr;
 	size_t left;
 	ptr = buf;
Index: kexec-tools/purgatory/purgatory.c
===================================================================
--- kexec-tools.orig/purgatory/purgatory.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/purgatory/purgatory.c	2010-02-01 23:07:19.000000000 +1100
@@ -13,7 +13,7 @@ void verify_sha256_digest(void)
 {
 	struct sha256_region *ptr, *end;
 	sha256_digest_t digest;
-	int i;
+	size_t i;
 	sha256_context ctx;
 	sha256_starts(&ctx);
 	end = &sha256_regions[sizeof(sha256_regions)/sizeof(sha256_regions[0])];
Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c	2010-02-01 23:07:18.000000000 +1100
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c	2010-02-01 23:07:19.000000000 +1100
@@ -375,7 +375,8 @@ static void ultoa(unsigned long i, char 
  * memory regions the new kernel can use to boot into. */
 static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
 {
-	int i, cmdlen, len, min_sizek = 100;
+	int i, cmdlen, len;
+	unsigned long min_sizek = 100;
 	char str_mmap[256], str_tmp[20];
 
 	/* Exact map */
Index: kexec-tools/kexec/kexec-elf.c
===================================================================
--- kexec-tools.orig/kexec/kexec-elf.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/kexec-elf.c	2010-02-01 23:07:19.000000000 +1100
@@ -369,8 +369,7 @@ static int build_mem_elf64_phdr(const ch
 static int build_mem_phdrs(const char *buf, off_t len, struct mem_ehdr *ehdr,
 				uint32_t flags)
 {
-	size_t phdr_size, mem_phdr_size;
-	int i;
+	size_t phdr_size, mem_phdr_size, i;
 
 	/* e_phnum is at most 65535 so calculating
 	 * the size of the program header cannot overflow.
@@ -582,8 +581,7 @@ static int build_mem_elf64_shdr(const ch
 static int build_mem_shdrs(const char *buf, off_t len, struct mem_ehdr *ehdr,
 				uint32_t flags)
 {
-	size_t shdr_size, mem_shdr_size;
-	int i;
+	size_t shdr_size, mem_shdr_size, i;
 
 	/* e_shnum is at most 65536 so calculating
 	 * the size of the section header cannot overflow.
@@ -636,7 +634,7 @@ static int build_mem_shdrs(const char *b
 			&& (shdr->sh_offset + shdr->sh_size) > len) {
 			/* The section does not fit in the buffer */
 			if (probe_debug) {
-				fprintf(stderr, "ELF section %d not in file\n",
+				fprintf(stderr, "ELF section %zd not in file\n",
 					i);
 			}
 			return -1;
@@ -666,8 +664,7 @@ static void read_nhdr(const struct mem_e
 static int build_mem_notes(struct mem_ehdr *ehdr)
 {
 	const unsigned char *note_start, *note_end, *note;
-	size_t note_size;
-	int i;
+	size_t note_size, i;
 	/* First find the note segment or section */
 	note_start = note_end = NULL;
 	for(i = 0; !note_start && (i < ehdr->e_phnum); i++) {
Index: kexec-tools/kexec/kexec-elf-exec.c
===================================================================
--- kexec-tools.orig/kexec/kexec-elf-exec.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/kexec-elf-exec.c	2010-02-01 23:07:19.000000000 +1100
@@ -53,7 +53,7 @@ int elf_exec_load(struct mem_ehdr *ehdr,
 {
 	unsigned long base;
 	int result;
-	int i;
+	size_t i;
 
 	if (!ehdr->e_phdr) {
 		fprintf(stderr, "No program header?\n");
Index: kexec-tools/kexec/lzma.c
===================================================================
--- kexec-tools.orig/kexec/lzma.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/lzma.c	2010-02-01 23:07:19.000000000 +1100
@@ -91,7 +91,7 @@ LZFILE *lzopen(const char *path, const c
 int lzclose(LZFILE *lzfile)
 {
 	lzma_ret ret;
-	int n;
+	size_t n;
 
 	if (!lzfile)
 		return -1;
Index: kexec-tools/kexec/arch/i386/kexec-multiboot-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-multiboot-x86.c	2010-02-01 23:07:15.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-multiboot-x86.c	2010-02-01 23:07:19.000000000 +1100
@@ -154,6 +154,7 @@ int multiboot_x86_load(int argc, char **
 	struct AddrRangeDesc *mmap;
 	int command_line_len;
 	int i;
+	uint32_t u;
 	int opt;
 	int modules, mod_command_line_space;
 #define OPT_CL  		(OPT_ARCH_MAX+0)
@@ -375,8 +376,8 @@ int multiboot_x86_load(int argc, char **
 	/* Relocate offsets in the MBI to absolute addresses */
 	mbi_offset = mbi_base;
 	modp = ((void *)mbi) + mbi->mods_addr;
-	for (i=0; i<mbi->mods_count; i++) {
-		modp[i].cmdline += mbi_offset;
+	for (u = 0; u < mbi->mods_count; u++) {
+		modp[u].cmdline += mbi_offset;
 	}
 	mbi->mods_addr += mbi_offset;
 	mbi->cmdline += mbi_offset;
Index: kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-01 23:07:19.000000000 +1100
@@ -487,7 +487,8 @@ static void ultoa(unsigned long i, char 
  * memory regions the new kernel can use to boot into. */
 static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
 {
-	int i, cmdlen, len, min_sizek = 100;
+	int i, cmdlen, len;
+	unsigned long min_sizek = 100;
 	char str_mmap[256], str_tmp[20];
 
 	/* Exact map */
Index: kexec-tools/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/fs2dt.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/fs2dt.c	2010-02-01 23:07:19.000000000 +1100
@@ -127,8 +127,9 @@ static void add_dyn_reconf_usable_mem_pr
 	uint64_t buf[32];
 	uint64_t ranges[2*MAX_MEMORY_RANGES];
 	uint64_t base, end, loc_base, loc_end;
-	int range, rlen = 0, i;
-	int rngs_cnt, tmp_indx;
+	size_t i, rngs_cnt, range;
+	int rlen = 0;
+	int tmp_indx;
 
 	strcpy(fname, pathname);
 	bname = strrchr(fname, '/');
@@ -189,13 +190,15 @@ static void add_dyn_reconf_usable_mem_pr
 	dt += (rlen + 3)/4;
 }
 
-static void add_usable_mem_property(int fd, int len)
+static void add_usable_mem_property(int fd, size_t len)
 {
 	char fname[MAXPATH], *bname;
 	uint64_t buf[2];
 	uint64_t ranges[2*MAX_MEMORY_RANGES];
 	uint64_t base, end, loc_base, loc_end;
-	int range, rlen = 0;
+	size_t range;
+	int rlen = 0;
+	ssize_t slen;
 
 	strcpy(fname, pathname);
 	bname = strrchr(fname,'/');
@@ -206,12 +209,12 @@ static void add_usable_mem_property(int 
 
 	if (len < 2 * sizeof(uint64_t))
 		die("unrecoverable error: not enough data for mem property\n");
-	len = 2 * sizeof(uint64_t);
+	slen = 2 * sizeof(uint64_t);
 
 	if (lseek(fd, 0, SEEK_SET) < 0)
 		die("unrecoverable error: error seeking in \"%s\": %s\n",
 		    pathname, strerror(errno));
-	if (read(fd, buf, len) != len)
+	if (read(fd, buf, slen) != slen)
 		die("unrecoverable error: error reading \"%s\": %s\n",
 		    pathname, strerror(errno));
 
@@ -263,7 +266,9 @@ static void add_usable_mem_property(int 
 static void putprops(char *fn, struct dirent **nlist, int numlist)
 {
 	struct dirent *dp;
-	int i = 0, fd, len;
+	int i = 0, fd;
+	size_t len;
+	ssize_t slen;
 	struct stat statbuf;
 
 	for (i = 0; i < numlist; i++) {
@@ -324,9 +329,13 @@ static void putprops(char *fn, struct di
 			die("unrecoverable error: could not open \"%s\": %s\n",
 			    pathname, strerror(errno));
 
-		if (read(fd, dt, len) != len)
+		slen = read(fd, dt, len);
+		if (slen < 0)
 			die("unrecoverable error: could not read \"%s\": %s\n",
 			    pathname, strerror(errno));
+		if ((size_t)slen != len)
+			die("unrecoverable error: short read from\"%s\"\n",
+			    pathname);
 
 		checkprop(fn, dt, len);
 
Index: kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2010-02-01 23:07:19.000000000 +1100
@@ -84,7 +84,7 @@ int elf_ppc64_load(int argc, char **argv
 	size_t size;
 	uint64_t *rsvmap_ptr;
 	struct bootblock *bb_ptr;
-	unsigned int i;
+	int i;
 	int result, opt;
 	uint64_t my_kernel, my_dt_offset;
 	unsigned int my_panic_kernel;
Index: kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2010-02-01 23:07:19.000000000 +1100
@@ -148,7 +148,8 @@ static int get_dyn_reconf_base_ranges(vo
 	uint64_t start, end;
 	char fname[128], buf[32];
 	FILE *file;
-	int i, n;
+	unsigned int i;
+	int n;
 
 	strcpy(fname, "/proc/device-tree/");
 	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
Index: kexec-tools/kexec/arch/ppc64/crashdump-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/crashdump-ppc64.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.c	2010-02-01 23:07:19.000000000 +1100
@@ -126,7 +126,8 @@ static int get_dyn_reconf_crash_memory_r
 	uint64_t start, end;
 	char fname[128], buf[32];
 	FILE *file;
-	int i, n;
+	unsigned int i;
+	int n;
 	uint32_t flags;
 
 	strcpy(fname, "/proc/device-tree/");
@@ -450,7 +451,7 @@ int load_crashdump_segments(struct kexec
 
 void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 {
-	int i;
+	unsigned int i;
 	unsigned long long end = base + size;
 	unsigned long long ustart, uend;
 
Index: kexec-tools/kexec/arch/ia64/kexec-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:17.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:19.000000000 +1100
@@ -101,7 +101,7 @@ int get_memory_ranges(struct memory_rang
 	while(fgets(line, sizeof(line), fp) != 0) {
 		unsigned long start, end;
 		char *str;
-		int type;
+		unsigned type;
 		int consumed;
 		int count;
 		if (memory_ranges >= max_memory_ranges)
@@ -219,13 +219,14 @@ int arch_compat_trampoline(struct kexec_
 int update_loaded_segments(struct mem_ehdr *ehdr)
 {
 	int i;
+	unsigned u;
 	struct mem_phdr *phdr;
 	unsigned long start_addr = ULONG_MAX, end_addr = 0;
 	unsigned long align = 1UL<<26; /* 64M */
 	unsigned long start, end;
 
-	for (i = 0; i < ehdr->e_phnum; i++) {
-		phdr = &ehdr->e_phdr[i];
+	for (u = 0; u < ehdr->e_phnum; u++) {
+		phdr = &ehdr->e_phdr[u];
 		if (phdr->p_type != PT_LOAD)
 			continue;
 		if (phdr->p_paddr < start_addr)
Index: kexec-tools/kexec/arch/ia64/kexec-elf-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-elf-ia64.c	2010-02-01 23:07:17.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-elf-ia64.c	2010-02-01 23:07:19.000000000 +1100
@@ -98,7 +98,7 @@ void elf_ia64_usage(void)
  */
 void move_loaded_segments(struct mem_ehdr *ehdr, unsigned long addr)
 {
-	int i;
+	unsigned i;
 	long offset;
 	struct mem_phdr *phdr;
 	for(i = 0; i < ehdr->e_phnum; i++) {
Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:07:18.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:07:19.000000000 +1100
@@ -73,7 +73,7 @@ static int seg_comp(const void *a, const
  */
 static void add_loaded_segments_info(struct mem_ehdr *ehdr)
 {
-	 int i;
+	 unsigned i;
          for(i = 0; i < ehdr->e_phnum; i++) {
                 struct mem_phdr *phdr;
                 phdr = &ehdr->e_phdr[i];
Index: kexec-tools/purgatory/arch/ia64/purgatory-ia64.c
===================================================================
--- kexec-tools.orig/purgatory/arch/ia64/purgatory-ia64.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/purgatory/arch/ia64/purgatory-ia64.c	2010-02-01 23:07:19.000000000 +1100
@@ -159,7 +159,7 @@ patch_efi_memmap(struct kexec_boot_param
 	uint64_t orig_type;
 	efi_memory_desc_t *src_md, *dst_md;
 	void *src_end = src + boot_param->efi_memmap_size;
-	int i;
+	unsigned long i;
 	for (; src < src_end; src += boot_param->efi_memdesc_size,
 	     dest += boot_param->efi_memdesc_size) {
 		unsigned long mstart, mend;
Index: kexec-tools/kexec/arch/sh/kexec-zImage-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:07:17.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:07:19.000000000 +1100
@@ -74,8 +74,8 @@ int zImage_sh_load(int argc, char **argv
 	struct kexec_info *info)
 {
         char *command_line;
-	int opt, k;
-	unsigned long empty_zero, zero_page_base, zero_page_size;
+	int opt;
+	unsigned long empty_zero, zero_page_base, zero_page_size, k;
 	unsigned long image_base;
 	char *param;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
