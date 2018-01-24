Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eeQes-0005qA-Bo
 for kexec@lists.infradead.org; Wed, 24 Jan 2018 19:24:32 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v4] kexec-tools: Make xc_dlhandle static
Date: Wed, 24 Jan 2018 13:20:21 -0600
Message-Id: <1516821621-27139-1-git-send-email-eric.devolder@oracle.com>
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
xc_dlhandle variable static, insert missing 'extern'
qualifier for the new __xc() wrappers, and correct some
style issues.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v1: 23jan2018
 - Implemented feedback from Daniel Kiper

v2: 23jan2018
 - Implemented feedback from Daniel Kiper
 - Broke patch into two

v3: 24jan2018
 - Implemented feedback from Daniel Kiper
 - Added 'extern' to the new declarations in kexec-xen.h

v4: 24jan2018
 - Implemented feedback from Daniel Kiper
 - Corrected style issues
---
 kexec/kexec-xen.c | 11 ++++++++++-
 kexec/kexec-xen.h | 18 ++++++++----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 75f8758..1887390 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -15,8 +15,17 @@
 #include "crashdump.h"
 
 #ifdef CONFIG_LIBXENCTRL_DL
-void *xc_dlhandle;
+#include <dlfcn.h>
+
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
index ffb8743..ae67393 100644
--- a/kexec/kexec-xen.h
+++ b/kexec/kexec-xen.h
@@ -5,29 +5,27 @@
 #include <xenctrl.h>
 
 #ifdef CONFIG_LIBXENCTRL_DL
-#include <dlfcn.h>
-
-/* The handle from dlopen(), needed by dlsym(), dlclose() */
-extern void *xc_dlhandle;
+/* Lookup symbols in libxenctrl.so */
+extern void *__xc_dlsym(const char *symbol);
 
 /* Wrappers around xc_interface_open/close() to insert dlopen/dlclose() */
-xc_interface *__xc_interface_open(xentoollog_logger *logger,
-				  xentoollog_logger *dombuild_logger,
-				  unsigned open_flags);
-int __xc_interface_close(xc_interface *xch);
+extern xc_interface *__xc_interface_open(xentoollog_logger *logger,
+					 xentoollog_logger *dombuild_logger,
+					 unsigned open_flags);
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
