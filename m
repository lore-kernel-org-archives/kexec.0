Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK93g-0002tq-3y
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:11:40 +0000
Received: by mail-pa0-f42.google.com with SMTP id kq13so447483pab.15
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:11:34 -0700 (PDT)
Message-ID: <51506921.60807@gmail.com>
Date: Mon, 25 Mar 2013 23:11:29 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 06/13] kexec: i386: multiboot: fix memory leak caused by
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
 kexec/arch/i386/kexec-multiboot-x86.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 4252f75..4520fd7 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -147,7 +147,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned long mbi_base;
 	struct entry32_regs regs;
 	size_t mbi_bytes, mbi_offset;
-	char *command_line = NULL;
+	char *command_line = NULL, *tmp_cmdline = NULL;
 	char *imagename, *cp, *append = NULL;;
 	struct memory_range *range;
 	int ranges;
@@ -195,7 +195,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			tmp_cmdline = get_command_line();
 			break;
 		case OPT_MOD:
 			modules++;
@@ -204,7 +204,10 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		}
 	}
 	imagename = argv[optind];
-	command_line = concat_cmdline(command_line, append);
+	command_line = concat_cmdline(tmp_cmdline, append);
+	if (tmp_cmdline) {
+		free(tmp_cmdline);
+	}
 	command_line_len = strlen(command_line) + strlen(imagename) + 2;
 	
 	/* Load the ELF executable */
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
