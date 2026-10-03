Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945B7CA5FDD
	for <kexec@archiver.kernel.org>; Sat,  3 Oct 2026 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PhCXWf+F0kKIImkvMzPZcVKqpKPzzmNfLTmAIwKhi5U=; b=PgA+UpDGsLhm1mhvmLh7UWdm8N
	GyI1L30KPK9Ny3V3o1cp8kkZ4ofytGWH1PnmYxsmIJKt6/tfUJSRJFe85CofCq3JzgUKc2cLabR9s
	SGn5WodkYY2lWD49oGWp7zFTbqsxjG2UwaVqRK5CADB2VWHkwAAQTFXSDCyamcJGV8WPUxAV8hEbT
	s602zCqR9cusYT214SKAJcbDkJBLuzjomzVo+48SIsXFVlZY7FllKJZ2MzwuEt949kPvZZzF022sk
	wvI+84zMZxgYLeE0rSOTT0uJugC5dlslgwVFvb6/CqHFlRhCy3R7bDoXp9FTgzMe8F86SR0GnAdkX
	OlHdcT/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCunO-0000000D9hx-1c9M;
	Sat, 03 Oct 2026 08:08:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCunK-0000000D9hl-1H35
	for kexec@lists.infradead.org;
	Sat, 03 Oct 2026 08:08:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5B668602C2;
	Sat,  3 Oct 2026 08:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63ED1F0089B;
	Sat,  3 Oct 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014913;
	bh=PhCXWf+F0kKIImkvMzPZcVKqpKPzzmNfLTmAIwKhi5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGdjLO7hHmOhRag0vBx5sQqVyd+RlVq7IP4+6qDwZUTfovA4AJYzpewdSSQWLKaeL
	 IpOZLkyXTGTubJs/poT8lC0J3jf834xXHqPvi2yTe4mrrVQb+aUDnbYXxqp/iBRZRF
	 9GrQAnbemBXcwcSvjxuP24IQdAhD2Ry4ZKmaOlw5LHCHi9m8eCSm4FT1KIi0BZbMmS
	 F9i0XllekZXGkXH3ctDa4VU/kXVJfqR0uaterPWUAL0liqvHOJvF9LrGS9dLjib1Az
	 CoUcT9A1vO6CMkL3lNKrm1ftiM9RydTWKVhVESuMstXqbA7GLdo41lX19+iDpddiOw
	 FHSv/+XXGltpA==
Date: Sat, 3 Oct 2026 10:08:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Guo <guodongtai@kylinos.cn>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: fix global scratch size calculation
Message-ID: <asC3-4WNiTF3n7l1@kernel.org>
References: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
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

On Tue, Sep 22, 2026 at 06:42:16PM +0530, Sourabh Jain wrote:
> KHO calculates the global scratch size based on memblock-reserved kernel
> memory. It passes NUMA_NO_NODE to memblock_reserved_kern_size() for
> this calculation.
> 
> When memblock_reserved_kern_size() is called with NUMA_NO_NODE, it
> counts both:
> 
> - memory reserved for a specific NUMA node
> - memory reserved with NUMA_NO_NODE
> 
> KHO needs to distinguish between these two types of reservations.
> When calculating the size of global scratch memory, KHO only needs to
> account for reservations made with NUMA_NO_NODE. Reservations made for
> a specific NUMA node must not be included in the global scratch size.
> 
> Add memblock_reserved_size_nid() to calculate reserved memory for a
> given reservation type and NUMA node. When NUMA_NO_NODE is passed, it
> counts only memory reserved with NUMA_NO_NODE.
> 
> Use the new API for lowmem, global, and per-node KHO scratch size
> calculations. For lowmem and global scratch, count only memory
> reservations that were made with NUMA_NO_NODE. For per-node scratch,
> count only memory reservations that were made with the corresponding
> NUMA node ID.
> 
> Remove memblock_reserved_hugetlb_size() since it has the same
> implementation as the new API and differs only in the memblock
> reservation flag being checked. The new API handles both kernel and
> HugeTLB reservations through its reservation type argument.
> 
> Define the new helper as a static function in the KHO implementation,
> since it is only used by KHO and has no users outside
> kernel/liveupdate/kexec_handover.c.

I looked again and this feels like a band-aid to me.

I think we need to step back and rethink the order of the
scratch/kho-bootmem sizing and consider how NUMA and lowmem are involved
there.
 
