Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KXu06-0000XK-59
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 08:34:06 +0000
MIME-Version: 1.0
Subject: [PATCH] [PATCH] Add INSTALL file
Message-Id: <ccbaa5a3e0ef56dc40d1.1219739636@halley.suse.de>
Date: Tue, 26 Aug 2008 10:33:56 +0200
From: Bernhard Walle <bwalle@suse.de>
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
Cc: yhlu.kernel@gmail.com

1 file changed, 65 insertions(+)
INSTALL |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


To describe static compilation. I hope the rest is also okay.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

diff --git a/INSTALL b/INSTALL
new file mode 100644
--- /dev/null
+++ b/INSTALL
@@ -0,0 +1,65 @@
+Installation
+============
+
+General
+-------
+
+kexec-tools uses Autoconf, so you can just use
+
+    ./configure
+    make
+    su -c "make install"
+
+to install kexec-tools on your system. However, you should check first if your
+favourite Linux distribution doesn't offer a package. If that package is recent
+enough, you should consider using that package instead.
+
+
+Installation directory
+----------------------
+
+To change the default installation directory, call ./configure with
+
+    --prefix=<prefix> (for example, /usr)
+    --bindir=<binary directory> (for example, /usr/bin)
+    --sbindir=<super user binary directory>  (for example, /usr/sbin)
+    --mandir=<manpage directory> (for example, /usr/share/man)
+
+and so on. See the output of
+
+    ./configure --help
+
+for all options.
+
+
+Static compilation
+------------------
+
+To compile kexec-tools statically (i.e., independent of libraries that are
+present on the system), use
+
+    LDFLAGS=-static ./configure <options>
+
+instead.
+
+
+Cross compilation
+-----------------
+
+Because kexec is also used in the embedded world, cross-compilation is
+supported. You cannot only set "CC", "LD", "CCFLAGS" and "LDFLAGS" environment
+variables for the ./configure call as usual, you can also set
+
+    TARGET_CC       -- the C compiler used for files that should run on the
+                       target
+    TARGET_CCFLAGS  -- compilation flags for $TARGET_CC
+    TARGET_LD       -- linker used for files that should run on the
+                       target
+
+Because the build process also requires files that must be executed during the
+build, you also need a host compiler, only the target compiler is not enough.
+
+    BUILD_CC        -- the C compiler used for files that should run on the
+                       host (the system that builds the kexec-tools)
+    BUILD_CFLAGS    -- compilation flags for $BUILD_CC
+

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
