Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK97k-0003rc-PM
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:15:49 +0000
Received: by mail-pb0-f42.google.com with SMTP id xb4so4212557pbc.15
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:15:48 -0700 (PDT)
Message-ID: <51506A1E.8010906@gmail.com>
Date: Mon, 25 Mar 2013 23:15:42 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 10/13] kexec: ppc: uImage: fix memory leak caused by
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
 kexec/arch/ppc/kexec-uImage-ppc.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index fd8959c..c4d39f2 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -81,6 +81,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		unsigned int ep)
 {
 	char *command_line, *cmdline_buf, *crash_cmdline;
+	char *tmp_cmdline;
 	int command_line_len;
 	char *dtb;
 	unsigned int addr;
@@ -101,6 +102,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 
 	cmdline_buf = NULL;
 	command_line = NULL;
+	tmp_cmdline = NULL;
 	dtb = NULL;
 	max_addr = LONG_MAX;
 
@@ -115,7 +117,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 			usage();
 			return -1;
 		case OPT_APPEND:
-			command_line = optarg;
+			tmp_cmdline = optarg;
 			break;
 
 		case OPT_RAMDISK:
@@ -141,12 +143,12 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
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
 
@@ -295,6 +297,8 @@ out2:
 	free(cmdline_buf);
 out:
 	free(crash_cmdline);
+	if (!tmp_cmdline)
+		free(command_line);
 	if (error_msg)
 		die(error_msg);
 	return ret;
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
