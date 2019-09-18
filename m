Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAUod-0003tf-NR
 for kexec@lists.infradead.org; Wed, 18 Sep 2019 07:55:57 +0000
Date: Wed, 18 Sep 2019 15:55:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 0/2] x86/kdump: Reserve extra memory when SME or SEV
 is active
Message-ID: <20190918075546.GA27186@dhcp-128-65.nay.redhat.com>
References: <20190910151341.14986-1-kasong@redhat.com>
 <20190910151341.14986-3-kasong@redhat.com>
 <20190911055618.GA104115@gmail.com>
 <CACPcB9cEE5eYWixkUvMeLVdRC5qhrru9PbjbLLxP3k1jsbRanQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9cEE5eYWixkUvMeLVdRC5qhrru9PbjbLLxP3k1jsbRanQ@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>

On 09/12/19 at 12:23am, Kairui Song wrote:
> On Wednesday, September 11, 2019, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Kairui Song <kasong@redhat.com> wrote:
> >
> >> Since commit c7753208a94c ("x86, swiotlb: Add memory encryption
> support"),
> >> SWIOTLB will be enabled even if there is less than 4G of memory when SME
> >> is active, to support DMA of devices that not support address with the
> >> encrypt bit.
> >>
> >> And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> >> active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> >>
> >> Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> >> encryption") will always force SWIOTLB to be enabled when SEV is active
> >> in all cases.
> >>
> >> Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> >> and this is also true for kdump kernel. As a result kdump kernel will
> >> run out of already scarce pre-reserved memory easily.
> >>
> >> So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> >> kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> >> is specified or any offset is used. As for the high reservation case, an
> >> extra low memory region will always be reserved and that is enough for
> >> SWIOTLB. Else if the offset format is used, user should be fully aware
> >> of any possible kdump kernel memory requirement and have to organize the
> >> memory usage carefully.
> >>
> >> Signed-off-by: Kairui Song <kasong@redhat.com>
> >> ---
> >>  arch/x86/kernel/setup.c | 20 +++++++++++++++++---
> >>  1 file changed, 17 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> index 71f20bb18cb0..ee6a2f1e2226 100644
> >> --- a/arch/x86/kernel/setup.c
> >> +++ b/arch/x86/kernel/setup.c
> >> @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned
> long long *crash_base,
> >>                                         unsigned long long *crash_size,
> >>                                         bool high)
> >>  {
> >> -     unsigned long long base, size;
> >> +     unsigned long long base, size, mem_enc_req = 0;
> >>
> >>       base = *crash_base;
> >>       size = *crash_size;
> >> @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned
> long long *crash_base,
> >>       if (high)
> >>               goto high_reserve;
> >>
> >> +     /*
> >> +      * When SME/SEV is active and not using high reserve,
> >> +      * it will always required an extra SWIOTLB region.
> >> +      */
> >> +     if (mem_encrypt_active())
> >> +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> >> +
> >>       base = memblock_find_in_range(CRASH_ALIGN,
> >> -                                   CRASH_ADDR_LOW_MAX, size,
> >> +                                   CRASH_ADDR_LOW_MAX,
> >> +                                   size + mem_enc_req,
> >>                                     CRASH_ALIGN);
> >
> > What sizes are we talking about here?
> >
> > - What is the possible size range of swiotlb_size_or_default()
> >
> > - What is the size of CRASH_ADDR_LOW_MAX (the old limit)?
> >
> > - Why do we replace one fixed limit with another fixed limit instead of
> >   accurately sizing the area, with each required feature adding its own
> >   requirement to the reservation size?
> >
> > I.e. please engineer this into a proper solution instead of just
> > modifying it around the edges.
> >
> > For example have you considered adding some sort of
> > kdump_memory_reserve(size) facility, which increases the reservation size
> > as something like SWIOTLB gets activated? That would avoid the ugly
> > mem_encrypt_active() flag, it would just automagically work.
> 
> Hi, thanks for the suggestions, actually I did try to workout a better
> resolution, at least for SWIOTLB and crashkernel memory, like make
> crashkernel reserve more memory as SWIOTLB get activated to be more
> flexible and generic.
> 
> There are some problems:
> 
> - Usually, for SWIOTLB, even if the first booting kernel have SWIOTLB
> activated, second kernel will most likely not need it. Currently, only the
> high reservation case will still need SWIOTLB in second kernel, and it's
> already reserving extra low memory automatically. SME/SEV systems is the
> only other special case that will force both kernel to use it.
> 
> - There is a little complex procedure to judge whether SWIOTLB is required
> (Depends on whether the system have >4G, if there is an iommu want to shut
> down SWIOTLB, and some times iommu still expect SWIOTLB to exist, and
> SWIOTLB could be activated first, then got closed later etc...). The crash
> kernel reserve should happen very early to ensure the region is usable, but
> kernel is not aware of if SWIOTLB is needed. Have to either move the
> reservation to some later stage or always reserve extra memories early,
> then release if not needed later. Neither sound a good solution, and after
> all, as mentioned above, currently kernel need it doesn't mean kdump kernel
> needs it.
> 
> - Also tried to reuse and improve the currently crashk_low_res facility to
> reserve the memory in a different block at first, make the code simpler.
> Didn't work well due to some other issue with all current version of user
> space kexec-tools, which never expect there will be an extra memory region
> for non-high reservation case, and failed to load the kernel for kdump.
> Have to always make the another block in a lower position or rename the
> memory resource. I think this will either break user space tools heavily,
> or make the implementation even more complex and confusing.

Kairui, I remember you tried to reuse the swiotlb regions across kexec
reboot, are you saying this as the 3rd problem above?

It is not clear how you use crashk_low_res,  can you elaborate it I
remember you mentioned some problem with this approach, maybe we can
re-explore it.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
