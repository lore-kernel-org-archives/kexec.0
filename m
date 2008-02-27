Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUJmX-0002Xh-DK
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 10:45:02 +0000
Message-Id: <20080227104402.449882870@vergenet.net>
References: <20080227103536.406746333@vergenet.net>
Date: Wed, 27 Feb 2008 19:35:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 3/7] kexec-tools: Update mips port for recent build changes
Content-Disposition: inline; filename=mips-build.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tomasz Chmielewski <mangoo@wpkg.org>, Francesco Chiechi <francesco.chiechi@colibre.it>
Cc: kexec@lists.infradead.org

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/Makefile                 |    1 +
 kexec/arch/mipsel/Makefile     |   13 +++++++++----
 purgatory/Makefile             |    1 +
 purgatory/arch/mipsel/Makefile |    8 ++++++--
 4 files changed, 17 insertions(+), 6 deletions(-)

Index: kexec-tools-mips/kexec/Makefile
===================================================================
--- kexec-tools-mips.orig/kexec/Makefile	2008-02-27 19:05:29.000000000 +0900
+++ kexec-tools-mips/kexec/Makefile	2008-02-27 19:05:48.000000000 +0900
@@ -33,6 +33,7 @@ include $(srcdir)/kexec/arch/alpha/Makef
 include $(srcdir)/kexec/arch/arm/Makefile
 include $(srcdir)/kexec/arch/i386/Makefile
 include $(srcdir)/kexec/arch/ia64/Makefile
+include $(srcdir)/kexec/arch/mipsel/Makefile
 include $(srcdir)/kexec/arch/ppc/Makefile
 include $(srcdir)/kexec/arch/ppc64/Makefile
 include $(srcdir)/kexec/arch/s390/Makefile
Index: kexec-tools-mips/kexec/arch/mipsel/Makefile
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/Makefile	2008-02-27 19:07:50.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/Makefile	2008-02-27 19:13:30.000000000 +0900
@@ -1,7 +1,12 @@
 #
 # kexec mipsel (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-mipsel.c
-KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-elf-mipsel.c
-KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-elf-rel-mipsel.c
-KEXEC_S_SRCS+= kexec/arch/mipsel/mipsel-setup-simple.S
+mipsel_KEXEC_SRCS =  kexec/arch/mipsel/kexec-mipsel.c
+mipsel_KEXEC_SRCS += kexec/arch/mipsel/kexec-elf-mipsel.c
+mipsel_KEXEC_SRCS += kexec/arch/mipsel/kexec-elf-rel-mipsel.c
+mipsel_KEXEC_SRCS += kexec/arch/mipsel/mipsel-setup-simple.S
+
+dist += kexec/arch/mipsel/Makefile $(mipsel_KEXEC_SRCS)			\
+	kexec/arch/mipsel/kexec-mipsel.h				\
+	kexec/arch/mipsel/include/arch/options.h
+
Index: kexec-tools-mips/purgatory/Makefile
===================================================================
--- kexec-tools-mips.orig/purgatory/Makefile	2008-02-27 19:08:55.000000000 +0900
+++ kexec-tools-mips/purgatory/Makefile	2008-02-27 19:09:05.000000000 +0900
@@ -20,6 +20,7 @@ include $(srcdir)/purgatory/arch/alpha/M
 include $(srcdir)/purgatory/arch/arm/Makefile
 include $(srcdir)/purgatory/arch/i386/Makefile
 include $(srcdir)/purgatory/arch/ia64/Makefile
+include $(srcdir)/purgatory/arch/mipsel/Makefile
 include $(srcdir)/purgatory/arch/ppc/Makefile
 include $(srcdir)/purgatory/arch/ppc64/Makefile
 include $(srcdir)/purgatory/arch/s390/Makefile
Index: kexec-tools-mips/purgatory/arch/mipsel/Makefile
===================================================================
--- kexec-tools-mips.orig/purgatory/arch/mipsel/Makefile	2008-02-27 19:08:55.000000000 +0900
+++ kexec-tools-mips/purgatory/arch/mipsel/Makefile	2008-02-27 19:11:04.000000000 +0900
@@ -2,6 +2,10 @@
 # Purgatory mipsel
 #
 
-PURGATORY_C_SRCS+= purgatory/arch/mipsel/purgatory-mipsel.c
-PURGATORY_C_SRCS+= purgatory/arch/mipsel/console-mipsel.c
+mipsel_PURGATORY_C_SRCS+= purgatory/arch/mipsel/purgatory-mipsel.c
+mipsel_PURGATORY_C_SRCS+= purgatory/arch/mipsel/console-mipsel.c
+
+dist += purgatory/arch/mipsel/Makefile $(mipsel_PURGATORY_C_SRCS)	\
+	purgatory/arch/mipsel/include/limits.h				\
+	purgatory/arch/mipsel/purgatory-mipsel.h
 

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
