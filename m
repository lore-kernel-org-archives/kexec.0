Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKQTF-0006tP-Uh
 for kexec@lists.infradead.org; Tue, 15 Oct 2019 17:18:56 +0000
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 853F72D7E1
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2019 17:18:52 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id w8so33086082iol.20
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2019 10:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151341.14986-1-kasong@redhat.com>
 <20190910151341.14986-3-kasong@redhat.com>
 <20190911055618.GA104115@gmail.com>
 <CACPcB9eZUZ1fCsc1GZs9MJnoqLK9Ld5KEx0_emx8J44Mjcy3WA@mail.gmail.com>
 <20190927054208.GA13426@dhcp-128-65.nay.redhat.com>
 <3e1f65de-4539-736e-a7b4-3c726a001f4b@redhat.com>
 <20191014110504.GA16271@dhcp-128-65.nay.redhat.com>
 <20191015021848.GA18043@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20191015021848.GA18043@dhcp-128-65.nay.redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 16 Oct 2019 01:18:40 +0800
Message-ID: <CACPcB9dXYgJ3YqFNTi3sf0Ym8Ux47p-m3DXGpg=jtuq7070eAw@mail.gmail.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>

 thiOn Tue, Oct 15, 2019 at 10:18 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 10/14/19 at 07:05pm, Dave Young wrote:
