Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH10-00Ck8h-Ov
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:27:05 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 2/7] build: add dist make target
Date: Fri,  2 Apr 2021 12:17:32 +0200
Message-Id: <20210402101737.1886-3-horms@verge.net.au>
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

This provides a familiar alias for the existing tarball target.
The result is a tar.gz file.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index a9c779f..dc7fb07 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -198,6 +198,8 @@ Makefile: Makefile.in config.status
 configure: configure.ac
 	cd $(srcdir) && autoheader && autoconf && rm -rf autom4te.cache
 
+dist: tarball
+
 tarball: $(TARBALL.gz)
 
 $(TARBALL): $(SRCS) $(GENERATED_SRCS)
@@ -397,4 +399,4 @@ uninstall:
 	done
 
 .PHONY: echo install uninstall all targets uninstall-targets clean dist-clean distclean \
-	maintainer-clean maintainerclean tarball rpm
+	maintainer-clean maintainerclean dist tarball rpm
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
