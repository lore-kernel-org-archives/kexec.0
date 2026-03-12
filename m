Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9C9105A591
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIsfMs4j+lPCS4kIfeqCQLjUfqJKP3anmoLjCcByYnQ=; b=nUQ5g5K5vLmrycYgjthy7N7KhW
	eF3cR/0g9SYXpl5J+7OxWwCutsKj9n+8M35jLM5/p/SM0xQ13AhBJuSuWmW/YcmaEw3BkmPTuslWv
	R0KkAnw1lxc8qnwj9FKxN3Z7wQIf/dtKZwpuQX/Wmf4a0NBYbyVPXOSpYRW9jxtF5P2plcajrwe8Y
	Y1+n6Xi53uO1GWSrhlXvwGrS2+olj2f9StZ6Wt78XR9QdZHQnwZdgZE+qnaFvMY6lGHgjDjHImH5R
	i5I0w0At0Vv6zuKmQ5f3g43tIZ63NeOoMTTip1wYWJkcAmPdCSGt5Zp+Ivzye5gPT96jzKVUzGxzq
	TJ2lSpBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0fV2-0000000E4mk-1zuj;
	Thu, 12 Mar 2026 12:50:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0fV0-0000000E4me-2Zpl
	for kexec@lists.infradead.org;
	Thu, 12 Mar 2026 12:50:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B853260137;
	Thu, 12 Mar 2026 12:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFCAC4CEF7;
	Thu, 12 Mar 2026 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773319845;
	bh=MzjiPuohtEDKGClma5RuGX7Y58HlTMD2rexIjeLhUVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY3KJESrb6TNmp8o0a6KrYC64NHrIYA4JAeYmam/HwkseNmkd8XFZAHVgDqTUIYz+
	 aFmhAqDKX/q9jikQ/fDwk2LeooeXi3bu7QKmIBVFfhWGT2KyXT/kWgXjxcEv41Lptw
	 MDOLCdOf+YEiBrxKWl1Y64zL3K2wWPQ8nBLnNPrg9sMwLSDMQK5k/9wMVY0m18uBND
	 QRopgqmgWpMNXujD03tBd5P6syvdFOemy8RJQ56eAIExnGSDPp73MAeKGao6eczUVq
	 8I/Rx6Uv+91F8V2DAYKMTdDqVpaGj+tiqYdmH56N2V1EJmqeAqCDE1gJnm1K++7OwD
	 CWtArJTQ7JWCA==
Date: Thu, 12 Mar 2026 14:50:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 1/2] kho: fix deferred init of kho scratch
Message-ID: <abK2ntdGDpDS35J1@kernel.org>
References: <20260311125539.4123672-1-mclapinski@google.com>
 <20260311125539.4123672-2-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311125539.4123672-2-mclapinski@google.com>
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

On Wed, Mar 11, 2026 at 01:55:38PM +0100, Michal Clapinski wrote:
> Currently, if DEFERRED is enabled, kho_release_scratch will initialize
> the struct pages and set migratetype of kho scratch. Unless the whole
> scratch fit below first_deferred_pfn, some of that will be overwritten
> either by deferred_init_pages or memmap_init_reserved_pages.
> 
> To fix it, I initialize kho scratch early and modify every other
> path to leave the scratch alone.
> 
> In detail:
> 1. Modify deferred_init_memmap_chunk to not initialize kho
> scratch, since we already did that. Then, modify deferred_free_pages
> to not set the migratetype. Also modify reserve_bootmem_region to skip
> initializing kho scratch.
> 
> 2. Since kho scratch is now not initialized by any other code, we have
> to initialize it ourselves also on cold boot. On cold boot memblock
> doesn't mark scratch as scratch, so we also have to modify the
> initialization function to not use memblock regions.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> My previous idea of marking scratch as CMA late, after deferred struct
> page init was done, was bad since allocations can be made before that
> and if they land in kho scratch, they become unpreservable.
> Such was the case with iommu page tables.
> ---
>  include/linux/kexec_handover.h     |  6 +++++
>  include/linux/memblock.h           |  2 --
>  kernel/liveupdate/kexec_handover.c | 35 +++++++++++++++++++++++++++++-
>  mm/memblock.c                      | 22 -------------------
>  mm/mm_init.c                       | 17 ++++++++++-----
>  5 files changed, 52 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index ac4129d1d741..612a6da6127a 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -35,6 +35,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
>  int kho_add_subtree(const char *name, void *fdt);
>  void kho_remove_subtree(void *fdt);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
> +bool pfn_is_kho_scratch(unsigned long pfn);

I think we can rely on MEMBLOCK_KHO_SCRATCH and query ranges rather than
individual pfns.

This will also eliminate the need to special case scratch memory map
initialization on cold boot. 

