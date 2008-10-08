Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnSMR-0002du-FJ
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 06:17:28 +0000
Date: Wed, 8 Oct 2008 17:17:26 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] Only use -fno-zero-initialized-in-bss if it is available
Message-ID: <20081008061723.GG22396@verge.net.au>
References: <20080904140850.GC14660@edgar.se.axis.com>
	<20080905004244.GA22365@verge.net.au>
	<20080905092557.GA12335@edgar.se.axis.com>
	<20081008061541.GF22396@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081008061541.GF22396@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Cc: "Edgar E. Iglesias" <edgar@axis.com>, kexec@lists.infradead.org, jespern@axis.com

As pointed out by Edgar E. Iglesias, the -fno-zero-initialized-in-bss
option to gcc is not available in the cris 3.2.1 toolchain.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in        |    1 +
 configure.ac       |   14 ++++++++++++++
 purgatory/Makefile |    6 +++---
 3 files changed, 18 insertions(+), 3 deletions(-)

I have applied this patch to the kexec-tools git tree.

diff --git a/Makefile.in b/Makefile.in
index f0621e1..6b4c954 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -46,6 +46,7 @@ TARGET_CFLAGS	= @TARGET_CFLAGS@
 CPPFLAGS	= @CPPFLAGS@ -I$(srcdir)/include -I$(srcdir)/util_lib/include \
 			-Iinclude/
 CFLAGS		= @CFLAGS@ -fno-strict-aliasing -Wall -Wstrict-prototypes
+PURGATORY_EXTRA_CFLAGS = @PURGATORY_EXTRA_CFLAGS@
 ASFLAGS		= @ASFLAGS@
 LDFLAGS		= @LDFLAGS@
 LIBS		= @LIBS@
diff --git a/configure.ac b/configure.ac
index c677334..5351d53 100644
--- a/configure.ac
+++ b/configure.ac
@@ -7,6 +7,7 @@ dnl ---Required
 AC_INIT(kexec-tools, 2.0.0-git)
 AC_CONFIG_AUX_DIR(./config)
 AC_CONFIG_HEADERS([include/config.h])
+AC_LANG(C)
 
 AC_DEFINE_UNQUOTED(PACKAGE_DATE, "19th July 2008",
 		[Define to the release date of this package])
@@ -105,6 +106,19 @@ else
 	TARGET_LD="$LD"
 fi
 
+AC_MSG_CHECKING([whether $TARGET_CC accepts -fno-zero-initialized-in-bss])
+saved_CFLAGS="$CFLAGS"
+saved_CC="$CC"
+CC="$TARGET_CC"
+CFLAGS="$CFLAGS -fno-zero-initialized-in-bss"
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM(,,)],
+		  PURGATORY_EXTRA_CFLAGS="-fno-zero-initialized-in-bss"
+		  AC_MSG_RESULT([Yes]), AC_MSG_RESULT([No]))
+CFLAGS="$saved_CFLAGS"
+CC="$saved_CC"
+
+AC_SUBST(PURGATORY_EXTRA_CFLAGS, [$PURGATORY_EXTRA_CFLAGS])
+
 dnl Find the helper functions
 AC_PROG_INSTALL
 AC_CHECK_PROG([MKDIR],    mkdir,    mkdir,    "no", [$PATH])
diff --git a/purgatory/Makefile b/purgatory/Makefile
index ac58719..ceab269 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -45,9 +45,9 @@ purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
 	$(COMPILE.c) -o $@ $^
 
 $(PURGATORY): CC=$(TARGET_CC)
-$(PURGATORY): CFLAGS+=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
-		      -Os -fno-builtin -ffreestanding \
-		      -fno-zero-initialized-in-bss
+$(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
+		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
+		      -Os -fno-builtin -ffreestanding
 
 $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/include \

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
