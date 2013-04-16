Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1US5UR-0005I3-6I
 for kexec@lists.infradead.org; Tue, 16 Apr 2013 13:00:04 +0000
Received: by mail-pa0-f48.google.com with SMTP id lj1so332011pab.35
 for <kexec@lists.infradead.org>; Tue, 16 Apr 2013 06:00:00 -0700 (PDT)
Message-ID: <516D4B47.1070109@gmail.com>
Date: Tue, 16 Apr 2013 20:59:51 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH RESEND] kexec/powerpc: Handle buffer overflow in kernel command
 line
References: <516D48F8.3010202@gmail.com>
In-Reply-To: <516D48F8.3010202@gmail.com>
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
Cc: "Suzuki K. Poulose" <suzuki@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Suzuki K. Poulose <suzuki@in.ibm.com>

Enforce size check for kernel command line to make sure it
doesn't overflow COMMAND_LINE_SIZE.

Reported-by: Nathan D. Miller <nathanm2@us.ibm.com>
Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c    |   29 ++++++++++++++++-------------
 kexec/arch/ppc/kexec-uImage-ppc.c |   23 ++++++++++++++---------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 3daca2d..98cae9c 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -157,7 +157,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	struct mem_ehdr ehdr;
 	char *command_line, *crash_cmdline, *cmdline_buf;
 	char *tmp_cmdline;
-	int command_line_len;
+	int command_line_len, crash_cmdline_len;
 	char *dtb;
 	int result;
 	char *error_msg;
@@ -244,19 +244,10 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	} else {
 		command_line = get_command_line();
 	}
-	command_line_len = strlen(command_line) + 1;
+	command_line_len = strlen(command_line);
 
 	fixup_nodes[cur_fixup] = NULL;
 
-	/* Need to append some command line parameters internally in case of
-	 * taking crash dumps.
-	 */
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
-		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
-	} else
-		crash_cmdline = NULL;
-
 	/* Parse the Elf file */
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
@@ -292,16 +283,23 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		goto out;
 	}
 
-	/* If panic kernel is being loaded, additional segments need
-	 * to be created.
+	/*
+	 * Need to append some command line parameters internally in case of
+	 * taking crash dumps. Additional segments need to be created.
 	 */
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
 		result = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
 		if (result < 0) {
 			result = -1;
 			goto out;
 		}
+		crash_cmdline_len = strlen(crash_cmdline);
+	} else {
+		crash_cmdline = NULL;
+		crash_cmdline_len = 0;
 	}
 
 	/*
@@ -337,6 +335,11 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 	info->entry = (void *)arg_base;
 #else
+	if (crash_cmdline_len + command_line_len + 1 > COMMAND_LINE_SIZE) {
+		printf("Kernel command line exceeds size\n");
+		return -1;
+	}
+
 	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
 	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
 	if (command_line)
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 9113fbe..008463b 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -82,7 +82,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 {
 	char *command_line, *cmdline_buf, *crash_cmdline;
 	char *tmp_cmdline;
-	int command_line_len;
+	int command_line_len, crash_cmdline_len;
 	char *dtb;
 	unsigned int addr;
 	unsigned long dtb_addr;
@@ -178,29 +178,34 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 
 	add_segment(info, buf, len, load_addr, len + _1MiB);
 
+
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
                 crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
                 memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
-        } else
-                crash_cmdline = NULL;
-
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		ret = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
 		if (ret < 0) {
 			ret = -1;
 			goto out;
 		}
+		crash_cmdline_len = strlen(crash_cmdline);
+	} else {
+		crash_cmdline = NULL;
+		crash_cmdline_len = 0;
+	}
+
+	if (crash_cmdline_len + command_line_len + 1 > COMMAND_LINE_SIZE) {
+		printf("Kernel command line exceeds maximum possible length\n");
+		return -1;
 	}
 
 	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
 	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
+
 	if (command_line)
-		strncat(cmdline_buf, command_line, command_line_len);
+		strcpy(cmdline_buf, command_line);
 	if (crash_cmdline)
-		strncat(cmdline_buf, crash_cmdline,
-			sizeof(crash_cmdline) -
-			strlen(crash_cmdline) - 1);
+		strncat(cmdline_buf, crash_cmdline, crash_cmdline_len);
 
 	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
 				purgatory_size, 0, -1, -1, 0);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
