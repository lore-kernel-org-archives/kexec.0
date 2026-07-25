Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D44C531C9
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fI8EblvjWzjGCZk7JcnyrfLB78roRKFER5ZnFfas16U=; b=qxEhYDHLV8S5bxKfbZw3GO6Pqm
	J1lAGH9KPXw4+d21jmCp+1NoLY7aGP/UvU2FqtgOSZiFB9YVYCJGiofn162KZhxKolGQdTGO9p8/h
	AZO6OouH4ylNeGEKoMAuT9vXR/ADtD0yLj+HiMTXf46J38kofkFbznhkAX+ylyP8fI6qSx8UJL5BQ
	7evzfI3SU2JKFJGNT2KWd4OiJTJwZNvCBjEHf4RQevZjO68rBYNCq4hAyUpt2GgikFWds983GNGmL
	OoBvFbyQqocHCKkPKEFilgkC+jnMeyyXUwOBuLiAlwn1AmHuXx005To3ftOSdm5BTQNUEWLWlkn61
	kxSZ3vsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnejW-00000000VA9-0pG5;
	Sat, 25 Jul 2026 15:56:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnejU-00000000VA2-42Ez
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 15:56:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57739413C5;
	Sat, 25 Jul 2026 15:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDF01F000E9;
	Sat, 25 Jul 2026 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994972;
	bh=fI8EblvjWzjGCZk7JcnyrfLB78roRKFER5ZnFfas16U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kr4+GvU9/gKyPFM6yyLN+aKhTi7LD5HoR5e8OS2lwtoltA0FEPaMWfd5J4bKjkClc
	 IphZ1GcZ9QAt60rtotgq75gmGmCcTnKeHrz9aF+P5LLZgk4R8OZXMPGxunOyZd81Zt
	 UGUAZ5kORt54bbc8Jhr+kbJnMh1ENd0Ii6WCgkfiE7b/+EZy6qjKQ94YQh4BISGbBx
	 VR/nBed0i/FrUTEMDe/f5sYx+H0/n/NACV4olQaJQ62cFlx5a9lNzHqJYxmW4+wukk
	 q+mE7hgf1Xj0RajHCrKvMWgbGSyMD4vHzE99kKTR/S6I7rZyLFU/CQ6p4HcqEStaNE
	 +wpjJZZt/qsig==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/21] mm/mm_init: don't rely on memblock to get KHO
 scratch migratetype
