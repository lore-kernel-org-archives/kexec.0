Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCrA-0006sR-1K
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:44 +0000
Message-Id: <20080306094800.038871930@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:46 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 09/12] kexec-tools: mipsel: Remove
	purgatory/arch/mipsel/include/limits.h
Content-Disposition: inline; filename=mips-no-limits.h.patch
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
To: kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Francesco Chiechi <francesco.chiechi@colibre.it>

Remove purgatory/arch/mipsel/include/limits.h as it is not needed.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 purgatory/arch/mipsel/include/limits.h |   58 --------------------------------
 1 file changed, 58 deletions(-)

Index: kexec-tools-testing-mips/purgatory/arch/mipsel/include/limits.h
===================================================================
--- kexec-tools-testing-mips.orig/purgatory/arch/mipsel/include/limits.h	2008-03-05 13:59:49.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,58 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H       1
-
-
-/* Number of bits in a `char' */
-#define CHAR_BIT       8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN      (-128)
-#define SCHAR_MAX      127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX      255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN       SCHAR_MIN
-#define CHAR_MAX       SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN       (-32768)
-#define SHRT_MAX       32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX      65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN                (-INT_MAX - 1)
-#define INT_MAX                2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX       4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN                (-INT_MAX - 1)
-#define INT_MAX                2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX       4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX       2147483647L
-#define LONG_MIN       (-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX      4294967295UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX      9223372036854775807LL
-#define LLONG_MIN      (-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX     18446744073709551615ULL
-
-
-#endif /* LIMITS_H */

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
