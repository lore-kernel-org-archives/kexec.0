Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6851CA5FF1
	for <kexec@archiver.kernel.org>; Wed,  7 Oct 2026 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imywIXeZN+/or3shxnnFEehI44taL7I6PvUTOA24c8E=; b=ThaxUTuIU3sAvHe0KItt+RUwM+
	HFj57Tb2m2HzEvHfPo2nOD44BM2youUuJHXbEmjCyuk7KHrUnPr6c6OATE5ikrngau6sObTBL7Uni
	CQAjAnEXN5+36ejpcETdAR/35JF3q9A/g449K7pBYu0IQMEW7KHM2nENO6ldzC6kUfYWXit5AqujC
	QzpZc0bVt3yOjpZF5OVeuyJpLiDRxARNFxXKrN/LkwM5jcWIZjd0ixBT0G2V7LQp7IvhR/Db4kfmG
	du9pmg4LAxoJb/snkjml8nuoOzSosCN4k6EnkscSP3/ctw9ashMvRP7L5vEfgYXyv0abwcyOgm30P
	snnwlBbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xESIQ-00000002a9s-1zIr;
	Wed, 07 Oct 2026 14:07:02 +0000
Received: from mail-ej1-x645.google.com ([2a00:1450:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xESIO-00000002a8b-28w2
	for kexec@lists.infradead.org;
	Wed, 07 Oct 2026 14:07:01 +0000
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c2e6affec80so393994566b.2
        for <kexec@lists.infradead.org>; Wed, 07 Oct 2026 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791382017; x=1791986817; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imywIXeZN+/or3shxnnFEehI44taL7I6PvUTOA24c8E=;
        b=qk4kH4ggclHUc+TIGQ6Jm68JSiY+cqaOanQGpT6w0VJCkjFzcSHqnQADhjbUNs5SX1
         1LBbJ5kUBXmT5vNrnhDElgnURYAG4z3c9rbSaaBiSU27sIfgA0GlhXxwTQ1WKcgOlV9A
         F66emYSj6cZr+FrNpmwg7tz+8CPqm4VyUQNvhoTMwHvfOkjFv3KaaeDGhWi+MYqWiipT
         njalhWO5Ziw89r5j0EvwTS9z9K2Ea+yDHyDddq1/9bdEgC8rj5DMWAEtvQx73acgEhqW
         OZYNK+40bq3AkApRK23Lt9vIwUA9KGG1/+EuMs2eDmtFxyXXdDoVjei4UJGueSkODKhz
         JwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382017; x=1791986817;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=imywIXeZN+/or3shxnnFEehI44taL7I6PvUTOA24c8E=;
        b=o/+V6buAw0UU5Kclb3VoWL7r0RCFBbDhtUaDN2OQJHcLyOiXMy2E25dc5ITDRRjG5l
         H+shU2SV0qml6Xg9JY0BZgVLApi1VJENH5QgTMHHZ9hbhUrgTWzX/RR4YBZZW9RyCU1Y
         XAFUCya0WLJcob5hz0i16SZAvKSG12QN4dhr/7rgtykIG1MaweMLWbKSChlyjOk2k8LP
         8j50D11oEWq6CDDd0tZqREM3T2J+rZVIChZvjpEcNXUz/pScMHed3e2HtSPWWghHefZo
         Md+aWu3qHnLr4ia5yQPmUOLKWTBqVS4jfqfdB5XuDZRi/T4K+e6XWGJRw3Y7RvrBi/BK
         C0cw==
X-Forwarded-Encrypted: i=1; AKwUvBxIYc6WrZnmXMkgTL7LyKI02S74l4E6jbdllWuZZyUWmhxmIEIDQ60rORCev3vNmHGbtBNU5Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYI7j+/EAt62C9TQLKiHjYjwMaHmcRpzYdrtoKXS9Ko7pDSbJhik
	oah1zDzFVuT27clzLA6xkX1c19iHDJhipTDSmvFnqJ/OYQUSSYxz/Yw/u5RzWhxqljcB36hR4RT
	fdv5jseEAlUS9rntKMw==
X-Received: from ejeck7-n2.prod.google.com ([2002:a17:907:e1c7:20b0:c2e:3bb5:3475])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7955:b0:c2a:fbe1:7340 with SMTP id a640c23a62f3a-c317c0d81f8mr206753866b.41.1791382017061;
 Wed, 07 Oct 2026 07:06:57 -0700 (PDT)
Date: Wed, 07 Oct 2026 14:06:56 +0000
In-Reply-To: <asC1FwHVHOhBHDGK@kernel.org>
Mime-Version: 1.0
References: <20260926092448.4090401-1-tarunsahu@google.com>
 <20260926092448.4090401-2-tarunsahu@google.com> <asC1FwHVHOhBHDGK@kernel.org>
Message-ID: <9huzy0c9siyn.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 2/2] memblock: use binary search to locate candidate regions
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	dmatlack@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dev.jain@arm.com, Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261007_070700_583650_E5F18621 
X-CRM114-Status: GOOD (  22.35  )
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

Mike Rapoport <rppt@kernel.org> writes:

> On Sat, Sep 26, 2026 at 09:24:48AM +0000, Tarun Sahu wrote:
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
>
> I'd call it __memblock_search()

Okay.

>
>> +{
>> +	int mid, low = 0;
>> +	int high = type->cnt;
>> +
>> +	if (type->cnt && base >= type->regions[type->cnt - 1].base +
>> +				 type->regions[type->cnt - 1].size)
>> +		return type->cnt;
>
> Using local variables would make it more readable IMHO.

removing this as per next comment. Let me know what you think? Should we
keep this optimization or not.

~Tarun

>
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
>> -- 
>> 2.56.0.rc1.315.gc6ed9934b7-goog
>> 
>
> -- 
> Sincerely yours,
> Mike.

