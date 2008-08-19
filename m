Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KVRYv-0007gN-6L
	for kexec@lists.infradead.org; Tue, 19 Aug 2008 13:47:53 +0000
Date: Tue, 19 Aug 2008 09:47:48 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
Message-ID: <20080819134748.GC18972@redhat.com>
References: <1218138156.3361.386.camel@amd.troyhebe>
	<20080808014024.GB3911@redhat.com>
	<1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1219081942.3361.436.camel@amd.troyhebe>
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
To: Bob Montgomery <bob.montgomery@hp.com>
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>

Hi Bob,

I am CCing this thread to kexec mailing list. It is good to discuss
the issue there to get the ideas.

I will summarize the discussion so far.

Bob is running into MCA in second kernel in kdump. Reason seems to be
that second kernel is trying to access the memory area marked as
GART aperture (by first kernel). Because GART aperture does not appear
as "reserved" or something else in /proc/iomem (in case kernel has
overridden the BIOS settings and has reserved a memory area), second
kernel thinks it is a valid RAM area and tries to dump it and runs into
issues.

Few options Bob is considering are.

- Update "e820" memory map to mark GART aperture as reserved, which will
  be reflected in /proc/iomem also. Kexec-tools will not pass reserved
  area to second kernel and it will not try to dump this area.


- Mark GART aperture as "GART aperture" in /proc/iomem and modify
  kexec-tools to filter out this memroy from memory map passed to second
  kernel.

- Disable cpu side GART access in first kernel so that even if second
  kernel tries to access it, it does not run into isseus.

Thanks
Vivek





On Mon, Aug 18, 2008 at 11:52:22AM -0600, Bob Montgomery wrote:
> On Fri, 2008-08-15 at 13:13 +0000, Vivek Goyal wrote:
> 
> > 
> > I checked that aperture is allocated in mem_init(), which is little late
> > in the game but bootmem allocator is still in effect and we have not
> > released the pages to free list. May be it is possible to modify e820
> > memory map even now. Somebody will have to experiemnt..
> 
> I'll try to study this a bit this week.
> 
> 
> 
> > 
> > If not, then I also like the idea of marking the region as "GART Aperture"
> > in /proc/iomem and let kexec-tools filter it.
> 
> This of course requires two things to change to get a fix - the kernel
> and the kexec-tools. 
> > 
> > Not very sure about the idea of disabling cpu side access. Will it run
> > into issues like MCE if DMAs are still going on? It does MCA if one
> > tries to disable GART when DMAs are going on.
> 
> I am disabling CPU side access in the *first kernel*, when the GART is
> initially set up.  The kdump kernel just inherits that setting when it
> boots.  So no DMA is going on when I do the disable.  The reason it
> seems safe to me is that in the first kernel, CPU side access is
> effectively disabled by this (in arch/x86_64/pci-gart.c on our
> 2.6.18-based kernel):
> 
>         /*
>          * Unmap the IOMMU part of the GART. The alias of the page is
>          * always mapped with cache enabled and there is no full cache
>          * coherency across the GART remapping. The unmapping avoids
>          * automatic prefetches from the CPU allocating cache lines in
>          * there. All CPU accesses are done via the direct mapping to
>          * the backing memory. The GART address is only used by PCI
>          * devices.
>          */
>         clear_kernel_mapping((unsigned long)__va(iommu_bus_base),
> iommu_size);
> 
> 
> I notice some changes in the equivalent area in 2.6.26:
>         /*
>          * Unmap the IOMMU part of the GART. The alias of the page is
>          * always mapped with cache enabled and there is no full cache
>          * coherency across the GART remapping. The unmapping avoids
>          * automatic prefetches from the CPU allocating cache lines in
>          * there. All CPU accesses are done via the direct mapping to
>          * the backing memory. The GART address is only used by PCI
>          * devices.
>          */
>         set_memory_np((unsigned long)__va(iommu_bus_base),
>                                 iommu_size >> PAGE_SHIFT);
>         /*
>          * Tricky. The GART table remaps the physical memory range,
>          * so the CPU wont notice potential aliases and if the memory
>          * is remapped to UC later on, we might surprise the PCI devices
>          * with a stray writeout of a cacheline. So play it sure and
>          * do an explicit, full-scale wbinvd() _after_ having marked all
>          * the pages as Not-Present:
>          */
>         wbinvd();
> 
> 
> set_memory_np does:
> 	change_page_attr_clear(addr, numpages, __pgprot(_PAGE_PRESENT));
> 
> wbinvd() does the wbinvd (write back and invalidate caches) instruction.
> 
> Bob Montgomery
> 
> 
> 
> 
> > 
> > Thanks
> > Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
