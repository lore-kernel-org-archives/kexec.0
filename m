Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJFnv-0003B4-FV
 for kexec@lists.infradead.org; Tue, 20 Dec 2016 08:29:48 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] alpha: add missing __NR_kexec_load definition
Date: Tue, 20 Dec 2016 09:29:18 +0100
Message-Id: <1482222558-30213-1-git-send-email-horms@verge.net.au>
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/kexec-syscall.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index c0d0beadf932..3b5c528d8aac 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -48,6 +48,9 @@
 #ifdef __m68k__
 #define __NR_kexec_load                313
 #endif
+#ifdef __alpha__
+#define __NR_kexec_load                448
+#endif
 #ifndef __NR_kexec_load
 #error Unknown processor architecture.  Needs a kexec_load syscall number.
 #endif
-- 
2.7.0.rc3.207.g0ac5344


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
