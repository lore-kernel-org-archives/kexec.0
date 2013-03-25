Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK98b-000457-BS
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:16:42 +0000
Received: by mail-pb0-f43.google.com with SMTP id md12so4240560pbc.30
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:16:39 -0700 (PDT)
Message-ID: <51506A52.8000906@gmail.com>
Date: Mon, 25 Mar 2013 23:16:34 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 11/13] kexec: x86_64: bzImage64: fix memory leak caused by
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
 kexec/arch/x86_64/kexec-bzImage64.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index 86e6d13..21bc4ae 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -232,7 +232,7 @@ static int do_bzImage64_load(struct kexec_info *info,
 int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
-	char *command_line = NULL;
+	char *command_line = NULL, *tmp_cmdline = NULL;
 	const char *ramdisk = NULL, *append = NULL;
 	char *ramdisk_buf;
 	off_t ramdisk_length = 0;
@@ -269,7 +269,7 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			tmp_cmdline = get_command_line();
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
@@ -282,7 +282,9 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 			break;
 		}
 	}
-	command_line = concat_cmdline(command_line, append);
+	command_line = concat_cmdline(tmp_cmdline, append);
+	if (tmp_cmdline)
+		free(tmp_cmdline);
 	command_line_len = 0;
 	if (command_line)
 		command_line_len = strlen(command_line) + 1;
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
