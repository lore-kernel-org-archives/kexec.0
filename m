Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMT2-00089N-GH
 for kexec@lists.infradead.org; Wed, 20 Feb 2019 07:38:57 +0000
Received: by mail-it1-x143.google.com with SMTP id z124so13324778itc.2
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2019 23:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 20 Feb 2019 15:38:43 +0800
Message-ID: <CAFgQCTu7pS=f2NgNvUgWaSt0hQ=KOZJXjBxktLi4PBkuXwvDFA@mail.gmail.com>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, Baoquan He <bhe@redhat.com>, konrad.wilk@oracle.com, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com

On Mon, Feb 18, 2019 at 9:48 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 02/15/19 at 11:24am, Borislav Petkov wrote:
> > On Tue, Feb 12, 2019 at 04:48:16AM +0800, Dave Young wrote:
> > > Even we make it automatic in kernel, but we have to have some default
> > > value for swiotlb in case crashkernel can not find a free region under 4G.
> > > So this default value can not work for every use cases, people need
> > > manually use crashkernel=,low and crashkernel=,high in case
> > > crashkernel=X does not work.
> >
> > Why would the user need to find swiotlb range? The kernel has all the
> > information it requires at its finger tips in order to decide properly.
> >
> > The user wants a crashkernel range, the kernel tries the low range =>
> > no workie, then it tries the next range => workie but needs to allocate
> > swiotlb range so that DMA can happen too. Doh, then the kernel does
> > allocate that too.
>
> It is ideal if kernel can do it automatically, but I'm not sure if
> kernel can predict the swiotlb reserved size automatically.
>
Agreed, I think it is hard to decide the reserved size automatically.
We do not know the requirement for memory of ZONE_DMA32 at boot time.
The requirement depends on how many DMA32 devices, and the dynamic
payload of them.

> Let's add more people to seek for comments.
>
> >
> > Why would the user need to do anything here?!
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
