Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TmfqI-00017V-Me
 for kexec@lists.infradead.org; Sun, 23 Dec 2012 07:19:27 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/3] build: Use cross compiler's strip if available
Date: Sun, 23 Dec 2012 16:19:17 +0900
Message-Id: <1356247158-9671-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1356247158-9671-1-git-send-email-horms@verge.net.au>
References: <1356247158-9671-1-git-send-email-horms@verge.net.au>
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
Cc: Simon Horman <horms@verge.net.au>

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in  |    1 +
 configure.ac |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index 99b4bb3..384cf0b 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -220,6 +220,7 @@ echo::
 	@echo CC=$(CC)
 	@echo AR=$(AR)
 	@echo LD=$(LD)
+	@echo STRIP=$(STRIP)
 
 clean:
 	$(RM) -f $(clean)
diff --git a/configure.ac b/configure.ac
index a423988..438b3c9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -107,6 +107,7 @@ AC_CHECK_TOOL([LD], ld, "no", $PATH)
 AC_CHECK_TOOL([AS], as, "no", $PATH)
 AC_CHECK_TOOL([OBJCOPY], objcopy, "no", $PATH)
 AC_CHECK_TOOL([AR], ar, "", $PATH)
+AC_CHECK_TOOL([STRIP], strip, "no", $PATH)
 
 dnl Find compiler for target
 if test "${target}" != "${host}" ; then
@@ -142,7 +143,6 @@ AC_CHECK_PROG([SED],      sed,      sed,      "no", [$PATH])
 AC_CHECK_PROG([FIND],     find,     find,     "no", [$PATH])
 AC_CHECK_PROG([XARGS],    xargs,    xargs,    "no", [$PATH])
 AC_CHECK_PROG([DIRNAME],  dirname,  dirname,  "no", [$PATH])
-AC_CHECK_PROG([STRIP],    strip,    strip,    "no", [$PATH])
 
 dnl See if I have a usable copy of zlib available
 if test "$with_zlib" = yes ; then
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
