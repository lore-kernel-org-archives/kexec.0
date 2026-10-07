Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE02CA5FF1
	for <kexec@archiver.kernel.org>; Wed,  7 Oct 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rU5wB6bHQgxWOlREbKkjzu4hbbXBoycTkgMxfiJ0Mmc=; b=kOos7Hiu5dqlWGvDUz5v2HnjWf
	oKCMgGJIt3IzYUC6ad80a4gh9vB5NL4lJmET4LGtLCSPN8GJjH/UfhCFJe9wItaKH6UOlK5h715kE
	mK/107sA1Pl1+fzBIWjT5lmvVlvcT4e01IP6lT45ONHZKcEulI3NFyur79ihQxAXC6GrdXhL8X/zq
	zQjM2gqs667sHVyZIHEiDRoyaMIwgWWnT/UORQPmnrep1HBTYdUUUc027dMs5SM37fqz0mbRdEVMW
	g+0e092rAtXy5gesB6YrWEaB/cuP7ZzqYQVTuyRSYn4g81geONlizBkHiiooqVBacIN6kTDOJb0C5
	QNcGHGNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xESHT-00000002a2d-0YuH;
	Wed, 07 Oct 2026 14:06:03 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xESHL-00000002a1g-3D7F
	for kexec@lists.infradead.org;
	Wed, 07 Oct 2026 14:05:59 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c2dd399f761so452569066b.3
        for <kexec@lists.infradead.org>; Wed, 07 Oct 2026 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791381953; x=1791986753; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rU5wB6bHQgxWOlREbKkjzu4hbbXBoycTkgMxfiJ0Mmc=;
        b=EVDedny9pubxF3X9Ylc8+eKeI0TSLMigX6ayPUo6EndTTF1p/W0bzF8WkbbTfvq6Gg
         0+qtL4E+bCpo3CP/0u4uS2tBAqRb0MB+uZqcbjF3Nw569a0KBAXFGJECbNbMHQWWwA1o
         M2LoEDJS9JWqkBKhH65PDDeF+EauxTtWO3yX5hlbaHnKMTZ0FbiyK1kwz2IQ4KMOP+d6
         H1/iAyPcKxGA5N/6lxalPRnPcy3WJ2WRdRGuBsHNEDTXD8c9V6F6yMZU7T0acaksFaKS
         /SyiwLFKidYFqh8b0uNcAWLGMzqG2RJtDl0K3Udu40992XB4RdPJBmQU+YnLA7Jlscmj
         9tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791381953; x=1791986753;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rU5wB6bHQgxWOlREbKkjzu4hbbXBoycTkgMxfiJ0Mmc=;
        b=R8tteQ2gcsAUDmNCfwStu2eo1IAhQtwgFrWAcVAcmbx1Pae4HMitJSyCc0gioG4aYu
         tzfIEq7cxVDnKRhhKb0gmNFi7oIHRYcFlyJJWnXviBsNWS26pdpDbVp1Pr1ASByZZmfk
         eOI8Sh3iZggRDNtKLaNlpkEfZFOExpYQ713/Rv1P3Ho9yNtDRO3SITcM3rN6L2UB1LyJ
         xcFlTuNTvMDOVZsxbWBgcgCZd+/6v+Z//6lFCM8piCH+7i3+gOWJZXOtvrjfEatMQktp
         Ee4syNg2U4AgrqasfTG1vf8zeAwAGBgG1Sz6y0VwUPvfF/i7B+Be4hJBDmjSBzkhG+uG
         8luA==
X-Forwarded-Encrypted: i=1; AKwUvBwQNuD5TLp71T87DJ8U86RERNJIPHSzRmLWYiHoFgRBVakzEPbmql6f9fnq9gMfV01DYUfWhw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJaBffQ3x9JNDwZJnPsINx5fM41b77EUNHVS0C/VQAA4m3f9SpV
	2dNXwwwEmgUAcstkoYAnUuLR62SRWB7Kr5gjzs6T2fDvV5bI4rKi9cTlShsJADUwLr9TM8kZMNR
	abnme2z64HwY7BKZS9w==
