Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OCmIp-0002O8-8C
	for kexec@lists.infradead.org; Fri, 14 May 2010 04:15:14 +0000
Message-ID: <4BECCE4D.2030905@ozlabs.org>
Date: Fri, 14 May 2010 14:15:09 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: [PATCH v2] kexec-tools: Fix option/argument parsing
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Michael Neuling <mikey@neuling.org>, Simon Horman <horms@verge.net.au>

Hi,

v2 changes:
- Fixed ARM's multiline KEXEC_ALL_OPTIONS #define
- Removed opterr=0 from main()'s getopts_long() scan, and handle 
  unknown options in main() (as it now knows about all allowed opts).  
  Previously it relied on the file_type->load()er parsing & complaining
  about unknown options; if the loader didn't parse them, no complaint.

Tested on x86, ppc and compile-tested on my new crisv32-axis-linux-gnu
crosscompiler :-)


Cheers,


Matt


---
The argument parsing is currently a bit broken as main()'s getopt_long()
knows nothing about either the architecture-specific options or, even
more specifically, the architecture-and-loader-specific options.

This patch introduces new #defines for all architectures,
KEXEC_ALL_OPTIONS and KEXEC_ALL_OPT_STR.  These contain all possible
options for a given build, and the getopt_long() passes in main() and
arch_process_options() will now recognise arch- and loader-specific
options; these will not be re-ordered in argv[], there is no confusion
over which argv[] entry is the kernel filename, and using '--opt=foo' and
'--opt foo' both work.

