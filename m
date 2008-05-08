Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JuD33-0000Kl-2k
	for kexec@lists.infradead.org; Thu, 08 May 2008 20:49:06 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DBA4B45CB6
	for <kexec@lists.infradead.org>; Thu,  8 May 2008 22:49:02 +0200 (CEST)
Date: Thu, 8 May 2008 22:49:43 +0200
Subject: [PATCH] Add --reuse-cmdline
Message-ID: <20080508204943.GA24160@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch adds an option "--reuse-cmdline" for people that are lazy in typing
--append="$(cat /proc/cmdline)". The advantage of "--reuse-cmdline" is also that
it strips off BOOT_IMAGE (since it may not be correct any more) from lilo and
other boot loaders, and, more important, the crashkernel option in case a
panic kernel is loaded.

If you like the option I can also add it for really all architectures. Tested only
with x86-bzImage both the kexec and kdump case.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kexec/arch/i386/kexec-bzImage.c       |   12 +++-
 kexec/arch/i386/kexec-elf-x86.c       |   16 ++++--
 kexec/arch/i386/kexec-multiboot-x86.c |   12 +++-
 kexec/arch/x86_64/kexec-elf-x86_64.c  |   16 ++++--
 kexec/kexec.8                         |   18 +++++++
 kexec/kexec.c                         |   85 +++++++++++++++++++++++++++++-----
 kexec/kexec.h                         |    1 
 7 files changed, 132 insertions(+), 28 deletions(-)

--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -89,6 +89,7 @@ void bzImage_usage(void)
 		"    --real-mode           Use the kernels real mode entry point.\n"
 		"    --command-line=STRING Set the kernel command line to STRING.\n"
 		"    --append=STRING       Set the kernel command line to STRING.\n"
+		"    --reuse-cmdline       Use kernel command line from running system.\n"
 		"    --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
 		"    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
 		);
