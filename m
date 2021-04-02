Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH18-00Ck8h-Dz
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:27:11 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 4/7] build: use DESTDIR in uninstall target
Date: Fri,  2 Apr 2021 12:17:34 +0200
Message-Id: <20210402101737.1886-5-horms@verge.net.au>
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

For symmetry with the install target, also use DESTDIR in the uninstall
target.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 4fe1016..94e9fd8 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -338,67 +338,67 @@ install: $(TARGETS)
 uninstall:
 	UINSTALL_LIST='$(UNINSTALL_TARGETS)'; for file in $$UINSTALL_LIST ; do \
 		if test `$(DIRNAME) $$file` =     "$(sbindir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(bindir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(libexecdir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(datadir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(sysconfdir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(sharedstatedir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(localstatedir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(libdir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(infodir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man1" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man2" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man3" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man4" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man5" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man6" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man7" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(mandir)/man8" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(includedir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(pkgdatadir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(pkglibdir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 		if test `$(DIRNAME) $$file` =     "$(pkgincludedir)" ; then \
-			rm -rf $$file ; \
+			rm -rf $(DESTDIR)/$$file ; \
 		fi; \
 	done
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
