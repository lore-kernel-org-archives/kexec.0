Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n00rl-00AIBS-OR
 for kexec@lists.infradead.org; Wed, 22 Dec 2021 12:37:11 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 2so1983231pgb.12
 for <kexec@lists.infradead.org>; Wed, 22 Dec 2021 04:37:09 -0800 (PST)
Date: Wed, 22 Dec 2021 12:37:03 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no managed
 pages in DMA zone
Message-ID: <YcMb7+RESj1nEx9l@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com>
 <20211213134319.GA997240@odroid>
 <20211214053253.GB2216@MiWiFi-R3L-srv>
 <Ybx2szXEgl1tN4MD@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <20211221085623.GA7733@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221085623.GA7733@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>

Hello Christoph.

On Tue, Dec 21, 2021 at 09:56:23AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 17, 2021 at 11:38:27AM +0000, Hyeonggon Yoo wrote:
> > My understanding is any buffer requested from kmalloc (without
> > GFP_DMA/DMA32) can be used by device driver because it allocates
> > continuous physical memory. It doesn't mean that buffer allocated
> > with kmalloc is free of addressing limitation.
> 
> Yes.
> 
> > 
> > the addressing limitation comes from the capability of device, not
> > allocation size. if you allocate memory using alloc_pages() or kmalloc(),
> > the device has same limitation. and vmalloc can't be used for
> > devices because they have no MMU.
> 
> vmalloc can be used as well, it just needs to be setup as a scatterlist
> and needs a little lover for DMA challenged platforms with the
> invalidate_kernel_vmap_range and flush_kernel_vmap_range helpers.

Oh I misunderstood this. Underlying physical address of vmalloc()-allocated memory
can be mapped using DMA API, and it needs to be setup as scatterlist because
the allocated memory is not physically continuous. Right?

BTW, looking at the API I think the scsi case can be converted to use
dma_alloc_pages(). but driver requires 512 bytes of buffer and the API
supports allocating by at least page size.

It's not a big problem as it allocates a single buffer but in other
cases maybe not. Can't we use dma pool for non-coherent pages?

Thanks,
Hyeonggon.

> > But we can map memory outside DMA zone into bounce buffer (which resides
> > in DMA zone) using DMA API.
> 
> Yes, although in a few specific cases the bounce buffer could also come
> from somewhere else.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
