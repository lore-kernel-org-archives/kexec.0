Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7b-0008Dp-L2
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:23 +0000
MIME-Version: 1.0
Subject: [PATCH 2/8] Use --target for target architecture specification
Message-Id: <1197967675.856377.756334005541.2.gpush@pokey>
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

Instead of using a combination of ARCH and --host, use --target.

It's possible to have host != target. For example, building a ppc
kexec binary for a ppc64 kernel. In this case, the kexec binary is
compiled for 32-bit, while the purgatory object is 64-bit.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 configure.ac |   40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index bcfbc58..032d9de 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,50 +14,40 @@ dnl as there are only a small number of targets that kexec
 dnl can support on a given host system.  If it stops making
 dnl sense compile support for all possible targets a given
 dnl host can support AC_CANONICAL_TARGET may help
-dnl AC_CANONICAL_TARGET
+AC_CANONICAL_TARGET
 
 
-dnl Compute host cpu
-case $host_cpu in 
-	i?86 )	
-		host_cpu="i386"
+dnl Compute ARCH from target cpu info
+case $target_cpu in
+	i?86 )
+		ARCH="i386"
 		;;
 	powerpc )
-		host_cpu="ppc"
+		ARCH="ppc"
 		;;
 	powerpc64 )
-		host_cpu="ppc64"
+		ARCH="ppc64"
 		;;
-	s390x )
-		host_cpu="s390"
+	s390x|s390 )
+		ARCH="s390"
 		;;
-	sh4|sh4a|sh3 )
-		host_cpu="sh"
+	sh4|sh4a|sh3|sh )
+		ARCH="sh"
 		;;
-	* ) 
-		host_cpu="$host_cpu"
-		;;
-esac
-case $host_cpu in
-	i386|ppc|x86_64|alpha|ppc64|ia64|s390|sh)
+	ia64|x86_64|alpha )
+		ARCH="$target_cpu"
 		;;
 	* )
-		AC_MSG_ERROR([ unsupported architecture $host_cpu])
+		AC_MSG_ERROR([unsupported architecture $target_cpu])
 		;;
 esac
 
-dnl Try to guess the kernel ARCH based on the autoconf host_cpu variable.
-
-if ! test "${ARCH}" ; then
-	ARCH=$host_cpu
-fi
-
 dnl ---Options
 
 OBJDIR=`pwd`/objdir
 if test "${host_alias}" ; then
 	OBJDIR="$OBJDIR-${host_alias}"
-fi 
+fi
 
 EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing -Wstrict-prototypes $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
 BUILD_CFLAGS='-O2 -Wall $(CPPFLAGS)'

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
