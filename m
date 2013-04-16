Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-da0-x233.google.com ([2607:f8b0:400e:c00::233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1US5U8-0005Gw-Fr
 for kexec@lists.infradead.org; Tue, 16 Apr 2013 12:59:45 +0000
Received: by mail-da0-f51.google.com with SMTP id g27so239474dan.38
 for <kexec@lists.infradead.org>; Tue, 16 Apr 2013 05:59:41 -0700 (PDT)
Message-ID: <516D4B35.3060300@gmail.com>
Date: Tue, 16 Apr 2013 20:59:33 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] Revert "kexec/powerpc: Handle buffer overflow in kernel
 command line"
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

This reverts commit d58dcae3e61b375578ff3145e627a5d85afb5f52.

The commit description is kind of wrong and maybe caused by Simon
when he applied the patch.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c    |   29 +++++++++++++----------------
 kexec/arch/ppc/kexec-uImage-ppc.c |   23 +++++++++--------------
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 98cae9c..3daca2d 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -157,7 +157,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	struct mem_ehdr ehdr;
 	char *command_line, *crash_cmdline, *cmdline_buf;
 	char *tmp_cmdline;
-	int command_line_len, crash_cmdline_len;
+	int command_line_len;
 	char *dtb;
 	int result;
 	char *error_msg;
@@ -244,10 +244,19 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	} else {
 		command_line = get_command_line();
 	}
-	command_line_len = strlen(command_line);
+	command_line_len = strlen(command_line) + 1;
 
 	fixup_nodes[cur_fixup] = NULL;
 
+	/* Need to append some command line parameters internally in case of
+	 * taking crash dumps.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
+	} else
+		crash_cmdline = NULL;
+
 	/* Parse the Elf file */
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
@@ -283,23 +292,16 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		goto out;
 	}
 
-	/*
-	 * Need to append some command line parameters internally in case of
-	 * taking crash dumps. Additional segments need to be created.
+	/* If panic kernel is being loaded, additional segments need
+	 * to be created.
 	 */
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
-		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
 		result = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
 		if (result < 0) {
 			result = -1;
 			goto out;
 		}
-		crash_cmdline_len = strlen(crash_cmdline);
-	} else {
-		crash_cmdline = NULL;
-		crash_cmdline_len = 0;
 	}
 
 	/*
@@ -335,11 +337,6 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 	info->entry = (void *)arg_base;
 #else
-	if (crash_cmdline_len + command_line_len + 1 > COMMAND_LINE_SIZE) {
-		printf("Kernel command line exceeds size\n");
-		return -1;
-	}
-
 	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
 	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
 	if (command_line)
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 008463b..9113fbe 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -82,7 +82,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 {
 	char *command_line, *cmdline_buf, *crash_cmdline;
 	char *tmp_cmdline;
-	int command_line_len, crash_cmdline_len;
+	int command_line_len;
 	char *dtb;
 	unsigned int addr;
 	unsigned long dtb_addr;
@@ -178,34 +178,29 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 
 	add_segment(info, buf, len, load_addr, len + _1MiB);
 
-
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
                 crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
                 memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
+        } else
+                crash_cmdline = NULL;
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		ret = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
 		if (ret < 0) {
 			ret = -1;
 			goto out;
 		}
-		crash_cmdline_len = strlen(crash_cmdline);
-	} else {
-		crash_cmdline = NULL;
-		crash_cmdline_len = 0;
-	}
-
-	if (crash_cmdline_len + command_line_len + 1 > COMMAND_LINE_SIZE) {
-		printf("Kernel command line exceeds maximum possible length\n");
-		return -1;
 	}
 
 	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
 	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
-
 	if (command_line)
-		strcpy(cmdline_buf, command_line);
+		strncat(cmdline_buf, command_line, command_line_len);
 	if (crash_cmdline)
-		strncat(cmdline_buf, crash_cmdline, crash_cmdline_len);
+		strncat(cmdline_buf, crash_cmdline,
+			sizeof(crash_cmdline) -
+			strlen(crash_cmdline) - 1);
 
 	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
 				purgatory_size, 0, -1, -1, 0);
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
