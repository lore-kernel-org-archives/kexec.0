Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCxQK-0002GT-9n
 for kexec@lists.infradead.org; Fri, 19 Feb 2021 04:29:49 +0000
Received: by mail-wm1-f48.google.com with SMTP id a207so5990949wmd.1
 for <kexec@lists.infradead.org>; Thu, 18 Feb 2021 20:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20210205081559.15956-1-fede@evolware.org>
 <20210207080013.GA7015@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20210207080013.GA7015@dhcp-128-65.nay.redhat.com>
From: Federico Pellegrin <fede@evolware.org>
Date: Fri, 19 Feb 2021 05:29:34 +0100
Message-ID: <CAM6O0ZgDLLUmdwirHks_+LZV_sBSuhLCxikgzgw9v7z3g3c04Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] kexec-tools: fix build on pre 4.4 kernels
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
Cc: kexec@lists.infradead.org, kasong@redhat.com

Hi,
Just trying my luck with a "ping", if someone could evaluate if the
patch seems correct and/or eventually merge.

Many thanks!
Federico


Il giorno dom 7 feb 2021 alle ore 09:00 Dave Young <dyoung@redhat.com>
ha scritto:
>
> Added Kairui in cc since he contributed that part
> On 02/05/21 at 09:15am, Federico Pellegrin wrote:
> > kexec build will fail on older kernels (pre 4.4) as the define
> > VIDEO_CAPABILITY_64BIT_BASE was not present at that time.
> >
> > This patch adds it, as per linux/include/uapi/linux/screen_info.h,
> > if not present.
> >
> > Signed-off-by: Federico Pellegrin <fede@evolware.org>
> > ---
> >  kexec/arch/i386/x86-linux-setup.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> > index 76e1185..ab54a4a 100644
> > --- a/kexec/arch/i386/x86-linux-setup.c
> > +++ b/kexec/arch/i386/x86-linux-setup.c
> > @@ -37,6 +37,10 @@
> >  #include "x86-linux-setup.h"
> >  #include "../../kexec/kexec-syscall.h"
> >
> > +#ifndef VIDEO_CAPABILITY_64BIT_BASE
> > +#define VIDEO_CAPABILITY_64BIT_BASE (1 << 1) /* Frame buffer base is 64-bit */
> > +#endif
> > +
> >  void init_linux_parameters(struct x86_linux_param_header *real_mode)
> >  {
> >       /* Fill in the values that are usually provided by the kernel. */
> > --
> > 2.26.2
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> >
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
