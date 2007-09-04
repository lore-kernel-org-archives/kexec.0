Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ISf8F-0000JN-TU
	for kexec@lists.infradead.org; Tue, 04 Sep 2007 16:36:23 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Tue, 4 Sep 2007 13:36:18 -0700
Date: Tue, 4 Sep 2007 13:36:18 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [patch] makedumpfile: update/clarify README
Message-Id: <20070904133618.6a23df52.rdunlap@xenotime.net>
In-Reply-To: <20070903165708tachibana@mail.jp.nec.com>
References: <20070831104951.f88cc3ba.rdunlap@xenotime.net>
	<20070903165708tachibana@mail.jp.nec.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: tachibana@mxm.nes.nec.co.jp
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

On Mon, 3 Sep 2007 16:57:08 +0900 tachibana@mxm.nes.nec.co.jp wrote:

> Makefile installs ld command etc. and they influence kernel build.
> We installed elfutils-0.125 not by 'make install' but by procedure 
> written at README of makedumpfile-1.1.6 in RHEL5.0 environment.
> Please uninstall elfutils-0.125 and elfutils-0.128 and try the above
> procedure.

Hi tachibana-san,

Thanks for that info.  I completely missed that in the README file.
Please update the README file with this patch.
---


From: Randy Dunlap <randy.dunlap@oracle.com>

Warn not to use "make install" for elfutils.
Fix a few typos.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 README |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- makedumpfile-1.1.6.orig/README
+++ makedumpfile-1.1.6/README
@@ -4,11 +4,13 @@
 ======================
 
 * REQUIREMENTS
-  Please download the following library file and install it:
+  Please download the following library file and install it exactly as below;
+  do NOT use "make install".
   - elfutils-0.125.tar.gz
     The "make install" of elfutils installs some commands (ld, readelf, etc.),
-    and the compiling problem sometimes happens due to using the installed
-    commands. To install only the library files, do the following method.
+    and compiling problems sometimes happen due to using the installed
+    commands. To install only the library & header files, use the following
+    method:
      # tar -zxvf elfutils-0.125.tar.gz
      # cd elfutils-0.125
      # ./configure
@@ -85,8 +87,8 @@
     make: *** [makedumpfile] Error 1
     #
 
-    The compiler cannot find out elf_getshstrndx() because it tries
-    searching it only from /usr/lib/libelf.a though elf_getshstrndx()
+    The compiler cannot find elf_getshstrndx() because it tries
+    searching for it only from /usr/lib/libelf.a though elf_getshstrndx()
     is archived in /usr/local/lib/libelf.a.
     To solve the problem, add the option (-L/usr/local/lib/) to CFLAGS
     of Makefile like the following:
@@ -104,4 +106,3 @@
   Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
   Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>
   kexec-ml <kexec@lists.infradead.org>
-

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
