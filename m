Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X7fId-0002fA-GG
 for kexec@lists.infradead.org; Thu, 17 Jul 2014 06:36:16 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Date: Thu, 17 Jul 2014 06:33:56 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97241B99@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
 <20140617083447.166244e5@hananiah.suse.cz>
In-Reply-To: <20140617083447.166244e5@hananiah.suse.cz>
Content-Language: ja-JP
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

>> Hello,
>>
>> This is the v2 patch for hugepage filtering rebased on Petr's
>> "Generic multi-page exclusion", thanks Petr.
>>
>> The current kernel's VMCOREINFO doesn't include necessary values
>> for this patch, so we need "-x vmlinux" to enable hugepage filtering.
>> I tested this patch on kernel 3.13.
>>
>> Regarding this, Petr made effort to add the values to VMCOREINFO,
>> but it looks suspended:
>>
>>   https://lkml.org/lkml/2014/4/11/349
>
>Actually, I received an Acked-by from Vivek last Wednesday. Oh, wait a
>moment, this email went to Andrew Morton, but not to any mailing
>list. :-(
>
>> So, we should resume this discussion for this patch. Then,
>> I should modify this patch to use PG_head_mask if it's accepted.
>
>I have already experimented with hugepage filtering, but haven't sent
>my patches yet, precisely because they depend on a not-yet-confirmed
>feature in the kernel.
>
>Anyway, let's take your patch as base. I'll add my comments where I
>believe my approach was better/cleaner.

Sorry for the late reply and thanks for your comments.
I agree with you, so I'll post the fixed version soon.


Thanks
Atsushi Kumagai

>>  	/*
>>  	 * If a multi-page exclusion is pending, do it first
>> @@ -4727,6 +4779,27 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>>  		flags   = ULONG(pcache + OFFSET(page.flags));
>>  		_count  = UINT(pcache + OFFSET(page._count));
>>  		mapping = ULONG(pcache + OFFSET(page.mapping));
>> +
>> +		if (index_pg < PGMM_CACHED - 1) {
>> +			compound_order = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
>> +					       + OFFSET(list_head.prev));
>> +			hugetlb_dtor = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
>> +					     + OFFSET(list_head.next));
>> +		} else if (pfn + 1 < pfn_end) {
>
>AFAICS this clause is not needed. All compound pages are aligned to its
>page order, e.g. the head page of an order-2 compound page is aligned
>to a multiple of 4. Since mem_map cache is aligned to PGMM_CACHED,
>which is defined as 512 (that is power of 2), a compound page cannot
>possibly start on the last PFN of the cache.
>
>I even added a sanity check for the alignment:
>
>			if (order && order < sizeof(unsigned long) * 8 &&
>			    (pfn & ((1UL << order) - 1)) == 0)
>
>Ok, the "order" above corresponds to your "compound_order"...
>
>> +			unsigned char page_cache_next[SIZE(page)];
>> +			if (!readmem(VADDR, mem_map, page_cache_next, SIZE(page))) {
>> +				ERRMSG("Can't read the buffer of struct page.\n");
>> +				return FALSE;
>> +			}
>> +			compound_order = ULONG(page_cache_next + OFFSET(page.lru)
>> +					       + OFFSET(list_head.prev));
>> +			hugetlb_dtor = ULONG(page_cache_next + OFFSET(page.lru)
>> +					     + OFFSET(list_head.next));
>> +		} else {
>> +			compound_order = 0;
>> +			hugetlb_dtor = 0;
>> +		}
>> +
>>  		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
>>  			_mapcount = UINT(pcache + OFFSET(page._mapcount));
>>  		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
>> @@ -4754,6 +4827,10 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>>  		    && !isPrivate(flags) && !isAnon(mapping)) {
>>  			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>>  				pfn_cache++;
>> +			/*
>> +			 * NOTE: If THP for cache is introduced, the check for
>> +			 *       compound pages is needed here.
>> +			 */
>
>I do this differently. I added:
>
>		mdf_pfn_t *pfn_counter
>
>Then I set pfn_counter to the appropriate counter, but do not call
>clear_bit_on_2nd_bitmap_for_kernel(). At the end of the long
>if-else-if-else-if statement I add a final else-clause:
>
>		/*
>		 * Page not excluded
>		 */
>		else
>			continue;
>
>If execution gets here, the page is excluded, so I can do:
>
>		if (nr_pages == 1) {
>			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>				(*pfn_counter)++;
>		} else {
>			exclude_range(pfn_counter, pfn, pfn + nr_pages, cycle);
>		}
>
>What do you think?
>
>Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
