Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VagYK-0004f5-Ee
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 06:43:53 +0000
Date: Mon, 28 Oct 2013 14:43:15 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
Message-ID: <20131028064315.GC3033@dhcp16-109.nay.redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
 <CAE9FiQWC43b9ptv3=9cth_cPWYaCZ8aCuTdO5is_ESpiFajQTw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQWC43b9ptv3=9cth_cPWYaCZ8aCuTdO5is_ESpiFajQTw@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jacob Shin <jacob.shin@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On 10/24/13 at 12:04pm, Yinghai Lu wrote:
> On Mon, Oct 14, 2013 at 4:46 AM, WANG Chao <chaowang@redhat.com> wrote:
> > Now crashkernel=X will fail out if there's not enough memory at
> > low (below 896M). What makes sense for crashkernel=X would be:
> >
> >  - First try to reserve X below 896M (for being compatible with old
> >    kexec-tools).
> >  - If fails, try to reserve X below 4G (swiotlb need to stay below 4G).
> >  - If fails, try to reserve X from MAXMEM top down.
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index f0de629..38e6c1f 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -593,6 +593,20 @@ static void __init reserve_crashkernel(void)
> >                                         high ? CRASH_KERNEL_ADDR_HIGH_MAX :
> >                                                CRASH_KERNEL_ADDR_LOW_MAX,
> >                                         crash_size, alignment);
> > +               /*
> > +                * crashkernel=X reserve below 896M fails? Try below 4G
> > +                */
> > +               if (!high && !crash_base)
> > +                       crash_base = memblock_find_in_range(alignment,
> > +                                               (1ULL << 32),
> > +                                               crash_size, alignment);
> 
> Another problem, it would allocate range in [0,4g) for 32bit,
> if the user have crashkernel=512M or plus.

Yes, should use #ifdef CONFIG_X86_64 .. #endif.
Thanks for pointing this out.

WANG Chao

> 
> > +               /*
> > +                * crashkernel=X reserve below 4G fails? Try MAXMEM
> > +                */
> > +               if (!high && !crash_base)
> > +                       crash_base = memblock_find_in_range(alignment,
> > +                                               CRASH_KERNEL_ADDR_HIGH_MAX,
> > +                                               crash_size, alignment);
> >
> >                 if (!crash_base) {
> >                         pr_info("crashkernel reservation failed - No suitable area found.\n");
> 
> 
> Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
