Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fLl7v-0002sR-6s
 for kexec@lists.infradead.org; Thu, 24 May 2018 07:57:37 +0000
Received: by mail-pg0-f65.google.com with SMTP id l2-v6so411434pgc.7
 for <kexec@lists.infradead.org>; Thu, 24 May 2018 00:57:24 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2] Makefile.in: Add uninstall rule
Date: Thu, 24 May 2018 13:27:07 +0530
Message-Id: <1527148627-11641-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, vgoyal@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, bhupesh.linux@gmail.com, Dave Young <dyoung@redhat.com>, Russell King <rmk@arm.linux.org.uk>

Presently the Makedumpfile.in doesn't include a uninstall rule, which is
useful in case we want to preform a reverse of the install process
done by Makefile.in

This patch adds this rule, thus making it easier to remove installed
executables and man pages in case one needs to uninstall the same.

Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Changes since v1:
 - As per Dave's suggestion, seperated the two patches included in the
   patchset in v1 as individual patches in v2.
 - Another patch sent by me now obsoletes the kdump tool and the 'make
   uninstall' rule can come in handy (especially on arm systems with
   low memory footprints) to remove already installed version of kdump
   tool and related man-pages.
   (the patch can be viewed here - http://lists.infradead.org/pipermail/kexec/2018-May/020754.html)
 - v1 can be viewed here: http://lists.infradead.org/pipermail/kexec/2018-April/020527.html

 Makefile.in | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 18e164595e3f..fb01134d9880 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -177,10 +177,21 @@ BINARIES_i386:=$(KEXEC_TEST)
 BINARIES_x86_64:=$(KEXEC_TEST)
 BINARIES:=$(KEXEC) $(VMCORE_DMESG) $(BINARIES_$(ARCH))
 
-TARGETS:=$(BINARIES) $(MAN_PAGES)
+UNINSTALL_KDUMP = $(sbindir)/kdump
+UNINSTALL_KDUMP_MANPAGE = $(mandir)/man8/kdump.8
+UNINSTALL_KEXEC = $(sbindir)/kexec
+UNINSTALL_KEXEC_MANPAGE = $(mandir)/man8/kexec.8
+UNINSTALL_VMCORE_DMESG = $(sbindir)/vmcore-dmesg
+UNINSTALL_VMCORE_DMESG_MANPAGE = $(mandir)/man8/vmcore-dmesg.8
 
+TARGETS:=$(BINARIES) $(MAN_PAGES)
 targets: $(TARGETS)
 
+UNINSTALL_TARGETS:=$(UNINSTALL_KDUMP) $(UNINSTALL_KDUMP_MANPAGE) \
+		   $(UNINSTALL_KEXEC) $(UNINSTALL_KEXEC_MANPAGE) \
+		   $(UNINSTALL_VMCORE_DMESG) $(UNINSTALL_VMCORE_DMESG_MANPAGE)
+uninstall-targets: $(UNINSTALL_TARGETS)
+
 Makefile: Makefile.in config.status
 	./config.status
 
@@ -213,6 +224,7 @@ echo::
 	@echo ARCH=$(ARCH)
 	@echo BINARIES=$(BINARIES)
 	@echo TARGETS=$(TARGETS)
+	@echo UNINSTALL_TARGETS=$(UNINSTALL_TARGETS)
 	@echo CC=$(CC)
 	@echo AR=$(AR)
 	@echo LD=$(LD)
@@ -318,5 +330,72 @@ install: $(TARGETS)
 		fi; \
 	done
 
-.PHONY: echo install all targets clean dist-clean distclean \
+uninstall:
+	UINSTALL_LIST='$(UNINSTALL_TARGETS)'; for file in $$UINSTALL_LIST ; do \
+		if test `$(DIRNAME) $$file` =     "$(sbindir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(bindir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(libexecdir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(datadir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(sysconfdir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(sharedstatedir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(localstatedir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(libdir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(infodir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man1" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man2" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man3" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man4" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man5" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man6" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man7" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(mandir)/man8" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(includedir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(pkgdatadir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(pkglibdir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+		if test `$(DIRNAME) $$file` =     "$(pkgincludedir)" ; then \
+			rm -rf $$file ; \
+		fi; \
+	done
+
+.PHONY: echo install uninstall all targets uninstall-targets clean dist-clean distclean \
 	maintainer-clean maintainerclean tarball rpm
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
