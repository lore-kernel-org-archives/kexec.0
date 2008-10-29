Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kv1fY-0006wU-PS
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 03:24:33 +0000
Subject: [PATCH 1/2] kexec jump support for kexec-tools
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 29 Oct 2008 11:24:25 +0800
Message-Id: <1225250665.24095.40.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1948135995=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>


--===============1948135995==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3en7NESG9gHstgymgpMB"


--=-3en7NESG9gHstgymgpMB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

To support memory backup/restore an option named
--load-preserve-context is added to kexec. When it is specified
toggether with --mem-max, most segments for crash dump support are
loaded, and the memory range between mem_min to mem_max which has no
segments loaded are loaded as backup segments. To support jump back
from kexeced, options named --load-jump-back-helper and --entry are
added to load a helper image with specified entry to jump back.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 kexec/arch/i386/crashdump-x86.c     |   51 +++++++---
 kexec/arch/i386/kexec-bzImage.c     |   10 +-
 kexec/arch/i386/kexec-elf-x86.c     |    4=20
 kexec/arch/i386/kexec-x86-common.c  |    3=20
 kexec/arch/i386/x86-linux-setup.h   |    3=20
 kexec/crashdump-elf.c               |    2=20
 kexec/crashdump.c                   |    1=20
 kexec/kexec-syscall.h               |    5 -
 kexec/kexec.c                       |  177 +++++++++++++++++++++++++++++++=
++++-
 kexec/kexec.h                       |   12 ++
 purgatory/arch/i386/purgatory-x86.c |   14 ++
 purgatory/arch/i386/setup-x86.S     |    3=20
 purgatory/include/purgatory.h       |    1=20
 purgatory/printf.c                  |   38 ++++++-
 14 files changed, 291 insertions(+), 33 deletions(-)

--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -75,8 +75,9 @@ static inline long kexec_reboot(void)
 }
