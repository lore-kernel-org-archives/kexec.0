Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7b-0008Dm-Jg
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:30 +0000
MIME-Version: 1.0
Subject: [PATCH 6/8] Build system simplification/standardisation
Message-Id: <1197967675.861836.168554211387.6.gpush@pokey>
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

This change makes kexec-tools work more like a standard configure-make-
make-install-type project:

* Remove $(OBJDIR) stuff. To do an out-of-tree build, just configure
from a different directory.

* Use the implicit Makefile rules more, and just edit the compiler
flags for specific targets.

* Simplify compiler/linker flags - no need for EXTRA_*

* Add TARGET_CC, and improve checks for BUILD_CC too.

* Set arch-specific flags in arch-specific makefiles, not conditional
on $(ARCH).

* Use combined _SRCS and _OBJS instead of splitting into .S and .c
components

* Use a $(clean) variable to store items to be removed on 'make clean'

* Generate dependency files in the main compile, rather than as a
separate step.

* Don't #include sha256.c, but re-build it into the purgatory.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 Makefile                       |  251 --------------------------------
 Makefile.conf.in               |   51 ------
 Makefile.in                    |  319 +++++++++++++++++++++++++++++++++++++++++
 configure.ac                   |   38 ++--
 kdump/Makefile                 |   27 +--
 kexec/Makefile                 |   91 +++--------
 kexec/arch/i386/Makefile       |   18 +-
 kexec/arch/ia64/Makefile       |   10 -
 kexec/arch/ppc/Makefile        |   12 -
 kexec/arch/ppc64/Makefile      |   14 -
 kexec/arch/s390/Makefile       |    6 
 kexec/arch/sh/Makefile         |   10 -
 kexec/arch/x86_64/Makefile     |   20 +-
 kexec_test/Makefile            |   35 +---
 purgatory/Makefile             |   81 +++-------
 purgatory/arch/alpha/Makefile  |    3 
 purgatory/arch/i386/Makefile   |   22 +-
 purgatory/arch/ia64/Makefile   |   11 -
 purgatory/arch/ppc/Makefile    |    6 
 purgatory/arch/ppc64/Makefile  |   12 -
 purgatory/arch/s390/Makefile   |    4 
 purgatory/arch/sh/Makefile     |    4 
 purgatory/arch/x86_64/Makefile |   23 +-
 purgatory/include/string.h     |    2 
 purgatory/purgatory.c          |    4 
 util/Makefile                  |   14 +
 util_lib/Makefile              |   28 +--
 27 files changed, 525 insertions(+), 591 deletions(-)

