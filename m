Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O9TlZ-0006IB-Jz
	for kexec@lists.infradead.org; Wed, 05 May 2010 01:51:14 +0000
From: Michael Neuling <mikey@neuling.org>
MIME-Version: 1.0
Subject: [PATCH] kexec-tools: don't include every archs Makefile
References: <15110.1273024133@neuling.org>
Date: Wed, 05 May 2010 11:51:10 +1000
Message-ID: <15472.1273024270@neuling.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

This patches changes the kexec/Makefile to only include the required
arch Makefile.  

Including all arch Makefiles causes unexpected results as changing one
archs Makefile effects all other archs.

ppc64 recently broke surprisingly because
6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
improvements" added "CFLAGS +=-Wall -Werror" to
kexec/arch/mips/Makefile.  This shouldn't happen.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Horms: Tested by compiling on x86 and ppc64, but probably needs
testing on other archs before being committed.

 kexec/Makefile |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Index: kexec-tools/kexec/Makefile
===================================================================
--- kexec-tools.orig/kexec/Makefile
+++ kexec-tools/kexec/Makefile
@@ -48,17 +48,7 @@ KEXEC_SRCS += $($(ARCH)_ARCH_REUSE_INITR
 $(ARCH)_ARCH_INIT		= kexec/arch_init.c
 KEXEC_SRCS += $($(ARCH)_ARCH_INIT)
 
-include $(srcdir)/kexec/arch/alpha/Makefile
-include $(srcdir)/kexec/arch/arm/Makefile
-include $(srcdir)/kexec/arch/i386/Makefile
-include $(srcdir)/kexec/arch/ia64/Makefile
-include $(srcdir)/kexec/arch/mips/Makefile
-include $(srcdir)/kexec/arch/cris/Makefile
-include $(srcdir)/kexec/arch/ppc/Makefile
-include $(srcdir)/kexec/arch/ppc64/Makefile
-include $(srcdir)/kexec/arch/s390/Makefile
-include $(srcdir)/kexec/arch/sh/Makefile
-include $(srcdir)/kexec/arch/x86_64/Makefile
+include $(srcdir)/kexec/arch/$(ARCH)/Makefile
 
 KEXEC_SRCS += $($(ARCH)_KEXEC_SRCS)
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
