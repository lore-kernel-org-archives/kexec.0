Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22d.google.com ([2607:f8b0:400e:c00::22d])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpKl-0004dQ-VW
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:19:24 +0000
Received: by mail-da0-f45.google.com with SMTP id v40so506912dad.32
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:19:22 -0700 (PDT)
Message-ID: <5140B511.7020109@gmail.com>
Date: Thu, 14 Mar 2013 01:19:13 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 01/13] kexec: add _ALIGN* marcos for align operation
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

This patch imports Macros for align operation:
- _ALIGN_UP(addr, size): align addr up on a size boundary
- _ALIGN_DOWN(addr, size): align addr down on a size boundary
- _ALIGN(addr, size): align addr up on a size boundary

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index 94c62c1..916a24b 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -100,6 +100,18 @@ do { \
 	} \
 } while(0)
 
+#define _ALIGN_UP_MASK(addr, mask)   (((addr) + (mask)) & ~(mask))
+#define _ALIGN_DOWN_MASK(addr, mask) ((addr) & ~(mask))
+
+/* align addr on a size boundary - adjust address up/down if needed */
+#define _ALIGN_UP(addr, size)	     \
+	_ALIGN_UP_MASK(addr, (typeof(addr))(size) - 1)
+#define _ALIGN_DOWN(addr, size)	     \
+	_ALIGN_DOWN_MASK(addr, (typeof(addr))(size) - 1)
+
+/* align addr on a size boundary - adjust address up if needed */
+#define _ALIGN(addr, size)     _ALIGN_UP(addr, size)
+
 extern unsigned long long mem_min, mem_max;
 extern int kexec_debug;
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
