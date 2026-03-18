Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B147210854D7
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ka9ekrAm+PRtEIBddzjSTlGztFbLJbLcrB/yL7pqAII=; b=T56ln4kh+xAlwhylQuLKqx6Y3g
	p1gtfjiJ67KnNCjWGPyx89CEtn7Iu0HzBxfz90RsqG3CUIR0Uz002WNy/juiiJBpwPffhatt0misq
	xlVyl+/Qzj2p3GWfPN62ZTjoMYIYT3ji3LiipmpSQrk5z8Vp/wBMpgpvPlufFX2pVbsHz+zFyG+bY
	8vNYaNiNsKug9p3oPZhH1VAjA6X5A47qzuHKXHles5pOfCuyr9uO53VtaDRfDt+wKVCiL8WHzlPN9
	a2HnZ2Bd9LaL+vSilfZjh194TMjQpxvVumAIvXT1U+3VbrE6gq6axphotXSmTxf05BZHQZ+pTg0x1
	ePyeuizw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2nHA-000000089OD-3OS6;
	Wed, 18 Mar 2026 09:33:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2nH8-000000089Ne-0Rsi
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 09:33:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C628431CD;
	Wed, 18 Mar 2026 09:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9091C19421;
	Wed, 18 Mar 2026 09:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826391;
	bh=uEHOHnogW56+g2NCkawlI23RrTbijq7RbohziykD1t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N36oty7D6IXjGFsZKN4yobNwiu0L0Ch9p0graCXyTqc4EJXSZSe8IbzaBoOHfCzpJ
	 sE/i0ORGRTpFLanJH4LyEMsIhSGXpsOD1dR5Lu3vJHyjiDXxDXX2t8L2hzHtAqdbjn
	 KXxWVtpg7F6L70xB27ys4lh6EwtEZIWhueY4gEkaR/WV+REmobZHZyVfCck5YHMx12
	 Bzc1lWlRay5jpkfJyIH8DA66pip9nhUPRJSZinp3ov8EG78kaU59S5ZLS/9vWGgxoL
	 Q3YL6QsXyKGBvh1C0nr7gjgdpAhKBmDc3jfBTMpVo/5Fj6oECzoN4iYa1FvAJw+y7F
	 vt4lFIRnrdzCQ==
Date: Wed, 18 Mar 2026 11:33:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Message-ID: <abpxUEijdHJzziEV@kernel.org>
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317141534.815634-3-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_023314_190394_AA993ED6 
X-CRM114-Status: GOOD (  26.16  )
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

Hi Michal,

On Tue, Mar 17, 2026 at 03:15:33PM +0100, Michal Clapinski wrote:
> Currently, if DEFERRED is enabled, kho_release_scratch will initialize

Please spell out CONFIG_DEFERRED_STRUCT_PAGE_INIT

> the struct pages and set migratetype of kho scratch. Unless the whole
> scratch fit below first_deferred_pfn, some of that will be overwritten
> either by deferred_init_pages or memmap_init_reserved_pages.

Usually we put brackets after function names to make them more visible.
 
> To fix it, I modified kho_release_scratch to only set the migratetype

Prefer an imperative mood please, e.g. "To fix it, modify
kho_release_scratch() ..."

> on already initialized pages. Then, modified init_pageblock_migratetype
> to set the migratetype to CMA if the page is located inside scratch.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  include/linux/memblock.h           |  2 --
>  kernel/liveupdate/kexec_handover.c | 10 ++++++----
>  mm/memblock.c                      | 22 ----------------------
>  mm/page_alloc.c                    |  7 +++++++
>  4 files changed, 13 insertions(+), 28 deletions(-)
> 
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
> index c9b982372d6e..e511a50fab9c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1477,8 +1477,7 @@ static void __init kho_release_scratch(void)
>  {
>  	phys_addr_t start, end;
>  	u64 i;
> -
> -	memmap_init_kho_scratch_pages();
> +	int nid;
>  
>  	/*
>  	 * Mark scratch mem as CMA before we return it. That way we
> @@ -1486,10 +1485,13 @@ static void __init kho_release_scratch(void)
>  	 * we can reuse it as scratch memory again later.
>  	 */
>  	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> -			     MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
> +			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
>  		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
>  		ulong end_pfn = pageblock_align(PFN_UP(end));
>  		ulong pfn;
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +		end_pfn = min(end_pfn, NODE_DATA(nid)->first_deferred_pfn);
> +#endif

A helper that returns first_deferred_pfn or ULONG_MAX might be beeter
looking. 

>  
>  		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
>  			init_pageblock_migratetype(pfn_to_page(pfn),
> @@ -1500,8 +1502,8 @@ static void __init kho_release_scratch(void)
>  void __init kho_memory_init(void)
>  {
>  	if (kho_in.scratch_phys) {
> -		kho_scratch = phys_to_virt(kho_in.scratch_phys);
>  		kho_release_scratch();
> +		kho_scratch = phys_to_virt(kho_in.scratch_phys);

Why this change is needed?

>  
>  		if (kho_mem_retrieve(kho_get_fdt()))
>  			kho_in.fdt_phys = 0;
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
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ee81f5c67c18..5ca078dde61d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
>  #include <linux/mmzone_lock.h>
> +#include <linux/kexec_handover.h>
>  #include <asm/div64.h>
>  #include "internal.h"
>  #include "shuffle.h"
> @@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(struct page *page,
>  		     migratetype < MIGRATE_PCPTYPES))
>  		migratetype = MIGRATE_UNMOVABLE;
>  
> +	/*
> +	 * Mark KHO scratch as CMA so no unmovable allocations are made there.
> +	 */
> +	if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
> +		migratetype = MIGRATE_CMA;
> +

Please pick SJ's fixup for the next respin :)

>  	flags = migratetype;
>  
>  #ifdef CONFIG_MEMORY_ISOLATION
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 

-- 
Sincerely yours,
Mike.