> > On 10/12/19 at 05:24pm, Kairui Song wrote:
> > > On 9/27/19 1:42 PM, Dave Young wrote:
> > > > On 09/25/19 at 06:36pm, Kairui Song wrote:
> > > > > On Wed, Sep 11, 2019 at 1:56 PM Ingo Molnar <mingo@kernel.org> wrote:
> > > > > > * Kairui Song <kasong@redhat.com> wrote:
> > > > > >
> > > > > > > Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> > > > > > > SWIOTLB will be enabled even if there is less than 4G of memory when SME
> > > > > > > is active, to support DMA of devices that not support address with the
> > > > > > > encrypt bit.
> > > > > > >
> > > > > > > And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> > > > > > > active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> > > > > > >
> > > > > > > Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> > > > > > > encryption") will always force SWIOTLB to be enabled when SEV is active
> > > > > > > in all cases.
> > > > > > >
> > > > > > > Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> > > > > > > and this is also true for kdump kernel. As a result kdump kernel will
> > > > > > > run out of already scarce pre-reserved memory easily.
> > > > > > >
> > > > > > > So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> > > > > > > kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> > > > > > > is specified or any offset is used. As for the high reservation case, an
> > > > > > > extra low memory region will always be reserved and that is enough for
> > > > > > > SWIOTLB. Else if the offset format is used, user should be fully aware
> > > > > > > of any possible kdump kernel memory requirement and have to organize the
> > > > > > > memory usage carefully.
> > > > > > >
> > > > > > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > > > > > ---
> > > > > > >   arch/x86/kernel/setup.c | 20 +++++++++++++++++---
> > > > > > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > > > > index 71f20bb18cb0..ee6a2f1e2226 100644
> > > > > > > --- a/arch/x86/kernel/setup.c
> > > > > > > +++ b/arch/x86/kernel/setup.c
> > > > > > > @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> > > > > > >                                          unsigned long long *crash_size,
> > > > > > >                                          bool high)
> > > > > > >   {
> > > > > > > -     unsigned long long base, size;
> > > > > > > +     unsigned long long base, size, mem_enc_req = 0;
> > > > > > >
> > > > > > >        base = *crash_base;
> > > > > > >        size = *crash_size;
> > > > > > > @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> > > > > > >        if (high)
> > > > > > >                goto high_reserve;
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * When SME/SEV is active and not using high reserve,
> > > > > > > +      * it will always required an extra SWIOTLB region.
> > > > > > > +      */
> > > > > > > +     if (mem_encrypt_active())
> > > > > > > +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> > > > > > > +
> > > > > > >        base = memblock_find_in_range(CRASH_ALIGN,
> > > > > > > -                                   CRASH_ADDR_LOW_MAX, size,
> > > > > > > +                                   CRASH_ADDR_LOW_MAX,
> > > > > > > +                                   size + mem_enc_req,
> > > > > > >                                      CRASH_ALIGN);
> > > > > >
> > > > >
> > > > > Hi Ingo,
> > > > >
> > > > > I re-read my previous reply, it's long and tedious, let me try to make
> > > > > a more effective reply:
> > > > >
> > > > > > What sizes are we talking about here?
> > > > >
> > > > > The size here is how much memory will be reserved for kdump kernel, to
> > > > > ensure kdump kernel and userspace can run without OOM.
> > > > >
> > > > > >
> > > > > > - What is the possible size range of swiotlb_size_or_default()
> > > > >
> > > > > swiotlb_size_or_default() returns the swiotlb size, it's specified by
> > > > > user using swiotlb=<size>, or default size (64MB)
> > > > >
> > > > > >
> > > > > > - What is the size of CRASH_ADDR_LOW_MAX (the old limit)?
> > > > >
> > > > > It's 4G.
> > > > >
> > > > > >
> > > > > > - Why do we replace one fixed limit with another fixed limit instead of
> > > > > >    accurately sizing the area, with each required feature adding its own
> > > > > >    requirement to the reservation size?
> > > > >
> > > > > It's quite hard to "accurately sizing the area".
> > > > >
> > > > > No way to tell the exact amount of memory kdump needs, we can only estimate.
> > > > > Kdump kernel use different cmdline, drivers and components will have
> > > > > special handling for kdump, and userspace is totally different.
> > > >
> > > > Agreed about your above, but specific this the problem in this patch
> > > > There should be other ways.
> > > >
> > > > First thought about doing generic handling in swiotlb part, and do
> > > > something like kdump_memory_reserve(size) Ingo suggested,  but according
> > > > to you swiotlb init is late, so it can not increase the size, OTOH if
> > > > reserve another region for kdump in swiotlb will cause other issues.
> > > >
> > > > So let's think about other improvement, for example to see if you can
> > > > call kdump_memory_reserve(size) in AMD SME init path, for example in
> > > > mem_encrypt_init(), is it before crashkernel reservation?
> > > >
> > > > If doable it will be at least cleaner than the code in this patch.
> > > >
> > > > Thanks
> > > > Dave
> > > >
> > >
> > > How about something simple as following code? The logic and new function is as simple as
> > > possible, just always reserve extra low memory when SME/SEV is active, ignore the high/low
> > > reservation case. It will waste some memory with SME and high reservation though.
> > >
> > > Was hesitating a lot about this series, one thing I'm thinking is that what is the point
> > > of "crashkernel=" argument, if the crashkernel value could be adjusted according, the value
> > > specified will seems more meanless or confusing...
> > >
> > > And currently there isn't anything like crashkernel=auto or anything similiar to let kernel
> > > calculate the value automatically, maybe the admin should be aware of the value or be informed
> > > about the suitable crashkernel value after all?
> >
> > Hmm, it is reasonable that a user defined value should be just as is
> > without any change by kernel.  So it is a good reason to introduce
> > a crashkernel=auto so that kernel can tune the crashkernel size
> > accordingly on top of some base value which can be configurable by
> > kernel configs (arch dependent).
> >
>
> And for the time being, can just print a warning when crashkernel= param
> is used, in mem_encrypt_init() code. alert people to increase the memory
> size swiotlb_size_or_default().

Good suggestion,  it will be much more reasonable if kernel only adjust the
crashekernel value when crashkernel=auto is used. For now, I think giving a
warning could be a better solution.

> In the future, if the crashkernel=auto is doable then kernel can adapt
> to that in code.  Even if it is reasonable to let admin to provide a
> exact value but sometimes it is hard to know these kernel requirement
> details..
>

Yes, and the crashkernel=auto could be more helpful with some infrastructure
for add extra kdump memory.

Let crashkernel=auto have a configurable basic size, and each component could
call kdump_memory_reserve to add to the basic size. (Like SME/SEV case here)

And currently I'm doing some experiment to reserve some pages from buddy
as the crash memory. So kernel can try reserve extra memory for kdump kernel
anytime, userspace can also tell kernel to reserve more crash memory.

If everything goes well, this may make the auto reservation even better.

crashkernel=auto just need to provide a more generic value that's enough to
contain the kernel image, initramfs, swiotlb, early boot memory, etc..
(all the continual things), plus some basic value to fits most default
kdump setups.

Extra usage could be estimated by userspace and added later.
Userspace is more aware of what service/module might be used for kdump
and can be more accurate.

This may provide a better 'auto' crashkernel solution.

--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
