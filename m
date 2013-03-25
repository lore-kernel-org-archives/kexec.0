Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK8yC-0000UZ-1Q
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:05:57 +0000
Received: by mail-pd0-f169.google.com with SMTP id 10so19244pdc.0
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:05:54 -0700 (PDT)
Message-ID: <515067CD.8000002@gmail.com>
Date: Mon, 25 Mar 2013 23:05:49 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 02/13] kexec: i386: bzImage: fix memory leak caused by
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
 kexec/arch/i386/kexec-bzImage.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 99fd790..39452a4 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -382,6 +382,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	char *command_line = NULL;
+	char *tmp_cmdline = NULL;
 	const char *ramdisk, *append = NULL;
 	char *ramdisk_buf;
 	off_t ramdisk_length;
@@ -421,7 +422,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			tmp_cmdline = get_command_line();
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
@@ -431,7 +432,10 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 			break;
 		}
 	}
-	command_line = concat_cmdline(command_line, append);
+	command_line = concat_cmdline(tmp_cmdline, append);
+	if (tmp_cmdline) {
+		free(tmp_cmdline);
+	}
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) +1;
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
