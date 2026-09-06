Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21B9C79F85
	for <kexec@archiver.kernel.org>; Sun,  6 Sep 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2XPq6jBsWxzSGkLN5JMNAqBj9VumCx6phCWWl2LqB4Y=; b=m+WAdNnGY0mrTOfZ7JzWCKru/L
	zN6pBikO5NS1nZ82b0Sy3r/jGQHNjlkw+TELctKLbIBd9XFgxaKfmuvTzcjTnsTGqZ+hpv5Eozpyn
	NIY6tNBEoYtQu3dNzzQ3elz0JUEbT/FFhF8/5SfB57E8Msw0UFO3BXgev+VHIw8G42nwAOiga4+0N
	l4gzDqeDIH4Q4hkGS9YXqsqjNABKdTopcYMuQlDuLOdtXBFN3K5y2VJAeGoN5Wu4Wx5Tc99jRmiQA
	kqmchHCHUHLIfYJHlB1GTUcmWiVyJ2ug6kFP+D6rseE1IaYUbOHvTYIG4C+2m9+3k6/0hDuT6ys/d
	wtJzFtWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3A4B-00000004w0I-1wxh;
	Sun, 06 Sep 2026 10:25:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3A45-00000004w0C-1hUy
	for kexec@lists.infradead.org;
	Sun, 06 Sep 2026 10:25:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 51F6F40C51;
	Sun,  6 Sep 2026 10:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4E71F00A3A;
	Sun,  6 Sep 2026 10:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788690332;
	bh=2XPq6jBsWxzSGkLN5JMNAqBj9VumCx6phCWWl2LqB4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aT+A71hJ8NCIRzwZvUAlmCF2acDHq2xysOzGVgGT3iPsEhswJ4mdi3jeaJj0iN+1f
	 HJ8Wr8RRz4il12phVpTJYqK7TZm6HBoFHc23BkPlzoVI5sOLzIcKxRJuafbti3zxqq
	 bBXfVWqy+KEdv6XsvE4Qy0digyusQeELvEYWRpU8teA74oWoYP3Zt0fHRT4wrmKt5g
	 0m94g72F2kB5Tbe47F6EGnNZHQc88m1JsxF1TNvzE9iMJY45iWStpPyPTxmO6fgjcY
	 wZ3IdvyxptArEnj1FQAsXDPHZTNWBFUPdAkGExdGbWnfmejDhiw5BQZPl6GBlhefSg
	 0tHqpXaRiaZLg==
Date: Sun, 6 Sep 2026 13:25:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] memblock: use binary search to locate candidate regions
Message-ID: <ap0_lSVF43FP3PPb@kernel.org>
References: <20260903155907.1065681-1-tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903155907.1065681-1-tarunsahu@google.com>
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

Hi Tarun,

On Thu, Sep 03, 2026 at 03:59:06PM +0000, Tarun Sahu wrote:
> Use binary search (memblock_bsearch_start) in memblock_add_range() and
> memblock_isolate_range() to locate candidate regions instead of linearly
> scanning from index 0.
> 
> Under heavy memory fragmentation (such as KHO page preservation registering
> hundreds of thousands of disjoint folios), scanning from index 0 on every
> insertion and isolation results in O(N^2) complexity, causing boot-time
> memory retrieval to take several minutes (~268s for 393k pages).
> 
> Using binary search reduces the worst-case complexity to O(N log N)
> (and O(N) for sequential appends), cutting KHO memory retrieval time
> from ~268s to ~50ms.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  mm/memblock.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 9ce86349a29f..88940474b020 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -160,6 +160,11 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>  	     i < memblock_type->cnt;					\
>  	     i++, rgn = &memblock_type->regions[i])
>  
> +#define for_each_memblock_type_from(i, memblock_type, rgn, start)	\
> +	for (i = (start), rgn = &memblock_type->regions[i];		\
> +	     i < memblock_type->cnt;					\
> +	     i++, rgn = &memblock_type->regions[i])
> +
>  #define memblock_dbg(fmt, ...)						\
>  	do {								\
>  		if (memblock_debug)					\
> @@ -591,6 +596,33 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
>  	type->total_size += size;
>  }
>  
> +/**
> + * memblock_bsearch_start - Find the first region index where rend > base
> + * @type: memblock type to search
> + * @base: base physical address of the candidate range
> + *
> + * Returns the first region index that could potentially overlap @base.
> + */
> +static int __init_memblock memblock_bsearch_start(struct memblock_type *type,
> +						  phys_addr_t base)
> +{

We already have memblock_search() ;-)

> +	int mid, low = 0;
> +	int high = type->cnt;
> +
> +	if (type->cnt && base >= type->regions[type->cnt - 1].base +
> +				 type->regions[type->cnt - 1].size)
> +		return type->cnt;
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
> @@ -651,7 +683,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	base = obase;
>  	nr_new = 0;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for_each_memblock_type_from(idx, type, rgn,
> +				    memblock_bsearch_start(type, base)) {

I think we can just kill for_each_memblock_type() and open code all loops
that use it and make memblock_add_range() and memblock_isolate_range() use
binary search.

>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> @@ -827,7 +860,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  		if (memblock_double_array(type, base, size) < 0)
>  			return -ENOMEM;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for_each_memblock_type_from(idx, type, rgn,
> +				    memblock_bsearch_start(type, base)) {
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> -- 
> 2.55.0.970.g62bdec98f9-goog
> 

-- 
Sincerely yours,
Mike.

