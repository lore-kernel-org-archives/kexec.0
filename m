Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH0u-00Ck8h-Kx
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:26:57 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 1/7] build: create tarball without
 self-referential hard links
Date: Fri,  2 Apr 2021 12:17:31 +0200
Message-Id: <20210402101737.1886-2-horms@verge.net.au>
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

The current method of creating the tarball, which is to the hard-link
the source directory to the target directory, results in self-referential
hardlinks which can be observed using tar xf.

This patch resolves this by using an intermediate tarball, held in memory,
which collects files to be distributed. This is then unpacked in the target
directory which is finally packed into the distribution tarball, a file.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index fb01134..a9c779f 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -201,14 +201,13 @@ configure: configure.ac
 tarball: $(TARBALL.gz)
 
 $(TARBALL): $(SRCS) $(GENERATED_SRCS)
-	$(RM) -f $(PACKAGE_NAME)-$(PACKAGE_VERSION)
-	$(LN) -s $(srcdir) $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(RM) -rf $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(MKDIR) $(PACKAGE_NAME)-$(PACKAGE_VERSION)
+	$(TAR) -c $(SRCS) $(GENERATED_SRCS) | \
+	        $(TAR) -C $(PACKAGE_NAME)-$(PACKAGE_VERSION) -x
 	$(TAR) -cf $@ $(PSRCS)
-	$(RM) -f $(PACKAGE_NAME)-$(PACKAGE_VERSION)
-	$(LN) -sf . $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 	$(TAR) -rf $@ $(PGSRCS)
-	$(RM) -f $(PACKAGE_NAME)-$(PACKAGE_VERSION)
-	@echo $(dist)
+	$(RM) -rf $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 
 $(TARBALL.gz): $(TARBALL)
 	gzip -c < $^ > $@
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