>  void kho_memory_init(void);
>  
> @@ -109,6 +110,11 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline bool pfn_is_kho_scratch(unsigned long pfn)
> +{
> +	return false;
> +}
> +
>  static inline void kho_memory_init(void) { }
>  
>  static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 6ec5e9ac0699..3e217414e12d 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -614,11 +614,9 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
>  #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>  void memblock_set_kho_scratch_only(void);
>  void memblock_clear_kho_scratch_only(void);
> -void memmap_init_kho_scratch_pages(void);
>  #else
>  static inline void memblock_set_kho_scratch_only(void) { }
>  static inline void memblock_clear_kho_scratch_only(void) { }
> -static inline void memmap_init_kho_scratch_pages(void) {}
>  #endif
>  
>  #endif /* _LINUX_MEMBLOCK_H */
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 532f455c5d4f..09cb6660ade7 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1327,6 +1327,23 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  }
>  EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
>  
> +bool pfn_is_kho_scratch(unsigned long pfn)
> +{
> +	unsigned int i;
> +	phys_addr_t scratch_start, scratch_end, phys = __pfn_to_phys(pfn);
> +
> +	for (i = 0; i < kho_scratch_cnt; i++) {
> +		scratch_start = kho_scratch[i].addr;
> +		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
> +
> +		if (scratch_start <= phys && phys < scratch_end)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pfn_is_kho_scratch);
> +
>  static int __init kho_mem_retrieve(const void *fdt)
>  {
>  	struct kho_radix_tree tree;
> @@ -1453,12 +1470,27 @@ static __init int kho_init(void)
>  }
>  fs_initcall(kho_init);
>  
> +static void __init kho_init_scratch_pages(void)
> +{
> +	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
> +		return;
> +
> +	for (int i = 0; i < kho_scratch_cnt; i++) {
> +		unsigned long pfn = PFN_DOWN(kho_scratch[i].addr);
> +		unsigned long end_pfn = PFN_UP(kho_scratch[i].addr + kho_scratch[i].size);
> +		int nid = early_pfn_to_nid(pfn);
> +
> +		for (; pfn < end_pfn; pfn++)
> +			init_deferred_page(pfn, nid);
> +	}
> +}
> +
>  static void __init kho_release_scratch(void)
>  {
>  	phys_addr_t start, end;
>  	u64 i;
>  
> -	memmap_init_kho_scratch_pages();
> +	kho_init_scratch_pages();

This should not be required if deferred init would check if a region is
MEMBLOCK_KHO_SCRATCH rather than pfn_is_kho_scratch().

>  	/*
>  	 * Mark scratch mem as CMA before we return it. That way we
> @@ -1487,6 +1519,7 @@ void __init kho_memory_init(void)
>  			kho_in.fdt_phys = 0;
>  	} else {
>  		kho_reserve_scratch();
> +		kho_init_scratch_pages();
>  	}
>  }
>  
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b3ddfdec7a80..ae6a5af46bd7 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -959,28 +959,6 @@ __init void memblock_clear_kho_scratch_only(void)
>  {
>  	kho_scratch_only = false;
>  }
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
> -	 * reserve_bootmem_region()
> -	 */
> -	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> -			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
> -		for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
> -			init_deferred_page(pfn, nid);
> -	}
> -}
>  #endif
>  
>  /**
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index cec7bb758bdd..969048f9b320 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -798,7 +798,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
>  	for_each_valid_pfn(pfn, PFN_DOWN(start), PFN_UP(end)) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_deferred_page(pfn, nid);
> +		if (!pfn_is_kho_scratch(pfn))
> +			__init_deferred_page(pfn, nid);

A bit unrelated, we can move reserve_bootmem_region() to memblock and make
it static.

As for skipping the initialization of, I think that
memmap_init_reserved_pages() should check if the region to reserve is in
scratch and if yes, make reserve_bootmem_region() to skip struct page
initialization.
I believe everything that is MEMBLOCK_RSRV_KERNEL would be in scratch and
all reserved memory in scratch would be MEMBLOCK_RSRV_KERNEL, but it's
better to double check it.

Another somewhat related thing, is that __init_page_from_nid() shouldn't
mess with pageblock migrate types, but only call __init_single_page().
It's up to __init_page_from_nid() caller to decide what migrate type to
use and the caller should set it explicitly.

>  
>  		/*
>  		 * no need for atomic set_bit because the struct
> @@ -2008,9 +2009,12 @@ static void __init deferred_free_pages(unsigned long pfn,
>  
>  	/* Free a large naturally-aligned chunk if possible */
>  	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
> -		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
> +		for (i = 0; i < nr_pages; i += pageblock_nr_pages) {
> +			if (pfn_is_kho_scratch(page_to_pfn(page + i)))
> +				continue;
>  			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
>  					false);

We can move init_pageblock_migratetype() here and below to
deferred_init_pages() and ...

> +		}
>  		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
>  		return;
>  	}
> @@ -2019,7 +2023,7 @@ static void __init deferred_free_pages(unsigned long pfn,
>  	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
>  
>  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
> -		if (pageblock_aligned(pfn))
> +		if (pageblock_aligned(pfn) && !pfn_is_kho_scratch(pfn))
>  			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
>  					false);
>  		__free_pages_core(page, 0, MEMINIT_EARLY);
> @@ -2090,9 +2094,11 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
>  			unsigned long chunk_end = min(mo_pfn, epfn);
>  
> -			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
> -			deferred_free_pages(spfn, chunk_end - spfn);
> +			// KHO scratch is MAX_ORDER_NR_PAGES aligned.
> +			if (!pfn_is_kho_scratch(spfn))
> +				deferred_init_pages(zone, spfn, chunk_end);

skip the entire MEMBLOCK_KHO_SCRATCH regions here and only call
deferred_free_pages() for them.

Since the outer loop already walks regions in memblock.memory it shouldn't
be hard to query memblock_region flags from the iterator, or just replace
the simplified iterator with __for_each_mem_range().
  
> +			deferred_free_pages(spfn, chunk_end - spfn);
>  			spfn = chunk_end;
>  
>  			if (can_resched)
> @@ -2100,6 +2106,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  			else
>  				touch_nmi_watchdog();
>  		}
> +		nr_pages += epfn - spfn;
>  	}
>  
>  	return nr_pages;
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

-- 
Sincerely yours,
Mike.

