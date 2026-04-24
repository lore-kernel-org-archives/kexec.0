Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDFCFB44CA
	for <kexec@archiver.kernel.org>; Fri, 24 Apr 2026 08:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/d8iutfeRBc4rt+6EkV/tU8ld5/4v9ivToNBJ3BxGeU=; b=G+9dxG8GDEV+aTbJmMt8x01kzM
	M23RVgrF8QBtZafyFq0OeixW74zs9o1y1FJa4z9nApVzLygzTXuZ/UAB2vkTVSYsdbavYPEYCEkOU
	lkH7vfAcLuOo/J2MYXpyvY6Syop7yaYaxxztqpCf+rqhDmh8ZzxmnEVk0KVOjQDj+5AmhCVEkSnov
	ZE/TcOwUsNCyWIrqe8BTBMbBFlmCYwYVJSh40b9cJb+RkKu7NacOiNfAvTIeg5qzKdP7PqCIy2Y/6
	d+eYSENxGYibaOY4rUpoiFbne3L0iV/5ljF5NdvkTSHiSDrddbQ5mOrB/8QkD0RcTZ44ie6+P7LsK
	3BJT9Jjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGBf2-0000000CqgL-3ze7;
	Fri, 24 Apr 2026 08:13:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGBew-0000000CqfW-1HeP
	for kexec@lists.infradead.org;
	Fri, 24 Apr 2026 08:13:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D95F140940;
	Fri, 24 Apr 2026 08:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAA7C19425;
	Fri, 24 Apr 2026 08:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777018388;
	bh=qgvCxMI7V6qiyZyTa6rjMBoEoZe+9V9lvHMQ4vCYLNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p104CO/foXsz/Pf6Y2U1PSA7BMFxZkMCy4lhBNoln9aqcU8N/6nynR+UhKRFvK0mV
	 K6pHpRNTWV1EhcMs/77l0v2ZdnNe3zPlpMl0nyyE6XpI7qEQk56NkGcQMtc4iSehac
	 4mbv7PmPRbdtI8DnVbp/4xIf2pRshmbpnAYGkmnZwUca1f5luG/ebPXPKkO1xCA7vi
	 rNS6chXo9lOruhRxAhOFdC9c2J0N+sKsveLMlKb1GJbeUyPuvR2bCVErLaJ23rHoH1
	 6pyosZ0L1PY3VYolQwXgeD/1E5E2bdEQo2ARMzYwIBxTJPRhONcaSDGbogE4soO8oJ
	 7V5yC1SEicWIA==
Date: Fri, 24 Apr 2026 11:12:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 1/3] kho: fix deferred initialization of scratch areas
Message-ID: <aesmC_VVWQwfKAF8@kernel.org>
References: <20260423122538.140993-1-mclapinski@google.com>
 <20260423122538.140993-2-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122538.140993-2-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_011310_399456_5685CEAA 
X-CRM114-Status: GOOD (  27.23  )
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

