Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8DW-0000GL-Fg
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:18 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 5/8] kexec: changes to facilitate compiling OpenSSL within Xen
Date: Mon, 14 Jan 2019 13:48:02 -0600
Message-Id: <1547495285-28907-6-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
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
To: xen-devel@lists.xen.org
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, kexec@lists.infradead.org, boris.ostrovsky@oracle.com

This is a collection of small changes to Xen sources to
allow compiling of OpenSSL within Xen kernel. There are a
few necessary code stubs, but vast majority is header file
manipulation to pass compilation.

Note I created an include2/ directory to place all the
standard include files needed by the (userland) OpenSSL
source files, as opposed to modifying about 145 source files.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 xen/arch/x86/Rules.mk           |   2 +
 xen/common/xmalloc_tlsf.c       |  25 ++++++++
 xen/include/asm-x86/types.h     |   2 +
 xen/include/xen/types.h         |   3 +
 xen/include/xen/xmalloc.h       |   1 +
 xen/include2/assert.h           |   1 +
 xen/include2/bits/syslog-path.h |   1 +
 xen/include2/ctype.h            |   1 +
 xen/include2/errno.h            |   1 +
 xen/include2/features.h         |   1 +
 xen/include2/inttypes.h         |   1 +
 xen/include2/limits.h           |   1 +
 xen/include2/memory.h           |   1 +
 xen/include2/stdarg.h           |   1 +
 xen/include2/stddef.h           |   1 +
 xen/include2/stdint.h           |   1 +
 xen/include2/stdio.h            |   1 +
 xen/include2/stdlib.h           |   1 +
 xen/include2/string.h           |   1 +
 xen/include2/strings.h          |   1 +
 xen/include2/sys/time.h         |   1 +
 xen/include2/sys/types.h        |   1 +
 xen/include2/syslog.h           |   1 +
 xen/include2/time.h             |   1 +
 xen/include2/unistd.h           |   1 +
 xen/include2/xenossl.h          | 130 ++++++++++++++++++++++++++++++++++++++++
 26 files changed, 183 insertions(+)
 create mode 100644 xen/include2/assert.h
 create mode 100644 xen/include2/bits/syslog-path.h
 create mode 100644 xen/include2/ctype.h
 create mode 100644 xen/include2/errno.h
 create mode 100644 xen/include2/features.h
 create mode 100644 xen/include2/inttypes.h
 create mode 100644 xen/include2/limits.h
 create mode 100644 xen/include2/memory.h
 create mode 100644 xen/include2/stdarg.h
 create mode 100644 xen/include2/stddef.h
 create mode 100644 xen/include2/stdint.h
 create mode 100644 xen/include2/stdio.h
 create mode 100644 xen/include2/stdlib.h
 create mode 100644 xen/include2/string.h
 create mode 100644 xen/include2/strings.h
 create mode 100644 xen/include2/sys/time.h
 create mode 100644 xen/include2/sys/types.h
 create mode 100644 xen/include2/syslog.h
 create mode 100644 xen/include2/time.h
 create mode 100644 xen/include2/unistd.h
 create mode 100644 xen/include2/xenossl.h

diff --git a/xen/arch/x86/Rules.mk b/xen/arch/x86/Rules.mk
index fe820d2..768026a 100644
--- a/xen/arch/x86/Rules.mk
+++ b/xen/arch/x86/Rules.mk
@@ -29,6 +29,8 @@ CFLAGS += -DXEN_FILE_ALIGN=PAGE_SIZE
 CFLAGS += -I$(BASEDIR)/include -Wa,-I$(BASEDIR)/include
 CFLAGS += -I$(BASEDIR)/include/asm-x86/mach-generic
 CFLAGS += -I$(BASEDIR)/include/asm-x86/mach-default
+CFLAGS += -I$(BASEDIR)/include2
+CFLAGS += -I$(BASEDIR)/common/openssl-1.1.0i/include
 
 CFLAGS += -ffunction-sections
 CFLAGS += -fdata-sections
diff --git a/xen/common/xmalloc_tlsf.c b/xen/common/xmalloc_tlsf.c
index b13317e..2d1ce40 100644
--- a/xen/common/xmalloc_tlsf.c
+++ b/xen/common/xmalloc_tlsf.c
@@ -569,6 +569,31 @@ static void tlsf_init(void)
 #define ZERO_BLOCK_PTR ((void *)-1L)
 #endif
 
