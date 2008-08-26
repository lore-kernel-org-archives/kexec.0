Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KXuan-0007ap-Sp
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 09:12:02 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Update INSTALL
Date: Tue, 26 Aug 2008 11:11:59 +0200
Message-Id: <1219741919-9274-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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
Cc: Bernhard Walle <bwalle@suse.de>, yhlu.kernel@gmail.com

That patch should merge my accidentally written INSTALL file with that
already present in the git tree.

It adds following items:

    - static compilation
    - cross compilation

And updates the instructions to build the auto-generated files to use the
"bootstrap" script already present.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 INSTALL |   83 ++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/INSTALL b/INSTALL
index e422868..442215f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,38 +1,77 @@
-To build kexec-tools
+Installation
+============
 
-1. If ./include/config.h.in doesn't exist, create it
 
-   # autoheader
+Checkout from git
+-----------------
 
-   If you obtain kexec-tools from a released tarball, you can ommit this
-   step.  If on the other hand you obtain kexec-tools from git or some
-   other revision control system, then you will probably need to do this.
+If you use the tarball, you can just skip that section. If you checked out the
+kexec-tools from git repository, you have to build the Autoconf-generated
+file yourself with running
 
-2. If ./configure deosn't exist, create it
+    ./bootstrap
 
-   # autoconf
+You have to install "autoconf" for that. After that, you should have a file
+called "configure" in the top-level directory of kexec-tools, and you can
+continue with the next step.
 
-   As per ./include/config.h.in, if you obtain kexec-tools from a released
-   tarball, you can ommit this step.  If on the other hand you obtain
-   kexec-tools from git or some other revision control system, then you
-   will probably need to do this.
 
-3. Run ./configure [--prefix=/usr/local] [options]...
+General
+-------
 
-   e.g.
-   # ./configure --prefix=/usr/local
+You should check first if your favourite Linux distribution doesn't offer a
+package. If that package is recent enough, you should consider using that
+package instead.
 
-   For a full list of options run
+However, if you want to install kexec-tools from sources
 
-   # ./configure --help
+ (1) Run ./configure [--prefix=/usr/local] [options]...
+     e.g.
 
-4. Run make
+        ./configure --prefix=/usr/local
 
-   # make
+     For a full list of options run
 
-To install kexec-tools
+        ./configure --help
 
-   After following the above instructions to build-kexec tools, run
+ (2) Run make
 
-   # make install
+        make
+
+ (3) To install kexec-tools
+     After following the above instructions to build-kexec tools, run
+
+        make install
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
 
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
