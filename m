Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7l-0008E5-Ux
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:36 +0000
MIME-Version: 1.0
Subject: [PATCH 7/8] removed partially duplicated system headers
Message-Id: <1197967675.863698.29684842564.7.gpush@pokey>
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

From: Simon Horman <horms@verge.net.au>

Purgatory seems to partially duplicate system headers.
It seems a log cleaner not to do so.

Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 purgatory/arch/alpha/include/limits.h    |   57 -----------------------------
 purgatory/arch/alpha/include/stdint.h    |   16 --------
 purgatory/arch/i386/console-x86.c        |    3 +
 purgatory/arch/i386/include/limits.h     |   58 ------------------------------
 purgatory/arch/i386/include/stdint.h     |   16 --------
 purgatory/arch/i386/pic.c                |    2 -
 purgatory/arch/i386/purgatory-x86.c      |    2 -
 purgatory/arch/i386/timer.c              |    1 
 purgatory/arch/i386/vga.c                |    2 -
 purgatory/arch/ia64/include/limits.h     |   57 -----------------------------
 purgatory/arch/ia64/include/stdint.h     |   16 --------
 purgatory/arch/ppc/include/limits.h      |   58 ------------------------------
 purgatory/arch/ppc/include/stdint.h      |   16 --------
 purgatory/arch/ppc64/include/limits.h    |   57 -----------------------------
 purgatory/arch/ppc64/include/stdint.h    |   16 --------
 purgatory/arch/s390/include/limits.h     |   54 ----------------------------
 purgatory/arch/s390/include/stdint.h     |   24 ------------
 purgatory/arch/sh/include/limits.h       |   58 ------------------------------
 purgatory/arch/sh/include/stdint.h       |   16 --------
 purgatory/arch/x86_64/include/arch/io.h  |   59 -------------------------------
 purgatory/arch/x86_64/include/limits.h   |   57 -----------------------------
 purgatory/arch/x86_64/include/stdint.h   |   16 --------
 purgatory/arch/x86_64/purgatory-x86_64.c |    2 -
 util_lib/include/sha256.h                |    1 
 24 files changed, 7 insertions(+), 657 deletions(-)

diff --git a/purgatory/arch/alpha/include/limits.h b/purgatory/arch/alpha/include/limits.h
deleted file mode 100644
index 0c6f21f..0000000
--- a/purgatory/arch/alpha/include/limits.h
+++ /dev/null
@@ -1,57 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H	1
-
-/* Number of bits in a `char' */
-#define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN	(-128)
-#define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX	255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN	SCHAR_MIN
-#define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN	(-32768)
-#define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX	65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX	9223372036854775807L
-#define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX	18446744073709551615UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX	9223372036854775807LL
-#define LLONG_MIN	(-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX	18446744073709551615ULL
-
-
-#endif /* LIMITS_H */
diff --git a/purgatory/arch/alpha/include/stdint.h b/purgatory/arch/alpha/include/stdint.h
deleted file mode 100644
index 2f9c592..0000000
--- a/purgatory/arch/alpha/include/stdint.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef STDINT_H
-#define STDINT_H
-
-typedef unsigned long      size_t;
-
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long      uint64_t;
-
-typedef signed char        int8_t;
-typedef signed short       int16_t;
-typedef signed int         int32_t;
-typedef signed long        int64_t;
-
-#endif /* STDINT_H */
diff --git a/purgatory/arch/i386/console-x86.c b/purgatory/arch/i386/console-x86.c
index 128f202..68f5daf 100644
--- a/purgatory/arch/i386/console-x86.c
+++ b/purgatory/arch/i386/console-x86.c
@@ -1,4 +1,5 @@
-#include <arch/io.h>
+#include <stdint.h>
+#include <sys/io.h>
 #include <purgatory.h>
 
 /*
diff --git a/purgatory/arch/i386/include/limits.h b/purgatory/arch/i386/include/limits.h
deleted file mode 100644
index d5a5a02..0000000
--- a/purgatory/arch/i386/include/limits.h
+++ /dev/null
@@ -1,58 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H	1
-
-
-/* Number of bits in a `char' */
-#define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN	(-128)
-#define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX	255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN	SCHAR_MIN
-#define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN	(-32768)
-#define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX	65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX	2147483647L
-#define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX	4294967295UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX	9223372036854775807LL
-#define LLONG_MIN	(-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX	18446744073709551615ULL
-
-
-#endif /* LIMITS_H */
diff --git a/purgatory/arch/i386/include/stdint.h b/purgatory/arch/i386/include/stdint.h
deleted file mode 100644
index 79262c2..0000000
--- a/purgatory/arch/i386/include/stdint.h
+++ /dev/null
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
diff --git a/purgatory/arch/i386/pic.c b/purgatory/arch/i386/pic.c
index 1b73ea9..c23c459 100644
--- a/purgatory/arch/i386/pic.c
+++ b/purgatory/arch/i386/pic.c
@@ -16,7 +16,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <arch/io.h>
+#include <sys/io.h>
 #include <purgatory.h>
 #include "purgatory-x86.h"
 
