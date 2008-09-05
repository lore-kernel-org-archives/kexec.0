Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KbQX2-0004xL-MZ
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 01:54:41 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1218138156.3361.386.camel@amd.troyhebe>
	<20080808014024.GB3911@redhat.com>
	<1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com>
	<m1wsib3raq.fsf@frodo.ebiederm.org>
	<1219442751.3361.459.camel@amd.troyhebe>
	<m18wuofw79.fsf@frodo.ebiederm.org>
	<20080825131603.GB18914@redhat.com>
	<m1vdxpky0c.fsf@frodo.ebiederm.org>
	<1220570928.2215.48.camel@amd.troyhebe>
Date: Thu, 04 Sep 2008 18:46:38 -0700
In-Reply-To: <1220570928.2215.48.camel@amd.troyhebe> (Bob Montgomery's message
	of "Thu, 04 Sep 2008 17:28:48 -0600")
Message-ID: <m11vzz1i0x.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: bob.montgomery@hp.com
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Bob Montgomery <bob.montgomery@hp.com> writes:

> On Mon, 2008-08-25 at 13:46 +0000, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > On Fri, Aug 22, 2008 at 04:48:10PM -0700, Eric W. Biederman wrote:
>> >>
>> >> Hmm.  Thinking about this we actually have 2 problems.
>> >> - Communication about what is going on.
>> >> - How to handle an iommu in the event of a crash dump scenario.
>> >>
>> >> The current solution is to ignore the iommu, and use swiotlb.  This
>> >> solution does not look like it will work for future iommus.
> Howdy all,
>
> There are several aspects to this problem that make solutions come in
> and out of contention:
>
> 1.  Kexec vs Kdump
>
> 	Kexec: If we are kexec'ing normally, we assume that the shutdown has
> successfully stopped DMAs prior to starting our new kernel, and if not,
> it's a bug in the previous kernel's driver shutdown.  So no issue here,
> right?

Correct.

> 	Kdump: The driver shutdown has been skipped as we go down during a
> crash, so assume that leftover DMA operations might be in progress as
> the kdump kernel comes up.  BUT!  They will be in progress to some area
> of memory other than the memory being used by the kdump kernel (it has
> its own crashkernel sandbox).  And on my 2.6.18-based system, with an
> AMD64 NB GART-acting-as-IOMMU, the kdump kernel *does not* try to
> initialize or use an IOMMU when it comes up because its memory size is
> too small to need one (no one is setting crashkernel=4G@4G).  So the
> kdump kernel can successfully ignore the old IOs using the old GART
> aperture IOMMU.
>
> EXCEPT(!) for the fact the we've left CPU-side translations turned on in
> the GART NB hardware and the kdump kernel will currently read through
> that zone using /proc/vmcore or /dev/oldmem.  That's why I like fixing
> my stone-age problem by turning off CPU-side access. 
>
> Note that real (future?) IOMMUs don't even have the concept of
> translating accesses from the CPU side.  They only work on IO requests.
> So reading old memory areas from the crashed kernel shouldn't cause an
> IOMMU to "do" anything.

Good point.  I don't think linux uses the translations either.

The downside of this is that it increases the dependency of the
kernel that crashed not to have done something bad.  So at least
long term it would be good to have code that can share do the
right thing with iommus.



> 2.  GART vs Calgary vs "new AMD IOMMU" vs "new Intel IOMMU"
>
> 	The GART-as-IOMMU thing is not a "real" IOMMU.  It doesn't offer much
> of the interesting protection of a real IOMMU, just "valid", "coherent"
> and a translation address.  An IO card is still free to screw up and hit
> other addresses outside the aperture if it wants to, or hit other pages
> in the aperture that really belong to some other driver, or to write to
> a page that it should only read, etc.  Consequently, there isn't much
> desire to utilize the GART thing unless I really need 32-bit IO card
> access to 40-bit address space.  Since I don't need that in the kdump
> kernel (currently), there's no reason to try to use the GART there, so
> it's safe to ignore it, as long as I don't provoke it :-)
>
> BUT, if I had a real IOMMU that provided cool protection stuff and
> domain stuff, and not just address range expansion for old IO cards,
> then I might want to (or be forced to) use it all the time, independent
> of memory size, and then the kdump kernel might really need to deal with
> sharing it in some way with old leftover DMAs from the crashed kernel
> that we're dumping.  And this, I think, is the only real issue looming.

Yes.  How do we properly share an iommu is the looming issue.

> But this should only be a kdump issue, and not a kexec issue (see #1
> above), because the previous kernel should have shut all that down
> before it kexec'd, right?

Correct.

> 3.  IOMMU vs swiotlb
>
> Isn't swiotlb just a way of hiding bounce buffer copies and management
> inside of the dma_map_single and dma_unmap_single calls?  If so, it's
> just software(TM) and it just uses addresses in the kdump kernel
> sandbox, which (by definition) are not addresses that could have been
> used in the old kernel that crashed.  There shouldn't be any conflict
> between kdump kernel and old crashed kernel if one or both are using
> swiotlb.  Once again, in *my* current situation, there's no reason to
> use swiotlb in the kdump kernel because my memory range is restricted to
> my crashkernel sandbox and I don't need any IOMMU address translation
> capability.  


> If the original kernel had been using swiotlb, then there's really no
> issue, because any leftover DMAs are just writing to the old bounce
> buffers anyway, and there's no driver left waiting to call
> dma_unmap_single to copy the result into the real buffer.
>
> What considerations have I missed?
>
> Bob Montgomery
> (vacation last week)
>

If the BIOS provides us with an aperture in pci mmio space for the AMD
GART there is no memory loss, and the issue that you are seeing can
not occur.

This has a couple of interesting implications.
1) If you disable translation of cpu side accesses than you can continue
   to use the memory instead at the bus addresses used for the GART.
2) If you can continue to use the memory you can make the GART aperture
   it's maximum size 2G I think.  This begins to provide protection from
   errant DMA addresses sent by devices.
3) If we enable access to the memory where the GART lives we have a
   situation where bus addresses and memory addresses are not always
   in the same domain.  Giving us true iommu fun.

So specific recommendations.
1) Since cpu side accesses to the GART appear to just silly let's
   disable them.
2) We need to figure out how to communicate the disjoint address
   spaces that come with iommus in /sbin/kexec the user space code
   that sets this up.
3) If anyone has the oomph let's put the AMD K8 GART into large
   window mode and see if we can sort through all of the iommu issues
   on a platform that a lot of people have to work with.

Eric
   

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
