Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119])
	by canuck.infradead.org with smtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0aha-0004lp-Df
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 15:03:13 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC2691DA
	for <kexec@lists.infradead.org>; Mon,  5 Sep 2011 15:03:03 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B5C1F2677
	for <kexec@lists.infradead.org>; Mon,  5 Sep 2011 15:03:03 +0000 (GMT)
From: Angelo CASTELLO <angelo.castello@st.com>
Subject: [PATCH] kexec: sh: Fixed command line management.
Date: Mon,  5 Sep 2011 17:02:24 +0200
Message-Id: <1315234944-8230-1-git-send-email-angelo.castello@st.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Angelo Castello <angelo.castello@st.com>

This fixes the command line management to be rightly used by
elf-sh and zImage-sh type formats. Basically, the issue was on use
of --append option for both set and append the STRING at the cmdline.
With this patch we correctly manage the cmdline by means of:
  --append=STRING           Append STRING to the current kernel command line
  --command-line=STRING     Set the kernel command line to STRING
Kexec by default gets and runs new kernel using the current
kernel command line. Running kexec -h you will see its default options.

Signed-off-by: Angelo Castello <angelo.castello@st.com>
---
 kexec/arch/sh/include/arch/options.h |    5 +++--
 kexec/arch/sh/kexec-elf-sh.c         |   11 ++++++++---
 kexec/arch/sh/kexec-sh.c             |    8 ++++----
 kexec/arch/sh/kexec-zImage-sh.c      |   16 ++++++++--------
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/kexec/arch/sh/include/arch/options.h b/kexec/arch/sh/include/arch/options.h
index 571b271..e381516 100644
--- a/kexec/arch/sh/include/arch/options.h
+++ b/kexec/arch/sh/include/arch/options.h
@@ -6,13 +6,14 @@
 #define OPT_EMPTYZERO    (OPT_ARCH_MAX+2)
 #define OPT_NBSD_HOWTO   (OPT_ARCH_MAX+3)
 #define OPT_NBSD_MROOT   (OPT_ARCH_MAX+4)
+#define OPT_CMDLINE      (OPT_ARCH_MAX+5)
 
 /* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
-        {"command-line",   1, 0, OPT_APPEND}, \
+        {"command-line",   1, 0, OPT_CMDLINE}, \
         {"append",         1, 0, OPT_APPEND}, \
-        {"empty-zero",     1, 0, OPT_APPEND}, \
+        {"empty-zero",     1, 0, OPT_EMPTYZERO}, \
         {"howto",          1, 0, OPT_NBSD_HOWTO}, \
         {"miniroot",       1, 0, OPT_NBSD_MROOT},
 /* These options seem to be loader-specific rather than cris-specific, so
diff --git a/kexec/arch/sh/kexec-elf-sh.c b/kexec/arch/sh/kexec-elf-sh.c
index 1186c09..dfd5e54 100644
--- a/kexec/arch/sh/kexec-elf-sh.c
+++ b/kexec/arch/sh/kexec-elf-sh.c
@@ -62,7 +62,8 @@ int elf_sh_probe(const char *buf, off_t len)
 
 void elf_sh_usage(void)
 {
-	printf("  --append=STRING       Set the kernel command line to STRING\n"
+	printf("  --command-line=STRING     Set the kernel command line to STRING\n"
+		"  --append=STRING           Append STRING to the current kernel command line\n"
 		);
 }
 
@@ -84,7 +85,8 @@ int elf_sh_load(int argc, char **argv, const char *buf, off_t len,
 	/*
 	 * Parse the command line arguments
 	 */
-	command_line = modified_cmdline = 0;
+	modified_cmdline = 0;
+	command_line = get_command_line();
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		default:
@@ -95,9 +97,12 @@ int elf_sh_load(int argc, char **argv, const char *buf, off_t len,
 		case '?':
 			usage();
 			return -1;
-		case OPT_APPEND:
+		case OPT_CMDLINE:
 			command_line = optarg;
 			break;
+		case OPT_APPEND:
+			command_line = concat_cmdline(command_line, optarg);
+			break;
 		}
 	}
 
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 4b21ee8..25e6939 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -89,10 +89,9 @@ void arch_usage(void)
   printf(
     " none\n\n"
     "Default options:\n"
-    " --append=\"%s\"\n"
-    " STRING of --append is set from /proc/cmdline as default.\n"
-    ,get_append());
-
+	" --command-line=\"%s\"\n"
+	" STRING of --command-line is set from /proc/cmdline as default.\n"
+		,get_command_line());
 }
 
 int arch_process_options(int argc, char **argv)
@@ -120,6 +119,7 @@ int arch_process_options(int argc, char **argv)
 		case '?':
 		        usage();
 		  	return -1;
+		case OPT_CMDLINE:
 		case OPT_APPEND:
 		case OPT_NBSD_HOWTO:
 		case OPT_NBSD_MROOT:
diff --git a/kexec/arch/sh/kexec-zImage-sh.c b/kexec/arch/sh/kexec-zImage-sh.c
index 1ce185a..bb6c3ab 100644
--- a/kexec/arch/sh/kexec-zImage-sh.c
+++ b/kexec/arch/sh/kexec-zImage-sh.c
@@ -64,9 +64,9 @@ int zImage_sh_probe(const char *buf, off_t UNUSED(len))
 
 void zImage_sh_usage(void)
 {
-	printf(
-    " --append=STRING      Set the kernel command line to STRING.\n"
-    " --empty-zero=ADDRESS Set the kernel top ADDRESS. \n\n");
+	printf("  --command-line=STRING     Set the kernel command line to STRING\n"
+	"  --append=STRING           Append STRING to the current kernel command line\n"
+	"  --empty-zero=ADDRESS      Set the kernel top ADDRESS. \n\n");
 
 }
 
@@ -86,7 +86,7 @@ int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
 
-	command_line = 0;
+	command_line = get_command_line();
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch (opt) {
 		default:
@@ -97,15 +97,15 @@ int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 		case '?':
 			usage();
 			return -1;
-		case OPT_APPEND:
+		case OPT_CMDLINE:
 			command_line = optarg;
 			break;
+		case OPT_APPEND:
+			command_line = concat_cmdline(command_line, optarg);
+			break;
 		}
 	}
 
-	if (!command_line)
-	        command_line = get_append();
-
 	/* assume the zero page is the page before the vmlinux entry point.
 	 * we don't know the page size though, but 64k seems to be max.
 	 * put several 4k zero page copies before the entry point to cover
-- 
1.7.4.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
