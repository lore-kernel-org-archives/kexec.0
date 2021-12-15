Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxRD6-00071e-4a
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 10:08:33 +0000
Date: Wed, 15 Dec 2021 18:08:16 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no managed
 pages in DMA zone
Message-ID: <20211215100816.GD10336@MiWiFi-R3L-srv>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com>
 <20211213134319.GA997240@odroid>
 <20211214053253.GB2216@MiWiFi-R3L-srv>
 <f5ff82eb-73b6-55b5-53d7-04ab73ce5035@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5ff82eb-73b6-55b5-53d7-04ab73ce5035@suse.cz>
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
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>

On 12/14/21 at 11:09am, Vlastimil Babka wrote:
> On 12/14/21 06:32, Baoquan He wrote:
> > On 12/13/21 at 01:43pm, Hyeonggon Yoo wrote:
> >> Hello Baoquan. I have a question on your code.
> >> 
> >> On Mon, Dec 13, 2021 at 08:27:12PM +0800, Baoquan He wrote:
> >> > Dma-kmalloc will be created as long as CONFIG_ZONE_DMA is enabled.
> >> > However, it will fail if DMA zone has no managed pages. The failure
> >> > can be seen in kdump kernel of x86_64 as below:
> >> > 
> 
> Could have included the warning headline too.

Sure, I will paste the whole warning when repost.