@@ -335,14 +336,16 @@ int bzImage_load(int argc, char **argv,
 	int debug, real_mode_entry;
 	int opt;
 	int result;
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-#define OPT_RAMDISK	(OPT_ARCH_MAX+1)
-#define OPT_REAL_MODE	(OPT_ARCH_MAX+2)
+#define OPT_APPEND		(OPT_ARCH_MAX+0)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
+#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
+#define OPT_REAL_MODE		(OPT_ARCH_MAX+3)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "debug",		0, 0, OPT_DEBUG },
 		{ "command-line",	1, 0, OPT_APPEND },
 		{ "append",		1, 0, OPT_APPEND },
+		{ "reuse-cmdline",	1, 0, OPT_REUSE_CMDLINE },
 		{ "initrd",		1, 0, OPT_RAMDISK },
 		{ "ramdisk",		1, 0, OPT_RAMDISK },
 		{ "real-mode",		0, 0, OPT_REAL_MODE },
@@ -374,6 +377,9 @@ int bzImage_load(int argc, char **argv,
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
+		case OPT_REUSE_CMDLINE:
+			command_line = get_command_line();
+			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
 			break;
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -73,6 +73,7 @@ void elf_x86_usage(void)
 {
 	printf(	"    --command-line=STRING Set the kernel command line to STRING\n"
 		"    --append=STRING       Set the kernel command line to STRING\n"
+		"    --reuse-cmdline       Use kernel command line from running system.\n"
 		"    --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
 		"    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
 		"    --args-linux          Pass linux kernel style options\n"
@@ -97,16 +98,18 @@ int elf_x86_load(int argc, char **argv,
 #define ARG_STYLE_LINUX 1
 #define ARG_STYLE_NONE  2
 	int opt;
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-#define OPT_RAMDISK	(OPT_ARCH_MAX+1)
-#define OPT_ARGS_ELF    (OPT_ARCH_MAX+2)
-#define OPT_ARGS_LINUX  (OPT_ARCH_MAX+3)
-#define OPT_ARGS_NONE   (OPT_ARCH_MAX+4)
+#define OPT_APPEND		(OPT_ARCH_MAX+0)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
+#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
+#define OPT_ARGS_ELF    	(OPT_ARCH_MAX+3)
+#define OPT_ARGS_LINUX  	(OPT_ARCH_MAX+4)
+#define OPT_ARGS_NONE   	(OPT_ARCH_MAX+5)
 
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",	1, NULL, OPT_APPEND },
 		{ "append",		1, NULL, OPT_APPEND },
+		{ "reuse-cmdline",	1, NULL, OPT_REUSE_CMDLINE },
 		{ "initrd",		1, NULL, OPT_RAMDISK },
 		{ "ramdisk",		1, NULL, OPT_RAMDISK },
 		{ "args-elf",		0, NULL, OPT_ARGS_ELF },
@@ -138,6 +141,9 @@ int elf_x86_load(int argc, char **argv,
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
+		case OPT_REUSE_CMDLINE:
+			command_line = get_command_line();
+			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
 			break;
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -129,6 +129,7 @@ void multiboot_x86_usage(void)
 /* Multiboot-specific options */
 {
 	printf("    --command-line=STRING        Set the kernel command line to STRING.\n");
+	printf("    --reuse-cmdline       	 Use kernel command line from running system.\n");
 	printf("    --module=\"MOD arg1 arg2...\"  Load module MOD with command-line \"arg1...\"\n");
 	printf("                                 (can be used multiple times).\n");
 }
@@ -155,13 +156,15 @@ int multiboot_x86_load(int argc, char **
 	int i;
 	int opt;
 	int modules, mod_command_line_space;
-#define OPT_CL  	(OPT_ARCH_MAX+0)
-#define OPT_MOD 	(OPT_ARCH_MAX+1)
-#define OPT_VGA 	(OPT_ARCH_MAX+2)
+#define OPT_CL  		(OPT_ARCH_MAX+0)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
+#define OPT_MOD 		(OPT_ARCH_MAX+2)
+#define OPT_VGA 		(OPT_ARCH_MAX+3)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",		1, 0, OPT_CL },
 		{ "append",			1, 0, OPT_CL },
+		{ "reuse-cmdline",		1, 0, OPT_REUSE_CMDLINE },
 		{ "module",			1, 0, OPT_MOD },
 		{ 0, 				0, 0, 0 },
 	};
@@ -194,6 +197,9 @@ int multiboot_x86_load(int argc, char **
 		case OPT_CL:
 			command_line = optarg;
 			break;
+		case OPT_REUSE_CMDLINE:
+			command_line = get_command_line();
+			break;
 		case OPT_MOD:
 			modules++;
 			mod_command_line_space += strlen(optarg) + 1;
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -73,6 +73,7 @@ void elf_x86_64_usage(void)
 {
 	printf(	"    --command-line=STRING Set the kernel command line to STRING\n"
 		"    --append=STRING       Set the kernel command line to STRING\n"
+		"    --reuse-cmdline       Use kernel command line from running system.\n"
 		"    --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
 		"    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
 		"    --args-linux          Pass linux kernel style options\n"
@@ -96,16 +97,18 @@ int elf_x86_64_load(int argc, char **arg
 #define ARG_STYLE_LINUX 1
 #define ARG_STYLE_NONE  2
 	int opt;
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-#define OPT_RAMDISK	(OPT_ARCH_MAX+1)
-#define OPT_ARGS_ELF    (OPT_ARCH_MAX+2)
-#define OPT_ARGS_LINUX  (OPT_ARCH_MAX+3)
-#define OPT_ARGS_NONE   (OPT_ARCH_MAX+4)
+#define OPT_APPEND		(OPT_ARCH_MAX+0)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
+#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
+#define OPT_ARGS_ELF		(OPT_ARCH_MAX+3)
+#define OPT_ARGS_LINUX		(OPT_ARCH_MAX+4)
+#define OPT_ARGS_NONE		(OPT_ARCH_MAX+5)
 
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",	1, NULL, OPT_APPEND },
 		{ "append",		1, NULL, OPT_APPEND },
+		{ "reuse-cmdline",	1, NULL, OPT_REUSE_CMDLINE },
 		{ "initrd",		1, NULL, OPT_RAMDISK },
 		{ "ramdisk",		1, NULL, OPT_RAMDISK },
 		{ "args-elf",		0, NULL, OPT_ARGS_ELF },
@@ -138,6 +141,9 @@ int elf_x86_64_load(int argc, char **arg
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
+		case OPT_REUSE_CMDLINE:
+			command_line = get_command_line();
+			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
 			break;
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -186,6 +186,15 @@ to the kernel command line.
 Set the kernel command line to
 .IR string .
 .TP
+.BI \-\-reuse-cmdline
+Use the command line from the running system. When a panic kernel is loaded, it
+strips the
+.I
+crashkernel
+parameter automatically. The
+.I BOOT_IMAGE
+parameter is also stripped.
+.TP
 .BI \-\-initrd= file
 Use
 .I file
@@ -204,6 +213,15 @@ as the kernel's initial ramdisk.
 Set the kernel command line to
 .IR string .
 .TP
+.BI \-\-reuse-cmdline
+Use the command line from the running system. When a panic kernel is loaded, it
+strips the
+.I
+crashkernel
+parameter automatically. The
+.I BOOT_IMAGE
+parameter is also stripped.
+.TP
 .BI \-\-module= "mod arg1 arg2 ..."
 Load module
 .I mod
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <getopt.h>
+#include <ctype.h>
 
 #include "config.h"
 
@@ -46,6 +47,7 @@
 
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
+unsigned long kexec_flags = 0;
 
 void die(char *fmt, ...)
 {
@@ -792,26 +794,86 @@ static int kexec_loaded(void)
 	return ret;
 }
 
+/*
+ * Remove parameter from a kernel command line. Helper function by get_command_line().
+ */
+static void remove_parameter(char *line, const char *param_name)
+{
+	char *start, *end;
+
+	start = strstr(line, param_name);
+
+	/* parameter not found */
+	if (!start)
+		return;
+
+	/*
+	 * check if that's really the start of a parameter and not in
+	 * the middle of the word
+	 */
+	if (start != line && !isspace(*(start-1)))
+		return;
+
+	end = strstr(start, " ");
+	if (!end)
+		*start = 0;
+	else {
+		memmove(start, end+1, strlen(end));
+		*(end + strlen(end)) = 0;
+	}
+}
+
+/*
+ * Returns the contents of the current command line to be used with
+ * --reuse-cmdline option.  The function gets called from architecture specific
+ * code. If we load a panic kernel, that function will strip the
+ * "crashkernel=" option because it does not make sense that the crashkernel
+ * reserves memory for a crashkernel (well, it would not boot since the
+ * amount is exactly the same as the crashkernel has overall memory). Also,
+ * remove the BOOT_IMAGE from lilo (and others) since that doesn't make
+ * sense here any more. The kernel could be different even if we reuse the
+ * commandline.
+ *
+ * The function returns dynamically allocated memory.
+ */
+char *get_command_line(void)
+{
+	FILE *fp;
+	size_t len;
+	char *line = NULL;
+
+	fp = fopen("/proc/cmdline", "r");
+	if (!fp)
+		die("Could not read /proc/cmdline.");
+	getline(&line, &len, fp);
+	fclose(fp);
+
+	if (line) {
+		/* strip newline */
+		*(line + strlen(line) - 1) = 0;
+
+		remove_parameter(line, "crashkernel");
+		if (kexec_flags & KEXEC_ON_CRASH)
+			remove_parameter(line, "BOOT_IMAGE");
+	} else
+		line = strdup("");
+
+	return line;
+}
+
 /* check we retained the initrd */
 void check_reuse_initrd(void)
 {
-	FILE * fp;
-	char * line = NULL;
-	size_t len = 0;
-	ssize_t read;
+	char *line = get_command_line();
 
-	fp = fopen("/proc/cmdline", "r");
-	if (fp == NULL)
-		die("unable to open /proc/cmdline\n");
-	read = getline(&line, &len, fp);
 	if (strstr(line, "retain_initrd") == NULL)
 		die("unrecoverable error: current boot didn't "
 		    "retain the initrd for reuse.\n");
-	if (line)
-		free(line);
-	fclose(fp);
+
+	free(line);
 }
 
+
 int main(int argc, char *argv[])
 {
 	int do_load = 1;
@@ -821,7 +883,6 @@ int main(int argc, char *argv[])
 	int do_ifdown = 0;
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
-	unsigned long kexec_flags = 0;
 	char *type = 0;
 	char *endptr;
 	int opt;
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -220,6 +220,7 @@ int arch_process_options(int argc, char
 int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
+char *get_command_line(void);
 
 int kexec_iomem_for_each_line(char *match,
 			      int (*callback)(void *data,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
