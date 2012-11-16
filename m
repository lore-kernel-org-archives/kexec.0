Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZUxl-0005lt-Am
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 23:04:42 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/8] Add min/max macro
Date: Fri, 16 Nov 2012 15:04:20 -0800
Message-Id: <1353107067-14564-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/ppc/include/types.h |   12 ------------
 kexec/kexec.h                  |   12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kexec/arch/ppc/include/types.h b/kexec/arch/ppc/include/types.h
index 31393d1..3773cda 100644
--- a/kexec/arch/ppc/include/types.h
+++ b/kexec/arch/ppc/include/types.h
@@ -12,16 +12,4 @@ typedef short			s16;
 typedef int			s32;
 typedef long long		s64;
 
-#define min(x,y) ({ \
-	typeof(x) _x = (x);	\
-	typeof(y) _y = (y);	\
-	(void) (&_x == &_y);	\
-	_x < _y ? _x : _y; })
-
-#define max(x,y) ({ \
-	typeof(x) _x = (x);	\
-	typeof(y) _y = (y);	\
-	(void) (&_x == &_y);	\
-	_x > _y ? _x : _y; })
-
 #endif /* _TYPES_H_ */
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 1f46bcb..35b0b10 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -100,6 +100,18 @@ do { \
 	} \
 } while(0)
 
+#define min(x,y) ({ \
+        typeof(x) _x = (x);     \
+        typeof(y) _y = (y);     \
+        (void) (&_x == &_y);    \
+        _x < _y ? _x : _y; })
+
+#define max(x,y) ({ \
+        typeof(x) _x = (x);     \
+        typeof(y) _y = (y);     \
+        (void) (&_x == &_y);    \
+        _x > _y ? _x : _y; })
+
 extern unsigned long long mem_min, mem_max;
 extern int kexec_debug;
 
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
