Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x230.google.com ([2607:f8b0:400e:c03::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YHanc-00045F-2b
 for kexec@lists.infradead.org; Sat, 31 Jan 2015 16:21:34 +0000
Received: by mail-pa0-f48.google.com with SMTP id ey11so64491455pad.7
 for <kexec@lists.infradead.org>; Sat, 31 Jan 2015 08:21:09 -0800 (PST)
From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 1/3] configure.ac: quote result of AC_CHECK_LIB()
Date: Sun,  1 Feb 2015 00:10:06 +0800
Message-Id: <1422720608-28700-1-git-send-email-yszhou4tech@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Yousong Zhou <yszhou4tech@gmail.com>, horms@verge.net.au

Fix the following error when searching for lzma support.

	checking for lzma_code in -llzma... ./configure: line 4756: ac_fn_c_try_link: command not found

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 configure.ac |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4e15cb0..212e838 100644
--- a/configure.ac
+++ b/configure.ac
@@ -152,22 +152,22 @@ AC_CHECK_PROG([DIRNAME],  dirname,  dirname,  "no", [$PATH])
 dnl See if I have a usable copy of zlib available
 if test "$with_zlib" = yes ; then
 	AC_CHECK_HEADER(zlib.h,
-		AC_CHECK_LIB(z, inflateInit_, ,
-		AC_MSG_NOTICE([zlib support disabled])))
+		[AC_CHECK_LIB(z, inflateInit_, ,
+		AC_MSG_NOTICE([zlib support disabled]))])
 fi
 
 dnl See if I have a usable copy of lzma available
 if test "$with_lzma" = yes ; then
 	AC_CHECK_HEADER(lzma.h,
-		AC_CHECK_LIB(lzma, lzma_code, ,
-		AC_MSG_NOTICE([lzma support disabled])))
+		[AC_CHECK_LIB(lzma, lzma_code, ,
+		AC_MSG_NOTICE([lzma support disabled]))])
 fi
 
 dnl find Xen control stack libraries
 if test "$with_xen" = yes ; then
 	AC_CHECK_HEADER(xenctrl.h,
-		AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
-		AC_MSG_NOTICE([Xen support disabled])))
+		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
+		AC_MSG_NOTICE([Xen support disabled]))])
 fi
 
 dnl ---Sanity checks
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
