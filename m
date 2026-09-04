Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0EBC624DE
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYO1KvVzPLClFw7IZqRu5rT86PANfLF01lGRYL9GdyA=; b=x1Dj7cAvkTIH8VjxLpLdumXtYg
	avNzgnGiuJQJUxyFPV4fd3YGMXOz4UJ2b8JZ+KG7lOfy+Z2TIUPZWR31M0AQGjhLBd5RSfpxEUp9U
	Hnpt3lhVCmAjObvhE/rKG1VQeOtegC6njx9qMkpQOIX0mvvFMZ1gEJIXs2ZQcY8Ts/pt+kOQKaGcd
	UNp4jIov3YF9YncrlbVdtqnA4SRaYfBkAVSQNTdWC5cMkbyOnKRNz3OQ0WQ1cI5eVlBfa7Jyma0ED
	r6fiotNw1iGsaKM94XIRcq5jNY0uQo2vH2CYnJPZiCCpdSt9HlTkUIsW5tXTJ2/s5Ws2m7wZPTytd
	VqnLr+Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2VvB-00000002XZt-0mqX;
	Fri, 04 Sep 2026 15:33:41 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Vv8-00000002XZM-47wE
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 15:33:40 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c252a2ae8e1so127128166b.1
        for <kexec@lists.infradead.org>; Fri, 04 Sep 2026 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788536016; x=1789140816; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYO1KvVzPLClFw7IZqRu5rT86PANfLF01lGRYL9GdyA=;
        b=lV0iylEnuHmcjzm/wKJr5zWbFIohyepStQuxblzjjLZRcdhWKG+ZRLoPzHyisvGgzb
         7hRqjrdrTcoJWCuadCr5NesHMWv0+aBBNMU9ccXTdNymVFYVRbVWhGzxYQzuye+WP4iX
         gnkrTfILYSozwl7nnXBOx+rRac+jqmcI17HpDY6zOx8FJmKmcKu5JtozTT7gfsbPZoyb
         eu6zLJy6/fS7cEjmhZsI4Qg+A9r2cxzDK3kk7ovFe1UnelyOqIjyAHsHhuHI20R/gu/u
         izx1LixwlUZ0EqzapF8DBVoZhi4FaAO70lnNjUcXSkdEh4xGbny3lBwjZ0Q7Ps7OE2dN
         hd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536016; x=1789140816;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYO1KvVzPLClFw7IZqRu5rT86PANfLF01lGRYL9GdyA=;
        b=caBs++vb1jZC9JSV4eBe2fas6HDXnW2NjsYuBh+vXcihuBK7OLqP3qtTciolryzGeS
         YCWt6i9XYaXLPxT9jXNnr1NGyPC0qBerZKiky4i+SxKbvtpCemD7Dwp09foijuXy2Vgz
         vkY80RMS4pqtBN49L4rBmz8NEpZ01I8jfly2sJ5YtxGqkS5jIqcQbUKI2kT+EAezE5E2
         bNBL3Rb5pMJQauvsLFtDt2At7hjn/6s+Lp7MshNmW6ME5owLSsC38TTeiHHWmGB0+0f0
         IJLUyKuOi1FymGNq5vALGwGk0EgVWDHyA0uS/WelTBEo7c9NjUgCKBP5LTKjPRHct048
         ecBw==
X-Forwarded-Encrypted: i=1; AKwUvBwdnVJMgCyfETf2L++ckbRsDSAR3ly6WFXqyAUsqgl/IDQG1XaPrahkSrPLjTAoL9D5kvVqWw==@lists.infradead.org
X-Gm-Message-State: AFuF++kSh/MKtUaykcPzKiKkk3UdMfDB30OGDN8vTw3/YtBBWvb/t4+B
	dyK3SuIawWvh5NDHJ9Ni4ApWSlJiG2xRRaey5e4bqrpq7Q+P4jk9SLnP3RUrzg/tNaYwoGuXI2e
	Bv2qAY1BUWcCKWeAA6Q==
