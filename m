Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrJYH-0004cG-2a
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 05:45:37 +0000
Message-Id: <20151028054359.980394494@redhat.com>
Date: Wed, 28 Oct 2015 13:41:36 +0800
From: dyoung@redhat.com
Subject: [kexec-tools PATCH 2/3] arm: add arch option --dt-no-old-root
References: <20151028054134.200833741@redhat.com>
Content-Disposition: inline; filename=arm-arch-no-root.patch
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
To: kexec@lists.infradead.org
Cc: jstodola@redhat.com, horms@verge.net.au

When createing fdt from /proc/device-tree, if there's local --command-line
option provided but there's no root= specified, kexec-tools will copy the root=
param from 1st kernel cmdline by default. In case one want kexec boot without
root= it will be impossible.

Thus add the new option so that one can provide --dt-no-old-root for above
mentioned case.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/arm/include/arch/options.h |    4 +++-
 kexec/arch/arm/kexec-arm.c            |   29 ++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

--- kexec-tools.orig/kexec/arch/arm/include/arch/options.h
+++ kexec-tools/kexec/arch/arm/include/arch/options.h
@@ -1,7 +1,8 @@
 #ifndef KEXEC_ARCH_ARM_OPTIONS_H
 #define KEXEC_ARCH_ARM_OPTIONS_H
 
-#define OPT_ARCH_MAX   (OPT_MAX+0)
+#define OPT_DT_NO_OLD_ROOT	(OPT_MAX+0)
+#define OPT_ARCH_MAX		(OPT_MAX+1)
 
 #define OPT_APPEND	'a'
 #define OPT_RAMDISK	'r'
@@ -15,6 +16,7 @@
  */
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
+	{ "dt-no-old-root",	0, 0, OPT_DT_NO_OLD_ROOT }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
--- kexec-tools.orig/kexec/arch/arm/kexec-arm.c
+++ kexec-tools/kexec/arch/arm/kexec-arm.c
@@ -16,6 +16,7 @@
 #include "../../kexec-syscall.h"
 #include "kexec-arm.h"
 #include <arch/options.h>
+#include "../../fs2dt.h"
 
 #define MAX_MEMORY_RANGES 64
 #define MAX_LINE 160
@@ -89,11 +90,37 @@ void arch_usage(void)
 	       "               including the .bss section, as reported\n"
 	       "               by 'arm-linux-size vmlinux'. If not\n"
 	       "               specified, this value is implicitly set\n"
-	       "               to the compressed images size * 4.\n");
+	       "               to the compressed images size * 4.\n"
+	       "     --dt-no-old-root\n"
+	       "               do not reuse old kernel root= param.\n"
+	       "               while creating flatten device tree.\n");
 }
 
 int arch_process_options(int argc, char **argv)
 {
+	/* We look for all options so getopt_long doesn't start reordering
+	 * argv[] before file_type[n].load() gets a look in.
+	 */
+	static const struct option options[] = {
+		KEXEC_ALL_OPTIONS
+		{ 0, 0, NULL, 0 },
+	};
+	static const char short_options[] = KEXEC_ALL_OPT_STR;
+	int opt;
+
+	opterr = 0; /* Don't complain about unrecognized options here */
+	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+		switch(opt) {
+		case OPT_DT_NO_OLD_ROOT:
+			dt_no_old_root = 1;
+			break;
+		default:
+			break;
+		}
+	}
+	/* Reset getopt for the next pass; called in other source modules */
+	opterr = 1;
+	optind = 1;
 	return 0;
 }
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
