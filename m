Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gentwo.de ([161.97.139.209])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvJ1n-00FzV4-1X
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 13:00:04 +0000
Date: Thu, 9 Dec 2021 13:59:58 +0100 (CET)
From: Christoph Lameter <cl@gentwo.org>
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
In-Reply-To: <20211209080540.GA3050@MiWiFi-R3L-srv>
Message-ID: <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
References: <20211207030750.30824-1-bhe@redhat.com>
 <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
 <20211209080540.GA3050@MiWiFi-R3L-srv>
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On Thu, 9 Dec 2021, Baoquan He wrote:

> > The slab allocators guarantee that all kmalloc allocations are DMA able
> > indepent of specifying ZONE_DMA/ZONE_DMA32
>
> Here you mean we guarantee dma-kmalloc will be DMA able independent of
> specifying ZONE_DMA/DMA32, or the whole sla/ub allocator?

All memory obtained via kmalloc --independent of "dma-alloc", ZONE_DMA
etc-- must be dmaable.

> With my understanding, isn't the reasonable sequence zone DMA firstly if
> GFP_DMA, then zone DMA32, finaly zone NORMAL. At least, on x86_64, I
> believe device driver developer prefer to see this because most of time,
> zone DMA and zone DMA32 are both used for dma buffer allocation, if
> IOMMU is not enabled. However, memory got from zone NORMAL when required
> with GFP_DMA, and it succeeds, does it mean that the developer doesn't
> take the GFP_DMA flag seriously, just try to get buffer for allocation?

ZONE_NORMAL is also used for DMA allocations. ZONE_DMA and ZONE_DMA32 are
only used if the physical range of memory supported by a device does not
include all of normal memory.

> > The size of ZONE_DMA is traditionally depending on the platform. On some
> > it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
> > only be used if ZONE_DMA has already been used.
>
> As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
> cover low 4G with ZONE_DMA32 alone.

If you do not have devices that are crap and cannot address the full
memory then you dont need these special zones.

Sorry this subject has caused confusion multiple times over the years and
there are still arches that are not implementing this in a consistent way.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