All architectures have command line options (and #define OPT_BLAHs)
consolidated into their include/arch/option.h files.  x86_64 builds
parts of i386/ as well, so now both share a single option.h file (with
a symlink).

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 kexec/arch/alpha/include/arch/options.h  |    9 +++++
 kexec/arch/arm/include/arch/options.h    |   29 +++++++++++++++++
 kexec/arch/arm/kexec-zImage-arm.c        |    3 +-
 kexec/arch/cris/include/arch/options.h   |   32 ++++++++++++++++--
 kexec/arch/cris/kexec-elf-cris.c         |    4 +-
 kexec/arch/i386/include/arch/options.h   |   51 ++++++++++++++++++++++++++++++
 kexec/arch/i386/kexec-beoboot-x86.c      |    3 +-
 kexec/arch/i386/kexec-bzImage.c          |    6 +--
 kexec/arch/i386/kexec-elf-x86.c          |    7 +---
 kexec/arch/i386/kexec-multiboot-x86.c    |    5 +--
 kexec/arch/i386/kexec-x86.c              |    4 +-
 kexec/arch/ia64/include/arch/options.h   |   33 ++++++++++++++++++-
 kexec/arch/ia64/kexec-elf-ia64.c         |    7 +---
 kexec/arch/mips/include/arch/options.h   |   27 +++++++++++++++-
 kexec/arch/mips/kexec-elf-mips.c         |    3 +-
 kexec/arch/ppc/include/arch/options.h    |   34 ++++++++++++++++++++
 kexec/arch/ppc/kexec-dol-ppc.c           |    4 +-
 kexec/arch/ppc/kexec-elf-ppc.c           |    7 +---
 kexec/arch/ppc/kexec-uImage-ppc.c        |    6 +--
 kexec/arch/ppc64/include/arch/options.h  |   37 ++++++++++++++++++++-
 kexec/arch/ppc64/kexec-elf-ppc64.c       |   12 ++++---
 kexec/arch/ppc64/kexec-ppc64.c           |   12 +++----
 kexec/arch/s390/include/arch/options.h   |   28 ++++++++++++++++-
 kexec/arch/s390/kexec-image.c            |    4 +--
 kexec/arch/sh/include/arch/options.h     |   26 +++++++++++++--
 kexec/arch/sh/kexec-sh.c                 |    7 +++-
 kexec/arch/x86_64/include/arch/options.h |   23 +-------------
 kexec/arch/x86_64/kexec-elf-x86_64.c     |    7 +---
 kexec/arch/x86_64/kexec-x86_64.c         |    4 +-
 kexec/kexec.c                            |    6 ++--
 30 files changed, 341 insertions(+), 99 deletions(-)
 mode change 100644 => 120000 kexec/arch/x86_64/include/arch/options.h

diff --git a/kexec/arch/alpha/include/arch/options.h b/kexec/arch/alpha/include/arch/options.h
index 11557a4..a012c8a 100644
--- a/kexec/arch/alpha/include/arch/options.h
+++ b/kexec/arch/alpha/include/arch/options.h
@@ -3,9 +3,18 @@
 
 #define OPT_ARCH_MAX   (OPT_MAX+0)
 
+/* Options relevant to the architecture (excluding loader-specific ones),
+ * in this case none:
+ */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* See the other architectures for details of these; Alpha has no
+ * loader-specific options yet.
+ */
+#define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
+
 #endif /* KEXEC_ARCH_ALPHA_OPTIONS_H */
diff --git a/kexec/arch/arm/include/arch/options.h b/kexec/arch/arm/include/arch/options.h
index 248230b..d89c91f 100644
--- a/kexec/arch/arm/include/arch/options.h
+++ b/kexec/arch/arm/include/arch/options.h
@@ -3,9 +3,38 @@
 
 #define OPT_ARCH_MAX   (OPT_MAX+0)
 
+#define OPT_APPEND	'a'
+#define OPT_RAMDISK	'r'
+
+/* Options relevant to the architecture (excluding loader-specific ones),
+ * in this case none:
+ */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS				\
+	KEXEC_ARCH_OPTIONS				\
+	{ "command-line",	1, 0, OPT_APPEND },	\
+	{ "append",		1, 0, OPT_APPEND },	\
+	{ "initrd",		1, 0, OPT_RAMDISK },	\
+	{ "ramdisk",		1, 0, OPT_RAMDISK },
+
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR "a:r:"
+
 #endif /* KEXEC_ARCH_ARM_OPTIONS_H */
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 1a446d9..e060f6e 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -219,8 +219,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	off_t ramdisk_length;
 	off_t ramdisk_offset;
 	int opt;
-#define OPT_APPEND	'a'
-#define OPT_RAMDISK	'r'
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",	1, 0, OPT_APPEND },
diff --git a/kexec/arch/cris/include/arch/options.h b/kexec/arch/cris/include/arch/options.h
index bc5f706..1c1a029 100644
--- a/kexec/arch/cris/include/arch/options.h
+++ b/kexec/arch/cris/include/arch/options.h
@@ -1,11 +1,35 @@
-#ifndef KEXEC_ARCH_MIPS_OPTIONS_H
-#define KEXEC_ARCH_MIPS_OPTIONS_H
+#ifndef KEXEC_ARCH_CRIS_OPTIONS_H
+#define KEXEC_ARCH_CRIS_OPTIONS_H
 
-#define OPT_ARCH_MAX   (OPT_MAX+0)
+#define OPT_ARCH_MAX	(OPT_MAX+0)
+#define OPT_APPEND	(OPT_ARCH_MAX+0)
 
+/* Options relevant to the architecture (excluding loader-specific ones),
+ * in this case none:
+ */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
-#endif /* KEXEC_ARCH_MIPS_OPTIONS_H */
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS \
+	KEXEC_ARCH_OPTIONS \
+	{"append", 1, 0, OPT_APPEND},
+
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
+
+#endif /* KEXEC_ARCH_CRIS_OPTIONS_H */
diff --git a/kexec/arch/cris/kexec-elf-cris.c b/kexec/arch/cris/kexec-elf-cris.c
index 4b56a20..b48b7b3 100644
--- a/kexec/arch/cris/kexec-elf-cris.c
+++ b/kexec/arch/cris/kexec-elf-cris.c
@@ -40,8 +40,6 @@
 #include <arch/options.h>
 #include "kexec-cris.h"
 
-#define OPT_APPEND      (OPT_ARCH_MAX+0)
-
 int elf_cris_probe(const char *buf, off_t len)
 {
 	struct mem_ehdr ehdr;
@@ -89,8 +87,10 @@ int elf_cris_load(int argc, char **argv, const char *buf, off_t len,
 		unsigned int regs[16];
 	} cris_regframe;
 
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
+		{"append", 1, 0, OPT_APPEND},
 		{ 0, 0, 0, 0 },
 	};
 
diff --git a/kexec/arch/i386/include/arch/options.h b/kexec/arch/i386/include/arch/options.h
index 0695f37..990527c 100644
--- a/kexec/arch/i386/include/arch/options.h
+++ b/kexec/arch/i386/include/arch/options.h
@@ -1,6 +1,15 @@
 #ifndef KEXEC_ARCH_I386_OPTIONS_H
 #define KEXEC_ARCH_I386_OPTIONS_H
 
+/*
+ *************************************************************************
+ * NOTE NOTE NOTE
+ * This file is included for i386 builds *and* x86_64 builds (which build
+ * both x86_64 and i386 loaders).
+ * It contains the combined set of options used by i386 and x86_64.
+ *************************************************************************
+ */
+
 #define OPT_RESET_VGA      (OPT_MAX+0)
 #define OPT_SERIAL         (OPT_MAX+1)
 #define OPT_SERIAL_BAUD    (OPT_MAX+2)
@@ -10,6 +19,18 @@
 #define OPT_ELF64_CORE     (OPT_MAX+6)
 #define OPT_ARCH_MAX       (OPT_MAX+7)
 
+#define OPT_APPEND		(OPT_ARCH_MAX+0)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
+#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
+#define OPT_ARGS_ELF    	(OPT_ARCH_MAX+3)
+#define OPT_ARGS_LINUX  	(OPT_ARCH_MAX+4)
+#define OPT_ARGS_NONE   	(OPT_ARCH_MAX+5)
+#define OPT_CL  		(OPT_ARCH_MAX+6)
+#define OPT_MOD 		(OPT_ARCH_MAX+7)
+#define OPT_VGA 		(OPT_ARCH_MAX+8)
+#define OPT_REAL_MODE		(OPT_ARCH_MAX+9)
+
+/* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 	{ "reset-vga",	    0, 0, OPT_RESET_VGA }, \
@@ -22,5 +43,35 @@
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS \
+	KEXEC_ARCH_OPTIONS \
+	{ "command-line",	1, NULL, OPT_APPEND },		\
+	{ "append",		1, NULL, OPT_APPEND },		\
+	{ "reuse-cmdline",	0, NULL, OPT_REUSE_CMDLINE },	\
+	{ "initrd",		1, NULL, OPT_RAMDISK },		\
+	{ "ramdisk",		1, NULL, OPT_RAMDISK },		\
+	{ "args-elf",		0, NULL, OPT_ARGS_ELF },	\
+	{ "args-linux",		0, NULL, OPT_ARGS_LINUX },	\
+	{ "args-none",		0, NULL, OPT_ARGS_NONE },	\
+	{ "debug",		0, NULL, OPT_DEBUG },		\
+	{ "module",		1, 0, OPT_MOD },		\
+	{ "real-mode",		0, NULL, OPT_REAL_MODE },
+
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
+
 #endif /* KEXEC_ARCH_I386_OPTIONS_H */
 
diff --git a/kexec/arch/i386/kexec-beoboot-x86.c b/kexec/arch/i386/kexec-beoboot-x86.c
index 27c5a2c..6d459ae 100644
--- a/kexec/arch/i386/kexec-beoboot-x86.c
+++ b/kexec/arch/i386/kexec-beoboot-x86.c
@@ -84,7 +84,8 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	int debug, real_mode_entry;
 	int opt;
 	int result;
-#define OPT_REAL_MODE	(OPT_ARCH_MAX+0)
+
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "debug",		0, 0, OPT_DEBUG },
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 53a50b3..ae18689 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -341,10 +341,8 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 	int debug, real_mode_entry;
 	int opt;
 	int result;
