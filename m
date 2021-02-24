Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEmkF-0007QP-HS
 for kexec@lists.infradead.org; Wed, 24 Feb 2021 05:29:58 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH] MIPS: Add '--reuse-cmdline' optional parameter support
Date: Wed, 24 Feb 2021 13:29:41 +0800
Message-Id: <1614144581-5456-1-git-send-email-tangyouling@loongson.cn>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: tangyouling@loongson.cn, kexec@lists.infradead.org

This patch adds an option "--reuse-cmdline" for people that are lazy
in typing --append="$(cat /proc/cmdline)", which will directly use the
command line of the currently running system.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/arch/mips/include/arch/options.h | 12 +++++++-----
 kexec/arch/mips/kexec-mips.c           |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/mips/include/arch/options.h b/kexec/arch/mips/include/arch/options.h
index 416e224..ba2f346 100644
--- a/kexec/arch/mips/include/arch/options.h
+++ b/kexec/arch/mips/include/arch/options.h
@@ -1,10 +1,11 @@
 #ifndef KEXEC_ARCH_MIPS_OPTIONS_H
 #define KEXEC_ARCH_MIPS_OPTIONS_H
 
-#define OPT_ARCH_MAX	(OPT_MAX+0)
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-#define OPT_DTB		(OPT_ARCH_MAX+1)
-#define OPT_RAMDISK	(OPT_ARCH_MAX+2)
+#define OPT_ARCH_MAX		(OPT_MAX+0)
+#define OPT_APPEND		(OPT_ARCH_MAX+0)
+#define OPT_DTB 		(OPT_ARCH_MAX+1)
+#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+3)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -14,7 +15,8 @@
 	{"command-line", 1, 0, OPT_APPEND}, \
 	{"append",	 1, 0, OPT_APPEND}, \
 	{"dtb",		1, 0, OPT_DTB }, \
-	{"initrd",	1, 0, OPT_RAMDISK },
+	{"initrd",	1, 0, OPT_RAMDISK }, \
+	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE },
 
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index 415c2ed..a9c6a09 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -89,6 +89,7 @@ void arch_usage(void)
 	"    --append=STRING       Set the kernel command line to STRING.\n"
 	"    --dtb=FILE            Use FILE as the device tree blob.\n"
 	"    --initrd=FILE         Use FILE as initial ramdisk.\n"
+	"    --reuse-cmdline       Use kernel command line from running system.\n"
 	);
 }
 
@@ -115,6 +116,9 @@ int arch_process_options(int argc, char **argv)
 		case OPT_APPEND:
 			arch_options.command_line = optarg;
 			break;
+		case OPT_REUSE_CMDLINE:
+			arch_options.command_line = get_command_line();
+			break;
 		case OPT_DTB:
 			arch_options.dtb_file = optarg;
 			break;
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
