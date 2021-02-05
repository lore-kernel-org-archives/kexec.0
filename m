Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7wHi-0002vR-DX
 for kexec@lists.infradead.org; Fri, 05 Feb 2021 08:16:11 +0000
Received: by mail-wr1-x431.google.com with SMTP id g10so6655197wrx.1
 for <kexec@lists.infradead.org>; Fri, 05 Feb 2021 00:16:08 -0800 (PST)
From: Federico Pellegrin <fede@evolware.org>
Subject: [PATCH 1/1] kexec-tools: fix build on pre 4.4 kernels
Date: Fri,  5 Feb 2021 09:15:59 +0100
Message-Id: <20210205081559.15956-1-fede@evolware.org>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: Federico Pellegrin <fede@evolware.org>

kexec build will fail on older kernels (pre 4.4) as the define
VIDEO_CAPABILITY_64BIT_BASE was not present at that time.

This patch adds it, as per linux/include/uapi/linux/screen_info.h,
if not present.

Signed-off-by: Federico Pellegrin <fede@evolware.org>
---
 kexec/arch/i386/x86-linux-setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 76e1185..ab54a4a 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -37,6 +37,10 @@
 #include "x86-linux-setup.h"
 #include "../../kexec/kexec-syscall.h"
 
+#ifndef VIDEO_CAPABILITY_64BIT_BASE
+#define VIDEO_CAPABILITY_64BIT_BASE (1 << 1)	/* Frame buffer base is 64-bit */
+#endif
+
 void init_linux_parameters(struct x86_linux_param_header *real_mode)
 {
 	/* Fill in the values that are usually provided by the kernel. */
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