diff --git a/purgatory/arch/i386/purgatory-x86.c b/purgatory/arch/i386/purgatory-x86.c
index 5ad0740..4d2c5c7 100644
--- a/purgatory/arch/i386/purgatory-x86.c
+++ b/purgatory/arch/i386/purgatory-x86.c
@@ -1,4 +1,4 @@
-#include <arch/io.h>
+#include <stdint.h>
 #include <purgatory.h>
 #include "purgatory-x86.h"
 
diff --git a/purgatory/arch/i386/timer.c b/purgatory/arch/i386/timer.c
index dec5938..7a4bdaa 100644
--- a/purgatory/arch/i386/timer.c
+++ b/purgatory/arch/i386/timer.c
@@ -1,4 +1,3 @@
-#include <arch/io.h>
 #include <purgatory.h>
 #include "purgatory-x86.h"
 
diff --git a/purgatory/arch/i386/vga.c b/purgatory/arch/i386/vga.c
index effa8ff..e65976c 100644
--- a/purgatory/arch/i386/vga.c
+++ b/purgatory/arch/i386/vga.c
@@ -1,4 +1,4 @@
-#include <arch/io.h>
+#include <sys/io.h>
 #include <purgatory.h>
 #include "purgatory-x86.h"
 
diff --git a/purgatory/arch/ia64/include/limits.h b/purgatory/arch/ia64/include/limits.h
deleted file mode 100644
index 0c6f21f..0000000
--- a/purgatory/arch/ia64/include/limits.h
+++ /dev/null
@@ -1,57 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H	1
-
-/* Number of bits in a `char' */
-#define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN	(-128)
-#define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX	255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN	SCHAR_MIN
-#define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN	(-32768)
-#define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX	65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX	9223372036854775807L
-#define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX	18446744073709551615UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX	9223372036854775807LL
-#define LLONG_MIN	(-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX	18446744073709551615ULL
-
-
-#endif /* LIMITS_H */
diff --git a/purgatory/arch/ia64/include/stdint.h b/purgatory/arch/ia64/include/stdint.h
deleted file mode 100644
index 2f9c592..0000000
--- a/purgatory/arch/ia64/include/stdint.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef STDINT_H
-#define STDINT_H
-
-typedef unsigned long      size_t;
-
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long      uint64_t;
-
-typedef signed char        int8_t;
-typedef signed short       int16_t;
-typedef signed int         int32_t;
-typedef signed long        int64_t;
-
-#endif /* STDINT_H */
diff --git a/purgatory/arch/ppc/include/limits.h b/purgatory/arch/ppc/include/limits.h
deleted file mode 100644
index d5a5a02..0000000
--- a/purgatory/arch/ppc/include/limits.h
+++ /dev/null
@@ -1,58 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H	1
-
-
-/* Number of bits in a `char' */
-#define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN	(-128)
-#define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX	255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN	SCHAR_MIN
-#define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN	(-32768)
-#define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX	65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX	2147483647L
-#define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX	4294967295UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX	9223372036854775807LL
-#define LLONG_MIN	(-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX	18446744073709551615ULL
-
-
-#endif /* LIMITS_H */
diff --git a/purgatory/arch/ppc/include/stdint.h b/purgatory/arch/ppc/include/stdint.h
deleted file mode 100644
index 79262c2..0000000
--- a/purgatory/arch/ppc/include/stdint.h
+++ /dev/null
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
diff --git a/purgatory/arch/ppc64/include/limits.h b/purgatory/arch/ppc64/include/limits.h
deleted file mode 100644
index 0c6f21f..0000000
--- a/purgatory/arch/ppc64/include/limits.h
+++ /dev/null
@@ -1,57 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H	1
-
-/* Number of bits in a `char' */
-#define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN	(-128)
-#define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX	255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN	SCHAR_MIN
-#define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN	(-32768)
-#define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX	65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX	9223372036854775807L
-#define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX	18446744073709551615UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX	9223372036854775807LL
-#define LLONG_MIN	(-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX	18446744073709551615ULL
-
-
-#endif /* LIMITS_H */
diff --git a/purgatory/arch/ppc64/include/stdint.h b/purgatory/arch/ppc64/include/stdint.h
deleted file mode 100644
index 2f9c592..0000000
--- a/purgatory/arch/ppc64/include/stdint.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef STDINT_H
-#define STDINT_H
-
-typedef unsigned long      size_t;
-
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long      uint64_t;
-
-typedef signed char        int8_t;
-typedef signed short       int16_t;
-typedef signed int         int32_t;
-typedef signed long        int64_t;
-
-#endif /* STDINT_H */
diff --git a/purgatory/arch/s390/include/limits.h b/purgatory/arch/s390/include/limits.h
deleted file mode 100644
index 3424298..0000000
--- a/purgatory/arch/s390/include/limits.h
+++ /dev/null
@@ -1,54 +0,0 @@
-#ifndef _LIMITS_H_
-#define _LIMITS_H_
-
-/* Number of bits in a `char'.	*/
-#  define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold.  */
-#  define SCHAR_MIN	(-128)
-#  define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold.  (Minimum is 0.)  */
-#  define UCHAR_MAX	255
-
-#  define CHAR_MIN	SCHAR_MIN
-#  define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold.  */
-#  define SHRT_MIN	(-32768)
-#  define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short int' can hold.  (Minimum is 0.)  */
-#  define USHRT_MAX	65535
-
-/* Minimum and maximum values a `signed int' can hold.  */
-#  define INT_MIN	(-INT_MAX - 1)
-#  define INT_MAX	2147483647
-
-/* Maximum value an `unsigned int' can hold.  (Minimum is 0.)  */
-#  define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long int' can hold.  */
-#ifdef __s390x__
-#   define LONG_MAX	9223372036854775807L
-#else
-#   define LONG_MAX	2147483647L
-#endif
-
-#  define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long int' can hold.  (Minimum is 0.)  */
-#ifdef __s390x__
-#   define ULONG_MAX	18446744073709551615UL
-#else
-#   define ULONG_MAX	4294967295UL
-#endif
-
-/* Minimum and maximum values a `signed long long int' can hold.  */
-#   define LLONG_MAX	9223372036854775807LL
-#   define LLONG_MIN	(-LLONG_MAX - 1LL)
-
-/* Maximum value an `unsigned long long int' can hold.  (Minimum is 0.)  */
-#   define ULLONG_MAX	18446744073709551615ULL
-
-#endif	/* !_LIMITS_H_ */
diff --git a/purgatory/arch/s390/include/stdint.h b/purgatory/arch/s390/include/stdint.h
deleted file mode 100644
index a713cf5..0000000
--- a/purgatory/arch/s390/include/stdint.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef _STDINT_H
-#define _STDINT_H
-
-typedef unsigned long		size_t;
-
-typedef unsigned char		uint8_t;
-typedef unsigned short		uint16_t;
-typedef unsigned int		uint32_t;
-#ifdef __s390x__
-typedef unsigned long		uint64_t;
-#else
-typedef unsigned long long	uint64_t;
-#endif
-
-typedef signed char 		int8_t;
-typedef short 			int16_t;
-typedef int 			int32_t;
-#ifdef __s390x__
-typedef long			int64_t;
-#else
-typedef long long		int64_t;
-#endif
-
-#endif
diff --git a/purgatory/arch/sh/include/limits.h b/purgatory/arch/sh/include/limits.h
deleted file mode 100644
index d5a5a02..0000000
--- a/purgatory/arch/sh/include/limits.h
+++ /dev/null
@@ -1,58 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H	1
-
-
-/* Number of bits in a `char' */
-#define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN	(-128)
-#define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX	255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN	SCHAR_MIN
-#define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN	(-32768)
-#define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX	65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX	2147483647L
-#define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX	4294967295UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX	9223372036854775807LL
-#define LLONG_MIN	(-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX	18446744073709551615ULL
-
-
-#endif /* LIMITS_H */
diff --git a/purgatory/arch/sh/include/stdint.h b/purgatory/arch/sh/include/stdint.h
deleted file mode 100644
index 79262c2..0000000
--- a/purgatory/arch/sh/include/stdint.h
+++ /dev/null
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
diff --git a/purgatory/arch/x86_64/include/arch/io.h b/purgatory/arch/x86_64/include/arch/io.h
index 13ad887..dcd01bf 100644
--- a/purgatory/arch/x86_64/include/arch/io.h
+++ b/purgatory/arch/x86_64/include/arch/io.h
@@ -2,65 +2,6 @@
 #define ARCH_IO_H
 
 #include <stdint.h>
