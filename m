Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iD4fF-0006cR-Po
 for kexec@lists.infradead.org; Wed, 25 Sep 2019 10:36:56 +0000
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0269E81DE0
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2019 10:36:49 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id a8so8601113ios.5
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2019 03:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151341.14986-1-kasong@redhat.com>
 <20190910151341.14986-3-kasong@redhat.com>
 <20190911055618.GA104115@gmail.com>
In-Reply-To: <20190911055618.GA104115@gmail.com>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 25 Sep 2019 18:36:36 +0800
Message-ID: <CACPcB9eZUZ1fCsc1GZs9MJnoqLK9Ld5KEx0_emx8J44Mjcy3WA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV is
 active
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
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On Wed, Sep 11, 2019 at 1:56 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Kairui Song <kasong@redhat.com> wrote:
>
> > Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> > SWIOTLB will be enabled even if there is less than 4G of memory when SME
> > is active, to support DMA of devices that not support address with the
> > encrypt bit.
> >
> > And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> > active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> >
> > Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> > encryption") will always force SWIOTLB to be enabled when SEV is active
> > in all cases.
> >
> > Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> > and this is also true for kdump kernel. As a result kdump kernel will
> > run out of already scarce pre-reserved memory easily.
> >
> > So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> > kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> > is specified or any offset is used. As for the high reservation case, an
> > extra low memory region will always be reserved and that is enough for
> > SWIOTLB. Else if the offset format is used, user should be fully aware
> > of any possible kdump kernel memory requirement and have to organize the
> > memory usage carefully.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  arch/x86/kernel/setup.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 71f20bb18cb0..ee6a2f1e2226 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> >                                         unsigned long long *crash_size,
> >                                         bool high)
> >  {
> > -     unsigned long long base, size;
> > +     unsigned long long base, size, mem_enc_req = 0;
> >
> >       base = *crash_base;
> >       size = *crash_size;
> > @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> >       if (high)
> >               goto high_reserve;
> >
> > +     /*
> > +      * When SME/SEV is active and not using high reserve,
> > +      * it will always required an extra SWIOTLB region.
> > +      */
> > +     if (mem_encrypt_active())
> > +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> > +
> >       base = memblock_find_in_range(CRASH_ALIGN,
> > -                                   CRASH_ADDR_LOW_MAX, size,
> > +                                   CRASH_ADDR_LOW_MAX,
> > +                                   size + mem_enc_req,
> >                                     CRASH_ALIGN);
>

Hi Ingo,

I re-read my previous reply, it's long and tedious, let me try to make
a more effective reply:

> What sizes are we talking about here?

The size here is how much memory will be reserved for kdump kernel, to
ensure kdump kernel and userspace can run without OOM.

>
> - What is the possible size range of swiotlb_size_or_default()

swiotlb_size_or_default() returns the swiotlb size, it's specified by
user using swiotlb=<size>, or default size (64MB)

>
> - What is the size of CRASH_ADDR_LOW_MAX (the old limit)?

It's 4G.

>
> - Why do we replace one fixed limit with another fixed limit instead of
>   accurately sizing the area, with each required feature adding its own
>   requirement to the reservation size?

It's quite hard to "accurately sizing the area".

No way to tell the exact amount of memory kdump needs, we can only estimate.
Kdump kernel use different cmdline, drivers and components will have
special handling for kdump, and userspace is totally different.

>
> I.e. please engineer this into a proper solution instead of just
> modifying it around the edges.
>
> For example have you considered adding some sort of
> kdump_memory_reserve(size) facility, which increases the reservation size
> as something like SWIOTLB gets activated? That would avoid the ugly
> mem_encrypt_active() flag, it would just automagically work.

My first attempt is increase crashkernel memory as swiotlb is
activated. There are problems.

First, SME/SEV is currently the only case that both kernel require
SWIOTLB, for most other case, it's wasting memory.

If we don't care about the memory waste, it has to check/reserve/free
crashkernel memory at three different points:
1. Early boot:
    - crash kernel reserved a region as usual.
2. Right before memblock freeing memoy:
    - If SWIOTLB is activated, crash kernel should reserve another region.
3. After Initcalls:
    - SWIOTLB may get deactivated by initcalls, so need to do a later
check for if we need to release the later reserved region.
It's more complex.

And about a "kdump_memory_reserve(size)" facility, as talked above,
it's hard to know how much kdump needs for now, also hard to find any
user of this.

Please let me know if I failed to make something clear or have any
misunderstanding.

>
> Thanks,
>
>         Ingo



--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
