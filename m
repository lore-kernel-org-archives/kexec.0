Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailapp01.imgtec.com ([195.59.15.196])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cCkTa-0000w3-Ur
 for kexec@lists.infradead.org; Fri, 02 Dec 2016 09:50:00 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
 by Forcepoint Email with ESMTPS id 74D47F59B146C
 for <kexec@lists.infradead.org>; Fri,  2 Dec 2016 09:49:28 +0000 (GMT)
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 3/6] mips: move arch option parsing from elf loader to common
 arch code
Date: Fri, 2 Dec 2016 10:49:08 +0100
Message-ID: <1480672151-18503-4-git-send-email-marcin.nowakowski@imgtec.com>
In-Reply-To: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

At the moment only commandline handling is implemented and there is
nothing elf-specific about it, so all of the commandline parsing logic
can be moved to common arch code.
getopt() options are moved to KEXEC_ARCH_OPTIONS macro (as many
platforms currently do) to avoid unnecessary duplication.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 kexec/arch/mips/include/arch/options.h |  6 ++---
 kexec/arch/mips/kexec-elf-mips.c       | 43 ++++------------------------------
 kexec/arch/mips/kexec-mips.c           | 22 +++++++++++++++++
 kexec/arch/mips/kexec-mips.h           |  3 ++-
 4 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/kexec/arch/mips/include/arch/options.h b/kexec/arch/mips/include/arch/options.h
index 07b4f63..a18251b 100644
--- a/kexec/arch/mips/include/arch/options.h
+++ b/kexec/arch/mips/include/arch/options.h
@@ -9,6 +9,8 @@
  */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
+	{"command-line", 1, 0, OPT_APPEND}, \
+	{"append",	 1, 0, OPT_APPEND},
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
@@ -27,9 +29,7 @@
  * recognise -- as they now recognise (if not act upon) all possible options.
  */
 #define KEXEC_ALL_OPTIONS			\
-	KEXEC_ARCH_OPTIONS		       	\
-	{"command-line", 1, 0, OPT_APPEND},	\
-	{"append",	 1, 0, OPT_APPEND},
+	KEXEC_ARCH_OPTIONS
 
 #define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
 
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 8a6419a..7cb06f1 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -63,51 +63,18 @@ int elf_mips_probe(const char *buf, off_t len)
 
 void elf_mips_usage(void)
 {
-	printf("    --command-line=STRING Set the kernel command line to "
-			"STRING.\n"
-	       "    --append=STRING       Set the kernel command line to "
-			"STRING.\n");
 }
 
 int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
-	const char *command_line;
-	int command_line_len;
+	int command_line_len = 0;
 	char *crash_cmdline;
-	int opt;
 	int result;
 	unsigned long cmdline_addr;
 	size_t i;
 
-	/* See options.h if adding any more options. */
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{"command-line", 1, 0, OPT_APPEND},
-		{"append",       1, 0, OPT_APPEND},
-		{0, 0, 0, 0},
-	};
-
-	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
-
-	command_line = 0;
-	while ((opt = getopt_long(argc, argv, short_options,
-				  options, 0)) != -1) {
-		switch (opt) {
-		default:
-			/* Ignore core options */
-			if (opt < OPT_ARCH_MAX) {
-				break;
-			}
-		case OPT_APPEND:
-			command_line = optarg;
-			break;
-		}
-	}
-
-	command_line_len = 0;
-
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
 	 */
@@ -136,8 +103,8 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 
 	info->entry = (void *)virt_to_phys(ehdr.e_entry);
 
-	if (command_line)
-		command_line_len = strlen(command_line) + 1;
+	if (arch_options.command_line)
+		command_line_len = strlen(arch_options.command_line) + 1;
 
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		result = load_crashdump_segments(info, crash_cmdline,
@@ -148,8 +115,8 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 		}
 	}
 
-	if (command_line)
-		strncat(cmdline_buf, command_line, command_line_len);
+	if (arch_options.command_line)
+		strncat(cmdline_buf, arch_options.command_line, command_line_len);
 	if (crash_cmdline)
 		strncat(cmdline_buf, crash_cmdline,
 				sizeof(crash_cmdline) -
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index de9019a..867e9c3 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -74,6 +74,10 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
 void arch_usage(void)
 {
+	printf(
+	"    --command-line=STRING Set the kernel command line to STRING.\n"
+	"    --append=STRING       Set the kernel command line to STRING.\n"
+	);
 }
 
 struct arch_options_t arch_options = {
@@ -86,6 +90,24 @@ struct arch_options_t arch_options = {
 
 int arch_process_options(int argc, char **argv)
 {
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, short_options,
+				  options, 0)) != -1) {
+		switch (opt) {
+		case OPT_APPEND:
+			arch_options.command_line = optarg;
+			break;
+		default:
+			break;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/kexec/arch/mips/kexec-mips.h b/kexec/arch/mips/kexec-mips.h
index e67960b..2991b2d 100644
--- a/kexec/arch/mips/kexec-mips.h
+++ b/kexec/arch/mips/kexec-mips.h
@@ -13,7 +13,8 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 void elf_mips_usage(void);
 
 struct arch_options_t {
-	int      core_header_type;
+	char *command_line;
+	int core_header_type;
 };
 
 #endif /* KEXEC_MIPS_H */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
