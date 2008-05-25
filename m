Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0GYp-00048n-7N
	for kexec@lists.infradead.org; Sun, 25 May 2008 13:46:56 +0000
Date: Sun, 25 May 2008 15:46:52 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Fix build without cross compilation
Message-ID: <20080525154652.12e1dd00@kopernikus.site>
Mime-Version: 1.0
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
Cc: Jamey Sharp <jamey@thetovacompany.com>

This patch fixes build on "normal" Linux hosts without cross compiler.
The regression was introduced with

    commit 6f95d707544ab3417673990e6a78b27b79737856
    Author: Jamey Sharp <jamey@thetovacompany.com>
    Date:   Thu May 15 17:03:09 2008 -0700

    Use target CC and LD to build kdump and kexec_test.
    
    Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 configure.ac |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index beb8b3e..36436ba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -84,21 +84,22 @@ else
 	BUILD_CC="$CC"
 fi
 
+dnl Find the compiler tool chain
+AC_PROG_CPP
+AC_CHECK_TOOL([LD], ld, "no", $PATH)
+AC_CHECK_TOOL([AS], as, "no", $PATH)
+AC_CHECK_TOOL([OBJCOPY], objcopy, "no", $PATH)
+AC_CHECK_TOOL([AR], ar, "", $PATH)
+
 dnl Find compiler for target
 if test "${target}" != "${host}" ; then
 	AC_CHECK_PROGS(TARGET_CC, [${target_alias}-gcc ${target}-gcc
gcc]) AC_CHECK_PROGS(TARGET_LD, [${target_alias}-ld ${target}-ld ld])
 else
 	TARGET_CC="$CC"
+	TARGET_LD="$LD"
 fi
 
-dnl Find the compiler tool chain
-AC_PROG_CPP
-AC_CHECK_TOOL([LD], ld, "no", $PATH)
-AC_CHECK_TOOL([AS], as, "no", $PATH)
-AC_CHECK_TOOL([OBJCOPY], objcopy, "no", $PATH)
-AC_CHECK_TOOL([AR], ar, "", $PATH)
-
 dnl Find the helper functions
 AC_PROG_INSTALL
 AC_CHECK_PROG([MKDIR],    mkdir,    mkdir,    "no", [$PATH])

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
