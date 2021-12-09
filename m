Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvJOZ-00G5hB-6y
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 13:23:36 +0000
Date: Thu, 9 Dec 2021 21:23:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed
 dma zone exists
Message-ID: <20211209132314.GC3050@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-4-bhe@redhat.com>
 <0a9bc228-21ba-abe3-d9c8-b9d52b936366@redhat.com>
 <20211209130210.GB3050@MiWiFi-R3L-srv>
 <a5e172db-2be9-c5bc-a43e-9e9a1fb2a69c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5e172db-2be9-c5bc-a43e-9e9a1fb2a69c@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On 12/09/21 at 02:10pm, David Hildenbrand wrote:
......
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index c5952749ad40..ac0ea42a4e5f 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
> >>>  	spin_unlock_irqrestore(&zone->lock, flags);
> >>>  	return ret;
> >>>  }
> >>> +
> >>> +bool has_managed_dma(void)
> >>> +{
> >>> +	struct zone *zone;
> >>> +
> >>> +	for_each_managed_zone(zone) {
> >>> +		if (zone_is_dma(zone))
> >>> +			return true;
> >>> +	}
> >>> +	return false;
> >>> +}
> >>
> >> Wouldn't it be "easier/faster" to just iterate online nodes and directly
> >> obtain the ZONE_DMA, checking if there are managed pages?
> > 
> > Thanks, Dave.
> > 
> > Please check for_each_managed_zone(), it is iterating online nodes and
> > it's each managed zone. 
> > 
> > Is below what you are suggesting? The only difference is I introduced
> > for_each_managed_zone() which can be reused later if needed. Not sure if
> > I got your suggestion correctly.
> > 
> > bool has_managed_dma(void)
> > {
> >         struct pglist_data *pgdat;
> >         struct zone *zone;
> >         enum zone_type i, j;
> > 
> >         for_each_online_pgdat(pgdat) {
> >                 for (i = 0; i < MAX_NR_ZONES - 1; i++) {          
> >                         struct zone *zone = &pgdat->node_zones[i];
> >                         if (zone_is_dma(zone))                                                                                                    
> >                                 return true;
> >                 }
> >         }
> >         return false;
> > 
> > }
> 
> 
> Even simpler, no need to iterate over zones at all, only over nodes:
> 
> #ifdef CONFIG_ZONE_DMA
> bool has_managed_dma(void)
> {
> 	struct pglist_data *pgdat;
> 
> 	for_each_online_pgdat(pgdat) {
> 		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
> 
> 		if (managed_zone(zone)
> 			return true;
> 	}
> 	return false;
> }
> #endif /* CONFIG_ZONE_DMA */
> 
> Without CONFIG_ZONE_DMA, simply provide a dummy in the header that
> returns false.

Yeah, it only iterates the number of nodes times. I will take this in
v3. Thanks, David.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