X-Received: from edj28.prod.google.com ([2002:a05:6402:325c:b0:6a7:e24b:5a30])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:f0b:b0:6a7:ee56:815f with SMTP id 4fb4d7f45d1cf-6a7ee568276mr1201539a12.45.1788536016263;
 Fri, 04 Sep 2026 08:33:36 -0700 (PDT)
Date: Fri, 04 Sep 2026 15:33:35 +0000
In-Reply-To: <925c45d9-91dc-406a-9ff5-8c16f3ee0d9f@arm.com>
Mime-Version: 1.0
References: <20260903155907.1065681-1-tarunsahu@google.com> <925c45d9-91dc-406a-9ff5-8c16f3ee0d9f@arm.com>
Message-ID: <9huz4ig51168.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH] memblock: use binary search to locate candidate regions
From: tarunsahu@google.com
To: Dev Jain <dev.jain@arm.com>, dmatlack@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_083339_049770_8DF2E5EF 
X-CRM114-Status: GOOD (  26.27  )
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

Dev Jain <dev.jain@arm.com> writes:

> On 03/09/26 9:29 pm, Tarun Sahu wrote:
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
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>
> I recall noticing this 2 years ago : ) but then abandoned because
> I couldn't think of a usecase.
>
> I have forgotten memblock and no idea on KHO, but are you sure
> this patch won't have negative consequence for the usual cases?
> In other words is this something KHO specific, and in the usual
> cases a linear search is more cache/CPU friendly?
>

Linear search on very large list: A very big problem
Linear search on small list (< 100): Good and almost 100% cache hit
because of next memory prediction by CPU.

Binary Search on very large list: very good thing
Binary search on small list (< 100): Algorithm anyway faster (worst case
cycle 3-4 vs 100 in linear search), yes cache miss is problem but IIUC,
To contribute to latency significantly, the quantity of such cache
misses is very less. Binary search uses more instruction per loop than
linear search, so of course linear search is better in this case, But
that micro/nano seconds latency affect is really an issue here? because
memblock is boot time initialization code. (Except memory hotplug) So No
userspace application like HFT or gaming will be affected by this.

So I believe, binary search wins here. Let me know your thoughts?

> Also below I see you have implemented a custom binary search helper.
> I recall a generic one is there in some .h file somewhere in the
> codebase, perhaps that may be useful, just FYI, ignore if already
> tried that.

This one does lower bound serach:  To find the first element where the
addition can be done instead of trying to find the exact match.

This one has a fast-path unlike to general binary search:

+	if (type->cnt && base >= type->regions[type->cnt - 1].base +
+				 type->regions[type->cnt - 1].size)
+		return type->cnt;

Also, I followed what memblock_search already does, Having its own
binary search.

~Tarun

>
>>  mm/memblock.c | 38 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 9ce86349a29f..88940474b020 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -160,6 +160,11 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>>  	     i < memblock_type->cnt;					\
>>  	     i++, rgn = &memblock_type->regions[i])
>>  
>> +#define for_each_memblock_type_from(i, memblock_type, rgn, start)	\
>> +	for (i = (start), rgn = &memblock_type->regions[i];		\
>> +	     i < memblock_type->cnt;					\
>> +	     i++, rgn = &memblock_type->regions[i])
>> +
>>  #define memblock_dbg(fmt, ...)						\
>>  	do {								\
>>  		if (memblock_debug)					\
>> @@ -591,6 +596,33 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
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
>> @@ -651,7 +683,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>  	base = obase;
>>  	nr_new = 0;
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for_each_memblock_type_from(idx, type, rgn,
>> +				    memblock_bsearch_start(type, base)) {
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>>  
>> @@ -827,7 +860,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  		if (memblock_double_array(type, base, size) < 0)
>>  			return -ENOMEM;
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for_each_memblock_type_from(idx, type, rgn,
>> +				    memblock_bsearch_start(type, base)) {
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>>  