diff --git a/Makefile b/Makefile
deleted file mode 100644
index 73ff2f1..0000000
--- a/Makefile
+++ /dev/null
@@ -1,251 +0,0 @@
-# Hey Emacs this is a -*- makefile-*-
-include Makefile.conf
-
-pkgdatadir = $(datadir)/$(PACKAGE)
-pkglibdir = $(libdir)/$(PACKAGE)
-pkgincludedir = $(includedir)/$(PACKAGE)
-
-# You can specify DESTDIR on the command line to do a add
-# a prefix to the install so it doesn't really happen
-# Useful for building binary packages
-DESTDIR =
-
-EXTRA_CPPFLAGS:= -I./include -I./util_lib/include $(DEFS) $(EXTRA_CFLAGS)
-
-PREFIX:=$(OBJDIR)/build
-SBINDIR=$(PREFIX)/sbin
-BINDIR=$(PREFIX)/bin
-LIBEXECDIR=$(PREFIX)/libexec
-DATADIR=$(PREFIX)/share
-SYSCONFDIR=$(PREFIX)/etc
-SHAREDSTATEDIR=$(PREFIX)/com
-LOCALSTATEDIR=$(PREFIX)/var
-LIBDIR=$(PREFIX)/lib
-INFODIR=$(PREFIX)/info
-MANDIR=$(PREFIX)/man
-MAN1DIR=$(MANDIR)/man1
-MAN2DIR=$(MANDIR)/man2
-MAN3DIR=$(MANDIR)/man3
-MAN4DIR=$(MANDIR)/man4
-MAN5DIR=$(MANDIR)/man5
-MAN6DIR=$(MANDIR)/man6
-MAN7DIR=$(MANDIR)/man7
-MAN8DIR=$(MANDIR)/man8
-INCLUDEDIR=$(PREFIX)/include
-
-PKGDATADIR=$(DATADIR)/$(PACKAGE)
-PKGLIBDIR=$(LIBDIR)/$(PACKAGE)
-PKGINCLUDEIR=$(INCLUDEDIR)/$(PACKAGE)
-
-MAN_PAGES:= kexec/kexec.8
-MAN_PAGES+= kdump/kdump.8
-BINARIES_i386:=  $(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
-BINARIES_x86_64:=$(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
-BINARIES:=$(SBINDIR)/kexec $(SBINDIR)/kdump $(BINARIES_$(ARCH)) 
-
-TARGETS:=$(BINARIES) $(MAN_PAGES)
-
-all: $(TARGETS)
-
-# cc-option
-# Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
-cc-option = $(shell if $(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(1) -S -o /dev/null \
-	     -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else \
-	     echo "$(2)"; fi ;)
-
-# Utility function library
-#
-include util_lib/Makefile
-
-#
-# Stand alone utilities
-#
-include util/Makefile
-
-#
-# purgatory (code between kernels)
-#
-include purgatory/Makefile
-
-#
-# kexec (linux booting linux)
-#
-include kexec/Makefile
-
-
-# kdump (read a crashdump from memory)
-#
-include kdump/Makefile
-
-#
-# kexec_test (test program)
-#
-ifeq ($(ARCH),i386)
-include kexec_test/Makefile
-endif
-ifeq ($(ARCH),x86_64)
-include kexec_test/Makefile
-endif
-
-SPEC=$(PACKAGE).spec
-GENERATED_SRCS:= ./configure ./$(SPEC)
-TARBALL=$(OBJDIR)/$(PACKAGE)-$(VERSION).tar.gz
-SRCS:=$(shell $(FIND) \
-	./AUTHORS ./COPYING ./News ./TODO \
-	./Makefile ./Makefile.conf.in ./configure.ac \
-	./kexec-tools.spec.in ./config ./doc \
-	./include ./kexec ./purgatory ./kexec_test ./kdump ./util ./util_lib \
-	! -path '*CVS*' ! -name '*~' ! -name '.*' \
-	-type f -print )
-SRCS+=$(GENERATED_SRCS)
-PSRCS:=$(patsubst ./%,$(PACKAGE)-$(VERSION)/%,$(SRCS))
-
-Makefile.conf: Makefile.conf.in configure
-	/bin/sh ./configure
-
-configure: configure.ac
-	autoheader
-	autoconf
-	$(RM) -rf autom4te.cache
-
-tarball: $(TARBALL)
-
-$(TARBALL): $(SRCS) $(SPEC)
-	$(MKDIR) -p $(OBJDIR)
-	$(RM) -f $(OBJDIR)/$(PACKAGE)-$(VERSION)
-	$(LN) -s .. $(OBJDIR)/$(PACKAGE)-$(VERSION)
-	(cd $(OBJDIR); $(TAR) -cf - $(PSRCS) | gzip -9) > $@
-
-rpm: $(TARBALL)
-	$(MKDIR) -p $(OBJDIR)/RPM $(OBJDIR)/SRPM $(OBJDIR)/BUILD $(OBJDIR)/SPECS \
-		$(OBJDIR)/TMP $(OBJDIR)/SOURCES
-	unset MAKEFLAGS MAKELEVEL; \
-	$(RPMBUILD) -ta \
-		--define '_rpmdir $(OBJDIR)/RPM' \
-		--define '_srcrpmdir $(OBJDIR)/SRPM' \
-		--define '_builddir $(OBJDIR)/BUILD' \
-		--define '_specdir $(OBJDIR)/SPECS' \
-		--define '_tmppath $(OBJDIR)/TMP' \
-		--define '_sourcedir $(OBJDIR)/SOURCES' \
-		$(TARBALL)
-
-$(SPEC): kexec-tools.spec.in Makefile
-	$(SED) -e 's,^Version: $$,Version: $(VERSION),' $< > $@
-
-echo::
-	@echo ARCH=$(ARCH)
-	@echo BINARIES=$(BINARIES)
-	@echo TARGETS=$(TARGETS)
-	@echo CC=$(CC)
-	@echo AR=$(AR)
-	@echo LD=$(LD)
-
-clean:
-	@$(FIND) $(OBJDIR) ! -name '*.d' -type f | $(XARGS) $(RM) rm -f
-	@$(RM) -rf rpm
-	@$(RM) -f config.log config.status config.cache
-	@$(RM) -f $(TARBALL)
-
-distclean: dist-clean
-
-dist-clean: clean
-	@$(RM) -rf $(OBJDIR)
-	@$(FIND) . -type f -name '*~' -o -name '*.orig' | $(XARGS) $(RM) -f
-	@$(RM) -f Makefile.conf
-
-maintainerclean: maintainer-clean
-
-maintainer-clean: dist-clean
-	@$(RM) -f $(GENERATED_SRCS)
-
-
-install: $(TARGETS)
-	for file in $(TARGETS) ; do \
-		if test `$(DIRNAME) $$file` =     "$(SBINDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(sbindir)/; \
-			$(INSTALL) -m 555  $$file $(DESTDIR)/$(sbindir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(BINDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(bindir)/; \
-			$(INSTALL) -m 555 $$file $(DESTDIR)/$(bindir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(LIBEXECDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(libexecdir)/; \
-			$(INSTALL) -m 555 $$file $(DESTDIR)/$(libexecdir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(DATADIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(datadir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(datadir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(SYSCONFDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(sysconfdir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(sysconfdir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(SHAREDSTATEDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(sharedstatedir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(sharedstatedir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(LOCALSTATEDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(localstatedir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(localstatedir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(LIBDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(libdir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(libdir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(INFODIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(infodir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(infodir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN1DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man1; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man1; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN2DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man2; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man2; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN3DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man3/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man3/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN4DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man4/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man4/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN5DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man5/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man5/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN6DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man6/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man6/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN7DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man7/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man7/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(MAN8DIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man8/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man8/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(INCLUDEDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(includedir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(includedir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(PKGDATADIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(pkgdatadir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(pkgdatadir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(PKGLIBDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(pkglibdir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(pkglibdir)/; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(PKGINCLUDEDIR)" ; then \
-			$(MKDIR) -p     $(DESTDIR)/$(pkgincludedir)/; \
-			$(INSTALL) -m 444 $$file $(DESTDIR)/$(pkgincludedir)/; \
-		fi; \
-	done
-
-.PHONY: echo install all clean dist-clean distclean maintainer-clean 	\
-	maintainerclean tarball rpm
diff --git a/Makefile.conf.in b/Makefile.conf.in
deleted file mode 100644
index b5418e0..0000000
--- a/Makefile.conf.in
+++ /dev/null
@@ -1,51 +0,0 @@
-# Hey Emacs this is a -*- makefile-*-
-
-prefix=@prefix@
-exec_prefix=@exec_prefix@
-
-bindir=@bindir@
-sbindir=@sbindir@
-libexecdir=@libexecdir@
-datadir=@datadir@
-sysconfdir=@sysconfdir@
-sharedstatedir=@sharedstatedir@
-localstatedir=@localstatedir@
-libdir=@libdir@
-infodir=@infodir@
-mandir=@mandir@
-includedir=@includedir@
-
-LIBS=@LIBS@
-
-# The target architecture
-ARCH  =@ARCH@
-OBJDIR=@OBJDIR@
-
-# Compiler for building kexec
-CC          =@CC@
-CPP         =@CPP@
-LD          =@LD@
-AS          =@AS@
-OBJCOPY     =@OBJCOPY@
-AR          =@AR@
-CFLAGS      =@CFLAGS@
-EXTRA_CFLAGS=@EXTRA_CFLAGS@
-LDFLAGS     =@LDFLAGS@ 
-
-# Utilities called by the makefiles
-INSTALL=@INSTALL@
-MKDIR=@MKDIR@
-RM=@RM@
-CP=@CP@
-LN=@LN@
-TAR=@TAR@
-RPMBUILD=@RPMBUILD@
-SED=@SED@
-FIND=@FIND@
-XARGS=@XARGS@
-DIRNAME=@DIRNAME@
-
-# C compiler for building utilities to use
-# during the build
-BUILD_CC=@BUILD_CC@
-BUILD_CFLAGS=@BUILD_CFLAGS@  $(DEFS)
diff --git a/Makefile.in b/Makefile.in
new file mode 100644
index 0000000..fdbb7c2
--- /dev/null
+++ b/Makefile.in
@@ -0,0 +1,319 @@
+# Hey Emacs this is a -*- makefile-*-
+
+PACKAGE_NAME	= @PACKAGE_NAME@
+PACKAGE_VERSION	= @PACKAGE_VERSION@
+
+prefix		= @prefix@
+exec_prefix	= @exec_prefix@
+
+bindir		= @bindir@
+sbindir		= @sbindir@
+libexecdir	= @libexecdir@
+datadir		= @datadir@
+sysconfdir	= @sysconfdir@
+sharedstatedir	= @sharedstatedir@
+localstatedir	= @localstatedir@
+libdir		= @libdir@
+infodir		= @infodir@
+mandir		= @mandir@
+includedir	= @includedir@
+
+
+# The target architecture
+ARCH		= @ARCH@
+OBJDIR		= @OBJDIR@
+target		= @target@
+host		= @host@
+
+# Compiler for building kexec
+CC		= @CC@
+CPP		= @CPP@
+LD		= @LD@
+AS		= @AS@
+OBJCOPY		= @OBJCOPY@
+AR		= @AR@
+
+# C compiler for binaries to run during the build
+BUILD_CC	= @BUILD_CC@
+BUILD_CFLAGS	= @BUILD_CFLAGS@
+TARGET_CC	= @TARGET_CC@
+TARGET_CFLAGS	= @TARGET_CFLAGS@
+
+
+# Base compiler flags. These are extended by the subcomponent-Makefiles
+# where necessary.
+CPPFLAGS	= @CPPFLAGS@ -I$(srcdir)/include -I$(srcdir)/util_lib/include \
+		  	-Iinclude/
+CFLAGS		= @CFLAGS@ -fno-strict-aliasing -Wall -Wstrict-prototypes
+ASFLAGS		= @ASFLAGS@
+LDFLAGS		= @LDFLAGS@
+LIBS		= @LIBS@
+
+# Utilities called by the makefiles
+INSTALL		= @INSTALL@
+MKDIR		= @MKDIR@
+RM		= @RM@
+CP		= @CP@
+LN		= @LN@
+TAR		= @TAR@
+RPMBUILD	= @RPMBUILD@
+SED		= @SED@
+FIND		= @FIND@
+XARGS		= @XARGS@
+DIRNAME		= @DIRNAME@
+
+
+pkgdatadir = $(datadir)/$(PACKAGE_NAME)
+pkglibdir = $(libdir)/$(PACKAGE_NAME)
+pkgincludedir = $(includedir)/$(PACKAGE_NAME)
+
+# You can specify DESTDIR on the command line to do a add
+# a prefix to the install so it doesn't really happen
+# Useful for building binary packages
+DESTDIR =
+
+srcdir		= @srcdir@
+VPATH		= .:$(srcdir)
+
+# install paths
+BUILD_PREFIX:=build
+SBINDIR=$(BUILD_PREFIX)/sbin
+BINDIR=$(BUILD_PREFIX)/bin
+LIBEXECDIR=$(BUILD_PREFIX)/libexec
+DATADIR=$(BUILD_PREFIX)/share
+SYSCONFDIR=$(BUILD_PREFIX)/etc
+SHAREDSTATEDIR=$(BUILD_PREFIX)/com
+LOCALSTATEDIR=$(BUILD_PREFIX)/var
+LIBDIR=$(BUILD_PREFIX)/lib
+INFODIR=$(BUILD_PREFIX)/info
+MANDIR=$(BUILD_PREFIX)/man
+MAN1DIR=$(MANDIR)/man1
+MAN2DIR=$(MANDIR)/man2
+MAN3DIR=$(MANDIR)/man3
+MAN4DIR=$(MANDIR)/man4
+MAN5DIR=$(MANDIR)/man5
+MAN6DIR=$(MANDIR)/man6
+MAN7DIR=$(MANDIR)/man7
+MAN8DIR=$(MANDIR)/man8
+INCLUDEDIR=$(BUILD_PREFIX)/include
+
+PKGDATADIR=$(DATADIR)/$(PACKAGE_NAME)
+PKGLIBDIR=$(LIBDIR)/$(PACKAGE_NAME)
+PKGINCLUDEIR=$(INCLUDEDIR)/$(PACKAGE_NAME)
+
+MAN_PAGES:= kexec/kexec.8
+MAN_PAGES+= kdump/kdump.8
+BINARIES_i386:=  $(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
+BINARIES_x86_64:=$(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
+BINARIES:=$(SBINDIR)/kexec $(SBINDIR)/kdump $(BINARIES_$(ARCH))
+
+TARGETS:=$(BINARIES) $(MAN_PAGES)
+
+all: $(TARGETS)
+
+# generic build rules
+%.o: %.c
+	@$(MKDIR) -p $(@D)
+	$(COMPILE.c) -MD -o $@ $<
+
+%.o: %.S
+	@$(MKDIR) -p $(@D)
+	$(COMPILE.S) -MD -o $@ $<
+
+# collect objects to be removed in 'make clean'
+clean =
+
+# utility function for converting a list of files (with extension) to
+# file.o (or file.d) format.
+objify = $(addsuffix .o, $(basename $(1)))
+depify = $(addsuffix .d, $(basename $(1)))
+
+# Utility function library
+#
+include $(srcdir)/util_lib/Makefile
+
+#
+# Stand alone utilities
+#
+include $(srcdir)/util/Makefile
+
+#
+# purgatory (code between kernels)
+#
+include $(srcdir)/purgatory/Makefile
+
+#
+# kexec (linux booting linux)
+#
+include $(srcdir)/kexec/Makefile
+
+
+# kdump (read a crashdump from memory)
+#
+include $(srcdir)/kdump/Makefile
+
+#
+# kexec_test (test program)
+#
+ifeq ($(ARCH),i386)
+include $(srcdir)/kexec_test/Makefile
+endif
+ifeq ($(ARCH),x86_64)
+include $(srcdir)/kexec_test/Makefile
+endif
+
+SPEC=$(PACKAGE_NAME).spec
+GENERATED_SRCS:= $(SPEC)
+TARBALL=$(PACKAGE_NAME)-$(PACKAGE_VERSION).tar
+TARBALL.gz=$(TARBALL).gz
+SRCS:= AUTHORS COPYING News TODO Makefile.in configure.ac \
+	kexec-tools.spec.in config doc include kexec purgatory kexec_test \
+	kdump util util_lib configure
+PSRCS:=$(foreach s, $(SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
+PGSRCS:=$(foreach s, $(GENERATED_SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
+
+Makefile: Makefile.in configure
+	$(srcdir)/configure
+
+configure: configure.ac
+	cd $(srcdir) && autoheader && autoconf && rm -rf autom4te.cache
+
+tarball: $(TARBALL.gz)
+
+$(TARBALL): $(SRCS) $(GENERATED_SRCS)
+	$(RM) -f $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(LN) -s $(srcdir) $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(TAR) -cf $@ $(PSRCS)
+	$(RM) -f $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(LN) -sf . $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(TAR) -rf $@ $(PGSRCS)
+	$(RM) -f $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+
+$(TARBALL.gz): $(TARBALL)
+	gzip -c < $^ > $@
+
+RPMDIR=rpm
+rpm: $(TARBALL)
+	$(MKDIR) -p $(RPMDIR)/RPM $(RPMDIR)/SRPM $(RPMDIR)/BUILD \
+		$(RPMDIR)/SPECS $(RPMDIR)/TMP $(RPMDIR)/SOURCES
+	unset MAKEFLAGS MAKELEVEL; \
+	$(RPMBUILD) -ta \
+		--define '_rpmdir $(RPMDIR)/RPM' \
+		--define '_srcrpmdir $(RPMDIR)/SRPM' \
+		--define '_builddir $(RPMDIR)/BUILD' \
+		--define '_specdir $(RPMDIR)/SPECS' \
+		--define '_tmppath $(RPMDIR)/TMP' \
+		--define '_sourcedir $(RPMDIR)/SOURCES' \
+		$(TARBALL)
+
+$(SPEC): kexec-tools.spec.in Makefile
+	$(SED) -e 's,^Version: $$,Version: $(PACKAGE_VERSION),' $< > $@
+
+echo::
+	@echo ARCH=$(ARCH)
+	@echo BINARIES=$(BINARIES)
+	@echo TARGETS=$(TARGETS)
+	@echo CC=$(CC)
+	@echo AR=$(AR)
+	@echo LD=$(LD)
+
+clean:
+	$(RM) -f $(clean)
+	$(RM) -rf rpm build
+	$(RM) -f $(TARBALL) $(TARBALL.gz)
+
+distclean: dist-clean
+
+dist-clean: clean
+	$(RM) -f config.log config.status config.cache Makefile include/config.h
+
+install: $(TARGETS)
+	for file in $(TARGETS) ; do \
+		if test `$(DIRNAME) $$file` =     "$(SBINDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(sbindir)/; \
+			$(INSTALL) -m 555  $$file $(DESTDIR)/$(sbindir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(BINDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(bindir)/; \
+			$(INSTALL) -m 555 $$file $(DESTDIR)/$(bindir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(LIBEXECDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(libexecdir)/; \
+			$(INSTALL) -m 555 $$file $(DESTDIR)/$(libexecdir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(DATADIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(datadir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(datadir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(SYSCONFDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(sysconfdir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(sysconfdir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(SHAREDSTATEDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(sharedstatedir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(sharedstatedir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(LOCALSTATEDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(localstatedir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(localstatedir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(LIBDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(libdir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(libdir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(INFODIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(infodir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(infodir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN1DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man1; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man1; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN2DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man2; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man2; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN3DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man3/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man3/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN4DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man4/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man4/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN5DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man5/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man5/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN6DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man6/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man6/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN7DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man7/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man7/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(MAN8DIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(mandir)/man8/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(mandir)/man8/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(INCLUDEDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(includedir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(includedir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(PKGDATADIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(pkgdatadir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(pkgdatadir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(PKGLIBDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(pkglibdir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(pkglibdir)/; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(PKGINCLUDEDIR)" ; then \
+			$(MKDIR) -p     $(DESTDIR)/$(pkgincludedir)/; \
+			$(INSTALL) -m 444 $$file $(DESTDIR)/$(pkgincludedir)/; \
+		fi; \
+	done
+
+.PHONY: echo install all clean dist-clean distclean maintainer-clean 	\
+	maintainerclean tarball rpm
diff --git a/configure.ac b/configure.ac
index 8574bc6..6f0dbd6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,15 +13,11 @@ AC_DEFINE_UNQUOTED(PACKAGE_DATE, "30th October 2007",
 
 
 dnl -- Compilation platform configuration
+dnl -- the host specifices the host machine for the kexec binary, the
+dnl -- the target specifies the architecture of the kernel to be kexeced.
 AC_CANONICAL_HOST
-dnl Currentl AC_CANONICAL_HOST is sufficient for my needs
-dnl as there are only a small number of targets that kexec
-dnl can support on a given host system.  If it stops making
-dnl sense compile support for all possible targets a given
-dnl host can support AC_CANONICAL_TARGET may help
 AC_CANONICAL_TARGET
 
-
 dnl Compute ARCH from target cpu info
 case $target_cpu in
 	i?86 )
@@ -54,18 +50,8 @@ if test "${host_alias}" ; then
 	OBJDIR="$OBJDIR-${host_alias}"
 fi
 
-EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing -Wstrict-prototypes $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
-BUILD_CFLAGS='-O2 -Wall $(CPPFLAGS)'
-
-# Check whether ppc64. Add -m64 for building 64-bit binary
-# Add -mcall-aixdesc to generate dot-symbols as in gcc 3.3.3
-if test "$host_cpu" = ppc64; then
-  EXTRA_CFLAGS="$EXTRA_CFLAGS -m64 -mcall-aixdesc"
-fi;
-
-if test "$host_cpu" = ppc; then
-  EXTRA_CFLAGS="$EXTRA_CFLAGS -m32"
-fi;
+BUILD_CFLAGS='-O2 -Wall'
+TARGET_CFLAGS='-O2 -Wall'
 
 AC_ARG_WITH([objdir], AC_HELP_STRING([--with-objdir=<dir>],[select directory for object files]),
 	[ OBJDIR="$withval" ], [ OBJDIR="$OBJDIR" ])
@@ -87,11 +73,17 @@ dnl To specify a different compiler, just 'export CC=/path/to/compiler'
 AC_PROG_CC
 
 if test "${build}" != "${host}" ; then
-	BUILD_CC=${CC_FOR_BUILD-gcc}
+	AC_CHECK_PROGS(BUILD_CC, [${build_alias}-gcc ${build}-gcc gcc])
 else
-	BUILD_CC="\$(CC)"
+	BUILD_CC="$CC"
 fi
 
+dnl Find compiler for target
+if test "${target}" != "${host}" ; then
+	AC_CHECK_PROGS(TARGET_CC, [${target_alias}-gcc ${target}-gcc gcc])
+else
+	TARGET_CC="$CC"
+fi
 
 dnl Find the compiler tool chain
 AC_PROG_CPP
@@ -149,11 +141,13 @@ if test "$DIRNAME" = "no"; then AC_MSG_ERROR([ dirname not found]) fi
 dnl ---Output variables...
 AC_SUBST([BUILD_CC])
 AC_SUBST([BUILD_CFLAGS])
+AC_SUBST([TARGET_CC])
+AC_SUBST([TARGET_CFLAGS])
+AC_SUBST([ASFLAGS])
 
-AC_SUBST([EXTRA_CFLAGS])
 AC_SUBST([ARCH])
 AC_SUBST([OBJDIR])
 AC_SUBST([INSTALL])
 
 dnl ---Output
-AC_OUTPUT([Makefile.conf])
+AC_OUTPUT([Makefile])
diff --git a/kdump/Makefile b/kdump/Makefile
index 456c2fc..25c187b 100644
--- a/kdump/Makefile
+++ b/kdump/Makefile
@@ -2,37 +2,26 @@
 # kdump (reading a crashdump from memory)
 #
 
-KDUMP_C_SRCS:= kdump/kdump.c
+KDUMP_SRCS:= kdump/kdump.c
 
-KDUMP_C_OBJS:= $(patsubst %.c, $(OBJDIR)/%.o, $(KDUMP_C_SRCS))
-KDUMP_C_DEPS:= $(patsubst %.c, $(OBJDIR)/%.d, $(KDUMP_C_SRCS))
-KDUMP_SRCS:= $(KDUMP_C_SRCS)
-KDUMP_OBJS:= $(KDUMP_C_OBJS)
-KDUMP_DEPS:= $(KDUMP_C_DEPS)
-KDUMP:= $(SBINDIR)/kdump
-KDUMP_MANPAGE:= $(MANDIR)/man8/kdump.8
+KDUMP_OBJS = $(call objify, $(KDUMP_SRCS))
+KDUMP_DEPS = $(call depify, $(KDUMP_OBJS))
 
-include $(KDUMP_DEPS)
+KDUMP = $(SBINDIR)/kdump
+KDUMP_MANPAGE = $(MANDIR)/man8/kdump.8
 
-$(KDUMP_C_DEPS): $(OBJDIR)/%.d: %.c
-	mkdir -p $(@D)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -M $< | sed -e 's|$(patsubst %.d,%.o,$(@F))|$(patsubst %.d,%.o,$(@))|' > $@
+clean += $(KDUMP_OBJS) $(KDUMP_DEPS) $(KDUMP) $(KDUMP_MANPAGE)
 
-$(KDUMP_C_OBJS): $(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
-	mkdir -p $(@D)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -o $@ -c $<
+-include $(KDUMP_DEPS)
 
 $(KDUMP): $(KDUMP_OBJS)
-	mkdir -p $(@D)
+	@$(MKDIR) -p $(@D)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $(KDUMP_OBJS)
 
 $(KDUMP_MANPAGE): kdump/kdump.8
 	$(MKDIR) -p     $(MANDIR)/man8
 	cp kdump/kdump.8 $(KDUMP_MANPAGE)
 echo::
-	@echo "KDUMP_C_SRCS $(KDUMP_C_SRCS)"
-	@echo "KDUMP_C_DEPS $(KDUMP_C_DEPS)"
-	@echo "KDUMP_C_OBJS $(KDUMP_C_OBJS)"
 	@echo "KDUMP_SRCS $(KDUMP_SRCS)"
 	@echo "KDUMP_DEPS $(KDUMP_DEPS)"
 	@echo "KDUMP_OBJS $(KDUMP_OBJS)"
diff --git a/kexec/Makefile b/kexec/Makefile
index 6ad9461..29534d0 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -1,88 +1,51 @@
 #
 # kexec (linux booting linux)
 #
-PURGATORY_HEX_C:= $(OBJDIR)/kexec/purgatory.c
+PURGATORY_HEX_C = kexec/purgatory.c
 
 $(PURGATORY_HEX_C): $(PURGATORY) $(BIN_TO_HEX)
 	$(MKDIR) -p $(@D)
 	$(BIN_TO_HEX) purgatory < $(PURGATORY) > $@
 
-KCFLAGS:= $(CFLAGS) $(EXTRA_CFLAGS) -Ikexec/arch/$(ARCH)/include
+KEXEC_SRCS =
+KEXEC_GENERATED_SRCS =
 
-KEXEC_C_SRCS:= kexec/kexec.c 
-KEXEC_C_SRCS+= kexec/ifdown.c
-KEXEC_C_SRCS+= kexec/kexec-elf.c 
-KEXEC_C_SRCS+= kexec/kexec-elf-exec.c 
-KEXEC_C_SRCS+= kexec/kexec-elf-core.c
-KEXEC_C_SRCS+= kexec/kexec-elf-rel.c 
-KEXEC_C_SRCS+= kexec/kexec-elf-boot.c 
-KEXEC_C_SRCS+= kexec/kexec-iomem.c
-KEXEC_C_SRCS+= kexec/crashdump.c
-KEXEC_C_SRCS+= kexec/crashdump-xen.c
-KEXEC_C_GENERATED_SRCS+= $(PURGATORY_HEX_C)
-KEXEC_S_SRCS:= 
-KEXEC_S_GENERATED_SRCS:=
-include kexec/arch/$(ARCH)/Makefile
+KEXEC_SRCS += kexec/kexec.c
+KEXEC_SRCS += kexec/ifdown.c
+KEXEC_SRCS += kexec/kexec-elf.c
+KEXEC_SRCS += kexec/kexec-elf-exec.c
+KEXEC_SRCS += kexec/kexec-elf-core.c
+KEXEC_SRCS += kexec/kexec-elf-rel.c
+KEXEC_SRCS += kexec/kexec-elf-boot.c
+KEXEC_SRCS += kexec/kexec-iomem.c
+KEXEC_SRCS += kexec/crashdump.c
+KEXEC_SRCS += kexec/crashdump-xen.c
 
-KEXEC_C_OBJS:= $(patsubst %.c, $(OBJDIR)/%.o, $(KEXEC_C_SRCS) \
-	       $(KEXEC_C_GENERATED_SRCS))
-KEXEC_C_DEPS:= $(patsubst %.c, $(OBJDIR)/%.d, $(KEXEC_C_SRCS))
-KEXEC_C_DUMMY_DEPS:= $(patsubst %.c, $(OBJDIR)/%.d, $(KEXEC_C_GENERATED_SRCS))
-KEXEC_S_OBJS:= $(patsubst %.S, $(OBJDIR)/%.o, $(KEXEC_S_SRCS) \
-	       $(KEXEC_S_GENERATED_SRCS))
-KEXEC_S_DEPS:= $(patsubst %.S, $(OBJDIR)/%.d, $(KEXEC_S_SRCS))
-KEXEC_S_DUMMY_DEPS:= $(patsubst %.c, $(OBJDIR)/%.d, $(KEXEC_S_GENERATED_SRCS))
-KEXEC_SRCS:= $(KEXEC_C_SRCS) $(KEXEC_S_SRCS)
-KEXEC_OBJS:= $(KEXEC_C_OBJS) $(KEXEC_S_OBJS)
-KEXEC_DEPS:= $(KEXEC_C_DEPS) $(KEXEC_S_DEPS)
-KEXEC:= $(SBINDIR)/kexec
-KEXEC_MANPAGE:= $(MANDIR)/man8/kexec.8
+KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
 
-include $(KEXEC_DEPS)
+include $(srcdir)/kexec/arch/$(ARCH)/Makefile
 
-$(KEXEC_C_DEPS): $(OBJDIR)/%.d: %.c
-	mkdir -p $(@D)
-	$(CC) $(KCFLAGS) -M $< | sed -e 's|$(patsubst %.d,%.o,$(@F))|$(patsubst %.d,%.o,$(@))|' > $@
+KEXEC_OBJS = $(call objify, $(KEXEC_SRCS) $(KEXEC_GENERATED_SRCS))
+KEXEC_DEPS = $(call depify, $(KEXEC_OBJS))
 
-$(KEXEC_S_DEPS): $(OBJDIR)/%.d: %.S
-	mkdir -p $(@D)
-	$(CC) $(KCFLAGS) -M $< | sed -e 's|$(patsubst %.d,%.o,$(@F))|$(patsubst %.d,%.o,$(@))|' > $@
+clean += $(KEXEC_OBJS) $(KEXEC_DEPS) $(KEXEC_GENERATED_SRCS) \
+	 $(KEXEC) $(KEXEC_MANPAGE)
 
-# This is needed to ensure that the rule below that depend
-# on each .c file having a .d file don't break
-$(KEXEC_C_DUMMY_DEPS): $(OBJDIR)/%.d: %.c
-	mkdir -p $(@D)
-	touch $@
+KEXEC = $(SBINDIR)/kexec
+KEXEC_MANPAGE = $(MANDIR)/man8/kexec.8
 
-# This is needed to ensure that the rule below that depend
-# on each .S file having a .d file don't break
-$(KEXEC_S_DUMMY_DEPS): $(OBJDIR)/%.d: %.S
-	mkdir -p $(@D)
-	touch $@
-
-$(KEXEC_C_OBJS): $(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
-	mkdir -p $(@D)
-	$(CC) $(KCFLAGS) -o $@ -c $<
-
-$(KEXEC_S_OBJS): $(OBJDIR)/%.o: %.S $(OBJDIR)/%.d
-	mkdir -p $(@D)
-	$(CC) $(KCFLAGS) -o $@ -c $<
+-include $(KEXEC_DEPS)
 
 $(KEXEC): $(KEXEC_OBJS) $(UTIL_LIB)
-	mkdir -p $(@D)
-	$(CC) $(LDFLAGS) $(EXTRA_LDFLAGS) $(KCFLAGS) -o $@ \
-		$(KEXEC_OBJS) $(UTIL_LIB) $(LIBS)
+	@$(MKDIR) -p $(@D)
+	$(LINK.o) -o $@ $^
+
+$(KEXEC): CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/include
 
 $(KEXEC_MANPAGE): kexec/kexec.8
-	 $(MKDIR) -p     $(MANDIR)/man8
+	@$(MKDIR) -p     $(MANDIR)/man8
 	cp kexec/kexec.8 $(KEXEC_MANPAGE)
 echo::
-	@echo "KEXEC_C_SRCS $(KEXEC_C_SRCS)"
-	@echo "KEXEC_C_DEPS $(KEXEC_C_DEPS)"
-	@echo "KEXEC_C_OBJS $(KEXEC_C_OBJS)"
-	@echo "KEXEC_S_SRCS $(KEXEC_S_SRCS)"
-	@echo "KEXEC_S_DEPS $(KEXEC_S_DEPS)"
-	@echo "KEXEC_S_OBJS $(KEXEC_S_OBJS)"
 	@echo "KEXEC_SRCS $(KEXEC_SRCS)"
 	@echo "KEXEC_DEPS $(KEXEC_DEPS)"
 	@echo "KEXEC_OBJS $(KEXEC_OBJS)"
diff --git a/kexec/arch/i386/Makefile b/kexec/arch/i386/Makefile
index d77b064..7bda300 100644
--- a/kexec/arch/i386/Makefile
+++ b/kexec/arch/i386/Makefile
@@ -1,12 +1,12 @@
 #
 # kexec i386 (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-x86.c 
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-elf-x86.c 
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-elf-rel-x86.c
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-bzImage.c 
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-multiboot-x86.c
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-beoboot-x86.c
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-nbi.c
-KEXEC_C_SRCS+= kexec/arch/i386/x86-linux-setup.c
-KEXEC_C_SRCS+= kexec/arch/i386/crashdump-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-elf-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-elf-rel-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
+KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
+KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
+KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
diff --git a/kexec/arch/ia64/Makefile b/kexec/arch/ia64/Makefile
index a8a94fe..ea0bdb0 100644
--- a/kexec/arch/ia64/Makefile
+++ b/kexec/arch/ia64/Makefile
@@ -1,9 +1,9 @@
 #
 # kexec ia64 (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/ia64/kexec-iomem.c
-KEXEC_C_SRCS+= kexec/arch/ia64/kexec-ia64.c 
-KEXEC_C_SRCS+= kexec/arch/ia64/kexec-elf-ia64.c 
-KEXEC_C_SRCS+= kexec/arch/ia64/kexec-elf-rel-ia64.c
-KEXEC_C_SRCS+= kexec/arch/ia64/crashdump-ia64.c
+KEXEC_SRCS += kexec/arch/ia64/kexec-iomem.c
+KEXEC_SRCS += kexec/arch/ia64/kexec-ia64.c
+KEXEC_SRCS += kexec/arch/ia64/kexec-elf-ia64.c
+KEXEC_SRCS += kexec/arch/ia64/kexec-elf-rel-ia64.c
+KEXEC_SRCS += kexec/arch/ia64/crashdump-ia64.c
 
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 972a2f2..52295ae 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -1,9 +1,9 @@
 #
 # kexec ppc (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/ppc/kexec-ppc.c 
-KEXEC_C_SRCS+= kexec/arch/ppc/kexec-elf-ppc.c 
-KEXEC_C_SRCS+= kexec/arch/ppc/kexec-elf-rel-ppc.c
-KEXEC_C_SRCS+= kexec/arch/ppc/kexec-dol-ppc.c
-KEXEC_S_SRCS+= kexec/arch/ppc/ppc-setup-simple.S
-KEXEC_S_SRCS+= kexec/arch/ppc/ppc-setup-dol.S
+KEXEC_SRCS += kexec/arch/ppc/kexec-ppc.c
+KEXEC_SRCS += kexec/arch/ppc/kexec-elf-ppc.c
+KEXEC_SRCS += kexec/arch/ppc/kexec-elf-rel-ppc.c
+KEXEC_SRCS += kexec/arch/ppc/kexec-dol-ppc.c
+KEXEC_SRCS += kexec/arch/ppc/ppc-setup-simple.S
+KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
diff --git a/kexec/arch/ppc64/Makefile b/kexec/arch/ppc64/Makefile
index 187a303..b3de3a6 100644
--- a/kexec/arch/ppc64/Makefile
+++ b/kexec/arch/ppc64/Makefile
@@ -1,11 +1,9 @@
 #
 # kexec ppc64 (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/ppc64/kexec-elf-rel-ppc64.c
-KEXEC_C_SRCS+= kexec/arch/ppc64/kexec-zImage-ppc64.c
-KEXEC_C_SRCS+= kexec/arch/ppc64/fs2dt.c
-KEXEC_C_SRCS+= kexec/arch/ppc64/kexec-elf-ppc64.c
-KEXEC_C_SRCS+= kexec/arch/ppc64/kexec-ppc64.c
-KEXEC_C_SRCS+= kexec/arch/ppc64/crashdump-ppc64.c
-
-KEXEC_S_SRCS+=
+KEXEC_SRCS += kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+KEXEC_SRCS += kexec/arch/ppc64/kexec-zImage-ppc64.c
+KEXEC_SRCS += kexec/arch/ppc64/fs2dt.c
+KEXEC_SRCS += kexec/arch/ppc64/kexec-elf-ppc64.c
+KEXEC_SRCS += kexec/arch/ppc64/kexec-ppc64.c
+KEXEC_SRCS += kexec/arch/ppc64/crashdump-ppc64.c
diff --git a/kexec/arch/s390/Makefile b/kexec/arch/s390/Makefile
index 1d26e81..2e496b0 100644
--- a/kexec/arch/s390/Makefile
+++ b/kexec/arch/s390/Makefile
@@ -1,6 +1,6 @@
 #
 # kexec s390 (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/s390/kexec-s390.c
-KEXEC_C_SRCS+= kexec/arch/s390/kexec-image.c
-KEXEC_C_SRCS+= kexec/arch/s390/kexec-elf-rel-s390.c
+KEXEC_SRCS += kexec/arch/s390/kexec-s390.c
+KEXEC_SRCS += kexec/arch/s390/kexec-image.c
+KEXEC_SRCS += kexec/arch/s390/kexec-elf-rel-s390.c
diff --git a/kexec/arch/sh/Makefile b/kexec/arch/sh/Makefile
index 753e073..4d49490 100644
--- a/kexec/arch/sh/Makefile
+++ b/kexec/arch/sh/Makefile
@@ -1,8 +1,8 @@
 #
 # kexec sh (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/sh/kexec-sh.c
-KEXEC_C_SRCS+= kexec/arch/sh/kexec-zImage-sh.c
-KEXEC_C_SRCS+= kexec/arch/sh/kexec-netbsd-sh.c
-KEXEC_C_SRCS+= kexec/arch/sh/kexec-elf-rel-sh.c
-KEXEC_S_SRCS+= kexec/arch/sh/netbsd_booter.S
+KEXEC_SRCS += kexec/arch/sh/kexec-sh.c
+KEXEC_SRCS += kexec/arch/sh/kexec-zImage-sh.c
+KEXEC_SRCS += kexec/arch/sh/kexec-netbsd-sh.c
+KEXEC_SRCS += kexec/arch/sh/kexec-elf-rel-sh.c
+KEXEC_SRCS += kexec/arch/sh/netbsd_booter.S
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index 799e2a4..c3a4d4e 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -1,13 +1,13 @@
 #
 # kexec x86_64 (linux booting linux)
 #
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-elf-x86.c 
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-bzImage.c 
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-multiboot-x86.c
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-beoboot-x86.c
-KEXEC_C_SRCS+= kexec/arch/i386/kexec-nbi.c
-KEXEC_C_SRCS+= kexec/arch/i386/x86-linux-setup.c
-KEXEC_C_SRCS+= kexec/arch/x86_64/crashdump-x86_64.c
-KEXEC_C_SRCS+= kexec/arch/x86_64/kexec-x86_64.c 
-KEXEC_C_SRCS+= kexec/arch/x86_64/kexec-elf-x86_64.c 
-KEXEC_C_SRCS+= kexec/arch/x86_64/kexec-elf-rel-x86_64.c
+KEXEC_SRCS += kexec/arch/i386/kexec-elf-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
+KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
+KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
+KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
+KEXEC_SRCS += kexec/arch/x86_64/crashdump-x86_64.c
+KEXEC_SRCS += kexec/arch/x86_64/kexec-x86_64.c
+KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-x86_64.c
+KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
diff --git a/kexec_test/Makefile b/kexec_test/Makefile
index 70542de..3f0d0fe 100644
--- a/kexec_test/Makefile
+++ b/kexec_test/Makefile
@@ -2,29 +2,24 @@
 # kexec_test Debugging payload to be certain the infrastructure works
 #
 RELOC:=0x10000
-KEXEC_TEST_S_SRCS:= kexec_test/kexec_test16.S kexec_test/kexec_test.S
-KEXEC_TEST_S_TEMPS:=$(patsubst %.S, $(OBJDIR)/%.s, $(KEXEC_TEST_S_SRCS))
-KEXEC_TEST_S_OBJS:=$(patsubst $(OBJDIR)/%.s, $(OBJDIR)/%.o, $(KEXEC_TEST_S_TEMPS))
-KEXEC_TEST_S_DEPS:=$(patsubst %.S, $(OBJDIR)/%.d, $(KEXEC_TEST_S_SRCS))
-KEXEC_TEST_SRCS:= $(KEXEC_TEST_S_SRCS)
-KEXEC_TEST_OBJS:= $(KEXEC_TEST_S_OBJS)
-KEXEC_TEST_DEPS:= $(KEXEC_TEST_S_DEPS)
-KEXEC_TEST:=$(PKGLIBDIR)/kexec_test
+KEXEC_TEST_SRCS:= kexec_test/kexec_test16.S kexec_test/kexec_test.S
 
-include $(KEXEC_TEST_DEPS)
+KEXEC_TEST_OBJS = $(call objify, $(KEXEC_TEST_SRCS))
+KEXEC_TEST_DEPS = $(call depify, $(KEXEC_TEST_OBJS))
 
-$(KEXEC_TEST_S_DEPS): $(OBJDIR)/%.d: %.S
-	mkdir -p $(@D)
-	$(CC) -m32 $(CFLAGS) $(EXTRA_CFLAGS) -M $< | sed -e 's|$(patsubst %.d,%.o,$(@F))|$(patsubst %.d,%.o,$(@))|' > $@
+KEXEC_TEST = $(PKGLIBDIR)/kexec_test
 
-$(KEXEC_TEST_S_TEMPS): $(OBJDIR)/%.s: %.S 
-	mkdir -p $(@D)
-	$(CPP) $(CPPFLAGS) $(EXTRA_CPPFLAGS) -DRELOC=$(RELOC) $< > $@
+clean += $(KEXEC_TEST_OBJS) $(KEXEC_TEST_DEPS) $(KEXEC_TEST)
 
-$(KEXEC_TEST_S_OBJS): $(OBJDIR)/%.o: $(OBJDIR)/%.s 
-	mkdir -p $(@D)
-	$(AS) --32 -o $@ $<
+-include $(KEXEC_TEST_DEPS)
+
+$(KEXEC_TEST): CPPFLAGS+=-DRELOC=$(RELOC)
+$(KEXEC_TEST): ASFLAGS+=-m32
+#$(KEXEC_TEST): LDFLAGS=-m32 -Wl,-e -Wl,_start -Wl,-Ttext -Wl,$(RELOC) \
+#		       -nostartfiles
+$(KEXEC_TEST): LDFLAGS=-melf_i386 -e _start -Ttext $(RELOC)
 
-$(KEXEC_TEST): $(KEXEC_TEST_OBJS) 
+$(KEXEC_TEST): $(KEXEC_TEST_OBJS)
 	mkdir -p $(@D)
-	$(LD) -m elf_i386 -e _start -Ttext $(RELOC) $(KEXEC_TEST_OBJS) -o $@
+	#$(LINK.o) -o $@ $^
+	$(LD) $(LDFLAGS) -o $@ $^
diff --git a/purgatory/Makefile b/purgatory/Makefile
index adbd814..a543cdb 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -7,67 +7,46 @@
 # should keep us from accidentially include unsafe library functions
 # or headers.
 
-ifeq ($(ARCH),ppc64)
-EXTRA_LDFLAGS = -melf64ppc
-endif
+PURGATORY = purgatory/purgatory.ro
+PURGATORY_SRCS =
+PURGATORY_SRCS += purgatory/purgatory.c
+PURGATORY_SRCS += purgatory/printf.c
+PURGATORY_SRCS += purgatory/string.c
 
-PCFLAGS:=-Wall -Os  \
-	-I$(shell $(CC) -print-file-name=include) \
-	-Ipurgatory/include -Ipurgatory/arch/$(ARCH)/include \
-	$(CPPFLAGS) $(EXTRA_CPPFLAGS)
+include $(srcdir)/purgatory/arch/$(ARCH)/Makefile
 
-PCFLAGS += $(call cc-option, -ffreestanding)
-PCFLAGS += $(call cc-option, -fnobuiltin)
-PCFLAGS += $(call cc-option, -fnostdinc)
-PCFLAGS += $(call cc-option, -fno-zero-initialized-in-bss)
+PURGATORY_OBJS = $(call objify, $(PURGATORY_SRCS)) purgatory/sha256.o
+PURGATORY_DEPS = $(call depify, $(PURGATORY_OBJS))
 
-PURGATORY_C_SRCS:=
-PURGATORY_C_SRCS += purgatory/purgatory.c
-PURGATORY_C_SRCS += purgatory/printf.c
-PURGATORY_C_SRCS += purgatory/string.c
-PURGATORY_S_OBJS:=
+clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY)
 
-include purgatory/arch/$(ARCH)/Makefile
+-include $(PURGATORY_DEPS)
 
+# sha256.c needs to be compiled without optimization, else
+# purgatory fails to execute on ia64.
+purgatory/sha256.o: CFLAGS += -O0
 
-PURGATORY_C_OBJS:= $(patsubst %.c, $(OBJDIR)/%.o, $(PURGATORY_C_SRCS))
-PURGATORY_C_DEPS:= $(patsubst %.c, $(OBJDIR)/%.d, $(PURGATORY_C_SRCS))
-PURGATORY_S_OBJS:= $(patsubst %.S, $(OBJDIR)/%.o, $(PURGATORY_S_SRCS))
-PURGATORY_S_DEPS:= $(patsubst %.S, $(OBJDIR)/%.d, $(PURGATORY_S_SRCS))
-PURGATORY_SRCS:= $(PURGATORY_S_SRCS) $(PURGATORY_C_SRCS)
-PURGATORY_OBJS:= $(PURGATORY_S_OBJS) $(PURGATORY_C_OBJS)
-PURGATORY_DEPS:= $(PURGATORY_S_DEPS) $(PURGATORY_C_DEPS)
-PURGATORY:= $(OBJDIR)/purgatory/purgatory.ro
+purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
+	mkdir -p $(@D)
+	$(COMPILE.c) -o $@ $^
 
-include $(PURGATORY_DEPS)
+$(PURGATORY): CC=$(TARGET_CC)
+$(PURGATORY): CFLAGS+=-Os -fno-builtin -ffreestanding \
+		      -fno-zero-initialized-in-bss
 
-$(PURGATORY_C_DEPS): $(OBJDIR)/%.d: %.c
-	$(MKDIR) -p $(@D)
-	$(CC) $(PCFLAGS) -M $< | sed -e 's|$(patsubst %.d,%.o,$(@F))|$(patsubst %.d,%.o,$(@))|' > $@
-
-$(PURGATORY_S_DEPS): $(OBJDIR)/%.d: %.S
-	$(MKDIR) -p $(@D)
-	$(CC) $(PCFLAGS) -M $< | sed -e 's|$(patsubst %.d,%.o,$(@F))|$(patsubst %.d,%.o,$(@))|' > $@
+$(PURGATORY): CPPFLAGS+=-I$(srcdir)/purgatory/include \
+			-I$(srcdir)/purgatory/arch/$(ARCH)/include \
+			-I$(shell $(CC) -print-file-name=include)
+$(PURGATORY): LDFLAGS+=--no-undefined -nostartfiles -nostdlib -nodefaultlibs \
+			-e purgatory_start -r
 
-$(PURGATORY_C_OBJS): $(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
+$(PURGATORY): $(PURGATORY_OBJS)
 	$(MKDIR) -p $(@D)
-	$(CC) $(PCFLAGS) -o $@ -c $<
+	$(LD) $(LDFLAGS) -o $@ $^
 
-$(PURGATORY_S_OBJS): $(OBJDIR)/%.o: %.S $(OBJDIR)/%.d
-	$(MKDIR) -p $(@D)
-	$(CC) $(PCFLAGS) -o $@ -c $<
-
-$(PURGATORY): $(PURGATORY_OBJS) $(UTIL_LIB)
-	$(MKDIR) -p $(@D)
-	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
+#	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
 
 echo::
-	@echo "PURGATORY_C_SRCS $(PURGATORY_C_SRCS)"
-	@echo "PURGATORY_C_DEPS $(PURGATORY_C_DEPS)"
-	@echo "PURGATORY_C_OBJS $(PURGATORY_C_OBJS)"
-	@echo "PURGATORY_S_SRCS $(PURGATORY_S_SRCS)"
-	@echo "PURGATORY_S_DEPS $(PURGATORY_S_DEPS)"
-	@echo "PURGATORY_S_OBJS $(PURGATORY_S_OBJS)"
-	@echo "PURGATORY_SRCS   $(PURGATORY_SRCS)"
-	@echo "PURGATORY_DEPS   $(PURGATORY_DEPS)"
-	@echo "PURGATORY_OBJS   $(PURGATORY_OBJS)"
+	@echo "PURGATORY_SRCS $(PURGATORY_SRCS)"
+	@echo "PURGATORY_DEPS $(PURGATORY_DEPS)"
+	@echo "PURGATORY_OBJS $(PURGATORY_OBJS)"
diff --git a/purgatory/arch/alpha/Makefile b/purgatory/arch/alpha/Makefile
index a626bbd..02f62b2 100644
--- a/purgatory/arch/alpha/Makefile
+++ b/purgatory/arch/alpha/Makefile
@@ -2,6 +2,5 @@
 # Purgatory alpha
 #
 
-PURGATORY_C_SRCS+=
-PURGATORY_S_SRCS+=
+PURGATORY_SRCS +=
 
diff --git a/purgatory/arch/i386/Makefile b/purgatory/arch/i386/Makefile
index 97478f4..55cc7af 100644
--- a/purgatory/arch/i386/Makefile
+++ b/purgatory/arch/i386/Makefile
@@ -2,14 +2,14 @@
 # Purgatory i386
 #
 
-PURGATORY_S_SRCS+= purgatory/arch/i386/entry32-16.S
-PURGATORY_S_SRCS+= purgatory/arch/i386/entry32-16-debug.S
-PURGATORY_S_SRCS+= purgatory/arch/i386/entry32.S
-PURGATORY_S_SRCS+= purgatory/arch/i386/setup-x86.S
-PURGATORY_S_SRCS+= purgatory/arch/i386/stack.S
-PURGATORY_S_SRCS+= purgatory/arch/i386/compat_x86_64.S
-PURGATORY_C_SRCS+= purgatory/arch/i386/purgatory-x86.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/console-x86.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/vga.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/pic.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/crashdump_backup.c
+PURGATORY_SRCS += purgatory/arch/i386/entry32-16.S
+PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
+PURGATORY_SRCS += purgatory/arch/i386/entry32.S
+PURGATORY_SRCS += purgatory/arch/i386/setup-x86.S
+PURGATORY_SRCS += purgatory/arch/i386/stack.S
+PURGATORY_SRCS += purgatory/arch/i386/compat_x86_64.S
+PURGATORY_SRCS += purgatory/arch/i386/purgatory-x86.c
+PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
+PURGATORY_SRCS += purgatory/arch/i386/vga.c
+PURGATORY_SRCS += purgatory/arch/i386/pic.c
+PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
diff --git a/purgatory/arch/ia64/Makefile b/purgatory/arch/ia64/Makefile
index 953b3ee..9dda91d 100644
--- a/purgatory/arch/ia64/Makefile
+++ b/purgatory/arch/ia64/Makefile
@@ -1,9 +1,10 @@
 #
 # Purgatory ia64
 #
-PCFLAGS		+= -ffixed-r28
-PURGATORY_S_SRCS+= purgatory/arch/ia64/entry.S
-PURGATORY_C_SRCS+= purgatory/arch/ia64/purgatory-ia64.c
-PURGATORY_C_SRCS+= purgatory/arch/ia64/console-ia64.c
-PURGATORY_C_SRCS+= purgatory/arch/ia64/vga.c
+PURGATORY_SRCS += purgatory/arch/ia64/entry.S
+PURGATORY_SRCS += purgatory/arch/ia64/purgatory-ia64.c
+PURGATORY_SRCS += purgatory/arch/ia64/console-ia64.c
+PURGATORY_SRCS += purgatory/arch/ia64/vga.c
+
+$(PURGATORY): CFLAGS += -ffixed-r28
 
diff --git a/purgatory/arch/ppc/Makefile b/purgatory/arch/ppc/Makefile
index 4ce40fe..c40b4b5 100644
--- a/purgatory/arch/ppc/Makefile
+++ b/purgatory/arch/ppc/Makefile
@@ -2,7 +2,7 @@
 # Purgatory ppc
 #
 
-PURGATORY_S_SRCS+= purgatory/arch/ppc/misc.S
-PURGATORY_C_SRCS+= purgatory/arch/ppc/purgatory-ppc.c
-PURGATORY_C_SRCS+= purgatory/arch/ppc/console-ppc.c
+PURGATORY_SRCS += purgatory/arch/ppc/misc.S
+PURGATORY_SRCS += purgatory/arch/ppc/purgatory-ppc.c
+PURGATORY_SRCS += purgatory/arch/ppc/console-ppc.c
 
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 0406278..a62484e 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -2,9 +2,11 @@
 # Purgatory ppc
 #
 
-PURGATORY_S_SRCS+= purgatory/arch/ppc64/v2wrap.S
-PURGATORY_C_SRCS += purgatory/arch/ppc64/purgatory-ppc64.c
-PURGATORY_C_SRCS += purgatory/arch/ppc64/console-ppc64.c
-PURGATORY_C_SRCS += purgatory/arch/ppc64/crashdump_backup.c
+PURGATORY_SRCS += purgatory/arch/ppc64/v2wrap.S
+PURGATORY_SRCS += purgatory/arch/ppc64/purgatory-ppc64.c
+PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
+PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
 
-PCFLAGS += -m64 -mcall-aixdesc
+$(PURGATORY): CFLAGS += -m64 -mcall-aixdesc
+$(PURGATORY): ASFLAGS += -m64 -mcall-aixdesc
+$(PURGATORY): LDFLAGS += -melf64ppc
diff --git a/purgatory/arch/s390/Makefile b/purgatory/arch/s390/Makefile
index 63dac9d..9c795d1 100644
--- a/purgatory/arch/s390/Makefile
+++ b/purgatory/arch/s390/Makefile
@@ -2,6 +2,6 @@
 # Purgatory s390
 #
 
-PURGATORY_C_SRCS+=
-PURGATORY_S_SRCS+=
+PURGATORY_SRCS +=
+PURGATORY_SRCS +=
 
diff --git a/purgatory/arch/sh/Makefile b/purgatory/arch/sh/Makefile
index a626bbd..537d260 100644
--- a/purgatory/arch/sh/Makefile
+++ b/purgatory/arch/sh/Makefile
@@ -2,6 +2,6 @@
 # Purgatory alpha
 #
 
-PURGATORY_C_SRCS+=
-PURGATORY_S_SRCS+=
+PURGATORY_SRCS +=
+PURGATORY_SRCS +=
 
diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index 29f4340..e8fe96c 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -2,15 +2,14 @@
 # Purgatory x86_64
 #
 
-PURGATORY_S_SRCS+= purgatory/arch/i386/entry32-16.S
-PURGATORY_S_SRCS+= purgatory/arch/i386/entry32-16-debug.S
-PURGATORY_S_SRCS+= purgatory/arch/x86_64/entry64-32.S
-PURGATORY_S_SRCS+= purgatory/arch/x86_64/entry64.S
-PURGATORY_S_SRCS+= purgatory/arch/x86_64/setup-x86_64.S
-PURGATORY_S_SRCS+= purgatory/arch/x86_64/stack.S
-PURGATORY_C_SRCS+= purgatory/arch/x86_64/purgatory-x86_64.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/crashdump_backup.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/console-x86.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/vga.c
-PURGATORY_C_SRCS+= purgatory/arch/i386/pic.c
-
+PURGATORY_SRCS += purgatory/arch/i386/entry32-16.S
+PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
+PURGATORY_SRCS += purgatory/arch/x86_64/entry64-32.S
+PURGATORY_SRCS += purgatory/arch/x86_64/entry64.S
+PURGATORY_SRCS += purgatory/arch/x86_64/setup-x86_64.S
+PURGATORY_SRCS += purgatory/arch/x86_64/stack.S
+PURGATORY_SRCS += purgatory/arch/x86_64/purgatory-x86_64.c
+PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
+PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
+PURGATORY_SRCS += purgatory/arch/i386/vga.c
+PURGATORY_SRCS += purgatory/arch/i386/pic.c
diff --git a/purgatory/include/string.h b/purgatory/include/string.h
index 87cc4e1..14e172d 100644
--- a/purgatory/include/string.h
+++ b/purgatory/include/string.h
@@ -1,6 +1,8 @@
 #ifndef STRING_H
 #define STRING_H
 
+#include <stddef.h>
+
 size_t strnlen(const char *s, size_t max);
 void* memset(void* s, int c, size_t n);
 void* memcpy(void *dest, const void *src, size_t len);
diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
index aacbb3b..3889cf5 100644
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -1,4 +1,4 @@
-#include <stdarg.h>
+
 #include <limits.h>
 #include <stdint.h>
 #include <purgatory.h>
@@ -46,5 +46,3 @@ void purgatory(void)
 	verify_sha256_digest();
 	post_verification_setup_arch();
 }
-
-#include "../util_lib/sha256.c"
diff --git a/util/Makefile b/util/Makefile
index d6e8e79..6fee925 100644
--- a/util/Makefile
+++ b/util/Makefile
@@ -1,4 +1,10 @@
-BIN_TO_HEX:= $(OBJDIR)/bin/bin-to-hex
-$(BIN_TO_HEX): util/bin-to-hex.c
-	mkdir -p $(@D)
-	$(BUILD_CC) $(BUILD_CFLAGS) $< -o $@
+BIN_TO_HEX:= bin/bin-to-hex
+
+$(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
+	@$(MKDIR) -p $(@D)
+	$(LINK.o) -o $@ $^
+
+$(BIN_TO_HEX): CC=$(BUILD_CC)
+$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
+
+clean += util/bin-to-hex.o $(BIN_TO_HEX)
diff --git a/util_lib/Makefile b/util_lib/Makefile
index 75cde25..5b4bd22 100644
--- a/util_lib/Makefile
+++ b/util_lib/Makefile
@@ -1,28 +1,20 @@
 #
 # Utility function library
 #
-UTIL_LIB_SRCS:=util_lib/compute_ip_checksum.c
-UTIL_LIB_SRCS+=util_lib/sha256.c
-UTIL_LIB_OBJS:=$(patsubst %.c, $(OBJDIR)/%.o, $(UTIL_LIB_SRCS))
-UTIL_LIB_DEPS:=$(patsubst %.c, $(OBJDIR)/%.d, $(UTIL_LIB_SRCS))
-UTIL_LIB:=$(OBJDIR)/libutil.a
+UTIL_LIB_SRCS +=
+UTIL_LIB_SRCS += util_lib/compute_ip_checksum.c
+UTIL_LIB_SRCS += util_lib/sha256.c
+UTIL_LIB_OBJS =$(call objify, $(UTIL_LIB_SRCS))
+UTIL_LIB_DEPS =$(call depify, $(UTIL_LIB_OBJS))
+UTIL_LIB = libutil.a
 
-include $(UTIL_LIB_DEPS)
+-include $(UTIL_LIB_DEPS)
 
-$(UTIL_LIB_DEPS): $(OBJDIR)/%.d: %.c 
-	$(MKDIR) -p $(@D)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -M $< | sed -e 's|$(patsubst %.d,%.o,$(@F))|$(patsubst %.d,%.o,$(@))|' > $@
+clean += $(UTIL_LIB_OBJS) $(UTIL_LIB_DEPS) $(UTIL_LIB)
 
-# sha256.c needs to be compiled without optimization, else
-# purgatory fails to execute (on ia64 at least).
-# By placing -O0 after $(CFLAGS), which is provided by
-# the prevailing environment, it overrides any other -O flags
-# provided.
-$(UTIL_LIB_OBJS): $(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
-	$(MKDIR) -p $(@D)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -O0 -c -o $@ $<
+$(UTIL_LIB): CPPFLAGS += -I$(srcdir)/util_lib/include
 
 $(UTIL_LIB): $(UTIL_LIB_OBJS)
-	$(MKDIR) -p $(@D)
+	@$(MKDIR) -p $(@D)
 	$(AR) rs $(UTIL_LIB) $(UTIL_LIB_OBJS)
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
