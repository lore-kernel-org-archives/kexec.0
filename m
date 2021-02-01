Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6QFR-0006DT-CL
 for kexec@lists.infradead.org; Mon, 01 Feb 2021 03:51:36 +0000
Received: by mail-wr1-f51.google.com with SMTP id 7so15061135wrz.0
 for <kexec@lists.infradead.org>; Sun, 31 Jan 2021 19:51:31 -0800 (PST)
MIME-Version: 1.0
From: Federico Pellegrin <fede@evolware.org>
Date: Mon, 1 Feb 2021 04:51:19 +0100
Message-ID: <CAM6O0ZggWvYVkDPRW2a849DDei7WcQ=93S+r8v+zoot1BTRjcQ@mail.gmail.com>
Subject: kexec build with pre 4.4 kernels
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

Hello,
I've had problems buidling kexec-tools with pretty old (but currently
official in "enterprise" distributions....) kernels, namely a 3.10.x
series in the scope of a buildroot image generation.

It boils down to being due to missing VIDEO_CAPABILITY_64BIT_BASE
define (that appeared from 4.4.x kernels it seems in screen_info.h) in
kexec/arch/i386/x86-linux-setup.c from
a98b4da4fd4f1c7ad9a47ade17f377b833e5c9ae.

The local fix could be trivial, something like:


diff --git a/package/kexec/0003-kexec-tools-video-capability-64bit-define.patch
b/package/kexec/0003-kexec-tools-video-capability-64bit-define.patch
new file mode 100644
index 0000000000..93a66bb1a7
--- /dev/null
+++ b/package/kexec/0003-kexec-tools-video-capability-64bit-define.patch
@@ -0,0 +1,13 @@
+--- a/kexec/arch/i386/x86-linux-setup.c
++++ b/kexec/arch/i386/x86-linux-setup.c
+@@ -37,6 +37,10 @@
+ #include "x86-linux-setup.h"
+ #include "../../kexec/kexec-syscall.h"
+
++#ifndef VIDEO_CAPABILITY_64BIT_BASE
++#define VIDEO_CAPABILITY_64BIT_BASE (1 << 1)  /* Frame buffer base
is 64-bit */
++#endif
++
+ void init_linux_parameters(struct x86_linux_param_header *real_mode)
+ {
+       /* Fill in the values that are usually provided by the kernel. */

But I was wondering if this is something that would get considered or
dropped, and better managed at buildroot or so level, given the very
old version we are talking about.

Many thanks,
Federico

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
