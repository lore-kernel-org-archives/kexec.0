Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hyM3y-0003he-HQ
 for kexec@lists.infradead.org; Thu, 15 Aug 2019 20:09:37 +0000
Received: by mail-ed1-x543.google.com with SMTP id f22so3217975edt.4
 for <kexec@lists.infradead.org>; Thu, 15 Aug 2019 13:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
 <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com>
In-Reply-To: <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 15 Aug 2019 16:09:19 -0400
Message-ID: <CA+CK2bAqBi43Cchr=md7EPRuEWH-iuToK0PxN3ysSBQ42Hd0-g@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
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
To: James Morse <james.morse@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi James,

Thank you for your feedback. My replies below:

> > Also, I'd appreciate if anyone could test this series on vhe hardware
> > with vhe kernel, it does not look like QEMU can emulate it yet
>
> This locks up during resume from hibernate on my AMD Seattle, a regular v8.0 machine.

Thanks for reporting a bug I will root cause and fix it.

> Please try and build the series to reduce review time. What you have here is an all-new
> page-table generation API, which you switch hibernate and kexec too. This is effectively a
> new implementation of hibernate and kexec. There are three things here that need review.
>
> You have a regression in your all-new implementation of hibernate. It took six months (and
> lots of review) to get the existing code right, please don't rip it out if there is
> nothing wrong with it.

> Instead, please just move the hibernate copy_page_tables() code, and then wire kexec up.
> You shouldn't need to change anything in the copy_page_tables() code as the linear map is
> the same in both cases.

It is not really an all-new implementation of hibernate (for kexec it
is true though). I used the current implementation of hibernate as
bases, and simply generalized the functions by providing a flexible
interface. So what you are asking is actually exactly what I am doing.
I realize, that I introduced a bug that I will fix.

> It looks like you are creating the page tables just after the kexec:segments have been
> loaded. This will go horribly wrong if anything changes between then and kexec time. (e.g.
> memory you've got mapped gets hot-removed).
> This needs to be done as late as possible, so we don't waste memory, and the world can't
> change around us. Reboot notifiers run before kexec, can't we do the memory-allocation there?

Kexec by design does not allow allocate during kexec time. This is
because we cannot fail during kexec syscall. All allocations must be
done during kexec load time. Kernel memory cannot be hot-removed, as
it is not part of ZONE_MOVABLE, and cannot be migrated.

The current implementation relies on this assumption as well: during
load time the (struct kimage) -> head contains the physical addresses
of sources and destinations. If sources can be moved, this array will
be broken.


> >> Previously:
> >> kernel shutdown 0.022131328s
> >> relocation      0.440510736s
> >> kernel startup  0.294706768s
> >>
> >> Relocation was taking: 58.2% of reboot time
> >>
> >> Now:
> >> kernel shutdown 0.032066576s
> >> relocation      0.022158152s
> >> kernel startup  0.296055880s
> >>
> >> Now: Relocation takes 6.3% of reboot time
> >>
> >> Total reboot is x2.16 times faster.
>
> When I first saw these numbers they were ~'0.29s', which I wrongly assumed was 29 seconds.
> Savings in milliseconds, for _reboot_ is a hard sell. I'm hoping that on the machines that
> take minutes to kexec we'll get numbers that make this change more convincing.

Sure, this userland is very small kernel+userland is only 47M. Here is
another data point: fitImage: 380M, it contains a larger userland.
The numbers for kernel shutdown and startup are the same as this is
the same kernel, but relocation takes: 3.58s

shutdown: 0.02s
relocation: 3.58s
startup:  0.30s

Relocation take 88% of reboot time. And, we must have it under one second.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
