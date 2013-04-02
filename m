Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMwBq-0000Ih-D6
 for kexec@lists.infradead.org; Tue, 02 Apr 2013 08:03:36 +0000
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Tue, 2 Apr 2013 13:28:58 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 36AE4125804E
 for <kexec@lists.infradead.org>; Tue,  2 Apr 2013 13:34:41 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3283GFr7078172
 for <kexec@lists.infradead.org>; Tue, 2 Apr 2013 13:33:16 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3283Knj005556
 for <kexec@lists.infradead.org>; Tue, 2 Apr 2013 19:03:20 +1100
Subject: [PATCH] kexec/powerpc: Handle buffer overflow in kernel command line
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Tue, 02 Apr 2013 13:33:19 +0530
Message-ID: <20130402080307.16143.41901.stgit@suzukikp.in.ibm.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

From: Suzuki K. Poulose <suzuki@in.ibm.com>

Enforce size check for kernel command line to make sure it
doesn't overflow COMMAND_LINE_SIZE.

Reported-by: Nathan D. Miller <nathanm2@us.ibm.com>
Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c    |   41 ++++++++++++++++++-------------------
 kexec/arch/ppc/kexec-uImage-ppc.c |   31 ++++++++++++++--------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 5f63a64..7ba8421 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -156,7 +156,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 {
 	struct mem_ehdr ehdr;
 	char *command_line, *crash_cmdline, *cmdline_buf;
-	int command_line_len;
+	int command_line_len, crash_cmdline_len;
 	char *dtb;
 	int result;
 	unsigned long max_addr, hole_addr;
@@ -233,27 +233,15 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	}
 
 	command_line_len = 0;
-	if (command_line) {
-		command_line_len = strlen(command_line) + 1;
-	} else {
+	if (!command_line)
 		command_line = get_command_line();
-		command_line_len = strlen(command_line) + 1;
-	}
+	command_line_len = strlen(command_line);
 
 	if (ramdisk && reuse_initrd)
 		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
 
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
@@ -291,26 +279,37 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		return result;
 	}
 
-	/* If panic kernel is being loaded, additional segments need
-	 * to be created.
+	/*
+	 * Need to append some command line parameters internally in case of
+	 * taking crash dumps. Additional segments have to be loaded for panic
+	 * kernel.
 	 */
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
 		result = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
 		if (result < 0) {
 			free(crash_cmdline);
 			return -1;
 		}
+		crash_cmdline_len = strlen(crash_cmdline);
+	} else {
+		crash_cmdline = NULL;
+		crash_cmdline_len = 0;
 	}
 
+	if (crash_cmdline_len + command_line_len + 1 > COMMAND_LINE_SIZE) {
+		printf ("Command line buffer overflow\n");
+		return -1;
+	}
+		
 	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
 	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
 	if (command_line)
-		strncat(cmdline_buf, command_line, command_line_len);
+		strcpy(cmdline_buf, command_line);
 	if (crash_cmdline)
-		strncat(cmdline_buf, crash_cmdline,
-				sizeof(crash_cmdline) -
-				strlen(crash_cmdline) - 1);
+		strncat(cmdline_buf, crash_cmdline, crash_cmdline_len);
 
 	/*
 	 * In case of a toy we take the hardcoded things and an easy setup via
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 900cd16..0c96bac 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -81,7 +81,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		unsigned int ep)
 {
 	char *command_line, *cmdline_buf, *crash_cmdline;
-	int command_line_len;
+	int command_line_len, crash_cmdline_len;
 	char *dtb;
 	unsigned int addr;
 	unsigned long dtb_addr;
@@ -140,13 +140,10 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
 
 	command_line_len = 0;
-	if (command_line) {
-		command_line_len = strlen(command_line) + 1;
-	} else {
+	if (!command_line)
 		command_line = get_command_line();
-		command_line_len = strlen(command_line) + 1;
-	}
 
+	command_line_len = strlen(command_line);
 	fixup_nodes[cur_fixup] = NULL;
 
 	/*
@@ -179,25 +176,27 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
                 crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
                 memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
-        } else
-                crash_cmdline = NULL;
-
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		ret = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
-		if (ret < 0) {
+		if (ret < 0)
 			return -1;
-		}
+		crash_cmdline_len = strlen(crash_cmdline);
+	} else {
+		crash_cmdline = NULL;
+		crash_cmdline_len = 0;
+	}
+
+	if (command_line_len + crash_cmdline_len + 1 > COMMAND_LINE_SIZE) {
+		printf("Command line buffer overflow \n");
+		return -1;
 	}
 
 	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
 	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