> 
> >> >  CPU: 0 PID: 65 Comm: kworker/u2:1 Not tainted 5.14.0-rc2+ #9
> >> >  Hardware name: Intel Corporation SandyBridge Platform/To be filled by O.E.M., BIOS RMLSDP.86I.R2.28.D690.1306271008 06/27/2013
> >> >  Workqueue: events_unbound async_run_entry_fn
> >> >  Call Trace:
> >> >   dump_stack_lvl+0x57/0x72
> >> >   warn_alloc.cold+0x72/0xd6
> >> >   __alloc_pages_slowpath.constprop.0+0xf56/0xf70
> >> >   __alloc_pages+0x23b/0x2b0
> >> >   allocate_slab+0x406/0x630
> >> >   ___slab_alloc+0x4b1/0x7e0
> >> >   ? sr_probe+0x200/0x600
> >> >   ? lock_acquire+0xc4/0x2e0
> >> >   ? fs_reclaim_acquire+0x4d/0xe0
> >> >   ? lock_is_held_type+0xa7/0x120
> >> >   ? sr_probe+0x200/0x600
> >> >   ? __slab_alloc+0x67/0x90
> >> >   __slab_alloc+0x67/0x90
> >> >   ? sr_probe+0x200/0x600
> >> >   ? sr_probe+0x200/0x600
> >> >   kmem_cache_alloc_trace+0x259/0x270
> >> >   sr_probe+0x200/0x600
> >> >   ......
> >> >   bus_probe_device+0x9f/0xb0
> >> >   device_add+0x3d2/0x970
> >> >   ......
> >> >   __scsi_add_device+0xea/0x100
> >> >   ata_scsi_scan_host+0x97/0x1d0
> >> >   async_run_entry_fn+0x30/0x130
> >> >   process_one_work+0x2b0/0x5c0
> >> >   worker_thread+0x55/0x3c0
> >> >   ? process_one_work+0x5c0/0x5c0
> >> >   kthread+0x149/0x170
> >> >   ? set_kthread_struct+0x40/0x40
> >> >   ret_from_fork+0x22/0x30
> >> >  Mem-Info:
> >> >  ......
> >> > 
> >> > The above failure happened when calling kmalloc() to allocate buffer with
> >> > GFP_DMA. It requests to allocate slab page from DMA zone while no managed
> >> > pages in there.
> >> >  sr_probe()
> >> >  --> get_capabilities()
> >> >      --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
> >> > 
> >> > The DMA zone should be checked if it has managed pages, then try to create
> >> > dma-kmalloc.
> >> >
> >> 
> >> What is problem here?
> >> 
> >> The slab allocator requested buddy allocator with GFP_DMA,
> >> and then buddy allocator failed to allocate page in DMA zone because
> >> there was no page in DMA zone. and then the buddy allocator called warn_alloc
> >> because it failed at allocating page.
> >> 
> >> Looking at warn, I don't understand what the problem is.
> > 
> > The problem is this is a generic issue on x86_64, and will be warned out
> > always on all x86_64 systems, but not on a certain machine or a certain
> > type of machine. If not fixed, we can always see it in kdump kernel. The
> > way things are, it doesn't casue system or device collapse even if
> > dma-kmalloc can't provide buffer or provide buffer from zone NORMAL.
> > 
> > 
> > I have got bug reports several times from different people, and we have
> > several bugs tracking this inside Redhat. I think nobody want to see
> > this appearing in customers' monitor w or w/o a note. If we have to
> > leave it with that, it's a little embrassing.
> > 
> > 
> >> 
> >> > ---
> >> >  mm/slab_common.c | 9 +++++++++
> >> >  1 file changed, 9 insertions(+)
> >> > 
> >> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> > index e5d080a93009..ae4ef0f8903a 100644
> >> > --- a/mm/slab_common.c
> >> > +++ b/mm/slab_common.c
> >> > @@ -878,6 +878,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
> >> >  {
> >> >  	int i;
> >> >  	enum kmalloc_cache_type type;
> >> > +#ifdef CONFIG_ZONE_DMA
> >> > +	bool managed_dma;
> >> > +#endif
> >> >  
> >> >  	/*
> >> >  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
> >> > @@ -905,10 +908,16 @@ void __init create_kmalloc_caches(slab_flags_t flags)
> >> >  	slab_state = UP;
> >> >  
> >> >  #ifdef CONFIG_ZONE_DMA
> >> > +	managed_dma = has_managed_dma();
> >> > +
> >> >  	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
> >> >  		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
> >> >  
> >> >  		if (s) {
> >> > +			if (!managed_dma) {
> >> > +				kmalloc_caches[KMALLOC_DMA][i] = kmalloc_caches[KMALLOC_NORMAL][i];
> 
> The right side could be just 's'?

Right, will see if we will take another way, will change it if keeping
this way.

> 
> >> > +				continue;
> >> > +			}
> >> 
> >> This code is copying normal kmalloc caches to DMA kmalloc caches.
> >> With this code, the kmalloc() with GFP_DMA will succeed even if allocated
> >> memory is not actually from DMA zone. Is that really what you want?
> > 
> > This is a great question. Honestly, no,
> > 
> > On the surface, it's obviously not what we want, We should never give
> > user a zone NORMAL memory when they ask for zone DMA memory. If going to
> > this specific x86_64 ARCH where this problem is observed, I prefer to give
> > it zone DMA32 memory if zone DMA allocation failed. Because we rarely
> > have ISA device deployed which requires low 16M DMA buffer. The zone DMA
> > is just in case. Thus, for kdump kernel, we have been trying to make sure
> > zone DMA32 has enough memory to satisfy PCIe device DMA buffer allocation,
> > I don't remember we made any effort to do that for zone DMA.
> > 
> > Now the thing is that the nothing serious happened even if sr_probe()
> > doesn't get DMA buffer from zone DMA. And it works well when I feed it
> > with zone NORMAL memory instead with this patch applied.
> 
> If doesn't feel right to me to fix (or rather workaround) this on the level
> of kmalloc caches just because the current reports come from there. If we
> decide it's acceptable for kdump kernel to return !ZONE_DMA memory for
> GFP_DMA requests, then it should apply at the page allocator level for all
> allocations, not just kmalloc().
> 
> Also you mention above you'd prefer ZONE_DMA32 memory, while chances are
> this approach of using KMALLOC_NORMAL caches will end up giving you
> ZONE_NORMAL. On the page allocator level it would be much easier to
> implement a fallback from non-populated ZONE_DMA to ZONE_DMA32 specifically.

This could be do-able. I count this in when investigate all suggested
solutions. Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
