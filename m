Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15507CA5FDD
	for <kexec@archiver.kernel.org>; Sat,  3 Oct 2026 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPO4RM0i7SP/IETP8H+05lmtRukMrZzOkuL7g4aF8U4=; b=CR2n8is2KDvgiMDT0okPR+zIob
	65i8fw635I9OQSi/JCR01nIDyjakrhLMnP2K7AUVDgpwOd6b2xy7V9SdWDrNJhDAlAZAH8qxgoJq5
	Q6zA99VXy4jUmEEcEwcsbVoflbWgiHbvRCAPlsIyXLZsN84bMT8kOxBkmj2DfBNnIP099w2muAB/B
	dc3C6QpFh1YNZ9ciW+02Ks057kmXy1VadHTBA6spazxSsTof2H2ggqVU2RAJ+3d66XWZSGr6xTfqa
	Z0mFMj+2bP5rHwQXPIOwoiIfSTDE72HQuSFwxR6DLbHZ/BrwSUFgafwU28kNBgyZsjh7srmfrsJrP
	f+Dr2Org==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCubS-0000000D96J-0fLM;
	Sat, 03 Oct 2026 07:56:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCubN-0000000D964-3jCa
	for kexec@lists.infradead.org;
	Sat, 03 Oct 2026 07:56:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09447602C2;
	Sat,  3 Oct 2026 07:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E6A1F0089B;
	Sat,  3 Oct 2026 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014172;
	bh=UPO4RM0i7SP/IETP8H+05lmtRukMrZzOkuL7g4aF8U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VRLJc7HyEynjBACssz2mmFo30gjCyNt5Q471QjoAwHeXP5o4nCvfFp9iyqR2qwIYy
	 rdqKYt47RndMm6y1XcQ1FG8JEyO/28b1E10zVwA4k4cSfHfXz9a3q0FS4/ISdbLKOC
	 75jgXrEMNeuWwhSa8lOgEgKFM1e1ytwEe/cQK0NnbQgVRgoSaIE+nx/ug084XIddZN
	 yOIMS7FjC7SBakdQIeX3JIw7XCAE8j2vFG8jjmOCrjuhh2/LjnWS55aGmORTvWuvbJ
	 HE7kIH1M+QqWOfDYzLHCKurMsqEw4mKRNR1LmeCrzdw0+Lxe3xXPkdJgRE0FZ79p/q
	 JgL18ukxU0ciQ==
Date: Sat, 3 Oct 2026 09:56:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, dmatlack@google.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	dev.jain@arm.com, Pratyush Yadav <pratyush@kernel.org>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] memblock: use binary search to locate candidate
 regions
Message-ID: <asC1FwHVHOhBHDGK@kernel.org>
References: <20260926092448.4090401-1-tarunsahu@google.com>
 <20260926092448.4090401-2-tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926092448.4090401-2-tarunsahu@google.com>
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

On Sat, Sep 26, 2026 at 09:24:48AM +0000, Tarun Sahu wrote:
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
> memblock_search() open codes the same binary search, so reimplement it on
> top of the new helper.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> 
>  mm/memblock.c | 53 +++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 59dda7d085f3..87c71435c80c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -586,6 +586,33 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
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

I'd call it __memblock_search()

> +{
> +	int mid, low = 0;
> +	int high = type->cnt;
> +
> +	if (type->cnt && base >= type->regions[type->cnt - 1].base +
> +				 type->regions[type->cnt - 1].size)
> +		return type->cnt;

Using local variables would make it more readable IMHO.

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
> @@ -609,7 +636,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	bool insert = false;
>  	phys_addr_t obase = base;
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx, nr_new, start_rgn = -1, end_rgn;
> +	int idx, start_idx, nr_new, start_rgn = -1, end_rgn;
>  
>  	if (!size)
>  		return 0;
> @@ -644,8 +671,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	 */
>  	base = obase;
>  	nr_new = 0;
> +	start_idx = memblock_bsearch_start(type, base);
>  
> -	for (idx = 0; idx < type->cnt; idx++) {
> +	for (idx = start_idx; idx < type->cnt; idx++) {
>  		struct memblock_region *rgn = &type->regions[idx];
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> @@ -809,7 +837,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  					int *start_rgn, int *end_rgn)
>  {
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx;
> +	int idx, start_idx;
>  
>  	*start_rgn = *end_rgn = 0;
>  
> @@ -821,7 +849,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  		if (memblock_double_array(type, base, size) < 0)
>  			return -ENOMEM;
>  
> -	for (idx = 0; idx < type->cnt; idx++) {
> +	start_idx = memblock_bsearch_start(type, base);
> +
> +	for (idx = start_idx; idx < type->cnt; idx++) {
>  		struct memblock_region *rgn = &type->regions[idx];
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> @@ -2062,19 +2092,10 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>  
>  static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
>  {
> -	unsigned int left = 0, right = type->cnt;
> +	int idx = memblock_bsearch_start(type, addr);
>  
> -	do {
> -		unsigned int mid = (right + left) / 2;
> -
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
> base-commit: 1f18d740165163910df64d3063e1ad31648bc5e0
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

-- 
Sincerely yours,
Mike.

