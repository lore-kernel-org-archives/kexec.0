Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KdAVv-0003vi-KF
	for kexec@lists.infradead.org; Tue, 09 Sep 2008 21:12:44 +0000
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
From: Bob Montgomery <bob.montgomery@hp.com>
In-Reply-To: <20080905151209.GB13742@redhat.com>
References: <1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com> <m1wsib3raq.fsf@frodo.ebiederm.org>
	<1219442751.3361.459.camel@amd.troyhebe>
	<m18wuofw79.fsf@frodo.ebiederm.org> <20080825131603.GB18914@redhat.com>
	<m1vdxpky0c.fsf@frodo.ebiederm.org>
	<1220570928.2215.48.camel@amd.troyhebe>
	<20080905151209.GB13742@redhat.com>
Date: Tue, 09 Sep 2008 15:12:49 -0600
Message-Id: <1220994769.2215.75.camel@amd.troyhebe>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, 2008-09-05 at 15:12 +0000, Vivek Goyal wrote:

> Nice summary Bob. Few thoughts.
> 
> - So until and unless one is reserving memory for crashkernel above 4G,
> there is no need for initializing the IOMMU in second kernel (At this
> moment I am not too worried about need of isolation in second kernel). If
> that's the case, we shouldn't have initialized the calgary iommu in second
> kernel and just should have left it alone and things probably would have
> been fine?

Did you ever try booting the kdump kernel with iommu=off?  That should
have prevented the detection and initialization of the calgary iommu
from the kdump kernel, which (I ass-u-me) is what you had problems with,
if leftover IOs from the crashed kernel were still in progress when the
kdump kernel initialized it?

As for 4G, the info in 2.6.26 Documentation/x86_64/boot-options.txt
mentions 3G as the decision for using an iommu in several places.  The
test in our kernel for using the GART IOMMU is (end_pfn > MAX_DMA32_PFN)
where MAX_DMA32_PFN is:
#define MAX_DMA32_PFN ((4UL*1024*1024*1024) >> PAGE_SHIFT)

> 
> The only issue is that how do you make sure that first kernel has not
> setup an IOMMU entry with same bus address which falls in crash kernel
> reserved area. I am not very familiar with the dma/iommu code and how
> bus addresses are selected. Because if there is bus address overlap in
> first kernel and second kernel, IOMMU will trap the second kernel's DMA
> attempts and redirect it somewhere else. If we don't run into this issue
> then it is fine otherwise we will be forced to use IOMMU in second kernel
> and try to find free bus addresses/entries so that we don't conflict with
> the first kernel's settings.

I finally thought about this long enough to figure out what you meant, I
think :-).    If the existence of a real IOMMU in the first kernel
allows the use of completely virtualized addresses on the IO side, then
there's no reason that they would have to avoid real RAM addresses when
handing out addresses to IO cards with that IOMMU.  

In particular, our little joke about allocating the crash kernel under
the GART aperture (with CPU-side access turned off) would prevent the
kdump kernel from doing non-iommu IO to the crash kernel address range,
because the still-active GART from the old kernel would grab any of
those addresses coming in from the IO side.

The kdump kernel wouldn't be in danger of being overwritten, it just
might not be able to set up any IOs that work to its own address space
if an IOMMU is out there waiting to grab them.

For the calgary case, we'd maybe have to add the Crash Kernel range to
the list of things sent to iommu_range_reserve in
calgary_reserve_regions, to prevent those addresses from ever being
given out.

Bob M. 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
