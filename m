Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQTkL-0001Hw-3h
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 03:34:22 +0000
Date: Thu, 20 Mar 2014 11:34:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/2] kexec: pass initrd position in dtb
Message-ID: <20140320033459.GC4722@dhcp-16-126.nay.redhat.com>
References: <1395282993-37549-1-git-send-email-wangnan0@huawei.com>
 <1395282993-37549-3-git-send-email-wangnan0@huawei.com>
 <20140320032645.GB4722@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140320032645.GB4722@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 03/20/14 at 11:26am, Dave Young wrote:
> On 03/20/14 at 10:36am, Wang Nan wrote:
> > This patch append the position of initrd to dtb when loading arm kernel
> > and initrd without using atag.
> > 
> > Signed-off-by: Wang Nan <wangnan0@huawei.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Geng Hui <hui.geng@huawei.com>
> > ---
> >  kexec/arch/arm/kexec-zImage-arm.c | 84 +++++++++++++++++++++++++++------------
> >  1 file changed, 59 insertions(+), 25 deletions(-)
> > 
> > diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> > index 8a35018..15d8829 100644
> > --- a/kexec/arch/arm/kexec-zImage-arm.c
> > +++ b/kexec/arch/arm/kexec-zImage-arm.c
> > @@ -20,6 +20,7 @@
> >  #include "kexec-arm.h"
> >  #include "../../fs2dt.h"
> >  #include "crashdump-arm.h"
> > +#include "libfdt_internal.h"
> 
> I guess it's for the FDT_TAGALIGN and FDT_TAGSIZE?
> libfdt_internal.h should be used as internal header for libfdt, a better way is
> adding another patch which move these 2 macros to fdt.h

Or moving your new function setup_dtb_prop to libfdt, I'm not sure if it works on
other arch though.

> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
