Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.243]
	helo=rv-out-0506.google.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRzK-0006vd-QO
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:33:27 +0000
Received: by rv-out-0506.google.com with SMTP id b17so1263444rvf.42
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:33:26 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 5/9] Fix all gcc warnings for ARCH=i386 builds.
Date: Tue, 22 Apr 2008 16:21:08 -0700
Message-Id: <1208906472-18465-6-git-send-email-jamey@thetovacompany.com>
In-Reply-To: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
References: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
Some of GCC's warnings are clearly pointless in this code, but because
the "die" function is not declared "noreturn", GCC can't tell. In those
cases, I chose to initialize variables uselessly, rather than worry
about convinving the compiler that the existing code was actually OK.

 kexec/arch/i386/crashdump-x86.c       |    7 +++----
 kexec/arch/i386/kexec-beoboot-x86.c   |    2 +-
 kexec/arch/i386/kexec-bzImage.c       |    8 ++++----
 kexec/arch/i386/kexec-elf-x86.c       |    6 +++---
 kexec/arch/i386/kexec-multiboot-x86.c |    2 +-
 kexec/kexec-elf-rel.c                 |    8 ++++----
 kexec/kexec.c                         |    2 +-
 7 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 86dc166..7717219 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -151,7 +151,7 @@ static int exclude_crash_reserve_region(int *nr_ranges)
 {
 	int i, j, tidx = -1;
 	unsigned long long cstart, cend;
-	struct memory_range temp_region;
+	struct memory_range temp_region = { };
 
 	/* Crash reserved region. */
 	cstart = crash_reserved_mem.start;
@@ -185,9 +185,7 @@ static int exclude_crash_reserve_region(int *nr_ranges)
 		}
 		for (j = (*nr_ranges - 1); j >= tidx; j--)
 			crash_memory_range[j+1] = crash_memory_range[j];
-		crash_memory_range[tidx].start = temp_region.start;
-		crash_memory_range[tidx].end = temp_region.end;
-		crash_memory_range[tidx].type = temp_region.type;
+		crash_memory_range[tidx] = temp_region;
 		(*nr_ranges)++;
 	}
 	return 0;
@@ -291,6 +289,7 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
 				memmap_p[i].end = addr - 1;
 				temp_region.start = addr + size;
 				temp_region.end = mend;
+				temp_region.type = memmap_p[i].type;
 				operation = 1;
 				tidx = i;
 				break;
diff --git a/kexec/arch/i386/kexec-beoboot-x86.c b/kexec/arch/i386/kexec-beoboot-x86.c
index a73a3cb..2b1c34b 100644
--- a/kexec/arch/i386/kexec-beoboot-x86.c
+++ b/kexec/arch/i386/kexec-beoboot-x86.c
@@ -79,7 +79,7 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	struct beoboot_header bb_header;
-	const unsigned char *command_line, *kernel, *initrd;
+	const char *command_line, *kernel, *initrd;
 
 	int debug, real_mode_entry;
 	int opt;
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index abb094c..9ca3cea 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -128,7 +128,7 @@ int do_bzImage_load(struct kexec_info *info,
 	}
 
 	kern16_size = (setup_sects +1) *512;
-	kernel_version = ((unsigned char *)&setup_header) + 512 + setup_header.kver_addr;
+	kernel_version = ((char *)&setup_header) + 512 + setup_header.kver_addr;
 	if (kernel_len < kern16_size) {
 		fprintf(stderr, "BzImage truncated?\n");
 		return -1;
@@ -198,10 +198,10 @@ int do_bzImage_load(struct kexec_info *info,
 	 * overflow takes place while applying relocations.
 	 */
 	if (!real_mode_entry && relocatable_kernel)
-		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+		elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size,
 					0x3000, 0x7fffffff, -1, 0);
 	else
-		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+		elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size,
 					0x3000, 640*1024, -1, 0);
 	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
 	/* The argument/parameter segment */
