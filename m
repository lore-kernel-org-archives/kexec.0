Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NX95P-0005aF-3U
	for kexec@lists.infradead.org; Tue, 19 Jan 2010 08:05:19 +0000
Subject: [PATCH] Fix --reuse-cmdline so it is usable.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 19 Jan 2010 00:05:03 -0800
Message-ID: <m1d4167c5s.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>


A colleague of mine implemented kdump and it used --reuse-cmdline
with some rather interesting and unexpected results.

Update the getopt specification so that --reuse-cmdline does not
attempt to take an argument that it will not use.

Update the processing of --append so that --reuse-cmdline followed
by --append actually appends the parameters specified by --reuse-cmdline.

Signed-off-by: Eric W. Biederman <ebiederm@aristanetworks.com>
---
 kexec/arch/i386/kexec-bzImage.c       |    8 ++++----
 kexec/arch/i386/kexec-elf-x86.c       |    8 ++++----
 kexec/arch/i386/kexec-multiboot-x86.c |    7 ++++---
 kexec/arch/x86_64/kexec-elf-x86_64.c  |    8 ++++----
 kexec/kexec.c                         |   16 ++++++++++++++++
 kexec/kexec.h                         |    2 ++
 6 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index be88a3f..21c1ddf 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -332,7 +332,7 @@ int do_bzImage_load(struct kexec_info *info,
 int bzImage_load(int argc, char **argv, const char *buf, off_t len, 
 	struct kexec_info *info)
 {
-	const char *command_line;
+	const char *command_line = NULL, *append = NULL;
 	const char *ramdisk;
 	char *ramdisk_buf;
 	off_t ramdisk_length;
@@ -349,7 +349,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 		{ "debug",		0, 0, OPT_DEBUG },
 		{ "command-line",	1, 0, OPT_APPEND },
 		{ "append",		1, 0, OPT_APPEND },
-		{ "reuse-cmdline",	1, 0, OPT_REUSE_CMDLINE },
+		{ "reuse-cmdline",	0, 0, OPT_REUSE_CMDLINE },
 		{ "initrd",		1, 0, OPT_RAMDISK },
 		{ "ramdisk",		1, 0, OPT_RAMDISK },
 		{ "real-mode",		0, 0, OPT_REAL_MODE },
@@ -362,7 +362,6 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 	 */
 	debug = 0;
 	real_mode_entry = 0;
-	command_line = 0;
 	ramdisk = 0;
 	ramdisk_length = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
@@ -379,7 +378,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 			debug = 1;
 			break;
 		case OPT_APPEND:
-			command_line = optarg;
+			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
 			command_line = get_command_line();
@@ -392,6 +391,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 			break;
 		}
 	}
+	command_line = concat_cmdline(command_line, append);
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) +1;
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index afa0eb5..aaf46ba 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -88,7 +88,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
-	const char *command_line;
+	const char *command_line = NULL, *append = NULL;
 	char *modified_cmdline;
 	int command_line_len;
 	int modified_cmdline_len;
@@ -110,7 +110,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",	1, NULL, OPT_APPEND },
 		{ "append",		1, NULL, OPT_APPEND },
-		{ "reuse-cmdline",	1, NULL, OPT_REUSE_CMDLINE },
+		{ "reuse-cmdline",	0, NULL, OPT_REUSE_CMDLINE },
 		{ "initrd",		1, NULL, OPT_RAMDISK },
 		{ "ramdisk",		1, NULL, OPT_RAMDISK },
 		{ "args-elf",		0, NULL, OPT_ARGS_ELF },
@@ -125,7 +125,6 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	 * Parse the command line arguments
 	 */
 	arg_style = ARG_STYLE_ELF;
-	command_line = 0;
 	modified_cmdline = 0;
 	modified_cmdline_len = 0;
 	ramdisk = 0;
@@ -140,7 +139,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 			usage();
 			return -1;
 		case OPT_APPEND:
-			command_line = optarg;
+			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
 			command_line = get_command_line();
@@ -163,6 +162,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 			break;
 		}
 	}
+	command_line = concat_cmdline(command_line, append);
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) +1;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 9b41698..9817ba9 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -147,7 +147,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned long mbi_base;
 	struct entry32_regs regs;
 	size_t mbi_bytes, mbi_offset;
-	const char *command_line=NULL;
+	const char *command_line=NULL, *append=NULL;
 	char *imagename, *cp;
 	struct memory_range *range;
 	int ranges;
@@ -164,7 +164,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",		1, 0, OPT_CL },
 		{ "append",			1, 0, OPT_CL },
-		{ "reuse-cmdline",		1, 0, OPT_REUSE_CMDLINE },
+		{ "reuse-cmdline",		0, 0, OPT_REUSE_CMDLINE },
 		{ "module",			1, 0, OPT_MOD },
 		{ 0, 				0, 0, 0 },
 	};
@@ -195,7 +195,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 			usage();
 			return -1;
 		case OPT_CL:
-			command_line = optarg;
+			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
 			command_line = get_command_line();
@@ -207,6 +207,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		}
 	}
 	imagename = argv[optind];
+	command_line = concat_cmdline(command_line, append);
 	command_line_len = strlen(command_line) + strlen(imagename) + 2;
 
 
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index 95ebef6..901262f 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -87,7 +87,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
-	const char *command_line;
+	const char *command_line = NULL, *append = NULL;
 	char *modified_cmdline;
 	int command_line_len;
 	int modified_cmdline_len;
@@ -109,7 +109,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 		KEXEC_ARCH_OPTIONS
 		{ "command-line",	1, NULL, OPT_APPEND },
 		{ "append",		1, NULL, OPT_APPEND },
-		{ "reuse-cmdline",	1, NULL, OPT_REUSE_CMDLINE },
+		{ "reuse-cmdline",	0, NULL, OPT_REUSE_CMDLINE },
 		{ "initrd",		1, NULL, OPT_RAMDISK },
 		{ "ramdisk",		1, NULL, OPT_RAMDISK },
 		{ "args-elf",		0, NULL, OPT_ARGS_ELF },
@@ -124,7 +124,6 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 	 * Parse the command line arguments
 	 */
 	arg_style = ARG_STYLE_ELF;
-	command_line = 0;
 	modified_cmdline = 0;
 	modified_cmdline_len = 0;
 	ramdisk = 0;
@@ -140,7 +139,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 			usage();
 			return -1;
 		case OPT_APPEND:
-			command_line = optarg;
+			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
 			command_line = get_command_line();
@@ -163,6 +162,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 			break;
 		}
 	}
+	command_line = concat_cmdline(command_line, append);
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) +1;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index a1cec86..f4c22a6 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -994,6 +994,22 @@ void check_reuse_initrd(void)
 	free(line);
 }
 
+const char *concat_cmdline(const char *base, const char *append)
+{
+	const char *cmdline;
+	if (!base && !append)
+		return NULL;
+	if (!base)
+		return append;
+	if (!append)
+		return base;
+	cmdline = xmalloc(strlen(base) + 1 + strlen(append) + 1);
+	strcpy(cmdline, base);
+	strcat(cmdline, " ");
+	strcat(cmdline, append);
+	return cmdline;
+}
+
 
 int main(int argc, char *argv[])
 {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 53aa58c..ebc5a95 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -261,4 +261,6 @@ static inline int __attribute__ ((format (printf, 1, 2)))
 	dbgprintf(const char *fmt, ...) {return 0;}
 #endif
 
+const char *concat_cmdline(const char *base, const char *append);
+
 #endif /* KEXEC_H */
-- 
1.6.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