> On powerpc, the difference can be seen in the scratch_len values
> reported by:
> 
> cat /sys/kernel/debug/kho/out/scratch_len
> 
> Before this change, the global scratch allocation was 0x12000000
> (288 MB):
> 
> 0x1000000   (16 MB)
> 0x12000000  (288 MB)  <- global allocation
> 0x5000000   (80 MB)
> 
> After this change, the global scratch allocation is 0xd000000
> (208 MB):
> 
> 0x1000000   (16 MB)
> 0xd000000   (208 MB)  <- global allocation
> 0x5000000   (80 MB)
> 
> The 80 MB difference is the per-node reservation that was previously
> being included in the global allocation.
> 
> The same issue also affects lowmem scratch memory, but its impact is
> limited because the lowmem scratch memory calculation is restricted to
> the first 4G of memory. The changes also cover the lowmem scratch
> memory case.
> 
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: George Guo <guodongtai@kylinos.cn>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  include/linux/memblock.h           |  1 -
>  kernel/liveupdate/kexec_handover.c | 49 ++++++++++++++++++++++--------
>  mm/memblock.c                      | 22 --------------
>  3 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d62db9e776cf..678fe466529a 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -487,7 +487,6 @@ static inline __init_memblock bool memblock_bottom_up(void)
>  phys_addr_t memblock_phys_mem_size(void);
>  phys_addr_t memblock_reserved_size(void);
>  phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
> -phys_addr_t memblock_reserved_hugetlb_size(phys_addr_t limit, int nid);
>  unsigned long memblock_estimated_nr_free_pages(void);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..dc809e1e768c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -752,6 +752,31 @@ static int __init kho_parse_scratch_size(char *p)
>  }
>  early_param("kho_scratch", kho_parse_scratch_size);
>  
> +static phys_addr_t __init_memblock memblock_reserved_size_nid(phys_addr_t limit, int nid,
> +							      enum memblock_flags region_type)
> +{
> +	struct memblock_region *r;
> +	phys_addr_t total = 0;
> +
> +	for_each_reserved_mem_region(r) {
> +		phys_addr_t size = r->size;
> +
> +		if (r->base > limit)
> +			break;
> +
> +		if (r->base + r->size > limit)
> +			size = limit - r->base;
> +
> +#ifdef CONFIG_NUMA
> +		if (nid == memblock_get_region_node(r))
> +#endif
> +			if (r->flags & region_type)
> +				total += size;
> +	}
> +
> +	return total;
> +}
> +
>  static void __init scratch_size_update(void)
>  {
>  	/*
> @@ -762,17 +787,17 @@ static void __init scratch_size_update(void)
>  	if (scratch_scale) {
>  		phys_addr_t size;
>  
> -		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
> -						   NUMA_NO_NODE);
> -		size -= memblock_reserved_hugetlb_size(ARCH_LOW_ADDRESS_LIMIT,
> -						       NUMA_NO_NODE);
> +		size = memblock_reserved_size_nid(ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE,
> +						  MEMBLOCK_RSRV_KERN);
> +		size -= memblock_reserved_size_nid(ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE,
> +						   MEMBLOCK_RSRV_HUGETLB);
>  		size = size * scratch_scale / 100;
>  		scratch_size_lowmem = size;
>  
> -		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						   NUMA_NO_NODE);
> -		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						       NUMA_NO_NODE);
> +		size = memblock_reserved_size_nid(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE,
> +						  MEMBLOCK_RSRV_KERN);
> +		size -= memblock_reserved_size_nid(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE,
> +						   MEMBLOCK_RSRV_HUGETLB);
>  		size = size * scratch_scale / 100 - scratch_size_lowmem;
>  		scratch_size_global = size;
>  	}
> @@ -790,11 +815,11 @@ static phys_addr_t __init scratch_size_node(int nid)
>  	phys_addr_t size;
>  
>  	if (scratch_scale) {
> -		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						   nid);
> +		size = memblock_reserved_size_nid(MEMBLOCK_ALLOC_ANYWHERE, nid,
> +						  MEMBLOCK_RSRV_KERN);
>  		/* Do not count HugeTLB pages. */
> -		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						       nid);
> +		size -= memblock_reserved_size_nid(MEMBLOCK_ALLOC_ANYWHERE, nid,
> +						   MEMBLOCK_RSRV_HUGETLB);
>  		size = size * scratch_scale / 100;
>  	} else {
>  		size = scratch_size_pernode;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 021db49eb7fc..9da748e774ea 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1900,28 +1900,6 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>  	return memblock.reserved.total_size;
>  }
>  
> -phys_addr_t __init_memblock memblock_reserved_hugetlb_size(phys_addr_t limit, int nid)
> -{
> -	struct memblock_region *r;
> -	phys_addr_t total = 0;
> -
> -	for_each_reserved_mem_region(r) {
> -		phys_addr_t size = r->size;
> -
> -		if (r->base > limit)
> -			break;
> -
> -		if (r->base + r->size > limit)
> -			size = limit - r->base;
> -
> -		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
> -			if (r->flags & MEMBLOCK_RSRV_HUGETLB)
> -				total += size;
> -	}
> -
> -	return total;
> -}
> -
>  phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int nid)
>  {
>  	struct memblock_region *r;
> -- 
> 2.55.0
> 

-- 
Sincerely yours,
Mike.