-#define OPT_APPEND		(OPT_ARCH_MAX+0)
-#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
-#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
-#define OPT_REAL_MODE		(OPT_ARCH_MAX+3)
+
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "debug",		0, 0, OPT_DEBUG },
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index 2cb9d11..2e9cf9a 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -99,13 +99,8 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 #define ARG_STYLE_LINUX 1
 #define ARG_STYLE_NONE  2
 	int opt;
-#define OPT_APPEND		(OPT_ARCH_MAX+0)
-#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
-#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
-#define OPT_ARGS_ELF    	(OPT_ARCH_MAX+3)
-#define OPT_ARGS_LINUX  	(OPT_ARCH_MAX+4)
-#define OPT_ARGS_NONE   	(OPT_ARCH_MAX+5)
 
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",	1, NULL, OPT_APPEND },
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 970de2a..23dab7b 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -157,10 +157,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	uint32_t u;
 	int opt;
 	int modules, mod_command_line_space;
-#define OPT_CL  		(OPT_ARCH_MAX+0)
-#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
-#define OPT_MOD 		(OPT_ARCH_MAX+2)
-#define OPT_VGA 		(OPT_ARCH_MAX+3)
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",		1, 0, OPT_CL },
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index d33a14b..5c701aa 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -69,10 +69,10 @@ struct arch_options_t arch_options = {
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
+		KEXEC_ALL_OPTIONS
 		{ 0, 			0, NULL, 0 },
 	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
+	static const char short_options[] = KEXEC_ALL_OPT_STR;
 	int opt;
 	unsigned long value;
 	char *end;
diff --git a/kexec/arch/ia64/include/arch/options.h b/kexec/arch/ia64/include/arch/options.h
index 3053576..e8754ad 100644
--- a/kexec/arch/ia64/include/arch/options.h
+++ b/kexec/arch/ia64/include/arch/options.h
@@ -1,11 +1,42 @@
 #ifndef KEXEC_ARCH_IA64_OPTIONS_H
 #define KEXEC_ARCH_IA64_OPTIONS_H
 
-#define OPT_ARCH_MAX   (OPT_MAX+0)
+#define OPT_ARCH_MAX	(OPT_MAX+0)
+#define OPT_APPEND	(OPT_ARCH_MAX+0)
+#define OPT_RAMDISK	(OPT_ARCH_MAX+1)
+#define OPT_NOIO	(OPT_ARCH_MAX+2)
+#define OPT_VMM		(OPT_ARCH_MAX+3)
 
+/* Options relevant to the architecture (excluding loader-specific ones),
+ * in this case none:
+ */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS			\
+	KEXEC_ARCH_OPTIONS			\
+	{"command-line", 1, 0, OPT_APPEND},	\
+	{"append",	 1, 0, OPT_APPEND},	\
+	{"initrd",	 1, 0, OPT_RAMDISK},	\
+	{"noio",	 0, 0, OPT_NOIO},	\
+	{"vmm",		 1, 0, OPT_VMM},	\
+
+#define KEXEC_ALL_OPT_STR KEXEC_OPT_STR
+
 #endif /* KEXEC_ARCH_IA64_OPTIONS_H */
diff --git a/kexec/arch/ia64/kexec-elf-ia64.c b/kexec/arch/ia64/kexec-elf-ia64.c
index 3bb5a4d..8da061e 100644
--- a/kexec/arch/ia64/kexec-elf-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-ia64.c
@@ -45,11 +45,6 @@
 #include "crashdump-ia64.h"
 #include <arch/options.h>
 
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-#define OPT_RAMDISK	(OPT_ARCH_MAX+1)
-#define OPT_NOIO	(OPT_ARCH_MAX+2)
-#define OPT_VMM		(OPT_ARCH_MAX+3)
-
 static const int probe_debug = 0;
 extern unsigned long saved_efi_memmap_size;
 
@@ -136,6 +131,8 @@ int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 	int result;
 	int opt;
 	char *efi_memmap_buf, *boot_param;
+
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{"command-line", 1, 0, OPT_APPEND},
diff --git a/kexec/arch/mips/include/arch/options.h b/kexec/arch/mips/include/arch/options.h
index bc5f706..07b4f63 100644
--- a/kexec/arch/mips/include/arch/options.h
+++ b/kexec/arch/mips/include/arch/options.h
@@ -1,11 +1,36 @@
 #ifndef KEXEC_ARCH_MIPS_OPTIONS_H
 #define KEXEC_ARCH_MIPS_OPTIONS_H
 
-#define OPT_ARCH_MAX   (OPT_MAX+0)
+#define OPT_ARCH_MAX	(OPT_MAX+0)
+#define OPT_APPEND	(OPT_ARCH_MAX+0)
 
+/* Options relevant to the architecture (excluding loader-specific ones),
+ * in this case none:
+ */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS			\
+	KEXEC_ARCH_OPTIONS		       	\
+	{"command-line", 1, 0, OPT_APPEND},	\
+	{"append",	 1, 0, OPT_APPEND},
+
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
+
 #endif /* KEXEC_ARCH_MIPS_OPTIONS_H */
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index ce6bf0c..a9c865e 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -35,7 +35,6 @@ static const int probe_debug = 0;
 #define BOOTLOADER         "kexec"
 #define MAX_COMMAND_LINE   256
 #define UPSZ(X) ((sizeof(X) + 3) & ~3)
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
 static char cmdline_buf[256] = "kexec ";
 
 int elf_mips_probe(const char *buf, off_t len)
@@ -82,6 +81,8 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned long cmdline_addr;
 	size_t i;
 	unsigned long bss_start = 0, bss_size = 0;
+
+	/* See options.h if adding any more options. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{"command-line", 1, 0, OPT_APPEND},
diff --git a/kexec/arch/ppc/include/arch/options.h b/kexec/arch/ppc/include/arch/options.h
index df14db5..f646ccc 100644
--- a/kexec/arch/ppc/include/arch/options.h
+++ b/kexec/arch/ppc/include/arch/options.h
@@ -3,9 +3,43 @@
 
 #define OPT_ARCH_MAX   (OPT_MAX+0)
 
+/* All 'local' loader options: */
+#define OPT_APPEND      (OPT_ARCH_MAX+0)
+#define OPT_GAMECUBE    (OPT_ARCH_MAX+1)
+#define OPT_DTB         (OPT_ARCH_MAX+2)
+#define OPT_NODES       (OPT_ARCH_MAX+3)
+
+/* Options relevant to the architecture (excluding loader-specific ones),
+ * in this case none:
+ */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS \
+	KEXEC_ARCH_OPTIONS \
+	{"command-line", 1, 0, OPT_APPEND},\
+	{"append",	 1, 0, OPT_APPEND},\
+	{"gamecube",	 1, 0, OPT_GAMECUBE},\
+	{"dtb",	    1, 0, OPT_DTB},\
+	{"reuse-node",	   1, 0, OPT_NODES},\
+	{"debug",	 0, 0, OPT_DEBUG},
+
+#define KEXEC_ALL_OPT_STR KEXEC_OPT_STR
+
 #endif /* KEXEC_ARCH_PPC_OPTIONS_H */
diff --git a/kexec/arch/ppc/kexec-dol-ppc.c b/kexec/arch/ppc/kexec-dol-ppc.c
index 83c122a..8de5293 100644
--- a/kexec/arch/ppc/kexec-dol-ppc.c
+++ b/kexec/arch/ppc/kexec-dol-ppc.c
@@ -335,8 +335,8 @@ int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	unsigned long lowest_start;
 	int i, j, k;
 	int opt;
-#define OPT_APPEND      (OPT_ARCH_MAX+0)
 
+	/* See options.h -- add any more there, too. */
         static const struct option options[] = {
                 KEXEC_ARCH_OPTIONS
                 {"debug",        0, 0, OPT_DEBUG},
@@ -344,7 +344,7 @@ int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
                 {"append",       1, 0, OPT_APPEND},
                 {0, 0, 0, 0},
         };
-	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+	static const char short_options[] = KEXEC_ARCH_OPT_STR;
 
 	/*
 	 * Parse the command line arguments
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index a54a5d5..cb2c07a 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -113,10 +113,7 @@ static void gamecube_hack_addresses(struct mem_ehdr *ehdr)
 	}
 }
 
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-#define OPT_GAMECUBE	(OPT_ARCH_MAX+1)
-#define OPT_DTB		(OPT_ARCH_MAX+2)
-#define OPT_NODES	(OPT_ARCH_MAX+3)
+/* See options.h -- add any more there, too. */
 static const struct option options[] = {
 	KEXEC_ARCH_OPTIONS
 	{"command-line", 1, 0, OPT_APPEND},
@@ -126,7 +123,7 @@ static const struct option options[] = {
 	{"reuse-node",     1, 0, OPT_NODES},
 	{0, 0, 0, 0},
 };
-static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+static const char short_options[] = KEXEC_ARCH_OPT_STR;
 
 void elf_ppc_usage(void)
 {
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 0a655a3..45cde2f 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -14,9 +14,7 @@
 #include "fixup_dtb.h"
 #include <kexec-uImage.h>
 
-#define OPT_APPEND      (OPT_ARCH_MAX+0)
-#define OPT_DTB         (OPT_ARCH_MAX+1)
-#define OPT_NODES       (OPT_ARCH_MAX+2)
+/* See options.h -- add any more there, too. */
 static const struct option options[] = {
 	KEXEC_ARCH_OPTIONS
 	{"command-line",	1, 0, OPT_APPEND},
@@ -25,7 +23,7 @@ static const struct option options[] = {
 	{"reuse-node",	1, 0, OPT_NODES},
 	{0, 0, 0, 0},
 };
-static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+static const char short_options[] = KEXEC_ARCH_OPT_STR;
 
 void uImage_ppc_usage(void)
 {
diff --git a/kexec/arch/ppc64/include/arch/options.h b/kexec/arch/ppc64/include/arch/options.h
index 973cd4f..8f11c83 100644
--- a/kexec/arch/ppc64/include/arch/options.h
+++ b/kexec/arch/ppc64/include/arch/options.h
@@ -1,13 +1,46 @@
 #ifndef KEXEC_ARCH_PPC64_OPTIONS_H
 #define KEXEC_ARCH_PPC64_OPTIONS_H
 
-#define OPT_ARCH_MAX   (OPT_MAX+0)
-#define OPT_ELF64_CORE  (OPT_MAX+1)
+#define OPT_ELF64_CORE		(OPT_MAX+0)
+#define OPT_ARCH_MAX		(OPT_MAX+1)
 
+/* All 'local' loader options: */
+#define OPT_APPEND		(OPT_ARCH_MAX+0)
+#define OPT_RAMDISK		(OPT_ARCH_MAX+1)
+#define OPT_DEVICETREEBLOB	(OPT_ARCH_MAX+2)
+#define OPT_ARGS_IGNORE		(OPT_ARCH_MAX+3)
+
+/* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 	{ "elf64-core-headers", 0, 0, OPT_ELF64_CORE }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS \
+	KEXEC_ARCH_OPTIONS				\
+	{ "command-line",       1, NULL, OPT_APPEND },	\
+	{ "append",             1, NULL, OPT_APPEND },	\
+	{ "ramdisk",            1, NULL, OPT_RAMDISK },	\
+	{ "initrd",             1, NULL, OPT_RAMDISK },		\
+	{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },	\
+	{ "args-linux",         0, NULL, OPT_ARGS_IGNORE },
+
+#define KEXEC_ALL_OPT_STR KEXEC_OPT_STR
+
+
 #endif /* KEXEC_ARCH_PPC64_OPTIONS_H */
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index d65a5d5..ab6da7c 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -93,11 +93,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	uint32_t my_run_at_load;
 	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
 
-#define OPT_APPEND     (OPT_ARCH_MAX+0)
-#define OPT_RAMDISK     (OPT_ARCH_MAX+1)
-#define OPT_DEVICETREEBLOB     (OPT_ARCH_MAX+2)
-#define OPT_ARGS_IGNORE		(OPT_ARCH_MAX+3)
-
+	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",       1, NULL, OPT_APPEND },
@@ -347,5 +343,11 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 
 void elf_ppc64_usage(void)
 {
+	fprintf(stderr, "     --command-line=<Command line> command line to append.\n");
+	fprintf(stderr, "     --append=<Command line> same as --command-line.\n");
+	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
+	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
+	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
+
 	fprintf(stderr, "elf support is still broken\n");
 }
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index f9dc65b..48ea421 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -735,11 +735,6 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
 void arch_usage(void)
 {
-	fprintf(stderr, "     --command-line=<Command line> command line to append.\n");
-	fprintf(stderr, "     --append=<Command line> same as --command-line.\n");
-	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
-	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
-	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
 	fprintf(stderr, "     --elf64-core-headers Prepare core headers in ELF64 format\n");
 }
 
@@ -749,11 +744,14 @@ struct arch_options_t arch_options = {
 
 int arch_process_options(int argc, char **argv)
 {
+	/* We look for all options so getopt_long doesn't start reordering
+	 * argv[] before file_type[n].load() gets a look in.
+	 */
 	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
+		KEXEC_ALL_OPTIONS
 		{ 0, 0, NULL, 0 },
 	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
+	static const char short_options[] = KEXEC_ALL_OPT_STR;
 	int opt;
 
 	opterr = 0; /* Don't complain about unrecognized options here */
diff --git a/kexec/arch/s390/include/arch/options.h b/kexec/arch/s390/include/arch/options.h
index 2979617..b57539f 100644
--- a/kexec/arch/s390/include/arch/options.h
+++ b/kexec/arch/s390/include/arch/options.h
@@ -1,11 +1,37 @@
 #ifndef KEXEC_ARCH_S390_OPTIONS_H
 #define KEXEC_ARCH_S390_OPTIONS_H
 
-#define OPT_ARCH_MAX   (OPT_MAX+0)
+#define OPT_ARCH_MAX	(OPT_MAX+0)
+#define OPT_APPEND	OPT_MAX+0
+#define OPT_RAMDISK	OPT_MAX+1
 
+/* Options relevant to the architecture (excluding loader-specific ones),
+ * in this case none:
+ */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS				\
+	KEXEC_ARCH_OPTIONS				\
+	{"command-line",     1, 0, OPT_APPEND},		\
+	{"initrd",	     1, 0, OPT_RAMDISK},
+
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
+
 #endif /* KEXEC_ARCH_S390_OPTIONS_H */
diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 13e550d..7ef8e29 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -19,9 +19,7 @@
 #include <getopt.h>
 #include "../../kexec.h"
 #include "kexec-s390.h"
-
-#define OPT_APPEND     OPT_MAX+0
-#define OPT_RAMDISK    OPT_MAX+1
+#include <arch/options.h>
 
 int
 image_s390_load(int argc, char **argv, const char *kernel_buf,
diff --git a/kexec/arch/sh/include/arch/options.h b/kexec/arch/sh/include/arch/options.h
index e02960d..4bdd6a3 100644
--- a/kexec/arch/sh/include/arch/options.h
+++ b/kexec/arch/sh/include/arch/options.h
@@ -7,16 +7,36 @@
 #define OPT_NBSD_HOWTO   (OPT_ARCH_MAX+3)
 #define OPT_NBSD_MROOT   (OPT_ARCH_MAX+4)
 
-
+/* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
         {"command-line",   1, 0, OPT_APPEND}, \
         {"append",         1, 0, OPT_APPEND}, \
         {"empty-zero",     1, 0, OPT_APPEND}, \
         {"howto",          1, 0, OPT_NBSD_HOWTO}, \
-        {"miniroot",       1, 0, OPT_NBSD_MROOT}, \
-
+        {"miniroot",       1, 0, OPT_NBSD_MROOT},
+/* These options seem to be loader-specific rather than cris-specific, so
+ * ought to be moved to KEXEC_ALL_OPTIONS below and parsed in the relevant 
+ * loader, e.g. kexec-netbsd-sh.c
+ */
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+/* The following two #defines list ALL of the options added by all of the
+ * architecture's loaders.
+ * o	main() uses this complete list to scan for its options, ignoring
+ *	arch-specific/loader-specific ones.
+ * o	Then, arch_process_options() uses this complete list to scan for its
+ *	options, ignoring general/loader-specific ones.
+ * o	Then, the file_type[n].load re-scans for options, using
+ *	KEXEC_ARCH_OPTIONS plus its loader-specific options subset.
+ *	Any unrecognised options cause an error here.
+ *
+ * This is done so that main()'s/arch_process_options()'s getopt_long() calls
+ * don't choose a kernel filename from random arguments to options they don't
+ * recognise -- as they now recognise (if not act upon) all possible options.
+ */
+#define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
+
 #endif /* KEXEC_ARCH_SH_OPTIONS_H */
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 1ad3d38..4b21ee8 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -97,8 +97,13 @@ void arch_usage(void)
 
 int arch_process_options(int argc, char **argv)
 {
+	/* The common options amongst loaders (e.g. --append) should be read
+	 * here, and the loader-specific options (e.g. NetBSD stuff) should
+	 * then be re-parsed in the loader.
+	 * (e.g. in kexec-netbsd-sh.c, for example.)
+	 */
 	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
+		KEXEC_ALL_OPTIONS
 		{ 0, 			0, NULL, 0 },
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR;
diff --git a/kexec/arch/x86_64/include/arch/options.h b/kexec/arch/x86_64/include/arch/options.h
deleted file mode 100644
index 75065b9..0000000
--- a/kexec/arch/x86_64/include/arch/options.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef KEXEC_ARCH_X86_64_OPTIONS_H
-#define KEXEC_ARCH_X86_64_OPTIONS_H
-
-#define OPT_RESET_VGA      (OPT_MAX+0)
-#define OPT_SERIAL         (OPT_MAX+1)
-#define OPT_SERIAL_BAUD    (OPT_MAX+2)
-#define OPT_CONSOLE_VGA    (OPT_MAX+3)
-#define OPT_CONSOLE_SERIAL (OPT_MAX+4)
-#define OPT_ARCH_MAX       (OPT_MAX+5)
-
-#define KEXEC_ARCH_OPTIONS \
-	KEXEC_OPTIONS \
-	{ "reset-vga",	    0, 0, OPT_RESET_VGA }, \
-	{ "serial",	    1, 0, OPT_SERIAL }, \
-	{ "serial-baud",    1, 0, OPT_SERIAL_BAUD }, \
-	{ "console-vga",    0, 0, OPT_CONSOLE_VGA }, \
-	{ "console-serial", 0, 0, OPT_CONSOLE_SERIAL }, \
-
-#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
-
-#endif /* KEXEC_ARCH_X86_64_OPTIONS_H */
-
diff --git a/kexec/arch/x86_64/include/arch/options.h b/kexec/arch/x86_64/include/arch/options.h
new file mode 120000
index 0000000..047b0f9
--- /dev/null
+++ b/kexec/arch/x86_64/include/arch/options.h
@@ -0,0 +1 @@
+../../../i386/include/arch/options.h
\ No newline at end of file
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index 20c7d77..a8204bc 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -98,13 +98,8 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 #define ARG_STYLE_LINUX 1
 #define ARG_STYLE_NONE  2
 	int opt;
-#define OPT_APPEND		(OPT_ARCH_MAX+0)
-#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
-#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
-#define OPT_ARGS_ELF		(OPT_ARCH_MAX+3)
-#define OPT_ARGS_LINUX		(OPT_ARCH_MAX+4)
-#define OPT_ARGS_NONE		(OPT_ARCH_MAX+5)
 
+	/* See options.h and add any new options there too! */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",	1, NULL, OPT_APPEND },
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 49bfd36..a4f2d10 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -74,10 +74,10 @@ static struct {
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
+		KEXEC_ALL_OPTIONS
 		{ 0, 			0, NULL, 0 },
 	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
+	static const char short_options[] = KEXEC_ALL_OPT_STR;
 	int opt;
 	unsigned long value;
 	char *end;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index e9a13a7..2d8258f 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1062,17 +1062,17 @@ int main(int argc, char *argv[])
 	int result = 0;
 	int fileind;
 	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
+		KEXEC_ALL_OPTIONS
 		{ 0, 0, 0, 0},
 	};
-	static const char short_options[] = KEXEC_OPT_STR;
+	static const char short_options[] = KEXEC_ALL_OPT_STR;
 
 	arch_init();
 
-	opterr = 0; /* Don't complain about unrecognized options here */
 	while ((opt = getopt_long(argc, argv, short_options,
 				  options, 0)) != -1) {
 		switch(opt) {
+		case '?':
 		case OPT_HELP:
 			usage();
 			return 0;
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