On Thu, Apr 23, 2026 at 02:25:36PM +0200, Michal Clapinski wrote:
> Currently, if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled,
> kho_release_scratch() will initialize the struct pages and set migratetype
> of KHO scratch. Unless the whole scratch fits below first_deferred_pfn,
> some of that will be overwritten either by deferred_init_pages() or
> memmap_init_reserved_range().
> 
> To fix it, make memmap_init_range(), deferred_init_memmap_chunk() and
> __init_page_from_nid() recognize KHO scratch regions and set
> migratetype of pageblocks in those regions to MIGRATE_CMA.
> 
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/memblock.h           | 21 +++++++++--
>  kernel/liveupdate/kexec_handover.c | 25 -------------
>  mm/memblock.c                      | 56 ++++++++++++------------------
>  mm/mm_init.c                       | 30 +++++++++-------
>  4 files changed, 58 insertions(+), 74 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index b0f750d22a7b..5afcd99aa8c1 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -613,11 +613,28 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
>  #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>  void memblock_set_kho_scratch_only(void);
>  void memblock_clear_kho_scratch_only(void);
> -void memmap_init_kho_scratch_pages(void);
> +bool memblock_is_kho_scratch_memory(phys_addr_t addr);
> +
> +static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
> +						       enum migratetype mt)
> +{
> +	if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
> +		return MIGRATE_CMA;
> +	return mt;
> +}
>  #else
>  static inline void memblock_set_kho_scratch_only(void) { }
>  static inline void memblock_clear_kho_scratch_only(void) { }
> -static inline void memmap_init_kho_scratch_pages(void) {}
> +static inline bool memblock_is_kho_scratch_memory(phys_addr_t addr)
> +{
> +	return false;
> +}
> +
> +static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
> +						       enum migratetype mt)
> +{
> +	return mt;
> +}
>  #endif
>  
>  #endif /* _LINUX_MEMBLOCK_H */
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 18509d8082ea..a507366a2cf9 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1576,35 +1576,10 @@ static __init int kho_init(void)
>  }
>  fs_initcall(kho_init);
>  
> -static void __init kho_release_scratch(void)
> -{
> -	phys_addr_t start, end;
> -	u64 i;
> -
> -	memmap_init_kho_scratch_pages();
> -
> -	/*
> -	 * Mark scratch mem as CMA before we return it. That way we
> -	 * ensure that no kernel allocations happen on it. That means
> -	 * we can reuse it as scratch memory again later.
> -	 */
> -	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> -			     MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
> -		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
> -		ulong end_pfn = pageblock_align(PFN_UP(end));
> -		ulong pfn;
> -
> -		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
> -			init_pageblock_migratetype(pfn_to_page(pfn),
> -						   MIGRATE_CMA, false);
> -	}
> -}
> -
>  void __init kho_memory_init(void)
>  {
>  	if (kho_in.scratch_phys) {
>  		kho_scratch = phys_to_virt(kho_in.scratch_phys);
> -		kho_release_scratch();
>  
>  		if (kho_mem_retrieve(kho_get_fdt()))
>  			kho_in.fdt_phys = 0;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a6a1c91e276d..01a962681726 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1026,40 +1026,6 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
>  }
>  #endif
>  
> -#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> -__init void memblock_set_kho_scratch_only(void)
> -{
> -	kho_scratch_only = true;
> -}
> -
> -__init void memblock_clear_kho_scratch_only(void)
> -{
> -	kho_scratch_only = false;
> -}
> -
> -__init void memmap_init_kho_scratch_pages(void)
> -{
> -	phys_addr_t start, end;
> -	unsigned long pfn;
> -	int nid;
> -	u64 i;
> -
> -	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
> -		return;
> -
> -	/*
> -	 * Initialize struct pages for free scratch memory.
> -	 * The struct pages for reserved scratch memory will be set up in
> -	 * memmap_init_reserved_pages()
> -	 */
> -	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> -			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
> -		for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
> -			init_deferred_page(pfn, nid);
> -	}
> -}
> -#endif
> -
>  /**
>   * memblock_setclr_flag - set or clear flag for a memory region
>   * @type: memblock type to set/clear flag for
> @@ -2533,6 +2499,28 @@ int reserve_mem_release_by_name(const char *name)
>  	return 1;
>  }
>  
> +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> +__init void memblock_set_kho_scratch_only(void)
> +{
> +	kho_scratch_only = true;
> +}
> +
> +__init void memblock_clear_kho_scratch_only(void)
> +{
> +	kho_scratch_only = false;
> +}
> +
> +bool __init_memblock memblock_is_kho_scratch_memory(phys_addr_t addr)
> +{
> +	int i = memblock_search(&memblock.memory, addr);
> +
> +	if (i == -1)
> +		return false;
> +
> +	return memblock_is_kho_scratch(&memblock.memory.regions[i]);
> +}
> +#endif
> +
>  #ifdef CONFIG_KEXEC_HANDOVER
>  
>  static int __init reserved_mem_preserve(void)
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..eddc0f03a779 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -692,9 +692,11 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid)
>  	}
>  	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
>  
> -	if (pageblock_aligned(pfn))
> -		init_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE,
> -				false);
> +	if (pageblock_aligned(pfn)) {
> +		enum migratetype mt =
> +			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
> +		init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
> +	}
>  }
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> @@ -927,7 +929,8 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>  static void __init memmap_init_zone_range(struct zone *zone,
>  					  unsigned long start_pfn,
>  					  unsigned long end_pfn,
> -					  unsigned long *hole_pfn)
> +					  unsigned long *hole_pfn,
> +					  enum migratetype mt)
>  {
>  	unsigned long zone_start_pfn = zone->zone_start_pfn;
>  	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
> @@ -940,8 +943,7 @@ static void __init memmap_init_zone_range(struct zone *zone,
>  		return;
>  
>  	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
> -			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE,
> -			  false);
> +			  zone_end_pfn, MEMINIT_EARLY, NULL, mt, false);
>  
>  	if (*hole_pfn < start_pfn)
>  		init_unavailable_range(*hole_pfn, start_pfn, zone_id, nid);
> @@ -957,6 +959,8 @@ static void __init memmap_init(void)
>  
>  	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
>  		struct pglist_data *node = NODE_DATA(nid);
> +		enum migratetype mt =
> +			kho_scratch_migratetype(start_pfn, MIGRATE_MOVABLE);
>  
>  		for (j = 0; j < MAX_NR_ZONES; j++) {
>  			struct zone *zone = node->node_zones + j;
> @@ -965,7 +969,7 @@ static void __init memmap_init(void)
>  				continue;
>  
>  			memmap_init_zone_range(zone, start_pfn, end_pfn,
> -					       &hole_pfn);
> +					       &hole_pfn, mt);
>  			zone_id = j;
>  		}
>  	}
> @@ -1970,7 +1974,7 @@ unsigned long __init node_map_pfn_alignment(void)
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  static void __init deferred_free_pages(unsigned long pfn,
> -		unsigned long nr_pages)
> +		unsigned long nr_pages, enum migratetype mt)
>  {
>  	struct page *page;
>  	unsigned long i;
> @@ -1983,8 +1987,7 @@ static void __init deferred_free_pages(unsigned long pfn,
>  	/* Free a large naturally-aligned chunk if possible */
>  	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
>  		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
> -			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
> -					false);
> +			init_pageblock_migratetype(page + i, mt, false);
>  		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
>  		return;
>  	}
> @@ -1994,8 +1997,7 @@ static void __init deferred_free_pages(unsigned long pfn,
>  
>  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>  		if (pageblock_aligned(pfn))
> -			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
> -					false);
> +			init_pageblock_migratetype(page, mt, false);
>  		__free_pages_core(page, 0, MEMINIT_EARLY);
>  	}
>  }
> @@ -2053,6 +2055,8 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  	for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
>  		unsigned long spfn = PFN_UP(start);
>  		unsigned long epfn = PFN_DOWN(end);
> +		enum migratetype mt =
> +			kho_scratch_migratetype(spfn, MIGRATE_MOVABLE);
>  
>  		if (spfn >= end_pfn)
>  			break;
> @@ -2065,7 +2069,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  			unsigned long chunk_end = min(mo_pfn, epfn);
>  
>  			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
> -			deferred_free_pages(spfn, chunk_end - spfn);
> +			deferred_free_pages(spfn, chunk_end - spfn, mt);
>  
>  			spfn = chunk_end;
>  
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 

-- 
Sincerely yours,
Mike.

