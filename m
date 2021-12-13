Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwfvs-0087Wn-Sa
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 07:39:38 +0000
Date: Mon, 13 Dec 2021 15:39:25 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213073925.GA29905@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
 <20211209080540.GA3050@MiWiFi-R3L-srv>
 <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
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
To: Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On 12/09/21 at 01:59pm, Christoph Lameter wrote:
> On Thu, 9 Dec 2021, Baoquan He wrote:
> 
> > > The slab allocators guarantee that all kmalloc allocations are DMA able
> > > indepent of specifying ZONE_DMA/ZONE_DMA32
> >
> > Here you mean we guarantee dma-kmalloc will be DMA able independent of
> > specifying ZONE_DMA/DMA32, or the whole sla/ub allocator?
> 
> All memory obtained via kmalloc --independent of "dma-alloc", ZONE_DMA
> etc-- must be dmaable.

This has a prerequisite as you said at below, only if devices can
address full memory, right?


> 
> > With my understanding, isn't the reasonable sequence zone DMA firstly if
> > GFP_DMA, then zone DMA32, finaly zone NORMAL. At least, on x86_64, I
> > believe device driver developer prefer to see this because most of time,
> > zone DMA and zone DMA32 are both used for dma buffer allocation, if
> > IOMMU is not enabled. However, memory got from zone NORMAL when required
> > with GFP_DMA, and it succeeds, does it mean that the developer doesn't
> > take the GFP_DMA flag seriously, just try to get buffer for allocation?
> 
> ZONE_NORMAL is also used for DMA allocations. ZONE_DMA and ZONE_DMA32 are
> only used if the physical range of memory supported by a device does not
> include all of normal memory.

If devices can address full memory, ZONE_NORMAL can also be used for DMA
allocations. (This covers the systems where IOMMU is provided).

If device has address limit, e.g dma mask is 24bit or 32bit, ZONE_DMA
and ZONE_DMA32 are needed.

> 
> > > The size of ZONE_DMA is traditionally depending on the platform. On some
> > > it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
> > > only be used if ZONE_DMA has already been used.
> >
> > As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
> > cover low 4G with ZONE_DMA32 alone.
> 
> If you do not have devices that are crap and cannot address the full
> memory then you dont need these special zones.

I am not a DMA expert, with my understanding, on x86_64 and arm64, we
have PCIe devices which dma mask is 32bit, means they can only address
ZONE_DMA32. Supporting to address full memory might be too expensive for
devices, e.g on these two ARCHes, supported memory could be deployed on
Petabyte of address.

> 
> Sorry this subject has caused confusion multiple times over the years and
> there are still arches that are not implementing this in a consistent way.

Seems so.

And by the way, when I read slub code, noticed a strange phenomenon, I
haven't found out why. When create cache with kmem_cache_create(), zone
flag SLAB_CACHE_DMA, SLAB_CACHE_DMA32 can be specified. allocflags will
store them, and will take out to use when allocating new slab.
Meanwhile, we can also specify gfpflags, but it can't be GFP_DMA32,
because of GFP_SLAB_BUG_MASK. I traced back to very old git history,
didn't find out why GFP_DMA32 can't be specified during
kmem_cache_alloc().

We can completely rely on the cache->allocflags to mark the zone which
we will request page from, but we can also specify gfpflags in
kmem_cache_alloc() to change zone. GFP_DMA32 is prohibited. Here I can
only see that kmalloc() might be the reason, since kmalloc_large()
doesn't have created cache, so no ->allocflags to use.

Is this expected? What can we do to clarify or improve this, at
leaset on code readability?

I am going to post v3, will discard the 'Further thinking' in cover
letter according to your comment. Please help point out if anthing need
be done or missed.

Thanks a lot.

Baoquan
Thanks


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
