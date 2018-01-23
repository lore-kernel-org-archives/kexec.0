Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ee2Xs-00024e-W0
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 17:39:43 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v1] kexec-tools: Tweak run-time handling of libxenctrl.so
Date: Tue, 23 Jan 2018 11:39:29 -0600
Message-Id: <1516729169-11871-1-git-send-email-eric.devolder@oracle.com>
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

This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
run-time linking of libxenctrl.so". This patch addresses feedback
from Daniel Kiper concerning the lack of a dlclose() and the desire
to make xc_dlhandle static, rather than extern.

In the original patch, the call to dlclose() was omitted, in contrast
to the description in the commit message. This patch inserts the call.
Note that this dynamic linking feature is dependent upon the proper
operation of the RTLD_NODELETE flag to dlopen(), which does work as
advertised on Linux (otherwise the call to dlclose() should be omitted).

This patch also implements Daniel's suggestion to make the
xc_dlhandle variable static.

This patch has been re-tested per scenarios outlined in the original
patch commit message.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v1: 23jan2018
 - Implemented feedback from Daniel Kiper
---
 kexec/kexec-xen.c | 13 ++++++++++++-
 kexec/kexec-xen.h |  9 ++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index d42a45a..03ea4a8 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -15,8 +15,18 @@
 #include "crashdump.h"
 
 #ifdef CONFIG_LIBXENCTRL_DL
-void *xc_dlhandle;
+/* The handle from dlopen(), needed by dlsym(), dlclose() */
+static void *xc_dlhandle;
 xc_hypercall_buffer_t XC__HYPERCALL_BUFFER_NAME(HYPERCALL_BUFFER_NULL);
+
+void *__xc_dlsym(const char *symbol)
+{
+	if (xc_dlhandle)
+		return dlsym(xc_dlhandle, symbol);
+	else
+		return NULL;
+}
+
 xc_interface *__xc_interface_open(xentoollog_logger *logger,
 				  xentoollog_logger *dombuild_logger,
 				  unsigned open_flags)
@@ -47,6 +57,7 @@ int __xc_interface_close(xc_interface *xch)
 
 		func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_close");
 		rc = func(xch);
+		dlclose(xc_dlhandle);
 		xc_dlhandle = NULL;
 	}
 
diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
index ffb8743..8955334 100644
--- a/kexec/kexec-xen.h
+++ b/kexec/kexec-xen.h
@@ -6,9 +6,8 @@
 
 #ifdef CONFIG_LIBXENCTRL_DL
 #include <dlfcn.h>
-
-/* The handle from dlopen(), needed by dlsym(), dlclose() */
-extern void *xc_dlhandle;
+/* Lookup symbols in libxenctrl.so */
+void *__xc_dlsym(const char *symbol);
 
 /* Wrappers around xc_interface_open/close() to insert dlopen/dlclose() */
 xc_interface *__xc_interface_open(xentoollog_logger *logger,
@@ -21,13 +20,13 @@ int __xc_interface_close(xc_interface *xch);
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
