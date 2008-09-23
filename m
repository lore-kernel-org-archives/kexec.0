Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KiDIs-0003Ss-SG
	for kexec@lists.infradead.org; Tue, 23 Sep 2008 19:12:07 +0000
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
From: Bob Montgomery <bob.montgomery@hp.com>
In-Reply-To: <m1y71joar6.fsf@frodo.ebiederm.org>
References: <1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com>	<m1wsib3raq.fsf@frodo.ebiederm.org>
	<1219442751.3361.459.camel@amd.troyhebe>
	<m18wuofw79.fsf@frodo.ebiederm.org> <20080825131603.GB18914@redhat.com>
	<m1vdxpky0c.fsf@frodo.ebiederm.org>
	<1220570928.2215.48.camel@amd.troyhebe>
	<20080905151209.GB13742@redhat.com>
	<1220994769.2215.75.camel@amd.troyhebe>
	<1222126294.2215.91.camel@amd.troyhebe>
	<m1y71joar6.fsf@frodo.ebiederm.org>
Date: Tue, 23 Sep 2008 13:12:15 -0600
Message-Id: <1222197135.2215.135.camel@amd.troyhebe>
Mime-Version: 1.0
Reply-To: bob.montgomery@hp.com
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2008-09-23 at 02:29 +0000, Eric W. Biederman wrote:
> Bob Montgomery <bob.montgomery@hp.com> writes:
> > And that leads to the Kdump IO Rule:
> >
> >         The primary kernel is responsible for setting up any necessary
> >         conditions to allow the kdump kernel to perform its required
> >         IO without detecting any iommu.
> 
> Reserving a range or addresses in the iommu I agree with.
> If that range of addresses allows for identity mapping I
> like it better.
> 
> I'm not certain about requiring it.
> 
> I don't like setting up the identity mapping before hand,
> it allows devices to trash the kdump kernel by accident.

The reason for having the primary kernel set up any mapping needed by a
kdump kernel *in advance* is that for a HW IOMMU, this setup actually
consists of modifying data structures (arrays, trees, lists) that are in
the primary kernel's memory, as well as setting registers in the HW.
When the kdump kernel comes up, none of those structures are in its
memory range.  They're just part of the artifacts left in
/dev/oldmem.  So yes, the kdump kernel could query any hardware that it
found, verify that the hardware had previously been in use, read HW
registers to get the root pointers, or list addresses or whatever, and
then modify arrays, trees, or lists in that non-owned memory to map its
DMA, but it's kind of an unprecedented step for the kdump kernel to
take.  (Blindly copying oldmem pages is one thing, manipulating live
data structures in oldmem seems like quite another thing.)

Regarding the danger of trashing the kdump kernel prior to its launch:
Currently, any driver or errant kernel code can trash the kdump area.
And any IO card on a non-IOMMU or swiotlb system can trash it.  So it
doesn't seem like much of an extension of a risk that already exists.

It does however negate one possibility to lower some of that risk.


> >         The kdump kernel must refrain from detecting and initializing
> >         any iommu.
> 
> Why?  I can fully understand avoiding addresses that are in flight.
> I can definitely see this being simpler in the kdump kernel.
> However this feels like it makes a less robust kdump kernel by
> not allowing it to touch the iommu.

As pointed out above, "touching the iommu" really includes touching its
data structures created by the primary kernel in what is now the oldmem
area.  In addition, I'm not sure the kdump kernel can determine which
addresses are in flight by querying either the HW or the oldmem
structures.   It could probably determine which ones were unused at the
time of the crash.


> > This has a these effects:
> >
> > A) Primary kernel: depending on what it is using for as an IOMMU,
> >         it may have to do some (or considerable) setup, to guarantee
> >         that the kdump kernel can have IO capability to its Crash
> >         kernel address range.
> >
> > B) Primary kernel: the Crash kernel range must be set up in an address
> >         range whose physical addresses are accessible to IO cards
> >         without address remapping.
> 
> Below <= 16MB?  That doesn't work in general.

I didn't think this was working now.  Aren't most crash kernels
allocated above 16 MB?  And I assumed lots of systems don't have IOMMU
capability.  Do you have an example where this would be an issue for an
IO card needed by the kdump kernel?  

> Especially not if we are running on an SGI box and someone had
> unplugged node 0 (with all of the memory below 4G).

How does an SGI box with an unplugged node 0 do kdump IO currently?


> > Possible? Comments? Corrections?
> 
> Possible.
> 
> I would very much like the option of doing the iommu setup, and possibly
> fiddling in the kdump kernel.   As long as we are not reusing the same
> addresses in the iommu I don't see a problem.

The problem I see is the oldmem area.  Now we could come up with a plan
to allow the primary kernel to do all of its iommu related allocations
in the Crash kernel area, effectively creating an area of memory that is
shared between the primary kernel and kdump.  (This would be complicated
in cases where the iommu state is in a dynamic tree vs. a fixed size
array.)  Then the kdump kernel would wake up and just take over
maintenance of the iommu.  But even the much smaller proposal to
preallocate entries in the iommu data structures to allow the kdump
kernel to do its IO is already violating one of the principals of kdump.
It is making kdump operation dependent on the integrity of a primary
kernel data structure.  Actually taking over a shared iommu data
structure from the primary kernel seems like an even bigger
philosophical violation.

> I like the theoretical option of disabling ongoing DMA's, with the
> more complete IOMMUs.  It isn't strictly necessary but I expect it
> would give a better result.

It seems like this implies 1) stopping the DMA at the IOMMU, 2)
surviving the resulting error condition when the IO card fails its next
access (hopefully not MCE on a modern IOMMU), 3) verifying that the IO
card won't try another access later after you've started using the IOMMU
in the kdump kernel, and then 4) reinitializing and using the IOMMU.  Is
it doable?

Thanks for considering,
Bob Montgomery 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
