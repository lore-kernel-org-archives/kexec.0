Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFHF1-0005iw-GG
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 09:13:20 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools] arm: do not build iomem.o target with no soruce
Date: Fri,  9 Dec 2016 10:12:55 +0100
Message-Id: <1481274775-32373-1-git-send-email-horms@verge.net.au>
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
Cc: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>

Header files should be added to the distribution but not
used to derive targets for compilation. In this an attempt was
made to build iomem.o, but iomem.c does not exist so this fails.

Fixes: 1574ff1aae4f ("arm: include phys_to_virt.h and iomem.h in distribution")
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/arm/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 871979e0ae26..a1b730034de8 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -27,9 +27,9 @@ arm_KEXEC_SRCS += $(libfdt_SRCS)
 
 arm_UIMAGE = kexec/kexec-uImage.c
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
-arm_PHYS_TO_VIRT += kexec/arch/arm/iomem.h
-arm_PHYS_TO_VIRT += kexec/arch/arm/phys_to_virt.h
+arm_PHYS_TO_VIRT_INCLUDE = kexec/arch/arm/iomem.h
+arm_PHYS_TO_VIRT_INCLUDE += kexec/arch/arm/phys_to_virt.h
 
 dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
-	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\
-	kexec/arch/arm/include/arch/options.h
+	$(arm_PHYS_TO_VIRT_INCLUDE) kexec/arch/arm/crashdump-arm.h \
+	kexec/arch/arm/kexec-arm.h kexec/arch/arm/include/arch/options.h
-- 
2.7.0.rc3.207.g0ac5344


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
