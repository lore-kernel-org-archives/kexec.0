Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NjT6I-0002nR-GC
	for kexec@lists.infradead.org; Mon, 22 Feb 2010 07:53:10 +0000
Date: Mon, 22 Feb 2010 18:53:00 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: make install fails to install man pages
Message-ID: <20100222075300.GA20519@verge.net.au>
References: <E1NXIL1-0005tH-Ho@bruson.ifs.umich.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1NXIL1-0005tH-Ho@bruson.ifs.umich.edu>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Marcus Watts <mdw@umich.edu>
Cc: kexec@lists.infradead.org

On Tue, Jan 19, 2010 at 12:57:59PM -0500, Marcus Watts wrote:
> When building kexec-tools 2.0.1, I noticed that "make install"
> failed to install any man pages.  Upon looking, I found that
> what "make install" had tried to do was:
> 
> 	for file in build/sbin/kexec .. kexec/kexec.8 kdump/kdump.8; do
> 	if test `dirname $file` =     "build/sbin" ; then
> 	...
> 	if test `dirname $file` =     "build/man/man8" ; then
> 		mkdir -p     /tmp/kex//usr/share/man/man8/
> 		/usr/bin/install -c -m 644 $file /tmp/kex//usr/share/man/man8/
> 	fi
> 	...
> 	done
> 
> Since the man pages don't start with "build/", they don't
> match the if clause so aren't installed.
> 
> Source in the makefile looks like this:
> 	if test `$(DIRNAME) $$file` =     "$(MAN8DIR)" ; then \
> 
> A test that might better express what you are trying to do:
> 	if test `basename x/foo.8 .8` = foo
> perhaps something like this:
> configure.ac:
> 	AC_CHECK_PROG([BASENAME],  basename,  basename,  "no", [$PATH])
> 	if test "$BASENAME" = "no"; then AC_MSG_ERROR([ basename not found]) fi
> Makefile.in:
> 	if test `$(BASENAME) $$file .8` =     "$$file" ; then \

Hi Marcus,

Sorry for overlooking this, it got lost in my INBOX somehow.

I have taken an slightly different approach to this problem,
which is to ensure that the manpages are in build/. Does this
with the problem you are seeing?

----------------------------------------------------------------------

Install man pages

Ensure that the man pages are built (end up in build/) so that they get
installed.

* Use variables set in kexec/Makefile and kdump/Makefile for the
  correct lotion of the "built" man pages.
* For consistency, use variables set in kexec/Makefile and kdump/Makefile
  for the location of built binaries too
* Use = instead of := for TARGETS and the variables that comprise it
  so that they are re-evaluated after kexec/Makefile and kdump/Makefile
  are sourced
* Move the building of targets to below the inclusion of
  kexec/Makefile and kdump/Makefile. This seems to be necessary
  for $(TARGETS) to be correctly evaluated when used as a source.
* Make sure all remains the first target without moving more rules
  than necessary to below where kexec/Makefile and kdump/Makefile -
  I'm concerned about unexpected consequences.

The kexec-tools build system is a bit special.

Reported-by: Marcus Watts <mdw@umich.edu>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/Makefile.in
===================================================================
--- kexec-tools.orig/Makefile.in	2010-02-22 18:45:47.000000000 +1100
+++ kexec-tools/Makefile.in	2010-02-22 18:45:53.000000000 +1100
@@ -104,15 +104,14 @@ PKGDATADIR=$(DATADIR)/$(PACKAGE_NAME)
 PKGLIBDIR=$(LIBDIR)/$(PACKAGE_NAME)
 PKGINCLUDEIR=$(INCLUDEDIR)/$(PACKAGE_NAME)
 
-MAN_PAGES:= kexec/kexec.8
-MAN_PAGES+= kdump/kdump.8
-BINARIES_i386:=  $(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
-BINARIES_x86_64:=$(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
-BINARIES:=$(SBINDIR)/kexec $(SBINDIR)/kdump $(BINARIES_$(ARCH))
+MAN_PAGES=$(KEXEC_MANPAGE) $(KDUMP_MANPAGE)
+BINARIES_i386=$(KEXEC_TEST)
+BINARIES_x86_64=$(KEXEC_TEST)
+BINARIES=$(KEXEC) $(KDUMP) $(BINARIES_$(ARCH))
 
-TARGETS:=$(BINARIES) $(MAN_PAGES)
+TARGETS=$(BINARIES) $(MAN_PAGES)
 
-all: $(TARGETS)
+all: targets
 
 # generic build rules
 %.o: %.c
@@ -180,6 +179,9 @@ SRCS:= $(dist)
 PSRCS:=$(foreach s, $(SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 PGSRCS:=$(foreach s, $(GENERATED_SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 
+targets: $(TARGETS)
+	@echo TARGETS: $(TARGETS)
+
 Makefile: Makefile.in config.status
 	./config.status
 
@@ -326,5 +328,5 @@ install: $(TARGETS)
 		fi; \
 	done
 
-.PHONY: echo install all clean dist-clean distclean maintainer-clean 	\
-	maintainerclean tarball rpm
+.PHONY: echo install all targets clean dist-clean distclean \
+	maintainer-clean maintainerclean tarball rpm

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
