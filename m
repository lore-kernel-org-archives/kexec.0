Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxVUQ-001BFu-2p
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 14:42:43 +0000
Date: Wed, 15 Dec 2021 22:42:28 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no managed
 pages in DMA zone
Message-ID: <20211215144228.GF10336@MiWiFi-R3L-srv>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com>
 <20211213134319.GA997240@odroid>
 <20211214053253.GB2216@MiWiFi-R3L-srv>
 <f5ff82eb-73b6-55b5-53d7-04ab73ce5035@suse.cz>
 <20211215044818.GB1097530@odroid> <20211215070335.GA1165926@odroid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211215070335.GA1165926@odroid>
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
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>

On 12/15/21 at 07:03am, Hyeonggon Yoo wrote:
> On Wed, Dec 15, 2021 at 04:48:26AM +0000, Hyeonggon Yoo wrote:
> > 
> > Hello Baoquan and Vlastimil.
> > 
> > I'm not sure allowing ZONE_DMA32 for kdump kernel is nice way to solve
> > this problem. Devices that requires ZONE_DMA is rare but we still
> > support them.
> > 
> > If we allow ZONE_DMA32 for ZONE_DMA in kdump kernels,
> > the problem will be hard to find.
> > 
> 
> Sorry, I sometimes forget validating my english writing :(
> 
> What I meant:
> 
> I'm not sure that allocating from ZONE_DMA32 instead of ZONE_DMA
> for kdump kernel is nice way to solve this problem.

Yeah, if it's really <32bit addressing limit on device, it doesn't solve
problem. Not sure if devices really has the limitation when
kmalloc(GFP_DMA) is invoked kernel driver.

> 
> Devices that requires ZONE_DMA memory is rare but we still support them.
> 
> If we use ZONE_DMA32 memory instead of ZONE_DMA in kdump kernels,
> It will be hard to the problem when we use devices that can use only
> ZONE_DMA memory.
> 
> > What about one of those?:
> > 
> >     1) Do not call warn_alloc in page allocator if will always fail
> >     to allocate ZONE_DMA pages.
> > 

Seems we can do like below.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c7a0b5de2ff..843bc8e5550a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	va_list args;
 	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
 
-	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
+	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
+		(gfp_mask & __GFP_DMA) && !has_managed_dma())
 		return;
 
> > 
> >     2) let's check all callers of kmalloc with GFP_DMA
> >     if they really need GFP_DMA flag and replace those by DMA API or
> >     just remove GFP_DMA from kmalloc()

I grepped and got a list, I will try to start with several easy place,
see if we can do something to improve.
start with.


> > 
> >     3) Drop support for allocating DMA memory from slab allocator
> >     (as Christoph Hellwig said) and convert them to use DMA32
> 
> 	(as Christoph Hellwig said) and convert them to use *DMA API*

Yes, that will be ideal result. This is equivalent to 2), or depends
on 2).

> 
> >     and see what happens
> > 
> > Thanks,
> > Hyeonggon.
> > 
> > > >> 
> > > >> Maybe the function get_capabilities() want to allocate memory
> > > >> even if it's not from DMA zone, but other callers will not expect that.
> > > > 
> > > > Yeah, I have the same guess too for get_capabilities(), not sure about other
> > > > callers. Or, as ChristophL and ChristophH said(Sorry, not sure if this is
> > > > the right way to call people when the first name is the same. Correct me if
> > > > it's wrong), any buffer requested from kmalloc can be used by device driver.
> > > > Means device enforces getting memory inside addressing limit for those
> > > > DMA transferring buffer which is usually large, Megabytes level with
> > > > vmalloc() or alloc_pages(), but doesn't care about this kind of small
> > > > piece buffer memory allocated with kmalloc()? Just a guess, please tell
> > > > a counter example if anyone happens to know, it could be easy.
> > > > 
> > > > 
> > > >> 
> > > >> >  			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
> > > >> >  				kmalloc_info[i].name[KMALLOC_DMA],
> > > >> >  				kmalloc_info[i].size,
> > > >> > -- 
> > > >> > 2.17.2
> > > >> > 
> > > >> > 
> > > >> 
> > > > 
> > > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
