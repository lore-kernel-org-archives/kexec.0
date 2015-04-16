Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from woodpecker.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]
 helo=smtp.gentoo.org)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yic9G-0004so-Mv
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 05:15:35 +0000
From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] purgatory: force PIC/PIE/SSP off
Date: Thu, 16 Apr 2015 01:15:04 -0400
Message-Id: <1429161304-2772-1-git-send-email-vapier@gentoo.org>
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
Cc: Mike Frysinger <vapier@chromium.org>

From: Mike Frysinger <vapier@chromium.org>

If the toolchain has these things turned on automatically, then the
purgatory code might be miscompiled leading to runtime errors like:
Unhandled rela relocation: R_X86_64_GOTPC64

It might look like the problem is with the kernel when in reality,
kexec is complaining about the purgatory module.  Force off harden
features that don't make sense in kernel space.

Signed-off-by: Mike Frysinger <vapier@chromium.org>
---
 purgatory/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 2d6b2c0..2b5c061 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -49,7 +49,8 @@ $(PURGATORY): CC=$(TARGET_CC)
 $(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
 		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 		      -Os -fno-builtin -ffreestanding \
-		      -fno-zero-initialized-in-bss
+		      -fno-zero-initialized-in-bss \
+		      -fno-PIC -fno-PIE -fno-stack-protector
 
 $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/include \
-- 
2.3.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
