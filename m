Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bX1vT-0001YV-BI
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 07:58:15 +0000
Date: Tue, 9 Aug 2016 15:57:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.13
Message-ID: <20160809075747.GA19066@dhcp-128-65.nay.redhat.com>
References: <20160808103434.GF17838@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160808103434.GF17838@verge.net.au>
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
Cc: kexec@lists.infradead.org

Hi, Simon

On 08/08/16 at 12:34pm, Simon Horman wrote:
> Hi all,
> 
> I am happy to announce the release of kexec-tools 2.0.13.
> 
> This is a feature release coinciding with the release of the v4.7 Linux Kernel[*].
> 
> This release can be downloaded from kernel.org:
> 
> 	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.13.tar.xz

The tarball can not build on armv7, below patch should fix it:
--
kexec-tools armv7 build fix

armv7 build failed as below:

kexec/arch/arm/phys_to_virt.c:3:26: fatal error: phys_to_virt.h: No such file or directory
 #include "phys_to_virt.h"
                          ^
Ditto for kexec/arch/arm/iomem.h

Add them to dist make target to fix it.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/arm/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- kexec-tools.orig/kexec/arch/arm/Makefile
+++ kexec-tools/kexec/arch/arm/Makefile
@@ -27,6 +27,8 @@ arm_KEXEC_SRCS += $(libfdt_SRCS)
 
 arm_UIMAGE = kexec/kexec-uImage.c
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
+arm_PHYS_TO_VIRT += kexec/arch/arm/iomem.h
+arm_PHYS_TO_VIRT += kexec/arch/arm/phys_to_virt.h
 
 dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
 	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
