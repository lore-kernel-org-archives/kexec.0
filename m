Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCr6-0006YZ-5E
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:40 +0000
Message-Id: <20080306094758.578257076@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 02/12] kexec-tools: mipsel: Remove
	purgatory/arch/mipsel/include/stdint.h
Content-Disposition: inline; filename=mips-dup_stdint.patch
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
To: kexec@lists.infradead.org, linux-mips@linux-mips.org, Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Francesco Chiechi <francesco.chiechi@colibre.it>

Remove purgatory/arch/mipsel/include/stdint.h as it just duplicates
things found in system header files.

Signed-off-by: Simon Horman <horms@verge.net.au>

---

 purgatory/arch/mipsel/include/stdint.h |   16 ----------------
 1 file changed, 16 deletions(-)

Index: kexec-tools-mips/purgatory/arch/mipsel/include/stdint.h
===================================================================
--- kexec-tools-mips.orig/purgatory/arch/mipsel/include/stdint.h	2008-02-27 19:02:34.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,16 +0,0 @@
-#ifndef STDINT_H
-#define STDINT_H
-
-typedef unsigned long      size_t;
-
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long long uint64_t;
-
-typedef signed char        int8_t;
-typedef signed short       int16_t;
-typedef signed int         int32_t;
-typedef signed long long   int64_t;
-
-#endif /* STDINT_H */

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
