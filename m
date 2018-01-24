Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eePUB-0002mu-N2
 for kexec@lists.infradead.org; Wed, 24 Jan 2018 18:09:25 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v3] kexec-tools: Make xc_dlhandle static
Date: Wed, 24 Jan 2018 12:04:34 -0600
Message-Id: <1516817074-24318-1-git-send-email-eric.devolder@oracle.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, konrad.wilk@oracle.com

This patch is a follow-on to commit 894bea93 "kexec-tools: Perform
run-time linking of libxenctrl.so". This patch addresses feedback
from Daniel Kiper.

This patch implements Daniel's suggestion to make the
xc_dlhandle variable static.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
v1: 23jan2018
 - Implemented feedback from Daniel Kiper

v2: 23jan2018
 - Implemented feedback from Daniel Kiper
 - Broke patch into two

v3: 24jan2018
 - Implemented feedback from Daniel Kiper
 - Added 'extern' to the new declarations in kexec-xen.h
---
 kexec/kexec-xen.c |  9 ++++++++-
 kexec/kexec-xen.h | 13 ++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 75f8758..960fa16 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -15,8 +15,15 @@
 #include "crashdump.h"
 
 #ifdef CONFIG_LIBXENCTRL_DL
-void *xc_dlhandle;
+/* The handle from dlopen(), needed by dlsym(), dlclose() */
+static void *xc_dlhandle;
 xc_hypercall_buffer_t XC__HYPERCALL_BUFFER_NAME(HYPERCALL_BUFFER_NULL);
+
+void *__xc_dlsym(const char *symbol)
+{
+	return dlsym(xc_dlhandle, symbol);
+}
+
 xc_interface *__xc_interface_open(xentoollog_logger *logger,
 				  xentoollog_logger *dombuild_logger,
 				  unsigned open_flags)
diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
index ffb8743..ef08d2c 100644
--- a/kexec/kexec-xen.h
+++ b/kexec/kexec-xen.h
@@ -6,28 +6,27 @@
 
 #ifdef CONFIG_LIBXENCTRL_DL
 #include <dlfcn.h>
-
-/* The handle from dlopen(), needed by dlsym(), dlclose() */
-extern void *xc_dlhandle;
+/* Lookup symbols in libxenctrl.so */
+extern void *__xc_dlsym(const char *symbol);
 
 /* Wrappers around xc_interface_open/close() to insert dlopen/dlclose() */
-xc_interface *__xc_interface_open(xentoollog_logger *logger,
+extern xc_interface *__xc_interface_open(xentoollog_logger *logger,
 				  xentoollog_logger *dombuild_logger,
 				  unsigned open_flags);
-int __xc_interface_close(xc_interface *xch);
+extern int __xc_interface_close(xc_interface *xch);
 
 /* GCC expression statements for evaluating dlsym() */
 #define __xc_call(dtype, name, args...) \
 ( \
 	{ dtype value; \
 	typedef dtype (*func_t)(xc_interface *, ...); \
-	func_t func = dlsym(xc_dlhandle, #name); \
+	func_t func = __xc_dlsym(#name); \
 	value = func(args); \
 	value; } \
 )
 #define __xc_data(dtype, name) \
 ( \
-	{ dtype *value = (dtype *)dlsym(xc_dlhandle, #name); value; } \
+	{ dtype *value = (dtype *)__xc_dlsym(#name); value; } \
 )
 
 /* The wrappers around utilized xenctrl.h functions */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