=20
=20
-#define KEXEC_ON_CRASH  0x00000001
-#define KEXEC_ARCH_MASK 0xffff0000
+#define KEXEC_ON_CRASH		0x00000001
+#define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_ARCH_MASK		0xffff0000
=20
 /* These values match the ELF architecture values.=20
  * Unless there is a good reason that should continue to be the case.
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -378,6 +378,91 @@ unsigned long add_buffer_virt(struct kex
 				    buf_min, buf_max, buf_end, 0);
 }
=20
+static int find_memory_range(struct kexec_info *info,
+			     unsigned long *base, unsigned long *size)
+{
+	int i;
+	unsigned long start, end;
+
+	for (i =3D 0; i < info->memory_ranges; i++) {
+		if (info->memory_range[i].type !=3D RANGE_RAM)
+			continue;
+		start =3D info->memory_range[i].start;
+		end =3D info->memory_range[i].end;
+		if (end > *base && start < *base + *size) {
+			if (start > *base) {
+				*size =3D *base + *size - start;
+				*base =3D start;
+			}
+			if (end < *base + *size)
+				*size =3D end - *base;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int find_segment_hole(struct kexec_info *info,
+			     unsigned long *base, unsigned long *size)
+{
+	int i;
+	unsigned long seg_base, seg_size;
+
+	for (i =3D 0; i < info->nr_segments; i++) {
+		seg_base =3D (unsigned long)info->segment[i].mem;
+		seg_size =3D info->segment[i].memsz;
+
+		if (seg_base + seg_size <=3D *base)
+			continue;
+		else if (seg_base >=3D *base + *size)
+			break;
+		else if (*base < seg_base) {
+			*size =3D seg_base - *base;
+			break;
+		} else if (seg_base + seg_size < *base + *size) {
+			*size =3D *base + *size - (seg_base + seg_size);
+			*base =3D seg_base + seg_size;
+		} else {
+			*size =3D 0;
+			break;
+		}
+	}
+	return *size;
+}
+
+int add_backup_segments(struct kexec_info *info, unsigned long backup_base=
,
+			unsigned long backup_size)
+{
+	unsigned long mem_base, mem_size, bkseg_base, bkseg_size, start, end;
+	unsigned long pagesize;
+
+	pagesize =3D getpagesize();
+	while (backup_size) {
+		mem_base =3D backup_base;
+		mem_size =3D backup_size;
+		if (!find_memory_range(info, &mem_base, &mem_size))
+			break;
+		backup_size =3D backup_base + backup_size - \
+			(mem_base + mem_size);
+		backup_base =3D mem_base + mem_size;
+		while (mem_size) {
+			bkseg_base =3D mem_base;
+			bkseg_size =3D mem_size;
+			if (sort_segments(info) < 0)
+				return -1;
+			if (!find_segment_hole(info, &bkseg_base, &bkseg_size))
+				break;
+			start =3D (bkseg_base + pagesize - 1) & ~(pagesize - 1);
+			end =3D (bkseg_base + bkseg_size) & ~(pagesize - 1);
+			add_segment(info, NULL, 0, start, end-start);
+			mem_size =3D mem_base + mem_size - \
+				(bkseg_base + bkseg_size);
+			mem_base =3D bkseg_base + bkseg_size;
+		}
+	}
+	return 0;
+}
+
 char *slurp_file(const char *filename, off_t *r_size)
 {
 	int fd;
@@ -581,7 +666,7 @@ static void update_purgatory(struct kexe
  *	Load the new kernel
  */
 static int my_load(const char *type, int fileind, int argc, char **argv,
-	unsigned long kexec_flags)
+		   unsigned long kexec_flags, unsigned long entry)
 {
 	char *kernel;
 	char *kernel_buf;
@@ -665,6 +750,9 @@ static int my_load(const char *type, int
 	if (arch_compat_trampoline(&info) < 0) {
 		return -1;
 	}
+	if (info.kexec_flags & KEXEC_PRESERVE_CONTEXT) {
+		add_backup_segments(&info, mem_min, mem_max - mem_min + 1);
+	}
 	/* Verify all of the segments load to a valid location in memory */
 	for (i =3D 0; i < info.nr_segments; i++) {
 		if (!valid_memory_segment(&info, info.segment +i)) {
@@ -681,6 +769,8 @@ static int my_load(const char *type, int
 	}
 	/* if purgatory is loaded update it */
 	update_purgatory(&info);
+	if (entry)
+		info.entry =3D entry;
 #if 0
 	fprintf(stderr, "kexec_load: entry =3D %p flags =3D %lx\n",=20
 		info.entry, info.kexec_flags);
@@ -754,6 +844,47 @@ static int my_exec(void)
 	return -1;
 }
=20
+static int kexec_loaded(void);
+
+static int load_jump_back_helper_image(unsigned long kexec_flags,
+				       unsigned long entry)
+{
+	int result;
+	struct kexec_segment seg;
+
+	memset(&seg, 0, sizeof(seg));
+	result =3D kexec_load((void *)entry, 1, &seg,
+			    kexec_flags);
+	return result;
+}
+
+/*
+ *	Jump back to the original kernel
+ */
+static int my_load_jump_back_helper(unsigned long kexec_flags,
+				    unsigned long entry)
+{
+	int result;
+
+	if (kexec_loaded()) {
+		fprintf(stderr, "There is kexec kernel loaded, make sure "
+			"you are in kexeced kernel.\n");
+		return -1;
+	}
+	if (!entry) {
+		fprintf(stderr, "Please specify jump back entry "
+			"in command line\n");
+		return -1;
+	}
+	result =3D load_jump_back_helper_image(kexec_flags, entry);
+	if (result) {
+		fprintf(stderr, "load jump back kernel failed: %s\n",
+			strerror(errno));
+		return result;
+	}
+	return result;
+}
+
 static void version(void)
 {
 	printf(PACKAGE_STRING " released " PACKAGE_DATE "\n");
@@ -787,6 +918,10 @@ void usage(void)
 	       "     --mem-max=3D<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
 	       "     --reuseinird     Reuse initrd from first boot.\n"
+	       "     --load-preserve-context Load the new kernel and preserve\n"
+	       "                      context of current kernel during kexec.\n"
+	       "     --load-jump-back-helper Load a helper image to jump back\n"
+	       "                      to original kernel.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i =3D 0; i < file_types; i++) {
@@ -895,11 +1030,13 @@ int main(int argc, char *argv[])
 {
 	int do_load =3D 1;
 	int do_exec =3D 0;
+	int do_load_jump_back_helper =3D 0;
 	int do_shutdown =3D 1;
 	int do_sync =3D 1;
 	int do_ifdown =3D 0;
 	int do_unload =3D 0;
 	int do_reuse_initrd =3D 0;
+	unsigned long entry =3D 0;
 	char *type =3D 0;
 	char *endptr;
 	int opt;
@@ -949,6 +1086,32 @@ int main(int argc, char *argv[])
 			do_ifdown =3D 1;
 			do_exec =3D 1;
 			break;
+		case OPT_LOAD_JUMP_BACK_HELPER:
+			do_load =3D 0;
+			do_shutdown =3D 0;
+			do_sync =3D 1;
+			do_ifdown =3D 1;
+			do_exec =3D 0;
+			do_load_jump_back_helper =3D 1;
+			kexec_flags =3D KEXEC_PRESERVE_CONTEXT;
+			break;
+		case OPT_ENTRY:
+			entry =3D strtoul(optarg, &endptr, 0);
+			if (*endptr) {
+				fprintf(stderr,
+					"Bad option value in --load-jump-back-helper=3D%s\n",
+					optarg);
+				usage();
+				return 1;
+			}
+			break;
+		case OPT_LOAD_PRESERVE_CONTEXT:
+			do_load =3D 1;
+			do_exec =3D 0;
+			do_shutdown =3D 0;
+			do_sync =3D 1;
+			kexec_flags =3D KEXEC_PRESERVE_CONTEXT;
+			break;
 		case OPT_TYPE:
 			type =3D optarg;
 			break;
@@ -994,6 +1157,13 @@ int main(int argc, char *argv[])
 		die("Then try loading kdump kernel\n");
 	}
=20
+	if (do_load && (kexec_flags & KEXEC_PRESERVE_CONTEXT) &&
+	    mem_max =3D=3D ULONG_MAX) {
+		printf("Please specify memory range used by kexeced kernel\n");
+		printf("to preserve the context of original kernel with \n");
+		die("\"--mem-max\" parameter\n");
+	}
+
 	fileind =3D optind;
 	/* Reset getopt for the next pass; called in other source modules */
 	opterr =3D 1;
@@ -1021,7 +1191,7 @@ int main(int argc, char *argv[])
 		result =3D k_unload(kexec_flags);
 	}
 	if (do_load && (result =3D=3D 0)) {
-		result =3D my_load(type, fileind, argc, argv, kexec_flags);
+		result =3D my_load(type, fileind, argc, argv, kexec_flags, entry);
 	}
 	/* Don't shutdown unless there is something to reboot to! */
 	if ((result =3D=3D 0) && (do_shutdown || do_exec) && !kexec_loaded()) {
@@ -1039,6 +1209,9 @@ int main(int argc, char *argv[])
 	if ((result =3D=3D 0) && do_exec) {
 		result =3D my_exec();
 	}
+	if ((result =3D=3D 0) && do_load_jump_back_helper) {
+		result =3D my_load_jump_back_helper(kexec_flags, entry);
+	}
=20
 	fflush(stdout);
 	fflush(stderr);
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -174,7 +174,10 @@ extern int file_types;
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
 #define OPT_REUSE_INITRD	258
-#define OPT_MAX			259
+#define OPT_LOAD_PRESERVE_CONTEXT 259
+#define OPT_LOAD_JUMP_BACK_HELPER 260
+#define OPT_ENTRY		261
+#define OPT_MAX			262
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -183,6 +186,9 @@ extern int file_types;
 	{ "load",		0, 0, OPT_LOAD }, \
 	{ "unload",		0, 0, OPT_UNLOAD }, \
 	{ "exec",		0, 0, OPT_EXEC }, \
+	{ "load-preserve-context", 0, 0, OPT_LOAD_PRESERVE_CONTEXT}, \
+	{ "load-jump-back-helper", 0, 0, OPT_LOAD_JUMP_BACK_HELPER }, \
+	{ "entry",		1, 0, OPT_ENTRY }, \
 	{ "type",		1, 0, OPT_TYPE }, \
 	{ "load-panic",         0, 0, OPT_PANIC }, \
 	{ "mem-min",		1, 0, OPT_MEM_MIN }, \
@@ -242,6 +248,10 @@ int kexec_iomem_for_each_line(char *matc
 int parse_iomem_single(char *str, uint64_t *start, uint64_t *end);
 const char * proc_iomem(void);
=20
+extern int add_backup_segments(struct kexec_info *info,
+			       unsigned long backup_base,
+			       unsigned long backup_size);
+
 #define MAX_LINE	160
=20
 #ifdef DEBUG
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -114,6 +114,7 @@ int do_bzImage_load(struct kexec_info *i
 	unsigned int relocatable_kernel =3D 0;
 	unsigned long kernel32_load_addr;
 	char *modified_cmdline;
+	unsigned long cmdline_end;
=20
 	/*
 	 * Find out about the file I am about to load.
@@ -166,7 +167,7 @@ int do_bzImage_load(struct kexec_info *i
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
 	 */
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
+	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
 		modified_cmdline =3D xmalloc(COMMAND_LINE_SIZE);
 		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
 		if (command_line) {
@@ -205,11 +206,11 @@ int do_bzImage_load(struct kexec_info *i
 					0x3000, 640*1024, -1, 0);
 	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
 	/* The argument/parameter segment */
-	setup_size =3D kern16_size + command_line_len;
+	setup_size =3D kern16_size + command_line_len + PURGATORY_CMDLINE_SIZE;
 	real_mode =3D xmalloc(setup_size);
 	memcpy(real_mode, kernel, kern16_size);
=20
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
+	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
 		/* If using bzImage for capture kernel, then we will not be
 		 * executing real mode code. setup segment can be loaded
 		 * anywhere as we will be just reading command line.
@@ -316,6 +317,9 @@ int do_bzImage_load(struct kexec_info *i
 	elf_rel_set_symbol(&info->rhdr, "entry16_regs", &regs16, sizeof(regs16));
 	elf_rel_set_symbol(&info->rhdr, "entry16_debug_regs", &regs16, sizeof(reg=
s16));
 	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
+	cmdline_end =3D setup_base + kern16_size + command_line_len - 1;
+	elf_rel_set_symbol(&info->rhdr, "cmdline_end", &cmdline_end,
+			   sizeof(unsigned long));
=20
 	/* Fill in the information BIOS calls would normally provide. */
 	if (!real_mode_entry) {
--- a/kexec/arch/i386/x86-linux-setup.h
+++ b/kexec/arch/i386/x86-linux-setup.h
@@ -15,4 +15,7 @@ void setup_linux_system_parameters(struc
 #define KERN32_BASE  0x100000 /* 1MB */
 #define INITRD_BASE 0x1000000 /* 16MB */
=20
+/* command line parameter may be appended by purgatory */
+#define PURGATORY_CMDLINE_SIZE 64
+
 #endif /* X86_LINUX_SETUP_H */
--- a/purgatory/arch/i386/purgatory-x86.c
+++ b/purgatory/arch/i386/purgatory-x86.c
@@ -31,6 +31,8 @@ uint8_t reset_vga =3D 0;
 uint8_t legacy_timer =3D 0;
 uint8_t legacy_pic   =3D 0;
 uint8_t panic_kernel =3D 0;
+unsigned long jump_back_entry =3D 0;
+char *cmdline_end =3D 0;
=20
 void setup_arch(void)
 {
@@ -40,8 +42,18 @@ void setup_arch(void)
 	/* if (legacy_timer) x86_setup_legacy_timer(); */
 }
=20
+extern void x86_setup_jump_back_entry();
+
 /* This function can be used to execute after the SHA256 verification. */
 void post_verification_setup_arch(void)
 {
-	if (panic_kernel)   crashdump_backup_memory();
+	if (panic_kernel)    crashdump_backup_memory();
+	if (jump_back_entry) x86_setup_jump_back_entry();
+}
+
+void x86_setup_jump_back_entry()
+{
+	if (cmdline_end)
+		sprintf(cmdline_end, " kexec_jump_back_entry=3D0x%x",
+			jump_back_entry);
 }
--- a/purgatory/arch/i386/setup-x86.S
+++ b/purgatory/arch/i386/setup-x86.S
@@ -41,6 +41,9 @@ purgatory_start:
 	ljmp	$0x10,$1f
 1:	=09
=20
+	movl	0(%esp), %eax
+	movl	%eax, jump_back_entry
+
 	/* Setup a stack */
 	movl	$lstack_end, %esp
=20
--- a/purgatory/printf.c
+++ b/purgatory/printf.c
@@ -33,19 +33,23 @@ PRINTF and friends
 		%s	- string
 	Note: width specification not supported
 **************************************************************************=
/
-void printf(const char *fmt, ...)
+void vsprintf(char *buffer, const char *fmt, va_list args)
 {
-	va_list args;
 	char *p;
-	va_start(args, fmt);
 	for ( ; *fmt !=3D '\0'; ++fmt) {
 		if (*fmt !=3D '%') {
-			putchar(*fmt);
+			if (buffer)
+				*buffer++ =3D *fmt;
+			else
+				putchar(*fmt);
 			continue;
 		}
 		if (*++fmt =3D=3D 's') {
 			for(p =3D va_arg(args, char *); *p !=3D '\0'; p++)=20
-				putchar(*p);
+				if (buffer)
+					*buffer++ =3D *p;
+				else
+					putchar(*p);
 		}
 		else {	/* Length of item is bounded */
 			char tmp[40], *q =3D tmp;
@@ -121,8 +125,30 @@ void printf(const char *fmt, ...)
 				*q++ =3D *fmt;
 			/* now output the saved string */
 			for (p =3D tmp; p < q; ++p)
-				putchar(*p);
+				if (buffer)
+					*buffer++ =3D *p;
+				else
+					putchar(*p);
 		}
 	}
+	if (buffer)
+		*buffer =3D '\0';
+}
+
+void sprintf(char *buffer, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsprintf(buffer, fmt, args);
+	va_end(args);
+}
+
+void printf(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsprintf(0, fmt, args);
 	va_end(args);
 }
--- a/purgatory/include/purgatory.h
+++ b/purgatory/include/purgatory.h
@@ -2,6 +2,7 @@
 #define PURGATORY_H
=20
 void putchar(int ch);
+void sprintf(char *buffer, const char *fmt, ...);
 void printf(const char *fmt, ...);
 void setup_arch(void);
 void post_verification_setup_arch(void);
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -57,7 +57,8 @@ static struct memory_range crash_reserve
  * to look into down the line. May be something like /proc/kernelmem or ma=
y
  * be zone data structures exported from kernel.
  */
-static int get_crash_memory_ranges(struct memory_range **range, int *range=
s)
+static int get_crash_memory_ranges(struct memory_range **range, int *range=
s,
+				   int kexec_flags)
 {
 	const char *iomem =3D proc_iomem();
 	int memory_ranges =3D 0;
@@ -74,10 +75,12 @@ static int get_crash_memory_ranges(struc
=20
 	/* First entry is for first 640K region. Different bios report first
 	 * 640K in different manner hence hardcoding it */
-	crash_memory_range[0].start =3D 0x00000000;
-	crash_memory_range[0].end =3D 0x0009ffff;
-	crash_memory_range[0].type =3D RANGE_RAM;
-	memory_ranges++;
+	if (!(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
+		crash_memory_range[0].start =3D 0x00000000;
+		crash_memory_range[0].end =3D 0x0009ffff;
+		crash_memory_range[0].type =3D RANGE_RAM;
+		memory_ranges++;
+	}
=20
 	while(fgets(line, sizeof(line), fp) !=3D 0) {
 		char *str;
@@ -128,6 +131,22 @@ static int get_crash_memory_ranges(struc
 		}
 	}
 	fclose(fp);
+	if (kexec_flags & KEXEC_PRESERVE_CONTEXT) {
+		int i;
+		for (i =3D 0; i < memory_ranges; i++) {
+			if (crash_memory_range[i].end > 0x0009ffff) {
+				crash_reserved_mem.start =3D \
+					crash_memory_range[i].start;
+				break;
+			}
+		}
+		if (crash_reserved_mem.start >=3D mem_max) {
+			fprintf("Too small mem_max: 0x%lx.\n", mem_max);
+			return -1;
+		}
+		crash_reserved_mem.end =3D mem_max;
+		crash_reserved_mem.type =3D RANGE_RAM;
+	}
 	if (exclude_crash_reserve_region(&memory_ranges) < 0)
 		return -1;
 	*range =3D crash_memory_range;
@@ -514,7 +533,8 @@ int load_crashdump_segments(struct kexec
 	int nr_ranges, align =3D 1024;
 	struct memory_range *mem_range, *memmap_p;
=20
-	if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
+	if (get_crash_memory_ranges(&mem_range, &nr_ranges,
+				    info->kexec_flags) < 0)
 		return -1;
=20
 	/*
@@ -535,14 +555,17 @@ int load_crashdump_segments(struct kexec
 	add_memmap(memmap_p, crash_reserved_mem.start, sz);
=20
 	/* Create a backup region segment to store backup data*/
-	sz =3D (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
-	tmp =3D xmalloc(sz);
-	memset(tmp, 0, sz);
-	info->backup_start =3D add_buffer(info, tmp, sz, sz, align,
-				0, max_addr, -1);
-	dbgprintf("Created backup segment at 0x%lx\n", info->backup_start);
-	if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
-		return -1;
+	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
+		sz =3D (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+		tmp =3D xmalloc(sz);
+		memset(tmp, 0, sz);
+		info->backup_start =3D add_buffer(info, tmp, sz, sz, align,
+						0, max_addr, -1);
+		dbgprintf("Created backup segment at 0x%lx\n",
+			  info->backup_start);
+		if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
+			return -1;
+	}
=20
 	/* Create elf header segment and store crash image data. */
 	if (arch_options.core_header_type =3D=3D CORE_TYPE_ELF64) {
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -164,7 +164,7 @@ int FUNC(struct kexec_info *info,
 		dbgprintf_phdr("Elf header", phdr);
 	}
=20
-	if (has_vmcoreinfo) {
+	if (has_vmcoreinfo && !(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
 		phdr =3D (PHDR *) bufp;
 		bufp +=3D sizeof(PHDR);
 		phdr->p_type	=3D PT_NOTE;
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -170,7 +170,7 @@ int elf_x86_load(int argc, char **argv,=20
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
 	 */
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
+	if (info->kexec_flags & (KEXEC_ON_CRASH|KEXEC_PRESERVE_CONTEXT)) {
 		modified_cmdline =3D xmalloc(COMMAND_LINE_SIZE);
 		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
 		if (command_line) {
@@ -257,7 +257,7 @@ int elf_x86_load(int argc, char **argv,=20
=20
 		/* If panic kernel is being loaded, additional segments need
 		 * to be created. */
-		if (info->kexec_flags & KEXEC_ON_CRASH) {
+		if (info->kexec_flags & (KEXEC_ON_CRASH|KEXEC_PRESERVE_CONTEXT)) {
 			rc =3D load_crashdump_segments(info, modified_cmdline,
 						max_addr, 0);
 			if (rc < 0)
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -174,7 +174,8 @@ int get_memory_ranges(struct memory_rang
 	 * Override user values only if kernel exported values are
 	 * subset of user defined values.
 	 */
-	if (kexec_flags & KEXEC_ON_CRASH) {
+	if ((kexec_flags & KEXEC_ON_CRASH) &&
+	    !(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
 		unsigned long long start, end;
=20
 		ret =3D parse_iomem_single("Crash kernel\n", &start, &end);
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -29,6 +29,7 @@
 #include <elf.h>
 #include "kexec.h"
 #include "crashdump.h"
+#include "kexec-syscall.h"
=20
 /* include "crashdump-elf.c" twice to create two functions from one */
=20


--=-3en7NESG9gHstgymgpMB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkH12AACgkQKhFGF+eHlpgW/wCfc84khX7FxbszyZniCb6wLLFV
qoUAn0isduT0KIvO0osuRSHbm+uN6z84
=G0yE
-----END PGP SIGNATURE-----

--=-3en7NESG9gHstgymgpMB--



--===============1948135995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1948135995==--


