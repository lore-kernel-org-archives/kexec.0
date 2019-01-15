Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjJhG-0007CP-FK
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 08:03:44 +0000
Received: by mail-it1-x142.google.com with SMTP id g76so3728063itg.2
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 00:03:39 -0800 (PST)
MIME-Version: 1.0
References: <1547435711-5786-1-git-send-email-kernelfans@gmail.com>
 <8206281c-c4e6-278a-899b-27cf9affd0da@infradead.org>
In-Reply-To: <8206281c-c4e6-278a-899b-27cf9affd0da@infradead.org>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 15 Jan 2019 16:03:28 +0800
Message-ID: <CAFgQCTv2P7vPDweK=yj3M2o-vV8x_CMdzASKHV60uioz9A-mKg@mail.gmail.com>
Subject: Re: [PATCHv6] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Baoquan He <bhe@redhat.com>, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Mon, Jan 14, 2019 at 12:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> Just fix a few of the commit log comments...
>
> On 1/13/19 7:15 PM, Pingfan Liu wrote:
> > People reported a bug on a high end server with many pcie devices, where
> > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > though we still see much memory under 896 MB, the finding still failed
> > intermittently. Because currently we can only find region under 896 MB,
> > if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
>
>   if w/o
> or preferably:
>   if without
>
> > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > why failure is found. It raises confusion to the end user that sometimes
> > crashkernel=X works while sometimes fails.
> > If want to make it succeed, customer can change kernel option to
> > "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
>
> no space?  just
>   "crashkernel=384M,high"
>
> > limited space to behave even though its grammer looks more generic.
>
>                                           grammar
>
Thanks for your review, will cc you in next version.

Regards,
Pingfan
> > And we can't answer questions raised from customer that confidently:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> > This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
> > finally above 4G.
> > Dave Young sent the original post, and I just re-post it with commit log
> > improvement as his requirement.
> > http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > There was an old discussion below (previously posted by Chao Wang):
> > https://lkml.org/lkml/2013/10/15/601
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > ---
> > v5 -> v6
> >   discard bottom-up allocation, just repost dyoung's original patch with commit log improved
> > ---
> >  arch/x86/kernel/setup.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3d872a5..fa62c81 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
> >                                                   high ? CRASH_ADDR_HIGH_MAX
> >                                                        : CRASH_ADDR_LOW_MAX,
> >                                                   crash_size, CRASH_ALIGN);
> > +#ifdef CONFIG_X86_64
> > +             /*
> > +              * crashkernel=X reserve below 896M fails? Try below 4G
> > +              */
> > +             if (!high && !crash_base)
> > +                     crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +                                             (1ULL << 32),
> > +                                             crash_size, CRASH_ALIGN);
> > +             /*
> > +              * crashkernel=X reserve below 4G fails? Try MAXMEM
> > +              */
> > +             if (!high && !crash_base)
> > +                     crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +                                             CRASH_ADDR_HIGH_MAX,
> > +                                             crash_size, CRASH_ALIGN);
> > +#endif
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> >
>
> ciao.
> --
> ~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