In-Reply-To: <178410811939.820181.7932476003120213021.b4-review@b4> (Mike
	Rapoport's message of "Wed, 15 Jul 2026 12:35:19 +0300")
References: <20260709173821.429921-1-pratyush@kernel.org>
	<20260709173821.429921-18-pratyush@kernel.org>
	<178410811939.820181.7932476003120213021.b4-review@b4>
Date: Sat, 25 Jul 2026 17:56:08 +0200
Message-ID: <2vxzfr17gj1j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jul 15 2026, Mike Rapoport wrote:

>> Currently struct page init via memmap_init() or deferred_init_memmap()
>> only queries the migrate type from KHO for each discrete memory range.
>> That works currently since KHO scratch memory has a different memory
>> type so it is always it its own region.
>> 
>> An upcoming patch will add support for discovering blocks of memory with
>> no preservations and it will mark it as MEMBLOCK_KHO_SCRATCH to allow
>> allocations from them. This can lead to the bootmem KHO scratch areas to
>> be merged into larger free ranges. This merging breaks the selection of
>> migrate type.
>> 
>> Get rid of kho_scratch_migratetype(). Instead, let the struct page init
>> logic set the migratetype to MIGRATE_MOVABLE for all pages, and then
>> give KHO a chance to update the migrate type of its bootmem scratch
>> areas to MIGRATE_CMA. Since scratch areas should be a few order of
>> magnitues smaller than the total system memory, doing it this way is
>> more efficient than searching the kho_scratch array for every pageblock.
>
> It's true for non-deferred case, but with deferred initialization of
> struct pages the static part is small and deferred chunks are small, so
> we are going to update the migratetype nearly as much as we would check
> it with kho_scratch_migratetype().
>
> For simplicity of this patchset I'd keep kho_scratch_migratetype(), just
> move it over to kexec_handover.h and make it rely on kho_scratch_overlap().
>
> The bulk optimization can be a separate patch on top.

Sure, will do.

>
>> Since kho_scratch_migratetype() no longer exists, drop the migratetype
>> argument to memmap_init_zone_range() and deferred_init_pages().
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>>
[...]
>> +/*
>> + * Mark all KHO scratch pageblocks between start_pfn and end_pfn as
>> + * MIGRATE_CMA.
>> + */
>> +void kho_init_scratch_migratetype(unsigned long start_pfn, unsigned long end_pfn)
>> +{
>> +	for (unsigned int i = 0; i < kho_scratch_cnt; i++) {
>> +		unsigned long scratch_start, scratch_end, pfn;
>> +
>> +		scratch_start = PHYS_PFN(kho_scratch[i].addr);
>> +		scratch_end = PHYS_PFN(kho_scratch[i].addr + kho_scratch[i].size);
>> +
>> +		/* Target range doesn't overlap with scratch. */
>> +		if (start_pfn >= scratch_end || end_pfn <= scratch_start)
>> +			continue;
>> +
>> +		pfn = max_t(unsigned long, start_pfn, scratch_start);
>> +		pfn = pageblock_start_pfn(pfn);
>> +
>> +		while (pfn < end_pfn && pfn < scratch_end) {
>> +			init_pageblock_migratetype(pfn_to_page(pfn),
>> +						   MIGRATE_CMA, false);
>> +			pfn += pageblock_nr_pages;
>> +		}
>> +	}
>> +}
>
> static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
> 						       enum migratetype mt)
> {
> 	if (kho_scratch_overlap(PFN_PHYS(pfn)), PAGE_SIZE)
> 		return MIGRATE_CMA;
> 	return mt;
> }
>
> Is way easier to parse and reason about ;-)
>
>> +
>>  /**
>>   * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
>>   *
[...]
>> @@ -2012,8 +2021,7 @@ static inline void __init pgdat_init_report_one_done(void)
>>   * Return number of pages initialized.
>>   */
>>  static unsigned long __init deferred_init_pages(struct zone *zone,
>> -		unsigned long start_pfn, unsigned long end_pfn,
>> -		enum migratetype mt)
>> +		unsigned long start_pfn, unsigned long end_pfn)
>>  {
>>  	int nid = zone_to_nid(zone);
>>  	unsigned long nr_pages = end_pfn - start_pfn, pfn = start_pfn;
>> @@ -2027,7 +2035,14 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
>>  	pfn = pageblock_align(start_pfn);
>>  	page = pfn_to_page(pfn);
>>  	for (; pfn < end_pfn; pfn += pageblock_nr_pages, page += pageblock_nr_pages)
>> -		init_pageblock_migratetype(page, mt, false);
>> +		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
>> +
>> +	/*
>> +	 * Update the migrate type for any pageblocks that fall in a KHO scratch
>> +	 * area. Since most pageblocks will not be KHO scratch, do it outside
>> +	 * the loop to only do the search once.
>> +	 */
>> +	kho_init_scratch_migratetype(start_pfn, end_pfn);
>
> And here the chunks are at most MAX_ORDER_NR_PAGES, so bulk init also
> wouldn't save much.

Hmm, right. I didn't think of that. On my system pageblock order is 9
and max page order is 10, so it does halve the amount of work done, but
still, I see your point. It took me a couple of tries to get
kho_init_scratch_migratetype() right, and kho_scratch_overlap() is
certainly easier to reason about.

Oh well, I suppose this gets added to the list of performance
improvements we do at some point down the line

-- 
Regards,
Pratyush Yadav