+void *xrealloc (void *ptr, unsigned long size)
+{
+    struct bhdr *b;
+    b = (struct bhdr *)((char *) ptr - BHDR_OVERHEAD);
+    if (0 == size)
+    {
+        xfree(ptr);
+        ptr = NULL;
+    }
+    else if (size <= b->size)
+        b->size = size;
+    else /* size > b->size */
+    {
+        /* FIX!!! brute force alloc new and copy */
+        char *newptr = xmalloc_array(char, size);
+        if (newptr)
+        {
+            memcpy(newptr, ptr, size);
+        }
+        xfree(ptr);
+        ptr = newptr;
+    }
+    return ptr;
+}
+
 void *_xmalloc(unsigned long size, unsigned long align)
 {
     void *p = NULL;
diff --git a/xen/include/asm-x86/types.h b/xen/include/asm-x86/types.h
index b82fa58..cb1e97a 100644
--- a/xen/include/asm-x86/types.h
+++ b/xen/include/asm-x86/types.h
@@ -40,6 +40,8 @@ typedef __SIZE_TYPE__ size_t;
 typedef unsigned long size_t;
 #endif
 typedef signed long ssize_t;
+# define __ssize_t_defined
+
 
 typedef char bool_t;
 #define test_and_set_bool(b)   xchg(&(b), 1)
diff --git a/xen/include/xen/types.h b/xen/include/xen/types.h
index 8596ded..8d4d365 100644
--- a/xen/include/xen/types.h
+++ b/xen/include/xen/types.h
@@ -24,6 +24,7 @@ typedef unsigned char           u_char;
 typedef unsigned short          u_short;
 typedef unsigned int            u_int;
 typedef unsigned long           u_long;
+#  define __u_char_defined
 
 /* sysv */
 typedef unsigned char           unchar;
@@ -46,6 +47,8 @@ typedef         __s32           int32_t;
 typedef         __u64           uint64_t;
 typedef         __u64           u_int64_t;
 typedef         __s64           int64_t;
+#  define __int8_t_defined
+
 
 struct domain;
 struct vcpu;
diff --git a/xen/include/xen/xmalloc.h b/xen/include/xen/xmalloc.h
index 24a99ac..2107a81 100644
--- a/xen/include/xen/xmalloc.h
+++ b/xen/include/xen/xmalloc.h
@@ -25,6 +25,7 @@
 
 /* Free any of the above. */
 extern void xfree(void *);
+extern void *xrealloc(void *, unsigned long size);
 
 /* Underlying functions */
 extern void *_xmalloc(unsigned long size, unsigned long align);
diff --git a/xen/include2/assert.h b/xen/include2/assert.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/assert.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/bits/syslog-path.h b/xen/include2/bits/syslog-path.h
new file mode 100644
index 0000000..1d80441
--- /dev/null
+++ b/xen/include2/bits/syslog-path.h
@@ -0,0 +1 @@
+#include "../xenossl.h"
diff --git a/xen/include2/ctype.h b/xen/include2/ctype.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/ctype.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/errno.h b/xen/include2/errno.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/errno.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/features.h b/xen/include2/features.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/features.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/inttypes.h b/xen/include2/inttypes.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/inttypes.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/limits.h b/xen/include2/limits.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/limits.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/memory.h b/xen/include2/memory.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/memory.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/stdarg.h b/xen/include2/stdarg.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/stdarg.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/stddef.h b/xen/include2/stddef.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/stddef.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/stdint.h b/xen/include2/stdint.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/stdint.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/stdio.h b/xen/include2/stdio.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/stdio.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/stdlib.h b/xen/include2/stdlib.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/stdlib.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/string.h b/xen/include2/string.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/string.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/strings.h b/xen/include2/strings.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/strings.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/sys/time.h b/xen/include2/sys/time.h
new file mode 100644
index 0000000..1d80441
--- /dev/null
+++ b/xen/include2/sys/time.h
@@ -0,0 +1 @@
+#include "../xenossl.h"
diff --git a/xen/include2/sys/types.h b/xen/include2/sys/types.h
new file mode 100644
index 0000000..1d80441
--- /dev/null
+++ b/xen/include2/sys/types.h
@@ -0,0 +1 @@
+#include "../xenossl.h"
diff --git a/xen/include2/syslog.h b/xen/include2/syslog.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/syslog.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/time.h b/xen/include2/time.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/time.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/unistd.h b/xen/include2/unistd.h
new file mode 100644
index 0000000..a92105a
--- /dev/null
+++ b/xen/include2/unistd.h
@@ -0,0 +1 @@
+#include "xenossl.h"
diff --git a/xen/include2/xenossl.h b/xen/include2/xenossl.h
new file mode 100644
index 0000000..2304ba3
--- /dev/null
+++ b/xen/include2/xenossl.h
@@ -0,0 +1,130 @@
+#ifndef PSUEDO_XENOSSL_H
+#define PSUEDO_XENOSSL_H
+
+/* neuter file crypto/bio/bss_log.c */
+#define NO_SYSLOG
+
+/* stdlib.h */
+#include <xen/lib.h>
+#include <xen/xmalloc.h>
+#define malloc(X) ((void *)xmalloc_array(char, X))
+#define realloc(X,SZ) xrealloc(X,SZ)
+#define free(P) xfree(P)
+#define strtol(A,B,C) simple_strtol((const char *)(A),(const char **)(B),C)
+#define strtoul(A,B,C) simple_strtoul((const char *)(A),(const char **)(B),C)
+#define strtoll(A,B,C) simple_strtoll((const char *)(A),(const char **)(B),C)
+#define strtoull(A,B,C) simple_strtoull((const char *)(A),(const char **)(B),C)
+#define atoi(A) (int)simple_strtol((const char *)(A),NULL,10)
+void qsort (void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));
+#undef current
+#define getenv(A) NULL
+//#define abort() /* FIX!!! XEN DIE */
+void abort (void) __attribute__ ((__noreturn__)); // for OPENSSL_die()
+
+/* stddef.h */
+#if 0
+/* #include <xen/stddef.h> */
+/* #ifdef __need_size_t */
+#ifndef __ssize_t_defined
+
+#if defined(__SIZE_TYPE__)
+typedef __SIZE_TYPE__ size_t;
+#else
+typedef unsigned long size_t;
+#endif
+#undef __need_size_t
+#endif
+#endif /* 0 */
+
+/* stdarg.h */
+#include <xen/stdarg.h>
+
+/* time.h */
+#include <xen/time.h>
+typedef long int time_t;
+/* #define time(P) if (NULL != (P)) *(P) = ((s_time_t)get_s_time()) FIX!!! */
+time_t time(time_t *ts);
+
+/* limits.h */
+#include "/usr/include/limits.h"
+#define CHAR_BIT 8
+
+/* stdint.h */
+/* #include "/usr/include/stdint.h" */
+
+/* errno.h */
+#include <xen/errno.h>
+extern int errno;
+
+/* inttypes.h */
+
+/* features.h */
+/*#include "/usr/include/features.h"*/
+#define __BEGIN_DECLS
+#define __END_DECLS
+#define __THROW
+
+/* stdio.h */
+extern int sscanf (const char *str, const char *format, ...);
+
+/* assert.h */
+/* #include "/usr/include/assert.h" */
+#define assert(EXPR)
+
+/* string.h */
+#include <xen/string.h>
+#undef memset
+void *memset(void *s, int c, size_t n);
+char *strerror(int errnum);
+#undef strncpy
+char *strncpy(char *dest, const char *src, size_t n);
+
+/* ctype.h */
+#include <xen/ctype.h>
+#include <xen/lib.h>
+
+/* strings.h */
+#define strncasecmp(A,B,C) 0 /* FIX!!! */
+#undef strcat
+#undef strncat
+extern char *strcat (char *dest, const char *src);
+extern char *strncat (char *dest, const char *src, size_t n);
+
+/* syslog.h */
+#include "/usr/include/sys/syslog.h"
+
+/* bits/syslog-path.h */
+#include "/usr/include/bits/syslog-path.h"
+
+/* memory.h */
+
+/* unistd.h */
+typedef int uid_t;
+uid_t getuid(void);
+uid_t geteuid(void);
+typedef int gid_t;
+gid_t getgid(void);
+gid_t getegid(void);
+
+/* sys/types.h */
+#include <xen/types.h>
+#undef LONG_MAX
+#define LONG_MAX 0x7FFFFFFFFFFFFFFFL
+#undef INT_MAX
+#define INT_MAX 0x7FFFFFFFL
+
+/* sys/time.h */
+struct timeval {
+    time_t tv_sec;
+    long tv_usec;
+};
+struct timezone {
+    int tz_minuswest;
+    int tz_dsttime;
+};
+extern int gettimeofday(struct timeval *tv, struct timezone *tz);
+
+#define double long
+
+#endif /* PSUEDO_XENOSSL_H */
+
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
