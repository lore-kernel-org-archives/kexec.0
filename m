Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK95n-0003N7-DM
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:13:48 +0000
Received: by mail-pb0-f48.google.com with SMTP id wy12so4194395pbc.35
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:13:46 -0700 (PDT)
Message-ID: <515069A4.6000804@gmail.com>
Date: Mon, 25 Mar 2013 23:13:40 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 08/13] kexec: ppc: elf: fix memory leak caused by
 get_command_line
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

Since get_command_line returns dynamically allocated memory, it is
easy for the caller to forget freeing the memory. Here fixes a
memory leak caused by this function.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 1eb3a62..694befb 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -156,6 +156,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 {
 	struct mem_ehdr ehdr;
 	char *command_line, *crash_cmdline, *cmdline_buf;
+	char *tmp_cmdline;
 	int command_line_len;
 	char *dtb;
 	int result;
@@ -191,7 +192,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	char *blob_buf = NULL;
 	off_t blob_size = 0;
 
-	command_line = NULL;
+	command_line = tmp_cmdline = NULL;
 	dtb = NULL;
 	max_addr = LONG_MAX;
 	hole_addr = 0;
@@ -211,7 +212,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 			usage();
 			return -1;
 		case OPT_APPEND:
-			command_line = optarg;
+			tmp_cmdline = optarg;
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
@@ -239,12 +240,12 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
 
 	command_line_len = 0;
-	if (command_line) {
-		command_line_len = strlen(command_line) + 1;
+	if (tmp_cmdline) {
+		command_line = tmp_cmdline;
 	} else {
 		command_line = get_command_line();
-		command_line_len = strlen(command_line) + 1;
 	}
+	command_line_len = strlen(command_line) + 1;
 
 	fixup_nodes[cur_fixup] = NULL;
 
@@ -450,6 +451,8 @@ out2:
 out:
 	free_elf_info(&ehdr);
 	free(crash_cmdline);
+	if (!tmp_cmdline)
+		free(command_line);
 	if (error_msg)
 		die(error_msg);
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
