Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK909-0001jo-Vn
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:07:59 +0000
Received: by mail-pa0-f41.google.com with SMTP id kx1so626978pab.28
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:07:55 -0700 (PDT)
Message-ID: <51506845.30303@gmail.com>
Date: Mon, 25 Mar 2013 23:07:49 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 03/13] kexec: i386: elf: fix possible memory leak in
 elf_x86_load
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

In elf_x86_load, allocated memory may not be free'd if the code
exits abnormally, by calling die() or return. So the patch fixes
the possible memory leak.

This patch is also a preparation for patch04.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/kexec-elf-x86.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index e62ebcb..de855c4 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -90,6 +90,8 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct mem_ehdr ehdr;
 	char *command_line = NULL, *modified_cmdline = NULL;
 	const char *append = NULL;
+	char *error_msg = NULL;
+	int result;
 	int command_line_len;
 	int modified_cmdline_len;
 	const char *ramdisk;
@@ -120,9 +122,9 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	 * Parse the command line arguments
 	 */
 	arg_style = ARG_STYLE_ELF;
-	modified_cmdline = 0;
 	modified_cmdline_len = 0;
 	ramdisk = 0;
+	result = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		default:
@@ -215,7 +217,8 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 		elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
 
 		if (ramdisk) {
-			die("Ramdisks not supported with generic elf arguments");
+			error_msg = "Ramdisks not supported with generic elf arguments";
+			goto out;
 		}
 	}
 	else if (arg_style == ARG_STYLE_LINUX) {
@@ -256,8 +259,10 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 		if (info->kexec_flags & (KEXEC_ON_CRASH|KEXEC_PRESERVE_CONTEXT)) {
 			rc = load_crashdump_segments(info, modified_cmdline,
 						max_addr, 0);
-			if (rc < 0)
-				return -1;
+			if (rc < 0) {
+				result = -1;
+				goto out;
+			}
 			/* Use new command line. */
 			free(command_line);
 			command_line = modified_cmdline;
@@ -283,10 +288,13 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 		elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
 	}
 	else {
-		die("Unknown argument style\n");
+		error_msg = "Unknown argument style\n";
 	}
 
+out:
 	free(command_line);
 	free(modified_cmdline);
-	return 0;
+	if (error_msg)
+		die(error_msg);
+	return result;
 }
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
