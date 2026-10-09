Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3CBCA601D
	for <kexec@archiver.kernel.org>; Fri,  9 Oct 2026 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ztyPoTsXQl2erL+nCDtIS3iAw5yK7s2FnhInIimetvY=; b=Rlnrzv9jApmDSTa+5MJ6bJM4bR
	CiLRtJAorBNKI0/tY4CsPAfgxmC2JPxsu45RCVBwVuHolUdQIPTol8pmCRGMcjQ7HDMTXgtYCgOOS
	SFAOFRRxPAbrL086UDZkyO3BA5qV3rWywOX4Qf7KNREZyluGFeFyFd1p/WqVh07fMd8nvKV253ucn
	4KQ2pInEOEaDP/t7lLHcxhYYGQ/p8PlV4h9+3ML4QeGbluwH/28Ws+xulYaWqaJZ4bCEKfbFNPhO+
	4IcO/ie4gVCOirPlGjkEjmIbwUAY5kpB01ktSJCfBdN8lzFdmyfgihQdS4xX3swihQ1efVum+fndk
	+y3UvziA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDxZ-00000006kGG-3Bwe;
	Fri, 09 Oct 2026 17:00:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDxR-00000006kDf-0QJu
	for kexec@lists.infradead.org;
	Fri, 09 Oct 2026 17:00:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D36F640801;
	Fri,  9 Oct 2026 17:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8111C1F000FF;
	Fri,  9 Oct 2026 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565232;
	bh=ztyPoTsXQl2erL+nCDtIS3iAw5yK7s2FnhInIimetvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PPBVQNEjP1rpUk9athtUmv4P1WtB+86fpqSx6AnywR1TtsvYSJIFmJNxilRtHzu6e
	 fgQGXdRphhqRFLklVel6bYh6mpHunUliifxVYCBs+HAUBYHYMjbeas8wPR7ZsqJ/3V
	 7eFLqmJrb3o9bIyTjWzS5gtRj6YMUZSvkE1FTp1cIJPG7/2eAxipl58T6kYTuHqYw2
	 2aBWnqsCTriH0YTTyg9I5ATGBuVPFuG24npRcRxXy98EkvFS1hFqVdgoAMTbL1XWu1
	 ovV5WYF1EZtOHQLIlkOfsX/4VWk9KildRnDpshHtld1h/Kh1TJND71W4Folv/iGj2x
	 isfpdlTkTKlyQ==
Date: Fri, 9 Oct 2026 19:00:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] memblock: use binary search to locate candidate
 regions
Message-ID: <askdqgzm2Cbeo3SB@kernel.org>
References: <20261008190828.3221718-1-tarunsahu@google.com>
 <20261008190828.3221718-2-tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008190828.3221718-2-tarunsahu@google.com>
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

On Thu, Oct 08, 2026 at 07:08:28PM +0000, Tarun Sahu wrote:
> Use binary search (memblock_bsearch_start) in memblock_add_range() and

The function name is __memblock_search now and I think you can drop it
altogether :)

> memblock_isolate_range() to locate candidate regions instead of linearly
> scanning from index 0.
> 
> Under heavy memory fragmentation (such as KHO page preservation registering

Comma instead of open parenthesis feels better to me.

> hundreds of thousands of disjoint folios), scanning from index 0 on every
> insertion and isolation results in O(N^2) complexity, causing boot-time
> memory retrieval to take several minutes (~268s for 393k pages).
> 
> Using binary search reduces the candidate search complexity to O(log N)
> (from O(N)), cutting KHO memory retrieval time from ~268s to ~50ms.
> 
> memblock_search() open codes the same binary search, so reimplement it on
> top of the new helper.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  mm/memblock.c | 45 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 59dda7d085f3..614d0a55dd70 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -586,6 +586,29 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
>  	type->total_size += size;
>  }
>  
> +/**
> + * __memblock_search - Find the first region index where rend > base
> + * @type: memblock type to search
> + * @base: base physical address of the candidate range
> + *
> + * Returns the first region index that could potentially overlap @base.

Return: for proper kernel-doc format AFAIR

> + */
> +static int __init_memblock __memblock_search(struct memblock_type *type,
> +						  phys_addr_t base)
> +{
> +	int mid, low = 0;
> +	int high = type->cnt;
> +
> +	while (low < high) {
> +		mid = (low + high) / 2;
> +		if (type->regions[mid].base + type->regions[mid].size <= base)
> +			low = mid + 1;
> +		else
> +			high = mid;
> +	}
> +	return low;
> +}
> +
>  /**
>   * memblock_add_range - add new memblock region
>   * @type: memblock type to add new region into
> @@ -644,8 +667,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	 */
>  	base = obase;
>  	nr_new = 0;
> +	idx = __memblock_search(type, base);
>  
> -	for (idx = 0; idx < type->cnt; idx++) {
> +	for (; idx < type->cnt; idx++) {


	for (idx = __memblock_search(type, base); ...

>  		struct memblock_region *rgn = &type->regions[idx];
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> @@ -821,7 +845,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  		if (memblock_double_array(type, base, size) < 0)
>  			return -ENOMEM;
>  
> -	for (idx = 0; idx < type->cnt; idx++) {
> +	idx = __memblock_search(type, base);
> +
> +	for (; idx < type->cnt; idx++) {

Same here or even

	for (int idx = __memblock_search(type, base); ...

>  		struct memblock_region *rgn = &type->regions[idx];
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> @@ -2062,19 +2088,10 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>  
>  static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
>  {
> -	unsigned int left = 0, right = type->cnt;
> -
> -	do {
> -		unsigned int mid = (right + left) / 2;
> +	int idx = __memblock_search(type, addr);
>  
> -		if (addr < type->regions[mid].base)
> -			right = mid;
> -		else if (addr >= (type->regions[mid].base +
> -				  type->regions[mid].size))
> -			left = mid + 1;
> -		else
> -			return mid;
> -	} while (left < right);
> +	if (idx < type->cnt && addr >= type->regions[idx].base)
> +		return idx;
>  	return -1;
>  }
>  
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 

-- 
Sincerely yours,
Mike.

