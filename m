Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtQj6-0002PL-Au
 for kexec@lists.infradead.org; Tue, 12 Feb 2019 05:35:25 +0000
Received: by mail-it1-x142.google.com with SMTP id i145so4308314ita.4
 for <kexec@lists.infradead.org>; Mon, 11 Feb 2019 21:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 12 Feb 2019 13:35:11 +0800
Message-ID: <CAFgQCTv0gkXpvJ6U+RztfVe+eL=5nL+=_TVaNV0VozX_dKtrWQ@mail.gmail.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com

On Tue, Feb 12, 2019 at 4:48 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 02/06/19 at 08:08pm, Dave Young wrote:
> > On 02/05/19 at 09:15am, Borislav Petkov wrote:
> > > On Mon, Feb 04, 2019 at 03:30:16PM -0700, Jerry Hoemann wrote:
> > > > Is your objection only to the second fallback of allocating
> > > > memory above >= 4GB?   Or are you objecting to allocating from
> > > > (896 .. 4GB) as well?
> > >
> > > My problem is why should the user need to specify high or low allocation
> > > explicitly when we can handle all that in the kernel automatically.
> > >
> > > The presence of crashkernel= on the cmdline sure means that the user
> > > wants to allocate memory for a second kernel.
> > >
> > > Now, if the requested allocation fails, we say:
> > >
> > >   Error reserving crashkernel
> > >
> > > So, instead of saying that, we can *try* *again* and say
> > >
> > >   Error reserving requested crashkernel at @..., attempting a high range.
> > >
> > > and run memblock_find_in_range() on the other regions which we deemed
> > > are ok to allocate from.
> > >
> > > Why aren't we doing that by default instead of placing all those
> > > different options in front of the user and expecting her/him to know
> > > something about all those magic ranges?
> >
> > As we talked in another reply, for the >4G allocation we can not avoid
> > the swiotlb issue,  but if one request for 256M in high region and we
> > allocate the low part automatically, it will eat more memory eg. 512M.
> >
> > But probably in case allacation failed in low region ,high is a must for kdump
> > reservation, since no other choices perhaps we can make that as you said
>
> That is exactly what Pingfan is doing in this patch.
>
> Even we make it automatic in kernel, but we have to have some default
> value for swiotlb in case crashkernel can not find a free region under 4G.
> So this default value can not work for every use cases, people need
> manually use crashkernel=,low and crashkernel=,high in case
> crashkernel=X does not work.  One can tune it for their use:
>
> 1) crashkernel=X reservation fails, likely the ,low default value is
> still too big, one can shrink the value and manually try other value
> 2) crashkernel=X reserve successfully on high memory and along with some
> default low memory region. But the low region is not enough.  In this
> case one can increase the
>
> This should answer the question why ,high and ,low is still needed.
>
> But for above consumption 1),  KASLR can still cause default ,low memory
> failed to reserve.  So I wonder if KASLR can skip the 0-896M if the
> system memory is big enough.
>
A little fix about the comment. Refer to reserve_crashkernel_low(),
low_base = memblock_find_in_range(0, 1ULL << 32, low_size,
CRASH_ALIGN); So it should try 0~4G for ",low". And the default size
for low is 256M. Given the limited memory region reserved by other
component before crashkernel, we always can find a continuous chunk of
256M inside the fragmented [0,4G], which is split by initrd, KASLR.

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
