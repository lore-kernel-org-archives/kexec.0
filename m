Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK950-0003Cx-OS
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:12:59 +0000
Received: by mail-pa0-f54.google.com with SMTP id fa10so1076837pad.41
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:12:56 -0700 (PDT)
Message-ID: <51506973.7050301@gmail.com>
Date: Mon, 25 Mar 2013 23:12:51 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 07/13] kexec: ppc: elf: fix possible memory leak in
 elf_ppc_load
References: <51506758.4070902@gmail.com>
In-Reply-To: <51506758.4070902@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

In elf_ppc_load, allocated memory may not be free'd if the code
exits abnormally, by calling die() or return. So the patch fixes
the possible memory leak.

This patch is also a preparation for patch08.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c |   56 ++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 65a65cc..1eb3a62 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -159,6 +159,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	int command_line_len;
 	char *dtb;
 	int result;
+	char *error_msg;
 	unsigned long max_addr, hole_addr;
 	struct mem_phdr *phdr;
 	size_t size;
@@ -196,6 +197,8 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	hole_addr = 0;
 	kernel_addr = 0;
 	ramdisk = 0;
+	result = 0;
+	error_msg = NULL;
 
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch (opt) {
@@ -232,6 +235,9 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		}
 	}
 
+	if (ramdisk && reuse_initrd)
+		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
+
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) + 1;
@@ -240,9 +246,6 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		command_line_len = strlen(command_line) + 1;
 	}
 
-	if (ramdisk && reuse_initrd)
-		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
-
 	fixup_nodes[cur_fixup] = NULL;
 
 	/* Need to append some command line parameters internally in case of
@@ -257,8 +260,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	/* Parse the Elf file */
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
-		free_elf_info(&ehdr);
-		return result;
+		goto out;
 	}
 
 #ifdef WITH_GAMECUBE
@@ -287,8 +289,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	/* Load the Elf data */
 	result = elf_exec_load(&ehdr, info);
 	if (result < 0) {
-		free_elf_info(&ehdr);
-		return result;
+		goto out;
 	}
 
 	/* If panic kernel is being loaded, additional segments need
@@ -298,20 +299,11 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		result = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
 		if (result < 0) {
-			free(crash_cmdline);
-			return -1;
+			result = -1;
+			goto out;
 		}
 	}
 
-	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
-	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
-	if (command_line)
-		strncat(cmdline_buf, command_line, command_line_len);
-	if (crash_cmdline)
-		strncat(cmdline_buf, crash_cmdline,
-				sizeof(crash_cmdline) -
-				strlen(crash_cmdline) - 1);
-
 	/*
 	 * In case of a toy we take the hardcoded things and an easy setup via
 	 * one of the assembly startups. Every thing else should be grown up
@@ -345,6 +337,15 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 	info->entry = (void *)arg_base;
 #else
+	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
+	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
+	if (command_line)
+		strncat(cmdline_buf, command_line, command_line_len);
+	if (crash_cmdline)
+		strncat(cmdline_buf, crash_cmdline,
+				sizeof(crash_cmdline) -
+				strlen(crash_cmdline) - 1);
+
 	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
 			purgatory_size, 0, elf_max_addr(&ehdr), 1, 0);
 
@@ -358,8 +359,10 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		create_flatten_tree(info, (unsigned char **)&blob_buf,
 				(unsigned long *)&blob_size, cmdline_buf);
 	}
-	if (!blob_buf || !blob_size)
-		die("Device tree seems to be an empty file.\n");
+	if (!blob_buf || !blob_size) {
+		error_msg = "Device tree seems to be an empty file.\n";
+		goto out2;
+	}
 
 	/* initial fixup for device tree */
 	blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, kernel_addr, &dtb_addr);
@@ -394,7 +397,8 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	dtb_addr_actual = add_buffer(info, blob_buf, blob_size, blob_size, 0, dtb_addr,
 			kernel_addr + KERNEL_ACCESS_TOP, 1);
 	if (dtb_addr_actual != dtb_addr) {
-		die("Error device tree not loadded to address it was expecting to be loaded too!\n");
+		error_msg = "Error device tree not loadded to address it was expecting to be loaded too!\n";
+		goto out2;
 	}
 
 	/* 
@@ -439,7 +443,15 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
 	info->entry = (void *)addr;
+
+out2:
+	free(cmdline_buf);
 #endif
+out:
+	free_elf_info(&ehdr);
+	free(crash_cmdline);
+	if (error_msg)
+		die(error_msg);
 
-	return 0;
+	return result;
 }
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
