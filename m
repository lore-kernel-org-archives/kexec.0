Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH0Y-00Ck8h-Pp
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:26:44 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 6/7] build: add distcheck target
Date: Fri,  2 Apr 2021 12:17:36 +0200
Message-Id: <20210402101737.1886-7-horms@verge.net.au>
In-Reply-To: <20210402101737.1886-1-horms@verge.net.au>
References: <20210402101737.1886-1-horms@verge.net.au>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Add distcheck target which aims to exercise build, install and uninstall
using distribution tarball.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in  | 39 ++++++++++++++++++++++++++++++++++++++-
 configure.ac |  1 +
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index 1569b42..09bbd5c 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -55,6 +55,8 @@ LIBS		= @LIBS@
 
 # Utilities called by the makefiles
 INSTALL		= @INSTALL@
+CHMOD		= @CHMOD@
+CD		= cd
 MKDIR		= @MKDIR@
 RM		= @RM@
 CP		= @CP@
@@ -215,6 +217,8 @@ dist: tarball
 tarball: $(TARBALL.gz)
 
 $(TARBALL): $(SRCS) $(GENERATED_SRCS)
+	[ ! -d $(PACKAGE_NAME)-$(PACKAGE_VERSION) ] || \
+	        $(CHMOD) u+w $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 	$(RM) -rf $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 	$(MKDIR) $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 	$(TAR) -c $(SRCS) $(GENERATED_SRCS) | \
@@ -255,6 +259,38 @@ dist-clean: clean
 	$(RM) -f include/config.h.in configure $(SPEC)
 	$(RM) -rf autom4te.cache
 
+distuninstallcheck:
+	FOUND=$$(find $(distuninstallcheck_dir) ! -type d) && \
+		[ -z "$$FOUND" ] || { \
+			echo "Unexpeced files found after uninstall:" && \
+			echo "$$FOUND" && \
+			exit 1; }
+
+distcheck: $(TARBALL)
+	[ ! -d $(PACKAGE_NAME)-$(PACKAGE_VERSION) ] || \
+	        $(CHMOD) u+w $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(RM) -rf $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(TAR) -xf $(TARBALL)
+	$(MKDIR) $(PACKAGE_NAME)-$(PACKAGE_VERSION)/_build \
+	         $(PACKAGE_NAME)-$(PACKAGE_VERSION)/_build/sub \
+	         $(PACKAGE_NAME)-$(PACKAGE_VERSION)/_inst \
+	         $(PACKAGE_NAME)-$(PACKAGE_VERSION)/_dest
+	$(CHMOD) a-w $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	test -d $(PACKAGE_NAME)-$(PACKAGE_VERSION)/_build
+	INSTALL_BASE=$$($(CD) $(PACKAGE_NAME)-$(PACKAGE_VERSION)/_inst && pwd | sed -e 's,^[^:\\/]:[\\/],/,') &&\
+		DESTDIR="$(PACKAGE_NAME)-$(PACKAGE_VERSION)/_dest" && \
+		$(CD) $(PACKAGE_NAME)-$(PACKAGE_VERSION)/_build/sub && \
+			../../configure \
+			$(DISTCHECK_CONFIGURE_FLAGS) \
+			--srcdir=../.. --prefix="$$INSTALL_BASE" && \
+		$(MAKE) $(AM_MAKEFLAGS) && \
+		$(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$DESTDIR" install && \
+		$(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$DESTDIR" uninstall && \
+		$(MAKE) $(AM_MAKEFLAGS) distuninstallcheck_dir="$$DESTDIR" \
+			distuninstallcheck
+	$(CHMOD) u+w $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(RM) -rf $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+
 install: $(TARGETS)
 	for file in $(TARGETS) ; do \
 		if test `$(DIRNAME) $$file` =     "$(SBINDIR)" ; then \
@@ -355,5 +391,6 @@ uninstall:
 		done; \
 	done
 
-.PHONY: echo install uninstall all targets uninstall-targets clean dist-clean distclean \
+.PHONY: echo install uninstall distuninstallcheck all targets \
+	uninstall-targets clean dist-clean distclean distcheck \
 	maintainer-clean maintainerclean dist tarball rpm
diff --git a/configure.ac b/configure.ac
index 6c8e053..6469fd1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -151,6 +151,7 @@ AC_SUBST(PURGATORY_EXTRA_CFLAGS, [$PURGATORY_EXTRA_CFLAGS])
 
 dnl Find the helper functions
 AC_PROG_INSTALL
+AC_CHECK_PROG([CHMOD],    chmod,    chmod,    "no", [$PATH])
 AC_CHECK_PROG([MKDIR],    mkdir,    mkdir,    "no", [$PATH])
 AC_CHECK_PROG([RM],       rm,       rm,       "no", [$PATH])
 AC_CHECK_PROG([CP],       cp,       cp,       "no", [$PATH])
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
