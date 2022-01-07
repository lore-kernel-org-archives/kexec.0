From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Fri, 7 Jan 2022 11:56:38 +0000
Subject: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no managed
 pages in DMA zone
In-Reply-To: <20211215072710.GA3010@lst.de>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com>
 <20211213134319.GA997240@odroid>
 <20211214053253.GB2216@MiWiFi-R3L-srv>
 <f5ff82eb-73b6-55b5-53d7-04ab73ce5035@suse.cz>
 <20211215044818.GB1097530@odroid> <20211215070335.GA1165926@odroid>
 <20211215072710.GA3010@lst.de>
Message-ID: <20220107115638.GB2769814@odroid>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Dec 15, 2021 at 08:27:10AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 15, 2021 at 07:03:35AM +0000, Hyeonggon Yoo wrote:
> > I'm not sure that allocating from ZONE_DMA32 instead of ZONE_DMA
> > for kdump kernel is nice way to solve this problem.
> 
> What is the problem with zones in kdump kernels?
> 
> > Devices that requires ZONE_DMA memory is rare but we still support them.
> 
> Indeed.
> 
> > >     1) Do not call warn_alloc in page allocator if will always fail
> > >     to allocate ZONE_DMA pages.
> > > 
> > > 
> > >     2) let's check all callers of kmalloc with GFP_DMA
> > >     if they really need GFP_DMA flag and replace those by DMA API or
> > >     just remove GFP_DMA from kmalloc()
> > > 
> > >     3) Drop support for allocating DMA memory from slab allocator
> > >     (as Christoph Hellwig said) and convert them to use DMA32
> > 
> > 	(as Christoph Hellwig said) and convert them to use *DMA API*
> > 
> > >     and see what happens
> 
> This is the right thing to do, but it will take a while.  In fact
> I dont think we really need the warning in step 1, a simple grep
> already allows to go over them.  I just looked at the uses of GFP_DMA
> in drivers/scsi for example, and all but one look bogus.
> 
> > > > > Yeah, I have the same guess too for get_capabilities(), not sure about other
> > > > > callers. Or, as ChristophL and ChristophH said(Sorry, not sure if this is
> > > > > the right way to call people when the first name is the same. Correct me if
> > > > > it's wrong), any buffer requested from kmalloc can be used by device driver.
> > > > > Means device enforces getting memory inside addressing limit for those
> > > > > DMA transferring buffer which is usually large, Megabytes level with
> > > > > vmalloc() or alloc_pages(), but doesn't care about this kind of small
> > > > > piece buffer memory allocated with kmalloc()? Just a guess, please tell
> > > > > a counter example if anyone happens to know, it could be easy.
> 
> The way this works is that the dma_map* calls will bounce buffer memory
> that does to fall into the addressing limitations.  This is a performance
> overhead, but allows drivers to address all memory in a system.  If the
> driver controls memory allocation it should use one of the dma_alloc_*
> APIs that allocate addressable memory from the start.  The allocator
> will dip into ZONE_DMA and ZONE_DMA32 when needed.

Hello Christoph, Baoquan and I started this cleanup.
But we're a bit confused. I want to ask you something.

-   Did you mean dma_map_* can handle arbitrary buffer, (and dma_map_* will
    bounce buffer when necessary) Can we assume it on every architectures
    and buses?

    Reading at the DMA API documentation and code (dma_map_page_attrs(),
    dma_direct_map_page()), I'm not sure about that.

    In the documentation: (dma_map_single)
    	Further, the DMA address of the memory must be within the
	dma_mask of the device (the dma_mask is a bit mask of the
	addressable region for the device, i.e., if the DMA address of
	the memory ANDed with the dma_mask is still equal to the DMA
	address, then the device can perform DMA to the memory).  To
	ensure that the memory allocated by kmalloc is within the dma_mask,
	the driver may specify various platform-dependent flags to restrict
	the DMA address range of the allocation (e.g., on x86, GFP_DMA
	guarantees to be within the first 16MB of available DMA addresses,
	as required by ISA devices).

-   In what function does the DMA API do bounce buffering?

Thanks a lot,
Hyeonggon

