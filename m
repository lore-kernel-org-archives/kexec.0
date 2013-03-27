Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22a.google.com ([2607:f8b0:400e:c00::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKquZ-0001Dk-PI
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 14:01:08 +0000
Received: by mail-da0-f42.google.com with SMTP id n15so4108144dad.1
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 07:01:06 -0700 (PDT)
Message-ID: <5152FB9B.1040409@gmail.com>
Date: Wed, 27 Mar 2013 22:00:59 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: Use die() to simplify code
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

Use die() to simplify code.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/fixup_dtb.c        |    4 +---
 kexec/arch/ppc/kexec-elf-ppc.c    |    3 +--
 kexec/arch/ppc/kexec-uImage-ppc.c |    3 +--
 kexec/arch/sh/kexec-sh.c          |    3 +--
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index f832026..b10ac59 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -58,9 +58,7 @@ static void fixup_nodes(char *nodes[])
 
 		content = slurp_file(fname, &content_size);
 		if (!content) {
-			fprintf(stderr, "Can't open %s: %s\n",
-					fname, strerror(errno));
-			exit(1);
+			die("Can't open %s: %s\n", fname, strerror(errno));
 		}
 
 		prop_name = fname + len;
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 694befb..3daca2d 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -227,8 +227,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 		case OPT_NODES:
 			if (cur_fixup >= FIXUP_ENTRYS) {
-				fprintf(stderr, "The number of entries for the fixup is too large\n");
-				exit(1);
+				die("The number of entries for the fixup is too large\n");
 			}
 			fixup_nodes[cur_fixup] = optarg;
 			cur_fixup++;
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index c4d39f2..9113fbe 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -130,8 +130,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 
 		case OPT_NODES:
 			if (cur_fixup >= FIXUP_ENTRYS) {
-				fprintf(stderr, "The number of entries for the fixup is too large\n");
-				exit(1);
+				die("The number of entries for the fixup is too large\n");
 			}
 			fixup_nodes[cur_fixup] = optarg;
 			cur_fixup++;
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 7710fdf..ea56041 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -159,8 +159,7 @@ char *get_append(void)
         FILE *fp;
         int len;
         if((fp = fopen("/proc/cmdline", "r")) == NULL){
-              printf("/proc/cmdline file open error !!\n");
-              exit(1);
+              die("/proc/cmdline file open error !!\n");
         }
         fgets(append_buf, 256, fp);
         len = strlen(append_buf);
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
