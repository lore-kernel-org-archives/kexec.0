Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsLwS-00071V-2D
	for kexec@lists.infradead.org; Thu, 18 Mar 2010 20:03:46 +0000
Received: by mail-bw0-f215.google.com with SMTP id 7so1840936bwz.4
	for <kexec@lists.infradead.org>; Thu, 18 Mar 2010 13:03:39 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH 6/6] kexec-tools: Use default rpmbuild definations
Date: Thu, 18 Mar 2010 22:03:24 +0200
Message-Id: <fd9d828f07e6cb070f73872d4427c865e52c5127.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Since current mechanism for building rpm into custom directory is not working,
remove it and switch to system defaults for rpmbuild.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 Makefile.in |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 256f4de..cc4f8d3 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -200,19 +200,9 @@ $(TARBALL): $(SRCS) $(GENERATED_SRCS)
 $(TARBALL.gz): $(TARBALL)
 	gzip -c < $^ > $@
 
-RPMDIR=rpm
 rpm: $(TARBALL.gz)
-	$(MKDIR) -p $(RPMDIR)/RPM $(RPMDIR)/SRPM $(RPMDIR)/BUILD \
-		$(RPMDIR)/SPECS $(RPMDIR)/TMP $(RPMDIR)/SOURCES
-	unset MAKEFLAGS MAKELEVEL; \
-	$(RPMBUILD) -ta \
-		--define '_rpmdir $(RPMDIR)/RPM' \
-		--define '_srcrpmdir $(RPMDIR)/SRPM' \
-		--define '_builddir $(RPMDIR)/BUILD' \
-		--define '_specdir $(RPMDIR)/SPECS' \
-		--define '_tmppath $(RPMDIR)/TMP' \
-		--define '_sourcedir $(RPMDIR)/SOURCES' \
-		$(TARBALL.gz)
+	unset MAKEFLAGS MAKELEVEL;
+	$(RPMBUILD) -ta $(TARBALL.gz)
 
 $(SPEC): kexec-tools.spec.in Makefile
 	$(SED) -e 's,^Version: $$,Version: $(PACKAGE_VERSION),' $< > $@
@@ -227,7 +217,7 @@ echo::
 
 clean:
 	$(RM) -f $(clean)
-	$(RM) -rf rpm build
+	$(RM) -rf build
 	$(RM) -f $(TARBALL) $(TARBALL.gz)
 
 distclean: dist-clean
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
