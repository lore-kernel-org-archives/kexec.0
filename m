Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f194.google.com ([209.85.166.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtpm-0004Yi-B4
 for kexec@lists.infradead.org; Sun, 24 Feb 2019 13:28:48 +0000
Received: by mail-it1-f194.google.com with SMTP id z124so9709615itc.2
 for <kexec@lists.infradead.org>; Sun, 24 Feb 2019 05:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de> <20190222130026.GA30766@zn.tnic>
In-Reply-To: <20190222130026.GA30766@zn.tnic>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Sun, 24 Feb 2019 21:25:18 +0800
Message-ID: <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
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
Cc: Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>, konrad.wilk@oracle.com, Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Fri, Feb 22, 2019 at 9:00 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > The current default of 256MB was found by experiments on a bigger
> > number of machines, to create a reasonable default that is at least
> > likely to be sufficient of an average machine.
>
> Exactly, and this is what makes sense.
>
> The code should try the requested reservation and if it fails, it should
> try high allocation with default swiotlb size because we need to reserve
> *some* range.
>
> If that reservation succeeds, we should say something along the lines of
>
> "... requested range failed, reserved <X> range instead."
>
Maybe I misunderstood you, but does "requested range failed" mean that
user specify the range? If yes, then it should be the duty of user as
you said later, not the duty of kernel"

> And then in Documentation/admin-guide/kernel-parameters.txt above the
> crashkernel= explanations, the allocation strategy of best effort should
> be explained in short. That the kernel will try to allocate high if the
> requested allocation didn't succeed and that the user can tweak the
> allocation with the below options.
>
Yes, it should be improved.

> Bottom line is: the kernel should assist the user and try harder to
> allocate *some* range for a crash kernel when there's no detailed
> specification what that range should be.
>
> *If* the user adds ,low, high, then the kernel should try only that
> specified range because the assumption is that the user knows what she's
> doing.
>
> But if the user simply wants a range for a crash kernel without stating
> where that range should be in particular and it's placement is a don't
> care - as long as there is a range - then the kernel should simply try
> high, etc.
>
We do not know the memory layout of a system, maybe a system with
memory less than 4GB. So it is better to try all the range of system
memory

Thanks,
Pingfan

> Makes sense?
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
