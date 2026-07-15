Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E89CC44507
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZxhqUqL6VNbNyZFCdKcNsdAw/uVN9dxe+gjlc32eLs=; b=jrYZAphFKJZSj4BI4oFc58H1ef
	81DiDL0b7bviALkpD3Txo70iMillZcv12MSCtavsQFTSmUP2VSUsFOnsw3Lgvr1jEvlXbHFoSqpqv
	oIFI7gTXHWORptxZbVgNYatCeUG1LQvNKNmWGYU52yBQHAqgl93fNFA1lvLyJbwUBHOvXtgWlvGIq
	1sx5hP8vXjqtYBlqUql7yI8VWcIy6+btK+FhIxpPMv2jdcr9NU5XKetNFLPkbTIFsXH0rHjbWvHBG
	oLXGg0KE3U+9j8mBEbJd7DvZv76y4anh7ZcfAPc1N7RBWkbZr0aGeAnNu1FwRoRjwjLshC4WY2NIP
	pfmL17bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1h-0000000EKuz-2o6s;
	Wed, 15 Jul 2026 09:35:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1h-0000000EKuZ-0sR5
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 09:35:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A4CC0601EB;
	Wed, 15 Jul 2026 09:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8741F00A3E;
	Wed, 15 Jul 2026 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108136;
	bh=9ZxhqUqL6VNbNyZFCdKcNsdAw/uVN9dxe+gjlc32eLs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JDwNLEHKiutYg6vJsp6YCzzNz2X9LK/771GvOVcHqbkUB8suf8mHCsTKnRRvwBLtL
	 Esyg1UyRIbUcHHEoUznjadW90xIy7ckjcTUvQ2lG486wmX3g4BQpFzmxow5IWLa01X
	 oZ5EszppzV2K2YtpNixGdpUt7Nia7/v9TEJn969iL2ZKQAva3zX3+dd1Yng1wqZh43
	 TaP0Nyl2Sqlk1BVg+Vt17dJOJf6PUfJZfpLJQ77TL9DzjbQhSEcKMskT7SW0Xpu1vg
	 LzLDXJRO8rxNdk6XfiJQROXwuOTv9OwDJQ2ogu5tEM7bubMgzlbPSkAfjL9Gzodx4e
	 7Q24gGIq/W+EQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 17/21] mm/mm_init: don't rely on memblock to get KHO
 scratch migratetype
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260709173821.429921-18-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
 <20260709173821.429921-18-pratyush@kernel.org>
Date: Wed, 15 Jul 2026 12:35:19 +0300
Message-Id: <178410811939.820181.7932476003120213021.b4-review@b4>
X-Mailer: b4 0.16-dev
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

> Currently struct page init via memmap_init() or deferred_init_memmap()
> only queries the migrate type from KHO for each discrete memory range.
> That works currently since KHO scratch memory has a different memory
> type so it is always it its own region.
> 
> An upcoming patch will add support for discovering blocks of memory with
> no preservations and it will mark it as MEMBLOCK_KHO_SCRATCH to allow
> allocations from them. This can lead to the bootmem KHO scratch areas to
> be merged into larger free ranges. This merging breaks the selection of
> migrate type.
> 
> Get rid of kho_scratch_migratetype(). Instead, let the struct page init
> logic set the migratetype to MIGRATE_MOVABLE for all pages, and then
> give KHO a chance to update the migrate type of its bootmem scratch
> areas to MIGRATE_CMA. Since scratch areas should be a few order of
> magnitues smaller than the total system memory, doing it this way is
> more efficient than searching the kho_scratch array for every pageblock.

It's true for non-deferred case, but with deferred initialization of
struct pages the static part is small and deferred chunks are small, so
we are going to update the migratetype nearly as much as we would check
it with kho_scratch_migratetype().

For simplicity of this patchset I'd keep kho_scratch_migratetype(), just
move it over to kexec_handover.h and make it rely on kho_scratch_overlap().

The bulk optimization can be a separate patch on top.

