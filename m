Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E76C624D4
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfLON0vOIMCx4YMExE8wsRsSHfIcGi/GWtHqeu9S6sQ=; b=pN+t5JVHZvJFYZrNP4D8qWpTxa
	kE4noLLkWeYHV5AG12KFCkhe1WoL9OB0wvEzDVcwO9yxqr/K9CihqskLuqgK/2j1vMIigyOyx7CKO
	qXESdrij7ku48NVDBWBCoS+ClxPQOYotgUGPeodq1kPT3O9hpp4YglrShDGCepd/W/1vyjNLynnzE
	Ijv3rSEOhP93BeN91U99O7qP/9uM8nsYJsX0LhsFKHJK15VH/L1QXh4uw7BYARzDRrjc2WAizhKkw
	zLhJucFjhOR75d+kzd/Co/E0MDUohNjpgNBGW1Tim2woANwBemUBF+m9jDRq2NOlcGBE6x/Htclxc
	ml2NrICw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2A8G-000000008oa-43D9;
	Thu, 03 Sep 2026 16:17:44 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2A8F-000000008nt-1MDv
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 16:17:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCDBD1596;
	Thu,  3 Sep 2026 09:17:36 -0700 (PDT)
Received: from [10.163.139.221] (unknown [10.163.139.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5C93F673;
	Thu,  3 Sep 2026 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788452260; bh=IGCjKrKbxdeYpXYZSvcnw7WtqBMc/XxE/M/sNq1isXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WQPzl4p+HAJJT3jsTl/2zRjvDVPFttOla1UX2/d2fnrmHSi/X9XHK6EUHX86G52sl
	 aFC0pXXEixydbGJmrY7+FmHm2AJEi6SywD11/HP5SrdlLNCzmEuNeuiY+f242VepQL
	 LXKrXyZOLn3ldtBr3xwOJPf52LEwEBXJ/ZMDjR0s=
Message-ID: <925c45d9-91dc-406a-9ff5-8c16f3ee0d9f@arm.com>
Date: Thu, 3 Sep 2026 21:47:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memblock: use binary search to locate candidate regions
To: Tarun Sahu <tarunsahu@google.com>, dmatlack@google.com,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-mm@kvack.org
References: <20260903155907.1065681-1-tarunsahu@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260903155907.1065681-1-tarunsahu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_091743_439152_74ADE66A 
X-CRM114-Status: GOOD (  23.45  )
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



On 03/09/26 9:29 pm, Tarun Sahu wrote:
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

I recall noticing this 2 years ago : ) but then abandoned because
I couldn't think of a usecase.

I have forgotten memblock and no idea on KHO, but are you sure
this patch won't have negative consequence for the usual cases?
In other words is this something KHO specific, and in the usual
cases a linear search is more cache/CPU friendly?

Also below I see you have implemented a custom binary search helper.
I recall a generic one is there in some .h file somewhere in the
codebase, perhaps that may be useful, just FYI, ignore if already
tried that.

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


