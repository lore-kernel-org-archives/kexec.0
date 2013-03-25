Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22d.google.com ([2607:f8b0:400e:c00::22d])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK91M-0002Dd-OD
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:09:13 +0000
Received: by mail-da0-f45.google.com with SMTP id v40so3245100dad.32
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:09:07 -0700 (PDT)
Message-ID: <5150688D.2030209@gmail.com>
Date: Mon, 25 Mar 2013 23:09:01 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 04/13] kexec: i386: elf: fix memory leak caused by
 get_command_line
References: <51506758.4070902@gmail.com> <51506845.30303@gmail.com>
In-Reply-To: <51506845.30303@gmail.com>
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
 kexec/arch/i386/kexec-elf-x86.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index de855c4..94571ca 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -90,6 +90,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct mem_ehdr ehdr;
 	char *command_line = NULL, *modified_cmdline = NULL;
 	const char *append = NULL;
+	char *tmp_cmdline = NULL;
 	char *error_msg = NULL;
 	int result;
 	int command_line_len;
@@ -139,7 +140,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			tmp_cmdline = get_command_line();
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
@@ -159,7 +160,10 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
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