> Since kho_scratch_migratetype() no longer exists, drop the migratetype
> argument to memmap_init_zone_range() and deferred_init_pages().
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 18ba417f1ada6..30a71710565a3 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -39,6 +39,7 @@ void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
>  		  u64 scratch_len);
>  
>  bool kho_scratch_overlap(phys_addr_t phys, size_t size);
> +void kho_init_scratch_migratetype(unsigned long start_pfn, unsigned long end_pfn);
>  #else
>  static inline bool kho_is_enabled(void)
>  {
> @@ -122,6 +123,11 @@ static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
>  {
>  	return false;
>  }
> +
> +static inline void kho_init_scratch_migratetype(unsigned long start_pfn,
> +						unsigned long end_pfn);
> +{
> +}
>  #endif /* CONFIG_KEXEC_HANDOVER */
>  
>  #endif /* LINUX_KEXEC_HANDOVER_H */
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 5afcd99aa8c14..f142c8a8cd5b7 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -613,28 +613,9 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
>  #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>  void memblock_set_kho_scratch_only(void);
>  void memblock_clear_kho_scratch_only(void);
> -bool memblock_is_kho_scratch_memory(phys_addr_t addr);
> -
> -static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
> -						       enum migratetype mt)
> -{
> -	if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
> -		return MIGRATE_CMA;
> -	return mt;
> -}
>  #else
>  static inline void memblock_set_kho_scratch_only(void) { }
>  static inline void memblock_clear_kho_scratch_only(void) { }
> -static inline bool memblock_is_kho_scratch_memory(phys_addr_t addr)
> -{
> -	return false;
> -}
> -
> -static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
> -						       enum migratetype mt)
> -{
> -	return mt;
> -}
>  #endif
>  
>  #endif /* _LINUX_MEMBLOCK_H */
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6e8682469bd7c..b400976851e76 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -781,6 +781,33 @@ bool kho_scratch_overlap(phys_addr_t phys, size_t size)
>  	return false;
>  }
>  
> +/*
> + * Mark all KHO scratch pageblocks between start_pfn and end_pfn as
> + * MIGRATE_CMA.
> + */
> +void kho_init_scratch_migratetype(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	for (unsigned int i = 0; i < kho_scratch_cnt; i++) {
> +		unsigned long scratch_start, scratch_end, pfn;
> +
> +		scratch_start = PHYS_PFN(kho_scratch[i].addr);
> +		scratch_end = PHYS_PFN(kho_scratch[i].addr + kho_scratch[i].size);
> +
> +		/* Target range doesn't overlap with scratch. */
> +		if (start_pfn >= scratch_end || end_pfn <= scratch_start)
> +			continue;
> +
> +		pfn = max_t(unsigned long, start_pfn, scratch_start);
> +		pfn = pageblock_start_pfn(pfn);
> +
> +		while (pfn < end_pfn && pfn < scratch_end) {
> +			init_pageblock_migratetype(pfn_to_page(pfn),
> +						   MIGRATE_CMA, false);
> +			pfn += pageblock_nr_pages;
> +		}
> +	}
> +}

static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
						       enum migratetype mt)
{
	if (kho_scratch_overlap(PFN_PHYS(pfn)), PAGE_SIZE)
		return MIGRATE_CMA;
	return mt;
}

Is way easier to parse and reason about ;-)

> +
>  /**
>   * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
>   *
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 6349c48154f4b..8b2e551435ae9 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2511,16 +2511,6 @@ __init void memblock_clear_kho_scratch_only(void)
>  {
>  	kho_scratch_only = false;
>  }
> -
> -bool __init_memblock memblock_is_kho_scratch_memory(phys_addr_t addr)
> -{
> -	int i = memblock_search(&memblock.memory, addr);
> -
> -	if (i == -1)
> -		return false;
> -
> -	return memblock_is_kho_scratch(&memblock.memory.regions[i]);
> -}
>  #endif
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index bd9dc1829005b..1d2f302d8cd9c 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -707,9 +707,10 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid)
>  	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
>  
>  	if (pageblock_aligned(pfn)) {
> -		enum migratetype mt =
> -			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
> -		init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
> +		init_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE,
> +					   false);
> +		/* Update the migrate type in case it is KHO scratch. */
> +		kho_init_scratch_migratetype(pfn, pfn + 1);

