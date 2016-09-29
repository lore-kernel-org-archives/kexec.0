Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpWHk-0003qy-VC
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 08:01:45 +0000
Date: Thu, 29 Sep 2016 10:01:16 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.13
Message-ID: <20160929080116.GG14497@verge.net.au>
References: <20160808103434.GF17838@verge.net.au>
 <20160809075747.GA19066@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160809075747.GA19066@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

Hi Dave,

On Tue, Aug 09, 2016 at 03:57:47PM +0800, Dave Young wrote:
> Hi, Simon
> 
> On 08/08/16 at 12:34pm, Simon Horman wrote:
> > Hi all,
> > 
> > I am happy to announce the release of kexec-tools 2.0.13.
> > 
> > This is a feature release coinciding with the release of the v4.7 Linux Kernel[*].
> > 
> > This release can be downloaded from kernel.org:
> > 
> > 	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.13.tar.xz
> 
> The tarball can not build on armv7, below patch should fix it:
> --
> kexec-tools armv7 build fix
> 
> armv7 build failed as below:
> 
> kexec/arch/arm/phys_to_virt.c:3:26: fatal error: phys_to_virt.h: No such file or directory
>  #include "phys_to_virt.h"
>                           ^
> Ditto for kexec/arch/arm/iomem.h
> 
> Add them to dist make target to fix it.

Sorry for letting that slip through and double sorry for not responding
for so long. I have applied the following:

From: Dave Young <dyoung@redhat.com>
Date: Tue, 9 Aug 2016 15:57:47 +0800
Subject: [PATCH] arm: include phys_to_virt.h and iomem.h in distribution

These files are required to build kexec-tools on arm.

Signed-off-by: Dave Young <dyoung@redhat.com>
[simon: added changelog]
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 71db8c32ce13..871979e0ae26 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -27,6 +27,8 @@ arm_KEXEC_SRCS += $(libfdt_SRCS)
 
 arm_UIMAGE = kexec/kexec-uImage.c
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
+arm_PHYS_TO_VIRT += kexec/arch/arm/iomem.h
+arm_PHYS_TO_VIRT += kexec/arch/arm/phys_to_virt.h
 
 dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
 	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\
-- 
2.7.0.rc3.207.g0ac5344



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
