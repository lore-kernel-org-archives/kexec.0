Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvJBx-00G0t5-CM
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 13:10:36 +0000
Received: by mail-wr1-f70.google.com with SMTP id
 r2-20020adfe682000000b00198af042b0dso1377454wrm.23
 for <kexec@lists.infradead.org>; Thu, 09 Dec 2021 05:10:28 -0800 (PST)
Message-ID: <a5e172db-2be9-c5bc-a43e-9e9a1fb2a69c@redhat.com>
Date: Thu, 9 Dec 2021 14:10:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed
 dma zone exists
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-4-bhe@redhat.com>
 <0a9bc228-21ba-abe3-d9c8-b9d52b936366@redhat.com>
 <20211209130210.GB3050@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20211209130210.GB3050@MiWiFi-R3L-srv>
Content-Language: en-US
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On 09.12.21 14:02, Baoquan He wrote:
> On 12/07/21 at 12:23pm, David Hildenbrand wrote:
>> On 07.12.21 04:07, Baoquan He wrote:
>>> In some places of the current kernel, it assumes that dma zone must have
>>> managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
>>> E.g in kdump kernel of x86_64, only low 1M is presented and locked down
>>> at very early stage of boot, so that there's no managed pages at all in
>>> DMA zone. This exception will always cause page allocation failure if page
>>> is requested from DMA zone.
>>>
>>> Here add function has_managed_dma() and the relevant helper functions to
>>> check if there's DMA zone with managed pages. It will be used in later
>>> patches.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>  include/linux/mmzone.h | 21 +++++++++++++++++++++
>>>  mm/page_alloc.c        | 11 +++++++++++
>>>  2 files changed, 32 insertions(+)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 58e744b78c2c..82d23e13e0e5 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -998,6 +998,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
>>>  }
>>>  #endif
>>>  
>>> +#ifdef CONFIG_ZONE_DMA
>>> +static inline bool zone_is_dma(struct zone *zone)
>>> +{
>>> +	return zone_idx(zone) == ZONE_DMA;
>>> +}
>>> +#else
>>> +static inline bool zone_is_dma(struct zone *zone)
>>> +{
>>> +	return false;
>>> +}
>>> +#endif
>>> +
>>>  /*
>>>   * Returns true if a zone has pages managed by the buddy allocator.
>>>   * All the reclaim decisions have to use this function rather than
>>> @@ -1046,6 +1058,7 @@ static inline int is_highmem_idx(enum zone_type idx)
>>>  #endif
>>>  }
>>>  
>>> +bool has_managed_dma(void);
>>>  /**
>>>   * is_highmem - helper function to quickly check if a struct zone is a
>>>   *              highmem zone or not.  This is an attempt to keep references
>>> @@ -1131,6 +1144,14 @@ extern struct zone *next_zone(struct zone *zone);
>>>  			; /* do nothing */		\
>>>  		else
>>>  
>>> +#define for_each_managed_zone(zone)		        \
>>> +	for (zone = (first_online_pgdat())->node_zones; \
>>> +	     zone;					\
>>> +	     zone = next_zone(zone))			\
>>> +		if (!managed_zone(zone))		\
>>> +			; /* do nothing */		\
>>> +		else
>>> +
>>>  static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>>>  {
>>>  	return zoneref->zone;
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index c5952749ad40..ac0ea42a4e5f 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
>>>  	spin_unlock_irqrestore(&zone->lock, flags);
>>>  	return ret;
>>>  }
>>> +
>>> +bool has_managed_dma(void)
>>> +{
>>> +	struct zone *zone;
>>> +
>>> +	for_each_managed_zone(zone) {
>>> +		if (zone_is_dma(zone))
>>> +			return true;
>>> +	}
>>> +	return false;
>>> +}
>>
>> Wouldn't it be "easier/faster" to just iterate online nodes and directly
>> obtain the ZONE_DMA, checking if there are managed pages?
> 
> Thanks, Dave.
> 
> Please check for_each_managed_zone(), it is iterating online nodes and
> it's each managed zone. 
> 
> Is below what you are suggesting? The only difference is I introduced
> for_each_managed_zone() which can be reused later if needed. Not sure if
> I got your suggestion correctly.
> 
> bool has_managed_dma(void)
> {
>         struct pglist_data *pgdat;
>         struct zone *zone;
>         enum zone_type i, j;
> 
>         for_each_online_pgdat(pgdat) {
>                 for (i = 0; i < MAX_NR_ZONES - 1; i++) {          
>                         struct zone *zone = &pgdat->node_zones[i];
>                         if (zone_is_dma(zone))                                                                                                    
>                                 return true;
>                 }
>         }
>         return false;
> 
> }


Even simpler, no need to iterate over zones at all, only over nodes:

#ifdef CONFIG_ZONE_DMA
bool has_managed_dma(void)
{
	struct pglist_data *pgdat;

	for_each_online_pgdat(pgdat) {
		struct zone *zone = &pgdat->node_zones[ZONE_DMA];

		if (managed_zone(zone)
			return true;
	}
	return false;
}
#endif /* CONFIG_ZONE_DMA */

Without CONFIG_ZONE_DMA, simply provide a dummy in the header that
returns false.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
