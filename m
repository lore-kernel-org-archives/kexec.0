Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7b-0008Dn-MN
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:23 +0000
MIME-Version: 1.0
Subject: [PATCH 8/8] Don't assume we can re-make Makefile
Message-Id: <1197967675.864524.207243455143.8.gpush@pokey>
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

We currently assume that we can recreate the Makefile by running
./configure, but we don't have the args available, so it's likely that
the Makefile will be generated incorrectly.

This change depends on config.status instead. We won't get the
configure re-run if configure.ac is updated, but we still have the
Makefile.in dependency.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 Makefile.in |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index fdbb7c2..2cc1c30 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -172,8 +172,8 @@ SRCS:= AUTHORS COPYING News TODO Makefile.in configure.ac \
 PSRCS:=$(foreach s, $(SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 PGSRCS:=$(foreach s, $(GENERATED_SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 
-Makefile: Makefile.in configure
-	$(srcdir)/configure
+Makefile: Makefile.in config.status
+	./config.status
 
 configure: configure.ac
 	cd $(srcdir) && autoheader && autoconf && rm -rf autom4te.cache

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
