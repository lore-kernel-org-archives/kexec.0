Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.gentoo.org ([140.211.166.183])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YieP7-00064L-IN
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 07:40:06 +0000
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id C3C0E34091A
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 07:39:43 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH v2] purgatory: force PIC/PIE/SSP off
Date: Thu, 16 Apr 2015 03:39:26 -0400
Message-Id: <1429169966-1340-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <552F6507.1010500@linux.vnet.ibm.com>
References: <552F6507.1010500@linux.vnet.ibm.com>
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

From: Mike Frysinger <vapier@chromium.org>

If the toolchain has these things turned on automatically, then the
purgatory code might be miscompiled leading to runtime errors like:
Unhandled rela relocation: R_X86_64_GOTPC64

It might look like the problem is with the kernel when in reality,
kexec is complaining about the purgatory module.  Force off harden
features that don't make sense in kernel space.

Signed-off-by: Mike Frysinger <vapier@chromium.org>
---
Note: I suspect this patch fixes a semi-recent report:
http://lists.infradead.org/pipermail/kexec/2015-February/013305.html

v2:
	- clean up ssp flags in arch subdirs

 purgatory/Makefile            | 3 ++-
 purgatory/arch/ppc64/Makefile | 2 +-
 purgatory/arch/s390/Makefile  | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 6c58fa2..8ca2719 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -9,7 +9,7 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 
-ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float -fno-stack-protector	\
+ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float \
 				-fno-exceptions
 ppc64_PURGATORY_EXTRA_ASFLAGS += -m64
 ifeq ($(SUBARCH),BE)
diff --git a/purgatory/arch/s390/Makefile b/purgatory/arch/s390/Makefile
index 09749bd..c94cc3c 100644
--- a/purgatory/arch/s390/Makefile
+++ b/purgatory/arch/s390/Makefile
@@ -2,7 +2,6 @@
 # Purgatory s390
 #
 
-s390_PURGATORY_EXTRA_CFLAGS += -fno-stack-protector
 s390_PURGATORY_SRCS += purgatory/arch/s390/console-s390.c
 s390_PURGATORY_SRCS += purgatory/arch/s390/setup-s390.S
 s390_PURGATORY_SRCS += purgatory/arch/s390/purgatory-s390.c
-- 
2.3.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