X-Received: from ejac25.prod.google.com ([2002:a17:906:3d9:b0:c2d:c729:d7a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7956:b0:c29:f5d5:5a9c with SMTP id a640c23a62f3a-c317c088215mr242709366b.38.1791381952681;
 Wed, 07 Oct 2026 07:05:52 -0700 (PDT)
Date: Wed, 07 Oct 2026 14:05:51 +0000
In-Reply-To: <2vxz8q4dlgrq.fsf@kernel.org>
Mime-Version: 1.0
References: <20260926092448.4090401-1-tarunsahu@google.com>
 <20260926092448.4090401-2-tarunsahu@google.com> <2vxz8q4dlgrq.fsf@kernel.org>
Message-ID: <9huz1pa1txkw.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 2/2] memblock: use binary search to locate candidate regions
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	dmatlack@google.com, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dev.jain@arm.com, 
	Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261007_070555_840132_F17A133D 
X-CRM114-Status: GOOD (  26.32  )
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

Pratyush Yadav <pratyush@kernel.org> writes:

> On Sat, Sep 26 2026, Tarun Sahu wrote:
>
>> Use binary search (memblock_bsearch_start) in memblock_add_range() and
>> memblock_isolate_range() to locate candidate regions instead of linearly
>> scanning from index 0.
>>
>> Under heavy memory fragmentation (such as KHO page preservation registering
>> hundreds of thousands of disjoint folios), scanning from index 0 on every
>> insertion and isolation results in O(N^2) complexity, causing boot-time
>> memory retrieval to take several minutes (~268s for 393k pages).
>>
>> Using binary search reduces the worst-case complexity to O(N log N)
>> (and O(N) for sequential appends), cutting KHO memory retrieval time
>> from ~268s to ~50ms.
>>
>> memblock_search() open codes the same binary search, so reimplement it on
>> top of the new helper.
>>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>>  mm/memblock.c | 53 +++++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 37 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 59dda7d085f3..87c71435c80c 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -586,6 +586,33 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
>>  	type->total_size += size;
>>  }
>>  
>> +/**
>> + * memblock_bsearch_start - Find the first region index where rend > base
>> + * @type: memblock type to search
>> + * @base: base physical address of the candidate range
>> + *
>> + * Returns the first region index that could potentially overlap @base.
>> + */
>> +static int __init_memblock memblock_bsearch_start(struct memblock_type *type,
>> +						  phys_addr_t base)
>> +{
>> +	int mid, low = 0;
>> +	int high = type->cnt;
>> +
>> +	if (type->cnt && base >= type->regions[type->cnt - 1].base +
>> +				 type->regions[type->cnt - 1].size)
>> +		return type->cnt;
>
> In some testing I did of this patch some time ago, I recall that this
> check didn't have much of a difference on performance. The binary search
> is the real optimization.
>
> Do you think this check is worth keeping?

Yes, This is true. After giving it a second thought. Binary search is
fast enough to find the candidate. Also it will be very common that
Incoming reserved entries are not only from single provider (KHO). Hence,
reserved list will have the entries that might cause above condition to
fail.

I will remove this. But if anyone wants this optimization in future. can
revisit this.

>
> Other than this, I only have a couple minor nitpicks below.
>
> Regardless of these small comments, this patch LGTM so feel free to add
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>

Thanks for reviewing it.


>> +
>> +	while (low < high) {
>> +		mid = (low + high) / 2;
>> +		if (type->regions[mid].base + type->regions[mid].size <= base)
>> +			low = mid + 1;
>> +		else
>> +			high = mid;
>> +	}
>> +	return low;
>> +}
>> +
>>  /**
>>   * memblock_add_range - add new memblock region
>>   * @type: memblock type to add new region into
>> @@ -609,7 +636,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>  	bool insert = false;
>>  	phys_addr_t obase = base;
>>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>> -	int idx, nr_new, start_rgn = -1, end_rgn;
>> +	int idx, start_idx, nr_new, start_rgn = -1, end_rgn;
>>  
>>  	if (!size)
>>  		return 0;
>> @@ -644,8 +671,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>  	 */
>>  	base = obase;
>>  	nr_new = 0;
>> +	start_idx = memblock_bsearch_start(type, base);
>>  
>> -	for (idx = 0; idx < type->cnt; idx++) {
>> +	for (idx = start_idx; idx < type->cnt; idx++) {
>
> Nit: why have start_idx as a separate variable? Why not assign idx to
> the result of memblock_bsearch_start() directly?
>

Right! thanks.

~ Tarun

>>  		struct memblock_region *rgn = &type->regions[idx];
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>> @@ -809,7 +837,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  					int *start_rgn, int *end_rgn)
>>  {
>>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>> -	int idx;
>> +	int idx, start_idx;
>>  
>>  	*start_rgn = *end_rgn = 0;
>>  
>> @@ -821,7 +849,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  		if (memblock_double_array(type, base, size) < 0)
>>  			return -ENOMEM;
>>  
>> -	for (idx = 0; idx < type->cnt; idx++) {
>> +	start_idx = memblock_bsearch_start(type, base);
>> +
>> +	for (idx = start_idx; idx < type->cnt; idx++) {
>
> Same here.
>
>>  		struct memblock_region *rgn = &type->regions[idx];
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>> @@ -2062,19 +2092,10 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>>  
>>  static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
>>  {
>> -	unsigned int left = 0, right = type->cnt;
>> +	int idx = memblock_bsearch_start(type, addr);
>>  
>> -	do {
>> -		unsigned int mid = (right + left) / 2;
>> -
>> -		if (addr < type->regions[mid].base)
>> -			right = mid;
>> -		else if (addr >= (type->regions[mid].base +
>> -				  type->regions[mid].size))
>> -			left = mid + 1;
>> -		else
>> -			return mid;
>> -	} while (left < right);
>> +	if (idx < type->cnt && addr >= type->regions[idx].base)
>> +		return idx;
>>  	return -1;
>>  }
>>  
>> base-commit: 1f18d740165163910df64d3063e1ad31648bc5e0
>
> -- 
> Regards,
> Pratyush Yadav

