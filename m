Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJ0SF-0006mF-BC
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 06:25:39 +0000
Date: Wed, 16 Jul 2008 16:25:33 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Allow BUILD_CFLAGS and TARGET_CFLAGS to be specified
	at configure time
Message-ID: <20080716062532.GB2073@verge.net.au>
References: <20080715102808.GA29267@verge.net.au>
	<1216123702.433919.719662663715.1.gpush@pingu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1216123702.433919.719662663715.1.gpush@pingu>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

I have applied the following:

From: Jeremy Kerr <jk@ozlabs.org>

Currently, we're unconditionally setting the build and target cflags in
the configure script, which means that they can't be easily
overwritten.

This change conditionally sets these variables if they're not specified
during configure, allowing something like:

BUILD_CFLAGS=-Werror ./configure

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Simon Horman <horms@verge.net.au>

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

diff --git a/util/Makefile b/util/Makefile
index a1a78ac..948ee63 100644
--- a/util/Makefile
+++ b/util/Makefile
@@ -5,7 +5,7 @@ $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
 	$(LINK.o) $(CFLAGS) -o $@ $^
 
 $(BIN_TO_HEX): CC=$(BUILD_CC)
-$(BIN_TO_HEX): CFLAGS+=$(BUILD_CFLAGS)
+$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
 $(BIN_TO_HEX): LDFLAGS=
 
 dist += util/Makefile util/bin-to-hex.c

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
