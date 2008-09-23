Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KhxkV-0002Ja-0z
	for kexec@lists.infradead.org; Tue, 23 Sep 2008 02:35:35 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com>
	<m1wsib3raq.fsf@frodo.ebiederm.org>
	<1219442751.3361.459.camel@amd.troyhebe>
	<m18wuofw79.fsf@frodo.ebiederm.org>
	<20080825131603.GB18914@redhat.com>
	<m1vdxpky0c.fsf@frodo.ebiederm.org>
	<1220570928.2215.48.camel@amd.troyhebe>
	<20080905151209.GB13742@redhat.com>
	<1220994769.2215.75.camel@amd.troyhebe>
	<1222126294.2215.91.camel@amd.troyhebe>
Date: Mon, 22 Sep 2008 19:29:33 -0700
In-Reply-To: <1222126294.2215.91.camel@amd.troyhebe> (Bob Montgomery's message
	of "Mon, 22 Sep 2008 17:31:34 -0600")
Message-ID: <m1y71joar6.fsf@frodo.ebiederm.org>
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
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

Bob Montgomery <bob.montgomery@hp.com> writes:

> On Tue, 2008-09-09 at 21:12 +0000, I wrote:
>
>> The kdump kernel wouldn't be in danger of being overwritten, it just
>> might not be able to set up any IOs that work to its own address space
>> if an IOMMU is out there waiting to grab them.
>> 
>> For the calgary case, we'd maybe have to add the Crash Kernel range to
>> the list of things sent to iommu_range_reserve in
>> calgary_reserve_regions, to prevent those addresses from ever being
>> given out.
>> 
>> Bob M.
>
> While this, or something like it, is necessary, it isn't sufficient.
> I think what we would really need to do is to have the primary kernel
> set up an identity mapping for all pages in the Crash kernel range,
> or the subset of pages that could be IO targets when the kdump kernel
> is running.  This would allow a still-running IOMMU from the primary
> kernel to translate kdump IOs to kdump addresses transparently.

> And that leads to the Kdump IO Rule:
>
>         The primary kernel is responsible for setting up any necessary
>         conditions to allow the kdump kernel to perform its required
>         IO without detecting any iommu.

Reserving a range or addresses in the iommu I agree with.
If that range of addresses allows for identity mapping I
like it better.

I'm not certain about requiring it.

I don't like setting up the identity mapping before hand,
it allows devices to trash the kdump kernel by accident.

>         The kdump kernel must refrain from detecting and initializing
>         any iommu.

Why?  I can fully understand avoiding addresses that are in flight.
I can definitely see this being simpler in the kdump kernel.
However this feels like it makes a less robust kdump kernel by
not allowing it to touch the iommu.

> This has a these effects:
>
> A) Primary kernel: depending on what it is using for as an IOMMU,
>         it may have to do some (or considerable) setup, to guarantee
>         that the kdump kernel can have IO capability to its Crash
>         kernel address range.
>
> B) Primary kernel: the Crash kernel range must be set up in an address
>         range whose physical addresses are accessible to IO cards
>         without address remapping.

Below <= 16MB?  That doesn't work in general.

Especially not if we are running on an SGI box and someone had
unplugged node 0 (with all of the memory below 4G).

> C) Kdump kernel: the kdump kernel must ignore any IOMMU hardware that
>         might be "detectable".


> The setup responsibilities for the primary kernel depend on what it is
> currently using for dma mapping:
>
> 1) no iommu (nommu_map_single): No setup is required for kdump.
>         Leftover IOs will go to IO buffers allocated by the primary
>         kernel outside of the Crash kernel area.  Kdump IOs will
>         go to IO buffers allocated by the kdump kernel in the Crash
>         kernel area.
>
> 2) swiotlb (swiotlb_map_single_phys): No setup is required for kdump.
>         Leftover IOs will go to the primary kernel bounce buffers
>         outside of the Crash kernel area.  Kdump IOs will go to IO
>         buffers allocated by the kdump kernel in the Crash kernel area.
>
> 3) GART (gart_map_single): No setup is required for kdump.  Leftover
>         IOs will be mapped through the GART aperture to IO buffers
>         allocated by the primary kernel outside of the Crash Kernel
>         area.  Kdump IOs will go to IO buffers allocated by the kdump
>         kernel in the Crash kernel area.
>
> 4) Calgary IOMMU (calgary_map_single): The Crash kernel memory range
>         must be pre-allocated for IO and identity-mapped, so any IO
>         operation to an address in the Crash kernel range is allowed
>         to complete to that same address.  To preallocate for a
>         128MB Crash kernel area, 32K entries (256 Kbytes) are used
>         from the Calgary table.  For a 4GB system, the default size
>         of the table is 1024K entries (8 Mbytes).
>
>         Leftover IOs will go to IO buffers allocated by the primary
>         kernel and remapped by the Calgary IOMMU.  Neither the IO-side
>         address (iova) nor the physical address of a leftover IO will
>         be in the Crash kernel area.  Kdump IOs will go to IO buffers
>         allocated by the kdump kernel, remapped by the Calgary IOMMU
>         to those same addresses (iova equals physical address within
>         the Crash kernel area).
>
> 5) Intel IOMMU (intel_map_single): The Crash kernel memory range must
>         be pre-allocated and identity-mapped for each hw device that
>         is needed by the kdump kernel, so any IO operation to an
>         address in the Crash kernel range is allowed to complete to
>         that same address.
>
>         Leftover IOs will go to IO buffers allocated by the primary
>         kernel and remapped by the Intel IOMMU.  Neither the IO-side
>         address (iova) nor the physical address of a leftover IO
>         will be in the Crash kernel area.  Kdump IOs will go to IO
>         buffers allocated by the kdump kernel, remapped by the Intel
>         IOMMU to those same addresses (iova equals physical address
>         within the Crash kernel area).
>
>
> This all assumes no virtual machine stuff yet.
>
> Possible? Comments? Corrections? 

Possible.

I would very much like the option of doing the iommu setup, and possibly
fiddling in the kdump kernel.   As long as we are not reusing the same
addresses in the iommu I don't see a problem.

I like the theoretical option of disabling ongoing DMA's, with the
more complete IOMMUs.  It isn't strictly necessary but I expect it
would give a better result.

Eric
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
