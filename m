Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK9AH-0004by-98
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:18:26 +0000
Received: by mail-pa0-f54.google.com with SMTP id fa10so1083715pad.13
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:18:23 -0700 (PDT)
Message-ID: <51506ABB.2030808@gmail.com>
Date: Mon, 25 Mar 2013 23:18:19 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 13/13] kexec: x86_64: elf: fix possible memory leak in
 elf_x86_64_load
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

In elf_x86_64_load, allocated memory may not be free'd if the code
exits abnormally, by calling die() or return. So the patch fixes
the possible memory leak.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/x86_64/kexec-elf-x86_64.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index 4a41780..7944be4 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -98,6 +98,8 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 #define ARG_STYLE_LINUX 1
 #define ARG_STYLE_NONE  2
 	int opt;
+	int result = 0;
+	char *error_msg = NULL;
 
 	/* See options.h and add any new options there too! */
 	static const struct option options[] = {
@@ -208,7 +210,8 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 		elf_rel_set_symbol(&info->rhdr, "entry64_regs", &regs, sizeof(regs));
 
 		if (ramdisk) {
-			die("Ramdisks not supported with generic elf arguments");
+			error_msg = "Ramdisks not supported with generic elf arguments";
+			goto out;
 		}
 	}
 	else if (arg_style == ARG_STYLE_LINUX) {
@@ -240,8 +243,10 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 		if (info->kexec_flags & KEXEC_ON_CRASH) {
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
@@ -267,10 +272,13 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 		elf_rel_set_symbol(&info->rhdr, "entry64_regs", &regs, sizeof(regs));
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
