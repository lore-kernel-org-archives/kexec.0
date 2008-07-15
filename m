Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIjKX-0004Ma-Gf
	for kexec@lists.infradead.org; Tue, 15 Jul 2008 12:08:34 +0000
MIME-Version: 1.0
Subject: [PATCH] Allow BUILD_CFLAGS and TARGET_CFLAGS to be specified at
	configure time
Message-Id: <1216123702.433919.719662663715.1.gpush@pingu>
In-Reply-To: <20080715102808.GA29267@verge.net.au>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 15 Jul 2008 22:08:22 +1000
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>, Simon Horman <horms@verge.net.au>

Currently, we're unconditionally setting the build and target cflags in
the configure script, which means that they can't be easily
overwritten.

This change conditionally sets these variables if they're not specified
during configure, allowing something like:

BUILD_CFLAGS=-Werror ./configure

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 configure.ac |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5f1c15a..fa5330a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,8 +56,13 @@ if test "${host_alias}" ; then
 	OBJDIR="$OBJDIR-${host_alias}"
 fi
 
-BUILD_CFLAGS='-O2 -Wall'
-TARGET_CFLAGS='-O2 -Wall'
+if test "x$BUILD_CFLAGS" = "x" ; then
+	BUILD_CFLAGS='-O2 -Wall'
+fi
+
+if test "x$TARGET_CFLAGS" = "x" ; then
+	TARGET_CFLAGS='-O2 -Wall'
+fi
 
 AC_ARG_WITH([objdir], AC_HELP_STRING([--with-objdir=<dir>],[select directory for object files]),
 	[ OBJDIR="$withval" ], [ OBJDIR="$OBJDIR" ])

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
