Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gentwo.de ([2a02:c206:2048:5042::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muVTe-007NQZ-PM
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 08:05:32 +0000
Date: Tue, 7 Dec 2021 09:05:26 +0100 (CET)
From: Christoph Lameter <cl@gentwo.org>
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
In-Reply-To: <20211207030750.30824-1-bhe@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
References: <20211207030750.30824-1-bhe@redhat.com>
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

On Tue, 7 Dec 2021, Baoquan He wrote:

> into ZONE_DMA32 by default. The zone DMA covering low 16M is used to
> take care of antique ISA devices. In fact, on 64bit system, it rarely
> need ZONE_DMA (which is low 16M) to support almost extinct ISA devices.
> However, some components treat DMA as a generic concept, e.g
> kmalloc-dma, slab allocator initializes it for later any DMA related
> buffer allocation, but not limited to ISA DMA.

The idea of the slab allocator DMA support is to have memory available
for devices that can only support a limited range of physical addresses.
These are only to be enabled for platforms that have such requirements.

The slab allocators guarantee that all kmalloc allocations are DMA able
indepent of specifying ZONE_DMA/ZONE_DMA32

> On arm64, even though both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> are enabled, it makes ZONE_DMA covers the low 4G area, and ZONE_DMA32
> empty. Unless on specific platforms (e.g. 30-bit on Raspberry Pi 4),
> then zone DMA covers the 1st 1G area, zone DMA32 covers the rest of
> the 32-bit addressable memory.

ZONE_NORMAL should cover all memory. ARM does not need ZONE_DMA32.

> I am wondering if we can also change the size of DMA and DMA32 ZONE as
> dynamically adjusted, just as arm64 is doing? On x86_64, we can make
> zone DMA covers the 32-bit addressable memory, and empty zone DMA32 by
> default. Once ISA_DMA_API is enabled, we go back to make zone DMA covers
> low 16M area, zone DMA32 covers the rest of 32-bit addressable memory.
> (I am not familiar with ISA_DMA_API, will it require 24-bit addressable
> memory when enabled?)

The size of ZONE_DMA is traditionally depending on the platform. On some
it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
only be used if ZONE_DMA has already been used.

ZONE_DMA is dynamic in the sense of being different on different
platforms.

Generally I guess it would be possible to use ZONE_DMA for generic tagging
of special memory that can be configured to have a dynamic size but that is
not what it was designed to do.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
