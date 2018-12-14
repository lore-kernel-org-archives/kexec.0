Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXeXk-0002vp-PV
 for kexec@lists.infradead.org; Fri, 14 Dec 2018 03:53:42 +0000
Received: by mail-ed1-x541.google.com with SMTP id b14so3833397edt.6
 for <kexec@lists.infradead.org>; Thu, 13 Dec 2018 19:53:27 -0800 (PST)
MIME-Version: 1.0
References: <1544602756-17449-1-git-send-email-kernelfans@gmail.com>
 <20181212090144.GQ17340@MiWiFi-R3L-srv>
In-Reply-To: <20181212090144.GQ17340@MiWiFi-R3L-srv>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 14 Dec 2018 11:53:14 +0800
Message-ID: <CAFgQCTuXnXmhSA7yfszGJ1z6f=K_Rg3_MW=4P+yupJ2BTsAtPw@mail.gmail.com>
Subject: Re: [PATCH] x86/kdump: directly find a candidate region when
 crashkernel=X
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
To: Baoquan He <bhe@redhat.com>
Cc: jroedel@suse.de, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

Hi Baoquan,

Thanks for your kindly review. I will update the commit log to explain
the scenario.

Best regards,
Pingfan
On Wed, Dec 12, 2018 at 5:01 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pingfan,
>
> Thanks for fixing this.
>
> On 12/12/18 at 04:19pm, Pingfan Liu wrote:
> > I encounter a case where crashkernel=384M, and kaslr is enabled. During the
> > test, sometimes, the system may fail to reserve region for crash kernel,
> > although there is much free space above 896MB. It is caused by the
>
> I remember this bug was reported by our customer. They specify
> crashkernel=384MB on a high end server with many pcie devices. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found.
>
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> limited space to behave even though its grammer looks more generic.
> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
>
> > truncation of the candidate region by kaslr kernel. It raises confusion to
> > the end user that sometimes crashkernel=X works while sometimes fails.
> > Since on x86, kaslr is a default option, and this corner case is
> > unavoidable.
> > This patch simplifies the method suggested in the mail [1]. It just goes
> > bottom-up to find a candidate region for crashkernel.
> > There is one trivial thing about the compatibility with old kexec-tools:
> > if the reserved region is above 896M, then old tool will fail to load
> > bzImage. But without this patch, the old tool also fail since there is no
> > memory below 896M can be reserved for crashkernel.
>
> Meanwhile, we set bottom-up to try to reserve crashkernel because we
> still want to get memory region from 896 MB firstly, then [896 MB, 4G],
> finally above 4G. This gives us a chance to be compatible with the old
> reservation style, and this is what we have been doing in redhat
> distros. We may only search [128MB, 4G] only if people mind, just leave
> above 4G reservation to ',high' explicitly.
>
> Thanks
> Baoquan
> >
> > [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: kexec@lists.infradead.org
> >
> > ---
> >  arch/x86/kernel/setup.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index d494b9b..60f12c4 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
> >
> >       /* 0 means: find the address automatically */
> >       if (crash_base <= 0) {
> > +             if (!memblock_bottom_up())
> > +                     memblock_set_bottom_up(true);
> Here maybe change it like below. Just personal opinion, not a big deal,
> not strongly suggested.
>                 bool bottom_up;
>
>                 bottom_up = memblock_bottom_up();
>                 memblock_set_bottom_up(true);
>
> >               /*
> >                * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> >                * as old kexec-tools loads bzImage below that, unless
> >                * "crashkernel=size[KMG],high" is specified.
> >                */
> >               crash_base = memblock_find_in_range(CRASH_ALIGN,
> > -                                                 high ? CRASH_ADDR_HIGH_MAX
> > -                                                      : CRASH_ADDR_LOW_MAX,
> > -                                                 crash_size, CRASH_ALIGN);
> > +                     (max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
>                 memblock_set_bottom_up(bottom_up);
> > +
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > --
> > 2.7.4
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