-/* Helper functions for directly doing I/O */
-
-extern inline uint8_t inb(uint16_t port)
-{
-	uint8_t result;
-
-	__asm__ __volatile__ (
-		"inb %w1,%0"
-		:"=a" (result)
-		:"Nd" (port));
-	return result;
-}
-
-extern inline uint16_t inw(uint16_t port)
-{
-	uint16_t result;
-
-	__asm__ __volatile__ (
-		"inw %w1,%0"
-		:"=a" (result)
-		:"Nd" (port));
-	return result;
-}
-
-extern inline uint32_t inl(uint32_t port)
-{
-	uint32_t result;
-
-	__asm__ __volatile__ (
-		"inl %w1,%0"
-		:"=a" (result)
-		:"Nd" (port));
-	return result;
-}
-
-extern inline void outb (uint8_t value, uint16_t port)
-{
-	__asm__ __volatile__ (
-		"outb %b0,%w1"
-		:
-		:"a" (value), "Nd" (port));
-}
-
-extern inline void outw (uint16_t value, uint16_t port)
-{
-	__asm__ __volatile__ (
-		"outw %w0,%w1"
-		:
-		:"a" (value), "Nd" (port));
-}
-
-extern inline void outl (uint32_t value, uint16_t port)
-{
-	__asm__ __volatile__ (
-		"outl %0,%w1"
-		:
-		:"a" (value), "Nd" (port));
-}
-
 
 /*
  * readX/writeX() are used to access memory mapped devices. On some
diff --git a/purgatory/arch/x86_64/include/limits.h b/purgatory/arch/x86_64/include/limits.h
deleted file mode 100644
index 0c6f21f..0000000
--- a/purgatory/arch/x86_64/include/limits.h
+++ /dev/null
@@ -1,57 +0,0 @@
-#ifndef LIMITS_H
-#define LIMITS_H	1
-
-/* Number of bits in a `char' */
-#define CHAR_BIT	8
-
-/* Minimum and maximum values a `signed char' can hold */
-#define SCHAR_MIN	(-128)
-#define SCHAR_MAX	127
-
-/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
-#define UCHAR_MAX	255
-
-/* Minimum and maximum values a `char' can hold */
-#define CHAR_MIN	SCHAR_MIN
-#define CHAR_MAX	SCHAR_MAX
-
-/* Minimum and maximum values a `signed short int' can hold */
-#define SHRT_MIN	(-32768)
-#define SHRT_MAX	32767
-
-/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
-#define USHRT_MAX	65535
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-
-/* Minimum and maximum values a `signed int' can hold */
-#define INT_MIN		(-INT_MAX - 1)
-#define INT_MAX		2147483647
-
-/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
-#define UINT_MAX	4294967295U
-
-/* Minimum and maximum values a `signed long' can hold */
-#define LONG_MAX	9223372036854775807L
-#define LONG_MIN	(-LONG_MAX - 1L)
-
-/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
-#define ULONG_MAX	18446744073709551615UL
-
-/* Minimum and maximum values a `signed long long' can hold */
-#define LLONG_MAX	9223372036854775807LL
-#define LLONG_MIN	(-LONG_MAX - 1LL)
-
-
-/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
-#define ULLONG_MAX	18446744073709551615ULL
-
-
-#endif /* LIMITS_H */
diff --git a/purgatory/arch/x86_64/include/stdint.h b/purgatory/arch/x86_64/include/stdint.h
deleted file mode 100644
index 2f9c592..0000000
--- a/purgatory/arch/x86_64/include/stdint.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef STDINT_H
-#define STDINT_H
-
-typedef unsigned long      size_t;
-
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long      uint64_t;
-
-typedef signed char        int8_t;
-typedef signed short       int16_t;
-typedef signed int         int32_t;
-typedef signed long        int64_t;
-
-#endif /* STDINT_H */
diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_64/purgatory-x86_64.c
index b159ed3..374b554 100644
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -1,4 +1,4 @@
-#include <arch/io.h>
+#include <stdint.h>
 #include <purgatory.h>
 #include "purgatory-x86_64.h"
 
diff --git a/util_lib/include/sha256.h b/util_lib/include/sha256.h
index b8278a1..467fb22 100644
--- a/util_lib/include/sha256.h
+++ b/util_lib/include/sha256.h
@@ -1,6 +1,7 @@
 #ifndef SHA256_H
 #define SHA256_H
 
+#include <sys/types.h>
 #include <stdint.h>
 
 typedef struct

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
