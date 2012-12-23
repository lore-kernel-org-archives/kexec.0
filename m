Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TmfqI-00017W-PU
 for kexec@lists.infradead.org; Sun, 23 Dec 2012 07:19:28 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/3] build: Restrict scope of per-arch compiler flags
Date: Sun, 23 Dec 2012 16:19:18 +0900
Message-Id: <1356247158-9671-4-git-send-email-horms@verge.net.au>
In-Reply-To: <1356247158-9671-1-git-send-email-horms@verge.net.au>
References: <1356247158-9671-1-git-send-email-horms@verge.net.au>
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Restrict the scope of compiler flags set in per-arch Makefiles
to the architecture the Makefile belongs to.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in             |    4 ++--
 kexec/arch/arm/Makefile |    2 +-
 kexec/arch/ppc/Makefile |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 384cf0b..c1859d1 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -45,10 +45,10 @@ TARGET_CFLAGS	= @TARGET_CFLAGS@
 # Base compiler flags. These are extended by the subcomponent-Makefiles
 # where necessary.
 CPPFLAGS	= @CPPFLAGS@ -I$(srcdir)/include -I$(srcdir)/util_lib/include \
-			-Iinclude/
+			-Iinclude/ $($(ARCH)_CPPFLAGS)
 CFLAGS		= @CFLAGS@ -fno-strict-aliasing -Wall -Wstrict-prototypes
 PURGATORY_EXTRA_CFLAGS = @PURGATORY_EXTRA_CFLAGS@
-ASFLAGS		= @ASFLAGS@
+ASFLAGS		= @ASFLAGS@ $($(ARCH)_ASFLAGS)
 LDFLAGS		= @LDFLAGS@
 LIBS		= @LIBS@
 
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 192e6ec..682db78 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -16,7 +16,7 @@ arm_KEXEC_SRCS+= kexec/fs2dt.c
 
 libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
 
-CPPFLAGS+=-I$(srcdir)/kexec/libfdt
+arm_CPPFLAGS = -I$(srcdir)/kexec/libfdt
 
 arm_KEXEC_SRCS += $(libfdt_SRCS)
 
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 312c2b9..71871f1 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -20,11 +20,11 @@ ppc_libfdt_SRCS = kexec/arch/ppc/libfdt-wrapper.c
 libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
 ppc_ARCH_REUSE_INITRD =
 
-CPPFLAGS+=-I$(srcdir)/kexec/libfdt
+ppc_CPPFLAGS = -I$(srcdir)/kexec/libfdt
 
 ppc_KEXEC_SRCS += $(libfdt_SRCS) $(ppc_libfdt_SRCS)
 
-ASFLAGS	+= -Wa,--noexecstack
+ppc_ASFLAGS = -Wa,--noexecstack
 
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
 	kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h	\
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
