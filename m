Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsLwM-00071Z-SP
	for kexec@lists.infradead.org; Thu, 18 Mar 2010 20:03:42 +0000
Received: by bwz7 with SMTP id 7so1840966bwz.4
	for <kexec@lists.infradead.org>; Thu, 18 Mar 2010 13:03:34 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH 2/6] kexec-tools: Use same source in rpm spec and Makefile.in
Date: Thu, 18 Mar 2010 22:03:20 +0200
Message-Id: <cdc54cec4aca1a2bf3877fdd6a30232e187908d5.1268942234.git.ameya.palande@nokia.com>
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

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 Makefile.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index cb0faae..3532457 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -202,7 +202,7 @@ $(TARBALL.gz): $(TARBALL)
 	gzip -c < $^ > $@
 
 RPMDIR=rpm
-rpm: $(TARBALL)
+rpm: $(TARBALL.gz)
 	$(MKDIR) -p $(RPMDIR)/RPM $(RPMDIR)/SRPM $(RPMDIR)/BUILD \
 		$(RPMDIR)/SPECS $(RPMDIR)/TMP $(RPMDIR)/SOURCES
 	unset MAKEFLAGS MAKELEVEL; \
@@ -213,7 +213,7 @@ rpm: $(TARBALL)
 		--define '_specdir $(RPMDIR)/SPECS' \
 		--define '_tmppath $(RPMDIR)/TMP' \
 		--define '_sourcedir $(RPMDIR)/SOURCES' \
-		$(TARBALL)
+		$(TARBALL.gz)
 
 $(SPEC): kexec-tools.spec.in Makefile
 	$(SED) -e 's,^Version: $$,Version: $(PACKAGE_VERSION),' $< > $@
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
