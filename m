Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goMJS-0006a5-8L
 for kexec@lists.infradead.org; Tue, 29 Jan 2019 05:52:09 +0000
Received: by mail-it1-x144.google.com with SMTP id a6so2285550itl.4
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2019 21:51:57 -0800 (PST)
MIME-Version: 1.0
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
In-Reply-To: <20190125103924.GB27998@zn.tnic>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 29 Jan 2019 13:51:45 +0800
Message-ID: <CAFgQCTtrBrt9CEY=3YiVm7ADD+8oh8bYmatu=3vU92K2_C45ww@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
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
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com

On Fri, Jan 25, 2019 at 6:39 PM Borislav Petkov <bp@alien8.de> wrote:
>
>
> >  Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
>
> s/bugfix, //
>
OK.

> On Mon, Jan 21, 2019 at 01:16:08PM +0800, Pingfan Liu wrote:
> > People reported crashkernel=384M reservation failed on a high end server
> > with KASLR enabled.  In that case there is enough free memory under 896M
> > but crashkernel reservation still fails intermittently.
> >
> > The situation is crashkernel reservation code only finds free region under
> > 896 MB with 128M aligned in case no ',high' being used.  And KASLR could
> > break the first 896M into several parts randomly thus the failure happens.
>
> This reads very strange.
>
What about   "  It turns out that crashkernel reservation code only
tries to find a region under 896 MB, aligned on 128M. But KASLR
randomly breaks big region inside [0,896M] into smaller pieces, not
big enough as demanded in the "crashkernel=X" parameter."

> > User has no way to predict and make sure crashkernel=xM working unless
> > he/she use 'crashkernel=xM,high'.  Since 'crashkernel=xM' is the most
> > common use case this issue is a serious bug.
> >
> > And we can't answer questions raised from customer:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
>
> Errr, this looks like communication issue. Sounds to me like the text
> around crashkernel= in
>
What about dropping this section in commit log and another patch to
fix the document?

> Documentation/admin-guide/kernel-parameters.txt
>
> needs improving?
>
> > This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
OK

> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.
>
> > finally above 4G.
> >
> > Dave Young sent the original post, and I just re-post it with commit log
>
> If he sent it, he should be the author I guess.
>
> > improvement as his requirement.
> > http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > There was an old discussion below (previously posted by Chao Wang):
> > https://lkml.org/lkml/2013/10/15/601
>
> All that changelog info doesn't belong in the commit message ...
>
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
>
> .... but here.
>
> > v6 -> v7: commit log improvement
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
>
> Ok, so this is silly: we know at which physical address KASLR allocated
> the kernel so why aren't we querying that and seeing if there's enough
> room before it or after it to call memblock_find_in_range() on the
> bigger range?
>
Sorry, can not catch up with you. Do you suggestion
memblock_find_in_range(0, kernel_start) and
memblock_find_in_range(kernel_end, mem_end)? But the memory is
truncated into fraction by many component which call
memblock_reserve(), besides kernel.

For the left question, Dave has follow the discussion in another
email, will follow there.

Thanks and regards,
Pingfan

> Also, why is "high" dealt with separately and why isn't the code
> enforcing "high" if the normal reservation fails?
>
> The presence of high is requiring from our users to pay attention what
> to use when the kernel can do all that automatically. Looks like a UI
> fail to me.
>
> And look at all the flavors of crashkernel= :
>
>         crashkernel=size[KMG][@offset[KMG]]
>         crashkernel=range1:size1[,range2:size2,...][@offset]
>         crashkernel=size[KMG],high
>         crashkernel=size[KMG],low
>
> We couldn't do one so we made 4?!?!
>
> What for?
>
> Nowhere in that help text does it explain why a user would care about
> high or low or range or offset or the planets alignment...
>
> So what's up?
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