@@ -262,7 +262,7 @@ int do_bzImage_load(struct kexec_info *info,
 	/* Tell the kernel what is going on */
 	setup_linux_bootloader_parameters(info, real_mode, setup_base,
 		kern16_size, command_line, command_line_len,
-		initrd, initrd_len);
+		(unsigned char *) initrd, initrd_len);
 
 	/* Get the initial register values */
 	elf_rel_get_symbol(&info->rhdr, "entry16_regs", &regs16, sizeof(regs16));
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index 76ea0e2..249dfa6 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -185,7 +185,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	/* Do we want arguments? */
 	if (arg_style != ARG_STYLE_NONE) {
 		/* Load the setup code */
-		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+		elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size,
 			0, ULONG_MAX, 1, 0);
 	}
 	if (arg_style == ARG_STYLE_NONE) {
@@ -199,7 +199,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 
 		/* Setup the ELF boot notes */
 		note_base = elf_boot_notes(info, max_addr,
-			command_line, command_line_len);
+			(unsigned char *) command_line, command_line_len);
 
 		/* Initialize the stack arguments */
 		arg2 = 0; /* No return address */
@@ -247,7 +247,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 		ramdisk_buf = NULL;
 		ramdisk_length = 0;
 		if (ramdisk) {
-			ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
+			ramdisk_buf = (unsigned char *) slurp_file(ramdisk, &ramdisk_length);
 		}
 
 		/* If panic kernel is being loaded, additional segments need
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 5ad279a..1618c82 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -210,7 +210,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	elf_exec_build_load(info, &ehdr, buf, len, 0);
 
 	/* Load the setup code */
-	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size, 0,
+	elf_rel_build_load(info, &info->rhdr, (char *) purgatory, purgatory_size, 0,
 				ULONG_MAX, 1, 0);
 	
 	/* The first segment will contain the multiboot headers:
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index 4419937..74c4b35 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -58,7 +58,7 @@ static size_t elf_rela_size(struct mem_ehdr *ehdr)
 
 static struct mem_sym elf_sym(struct mem_ehdr *ehdr, const unsigned char *ptr)
 {
-	struct mem_sym sym;
+	struct mem_sym sym = { };
 	if (ehdr->ei_class == ELFCLASS32) {
 		Elf32_Sym lsym;
 		memcpy(&lsym, ptr, sizeof(lsym));
@@ -87,7 +87,7 @@ static struct mem_sym elf_sym(struct mem_ehdr *ehdr, const unsigned char *ptr)
 
 static struct mem_rela elf_rel(struct mem_ehdr *ehdr, const unsigned char *ptr)
 {
-	struct mem_rela rela;
+	struct mem_rela rela = { };
 	if (ehdr->ei_class == ELFCLASS32) {
 		Elf32_Rel lrel;
 		memcpy(&lrel, ptr, sizeof(lrel));
@@ -112,7 +112,7 @@ static struct mem_rela elf_rel(struct mem_ehdr *ehdr, const unsigned char *ptr)
 
 static struct mem_rela elf_rela(struct mem_ehdr *ehdr, const unsigned char *ptr)
 {
-	struct mem_rela rela;
+	struct mem_rela rela = { };
 	if (ehdr->ei_class == ELFCLASS32) {
 		Elf32_Rela lrela;
 		memcpy(&lrela, ptr, sizeof(lrela));
@@ -339,7 +339,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 			struct mem_rela rel;
 			struct mem_sym sym;
 			const void *location;
-			const char *name;
+			const unsigned char *name;
 			unsigned long address, value, sec_base;
 			if (shdr->sh_type == SHT_REL) {
 				rel = elf_rel(ehdr, ptr);
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 0647295..20b2ae4 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -584,7 +584,7 @@ static void update_purgatory(struct kexec_info *info)
 			sha256_update(&ctx, null_buf, bytes);
 			nullsz -= bytes;
 		}
-		region[j].start = info->segment[i].mem;
+		region[j].start = (unsigned long) info->segment[i].mem;
 		region[j].len   = info->segment[i].memsz;
 		j++;
 	}
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
