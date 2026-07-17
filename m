Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE19C44514
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o9QpCCDFZl9Z3Fy1xWnmLKG4AFYlG+VaeyFxu5H2buc=; b=w1CQCt/tq+XoUY2sdIARy+sEZ8
	dk9ZoV2yXaWe4YwLBLe4qjZQi/dXwh8HfGQmnTQSyd1dyYljgD1Sk2gSXZ50UM3KF140SPCUKW0H9
	T+Lc1w/JSML0HOEwvIjG+4OhxTaR99lB2Autx9LAvuPBdFZp+F1Cus4utEkPXNkbXU0JbiwCy45dy
	KLGrq6f+jG1nmiqT/9Y/G8Uz8RZ1nEujtPJ9ckfTZomkpMPAJ3glAvaijP4k/4zkThOZjeTF2ohSU
	h6iPHa4wjjHdjstqgopXOp/yCCkEjAYgv/pUGnQ66tGmMWiSu9Hz3i5SzQXu8xotIr2wQfEyXIceP
	o1R7+5Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdms-00000001bxG-2AKj;
	Fri, 17 Jul 2026 08:19:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdmr-00000001bwi-0XcF
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 08:19:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C95B043C17;
	Fri, 17 Jul 2026 08:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A131F00A3A;
	Fri, 17 Jul 2026 08:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784276352;
	bh=o9QpCCDFZl9Z3Fy1xWnmLKG4AFYlG+VaeyFxu5H2buc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDN2kRUQJ+brggP3mMYAB4f6PCc9YCIge/VE2LqQvGMjTINOgCsP4PCtcNpCCPIwd
	 n1dt0Ca3JUFCwOuSkYTzUSoSgGeMcDgdNHuNLu3z6zl0ENhQ/4cHiyD+uxQQd+IF2e
	 CS6ltDpx4nrKv5LhtvuSr+8aEblgppz6z0axPBeuFJYbdr5nX5FPC6wbWdNAk2MnhS
	 maoIbdOCBiNIWdS3qqPlFhGtP4QftxlH8UMKGG3wgJX6SdSbCpvtllGBYl2ms4EnG3
	 ClEkQxW+4xMSQDj4dEN6k3GJzT/qArlFPf1q9DLuycwOrz5RWDZBHg6icz5BQ0vAtq
	 VCCgfYMMGrD6A==
Date: Fri, 17 Jul 2026 11:19:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
Message-ID: <alnlelMEqixyiXgz@kernel.org>
References: <20260714205111.2497151-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714205111.2497151-1-mclapinski@google.com>
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

On Tue, Jul 14, 2026 at 10:51:11PM +0200, Michal Clapinski wrote:
> I caught this crash:

We are not as strict as x86 folks, but imperative voice is preferred.

> BUG: unable to handle page fault for address: ff19164fffff8328
> RIP: 0010:__free_one_page+0x1a1/0x6b0
> Call Trace:
>  <TASK>
>  [<ffffffff913208bf>] free_one_page+0xaf/0x240
>  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
>  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
>  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
>  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
>  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
>  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
>  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
>  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
>  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
>  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
>  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> deferred_init_memmap_chunk() works fine without KHO because free
> regions will never be neighbors. However, with KHO, free memory

I'd change it to something like

  deferred_init_memmap_chunk() interleaves initialization of struct pages
with freeing them. This works fine without KHO ...

> will be split into (free && scratch) and (free && !scratch).
> KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
> is equal to 1 << 9 pages) but buddy can look at the neighborhood of
> MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).

Please make it clearer that the values correspond to a particular
configuration. E.g. 

  in a configuration where CMA_MIN_ALIGNMENT_PAGES is 512 and
  MAX_ORDER_NR_PAGES is 1024

> This sometimes crashes when one half of the neighborhood is being
> initialized but the other part is yet to be initialized.
> 
> To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> 
> Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferred struct page init")
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> Unfortunately, this is very hard to catch, so I don't have a good
> reproducer. But I run the code with the fix through extensive testing
> and it seems fine.
> I think I've never caught it before because enabling HUGETLB is what
> causes CMA_MIN_ALIGNMENT_PAGES to be 1 << 9, instead of 1 << 10.
> 
> If this passes review, please cherry-pick it to 7.2 so we don't release
> a broken kernel.
> ---
>  kernel/liveupdate/kexec_handover.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 4834a809985a..50928aaa3371 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -38,6 +38,16 @@
>  #include "../kexec_internal.h"
>  #include "kexec_handover_internal.h"
>  
> +/*
> + * This is the minimal alignment required by deferred struct page init.
> + * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> + * If KHO scratch is not aligned to that value, buddy can access uninitialized
> + * struct pages, which can cause a crash.
> + */
> +#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))

I believe PAGE_SIZE * MAX_ORDER_NR_PAGES looks better

> +static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
> +
>  /* The magic token for preserved pages */
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>  
> @@ -640,8 +650,8 @@ static void __init scratch_size_update(void)
>  	 * Scratch areas are released as MIGRATE_CMA. Round them up to the right
>  	 * size.
>  	 */
> -	scratch_size_lowmem = round_up(scratch_size_lowmem, CMA_MIN_ALIGNMENT_BYTES);
> -	scratch_size_global = round_up(scratch_size_global, CMA_MIN_ALIGNMENT_BYTES);
> +	scratch_size_lowmem = round_up(scratch_size_lowmem, SCRATCH_ALIGNMENT_BYTES);
> +	scratch_size_global = round_up(scratch_size_global, SCRATCH_ALIGNMENT_BYTES);
>  }
>  
>  static phys_addr_t __init scratch_size_node(int nid)
> @@ -656,7 +666,7 @@ static phys_addr_t __init scratch_size_node(int nid)
>  		size = scratch_size_pernode;
>  	}
>  
> -	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
> +	return round_up(size, SCRATCH_ALIGNMENT_BYTES);
>  }
>  
>  /**
> @@ -692,7 +702,7 @@ static void __init kho_reserve_scratch(void)
>  	 * next kernel
>  	 */
>  	size = scratch_size_lowmem;
> -	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
> +	addr = memblock_phys_alloc_range(size, SCRATCH_ALIGNMENT_BYTES, 0,
>  					 ARCH_LOW_ADDRESS_LIMIT);
>  	if (!addr) {
>  		pr_err("Failed to reserve lowmem scratch buffer\n");
> @@ -705,7 +715,7 @@ static void __init kho_reserve_scratch(void)
>  
>  	/* reserve large contiguous area for allocations without nid */
>  	size = scratch_size_global;
> -	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
> +	addr = memblock_phys_alloc(size, SCRATCH_ALIGNMENT_BYTES);
>  	if (!addr) {
>  		pr_err("Failed to reserve global scratch buffer\n");
>  		goto err_free_scratch_areas;
> @@ -721,7 +731,7 @@ static void __init kho_reserve_scratch(void)
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
>  		size = scratch_size_node(nid);
> -		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
> +		addr = memblock_alloc_range_nid(size, SCRATCH_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>  						nid, true);
>  		if (!addr) {
> -- 
> 2.55.0.141.g00534a21ce-goog
> 

-- 
Sincerely yours,
Mike.

