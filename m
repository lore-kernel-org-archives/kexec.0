Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7b-0008Dl-Je
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:30 +0000
MIME-Version: 1.0
Subject: [PATCH 4/8] Use config.h for defines
Message-Id: <1197967675.857691.861539748462.4.gpush@pokey>
In-Reply-To: <1197967675.854275.930419561848.0.gpush@pokey>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 18 Dec 2007 17:47:55 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Instead of putting a heap of -D directives in CPPFLAGS, use a config.h
header.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 Makefile                |    8 ++------
 Makefile.conf.in        |    1 -
 configure.ac            |   17 ++++++++++++-----
 kexec/crashdump-xen.c   |    6 ++++--
 kexec/kexec.c           |    5 ++++-
 kexec/kexec.h           |    4 +++-
 kexec_test/kexec_test.S |    4 +++-
 7 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 0a56615..73ff2f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,5 @@
 # Hey Emacs this is a -*- makefile-*-
 include Makefile.conf
-VERSION=20071030-git
-DATE=30th October 2007
-PACKAGE=kexec-tools-testing
 
 pkgdatadir = $(datadir)/$(PACKAGE)
 pkglibdir = $(libdir)/$(PACKAGE)
@@ -13,9 +10,7 @@ pkgincludedir = $(includedir)/$(PACKAGE)
 # Useful for building binary packages
 DESTDIR =
 
-EXTRA_CPPFLAGS:= -I./include -I./util_lib/include \
-	-DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"' \
-	-DPACKAGE='"$(PACKAGE)"' $(DEFS) $(EXTRA_CFLAGS)
+EXTRA_CPPFLAGS:= -I./include -I./util_lib/include $(DEFS) $(EXTRA_CFLAGS)
 
 PREFIX:=$(OBJDIR)/build
 SBINDIR=$(PREFIX)/sbin
@@ -109,6 +104,7 @@ Makefile.conf: Makefile.conf.in configure
 	/bin/sh ./configure
 
 configure: configure.ac
+	autoheader
 	autoconf
 	$(RM) -rf autom4te.cache
 
diff --git a/Makefile.conf.in b/Makefile.conf.in
index 40111b2..b5418e0 100644
--- a/Makefile.conf.in
+++ b/Makefile.conf.in
@@ -15,7 +15,6 @@ infodir=@infodir@
 mandir=@mandir@
 includedir=@includedir@
 
-DEFS=@DEFS@
 LIBS=@LIBS@
 
 # The target architecture
diff --git a/configure.ac b/configure.ac
index 032d9de..d036ba1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,8 +4,13 @@ dnl
 dnl 
 
 dnl ---Required
-AC_INIT(Makefile.conf.in)
+AC_INIT(kexec-tools-testing, 20071030-git)
 AC_CONFIG_AUX_DIR(./config)
+AC_CONFIG_HEADERS([include/config.h])
+
+AC_DEFINE_UNQUOTED(PACKAGE_DATE, "30th October 2007",
+		[Define to the release date of this package])
+
 
 dnl -- Compilation platform configuration
 AC_CANONICAL_HOST
@@ -108,13 +113,16 @@ AC_CHECK_PROG([DIRNAME],  dirname,  dirname,  "no", [$PATH])
 
 dnl See if I have a usable copy of zlib available
 if test "$with_zlib" = yes ; then
-	AC_CHECK_HEADER(zlib.h, AC_CHECK_LIB(z, inflateInit_, [AC_DEFINE(HAVE_ZLIB_H, 1) LIBS="$LIBS -lz"]))
+	AC_CHECK_HEADER(zlib.h,
+		AC_CHECK_LIB(z, inflateInit_, ,
+		AC_MSG_NOTICE([zlib support disabled])))
 fi
 
 dnl find Xen control stack libraries
 if test "$with_xen" = yes ; then
-	AC_CHECK_HEADER(xenctrl.h, AC_CHECK_LIB(xenctrl, xc_version,
-		[AC_DEFINE(HAVE_XENCTRL_H, 1) LIBS="$LIBS -lxenctrl"]))
+	AC_CHECK_HEADER(xenctrl.h,
+		AC_CHECK_LIB(xenctrl, xc_version, ,
+		AC_MSG_NOTICE([Xen support disabled])))
 fi
 
 dnl ---Sanity checks
@@ -137,7 +145,6 @@ if test "$XARGS"   = "no"; then AC_MSG_ERROR([ xargs not found]) fi
 if test "$DIRNAME" = "no"; then AC_MSG_ERROR([ dirname not found]) fi 
 
 dnl ---Output variables...
-
 AC_SUBST([BUILD_CC])
 AC_SUBST([BUILD_CFLAGS])
 
diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index 4d6a25d..1fdaf05 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -14,7 +14,9 @@
 #include "crashdump.h"
 #include "kexec-syscall.h"
 
-#ifdef HAVE_XENCTRL_H
+#include "config.h"
+
+#ifdef HAVE_LIBXENCTRL
 #include <xenctrl.h>
 #endif
 
@@ -36,7 +38,7 @@ int xen_present(void)
 unsigned long xen_architecture(struct crash_elf_info *elf_info)
 {
 	unsigned long machine = elf_info->machine;
-#ifdef HAVE_XENCTRL_H
+#ifdef HAVE_LIBXENCTRL
 	int xc, rc;
 	xen_capabilities_info_t capabilities;
 
diff --git a/kexec/kexec.c b/kexec/kexec.c
index fe29dad..abc1cce 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -29,6 +29,9 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <getopt.h>
+
+#include "config.h"
+
 #ifdef HAVE_ZLIB_H
 #include <zlib.h>
 #endif
@@ -718,7 +721,7 @@ static int my_exec(void)
 
 static void version(void)
 {
-	printf(PACKAGE " " VERSION " released " RELEASE_DATE "\n");
+	printf(PACKAGE_STRING " released " PACKAGE_DATE "\n");
 }
 
 void usage(void)
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 2ee48c4..2384c53 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -1,6 +1,8 @@
 #ifndef KEXEC_H
 #define KEXEC_H
 
+#include "config.h"
+
 #include <sys/types.h>
 #include <stdint.h>
 #define USE_BSD
@@ -197,7 +199,7 @@ extern unsigned char purgatory[];
 extern size_t purgatory_size;
 
 #define BOOTLOADER "kexec"
-#define BOOTLOADER_VERSION VERSION
+#define BOOTLOADER_VERSION PACKAGE_VERSION
 
 void arch_usage(void);
 int arch_process_options(int argc, char **argv);
diff --git a/kexec_test/kexec_test.S b/kexec_test/kexec_test.S
index 5106c5c..ad081bc 100644
--- a/kexec_test/kexec_test.S
+++ b/kexec_test/kexec_test.S
@@ -17,6 +17,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include "config.h"
+
 	.equ	PROT_CODE_SEG, pmcs - gdt
 	.equ	REAL_CODE_SEG, rmcs - gdt
  	.equ	PROT_DATA_SEG, pmds - gdt
@@ -419,7 +421,7 @@ gdt_end:
 	
 s_hello:
 	.ascii	"kexec_test "
-	.ascii VERSION
+	.ascii PACKAGE_VERSION
 	.asciz " starting...\r\n"
 s_switching_descriptors:
 	.asciz	"Switching descriptors.\r\n"

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
