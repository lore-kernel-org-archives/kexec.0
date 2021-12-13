Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwmD8-00A0WS-C5
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 14:21:51 +0000
Received: by mail-pg1-x531.google.com with SMTP id 133so14684018pgc.12
 for <kexec@lists.infradead.org>; Mon, 13 Dec 2021 06:21:49 -0800 (PST)
Date: Mon, 13 Dec 2021 14:21:42 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213142142.GA999996@odroid>
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
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On Thu, Dec 09, 2021 at 01:59:58PM +0100, Christoph Lameter wrote:
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
> 
> Sorry this subject has caused confusion multiple times over the years and
> there are still arches that are not implementing this in a consistent way.

Hello Baoquan and Christoph.

I'm the confused one here too. :)

So the point is that ZONE_NORMAL is also dma-able if the device can access
normal memory. (which is false for ISA devices, ancient PCI devices,
...etc.)

Then if I understand right, I think the patch 5/5 (mm/slub: Avoid ...) should be removing
GFP_DMA flag from the function sr_probe() -> get_capabilities, rather than
copying copying normal kmalloc caches to dma kmalloc caches. (If the device does
not have limitation in its address space.)

Please let me know If I got it wrong :)

Thanks,
Hyeonggon.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
