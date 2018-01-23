Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ee40A-0004tF-Rb
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 19:13:00 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2 1/2] kexec-tools: Call dlclose() from within
 __xc_interface_close()
Date: Tue, 23 Jan 2018 13:12:50 -0600
Message-Id: <1516734771-14795-2-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
References: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
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
from Daniel Kiper.

In the original patch, the call to dlclose() was omitted, in contrast
to the description in the commit message. This patch inserts the call.
Note that this dynamic linking feature is dependent upon the proper
operation of the RTLD_NODELETE flag to dlopen(), which does work as
advertised on Linux (otherwise the call to dlclose() should be omitted).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v1: 23jan2018
 - Implemented feedback from Daniel Kiper

v2: 23jan2018
 - Implemented feedback from Daniel Kiper
 - Broke patch into two
---
 kexec/kexec-xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index d42a45a..75f8758 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -47,6 +47,7 @@ int __xc_interface_close(xc_interface *xch)
 
 		func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_close");
 		rc = func(xch);
+		dlclose(xc_dlhandle);
 		xc_dlhandle = NULL;
 	}
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
