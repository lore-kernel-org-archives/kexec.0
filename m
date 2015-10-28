Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrJYM-0004cj-2U
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 05:45:42 +0000
Message-Id: <20151028054400.051359764@redhat.com>
Date: Wed, 28 Oct 2015 13:41:37 +0800
From: dyoung@redhat.com
Subject: [kexec-tools PATCH 3/3] ppc64: add arch option --dt-no-old-root
References: <20151028054134.200833741@redhat.com>
Content-Disposition: inline; filename=ppc64-arch-no-root.patch
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

Reported-by: Jan Stodola <jstodola@redhat.com>
Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/ppc64/include/arch/options.h |    4 +++-
 kexec/arch/ppc64/kexec-ppc64.c          |    5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- kexec-tools.orig/kexec/arch/ppc64/include/arch/options.h
+++ kexec-tools/kexec/arch/ppc64/include/arch/options.h
@@ -2,7 +2,8 @@
 #define KEXEC_ARCH_PPC64_OPTIONS_H
 
 #define OPT_ELF64_CORE		(OPT_MAX+0)
-#define OPT_ARCH_MAX		(OPT_MAX+1)
+#define OPT_DT_NO_OLD_ROOT	(OPT_MAX+1)
+#define OPT_ARCH_MAX		(OPT_MAX+2)
 
 /* All 'local' loader options: */
 #define OPT_APPEND		(OPT_ARCH_MAX+0)
@@ -14,6 +15,7 @@
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 	{ "elf64-core-headers", 0, 0, OPT_ELF64_CORE }, \
+	{ "dt-no-old-root",	0, 0, OPT_DT_NO_OLD_ROOT }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
--- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
@@ -869,6 +869,8 @@ int file_types = sizeof(file_type) / siz
 void arch_usage(void)
 {
 	fprintf(stderr, "     --elf64-core-headers Prepare core headers in ELF64 format\n");
+	fprintf(stderr, "     --dt-no-old-root Do not reuse old kernel root= param.\n" \
+	                "                      while creating flatten device tree.\n");
 }
 
 struct arch_options_t arch_options = {
@@ -895,6 +897,9 @@ int arch_process_options(int argc, char
 		case OPT_ELF64_CORE:
 			arch_options.core_header_type = CORE_TYPE_ELF64;
 			break;
+		case OPT_DT_NO_OLD_ROOT:
+			dt_no_old_root = 1;
+			break;
 		}
 	}
 	/* Reset getopt for the next pass; called in other source modules */



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