Calling kho_init_scratch_migratetype() instead of
kho_scratch_migratetype() here won't have any benefit, right?

A better optimization would be to call kho_init_scratch_migratetype()
from memmap_init_reserved_range() I think.

>  	}
>  }
>  
> @@ -938,13 +939,22 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>  		}
>  		pfn++;
>  	}
> +
> +	/*
> +	 * Update the migrate type for any pageblocks that fall in a KHO scratch
> +	 * area. Do this here outside the loop because most pageblocks will not
> +	 * be KHO scratch, so only search once.
> +	 *
> +	 * Only pageblocks up to pfn are updated, deferred pageblocks will be
> +	 * updated later.
> +	 */
> +	kho_init_scratch_migratetype(start_pfn, pfn);

It's no relevant for memory hotplug or ZONE_DEVICE so ideally this
should have been in memmap_init_zone_range() and somehow take into
account first_deferred_pfn. And then it becomes hairy :)

>  }
>  
>  static void __init memmap_init_zone_range(struct zone *zone,
>  					  unsigned long start_pfn,
>  					  unsigned long end_pfn,
> -					  unsigned long *hole_pfn,
> -					  enum migratetype mt)
> +					  unsigned long *hole_pfn)
>  {
>  	unsigned long zone_start_pfn = zone->zone_start_pfn;
>  	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
> @@ -957,7 +967,8 @@ static void __init memmap_init_zone_range(struct zone *zone,
>  		return;
>  
>  	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
> -			  zone_end_pfn, MEMINIT_EARLY, NULL, mt, false);
> +			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE,
> +			  false);
>  
>  	if (*hole_pfn < start_pfn)
>  		init_unavailable_range(*hole_pfn, start_pfn, zone_id, nid);
> @@ -973,8 +984,6 @@ static void __init memmap_init(void)
>  
>  	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
>  		struct pglist_data *node = NODE_DATA(nid);
> -		enum migratetype mt =
> -			kho_scratch_migratetype(start_pfn, MIGRATE_MOVABLE);
>  
>  		for (j = 0; j < MAX_NR_ZONES; j++) {
>  			struct zone *zone = node->node_zones + j;
> @@ -983,7 +992,7 @@ static void __init memmap_init(void)
>  				continue;
>  
>  			memmap_init_zone_range(zone, start_pfn, end_pfn,
> -					       &hole_pfn, mt);
> +					       &hole_pfn);
>  			zone_id = j;
>  		}
>  	}
> @@ -1973,7 +1982,7 @@ unsigned long __init node_map_pfn_alignment(void)
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  static void __init deferred_free_pages(unsigned long pfn,
> -		unsigned long nr_pages, enum migratetype mt)
> +		unsigned long nr_pages)
>  {
>  	struct page *page;
>  	unsigned long i;
> @@ -2012,8 +2021,7 @@ static inline void __init pgdat_init_report_one_done(void)
>   * Return number of pages initialized.
>   */
>  static unsigned long __init deferred_init_pages(struct zone *zone,
> -		unsigned long start_pfn, unsigned long end_pfn,
> -		enum migratetype mt)
> +		unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	int nid = zone_to_nid(zone);
>  	unsigned long nr_pages = end_pfn - start_pfn, pfn = start_pfn;
> @@ -2027,7 +2035,14 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
>  	pfn = pageblock_align(start_pfn);
>  	page = pfn_to_page(pfn);
>  	for (; pfn < end_pfn; pfn += pageblock_nr_pages, page += pageblock_nr_pages)
> -		init_pageblock_migratetype(page, mt, false);
> +		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
> +
> +	/*
> +	 * Update the migrate type for any pageblocks that fall in a KHO scratch
> +	 * area. Since most pageblocks will not be KHO scratch, do it outside
> +	 * the loop to only do the search once.
> +	 */
> +	kho_init_scratch_migratetype(start_pfn, end_pfn);

And here the chunks are at most MAX_ORDER_NR_PAGES, so bulk init also
wouldn't save much.

-- 
Sincerely yours,
Mike.


