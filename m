Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH0G-00Ck5r-5Z
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:26:21 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 5/7] build: simplify uninstall target
Date: Fri,  2 Apr 2021 12:17:35 +0200
Message-Id: <20210402101737.1886-6-horms@verge.net.au>
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

This appears to have been copied from some generated code.
Simplify it by rolling repetitive operations into a for loop.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in | 81 +++++++++++------------------------------------------
 1 file changed, 17 insertions(+), 64 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 94e9fd8..1569b42 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -106,6 +106,14 @@ PKGDATADIR=$(DATADIR)/$(PACKAGE_NAME)
 PKGLIBDIR=$(LIBDIR)/$(PACKAGE_NAME)
 PKGINCLUDEIR=$(INCLUDEDIR)/$(PACKAGE_NAME)
 
+ALLOWED_UNINSTALL_DIRS := \
+	$(SBINDIR) \
+	$(sbindir) $(bindir) $(libexecdir) $(datadir) $(sysconfdir) \
+	$(sharedstatedir) $(localstatedir) $(libdir) $(infodir) \
+	$(mandir)/man1 $(mandir)/man2 $(mandir)/man3 $(mandir)/man4 \
+	$(mandir)/man5 $(mandir)/man6 $(mandir)/man7 $(mandir)/man8 \
+	$(includedir) $(pkgdatadir) $(pkglibdir) $(pkgincludedir)
+
 all: targets
 
 # generic build rules
@@ -336,70 +344,15 @@ install: $(TARGETS)
 	done
 
 uninstall:
-	UINSTALL_LIST='$(UNINSTALL_TARGETS)'; for file in $$UINSTALL_LIST ; do \
-		if test `$(DIRNAME) $$file` =     "$(sbindir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(bindir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(libexecdir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(datadir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(sysconfdir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(sharedstatedir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(localstatedir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(libdir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(infodir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man1" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man2" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man3" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man4" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man5" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man6" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man7" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(mandir)/man8" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(includedir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(pkgdatadir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(pkglibdir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
-		if test `$(DIRNAME) $$file` =     "$(pkgincludedir)" ; then \
-			rm -rf $(DESTDIR)/$$file ; \
-		fi; \
+	UINSTALL_LIST='$(UNINSTALL_TARGETS)'; \
+	for file in $$UINSTALL_LIST ; do \
+		DIRS='$(ALLOWED_UNINSTALL_DIRS)'; \
+		for dir in $$DIRS ; do \
+			if test `$(DIRNAME) $$file` = "$$dir" ; then \
+				rm -rf $(DESTDIR)/$$file ; \
+				break ; \
+			fi; \
+		done; \
 	done
 
 .PHONY: echo install uninstall all targets uninstall-targets clean dist-clean distclean \
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
