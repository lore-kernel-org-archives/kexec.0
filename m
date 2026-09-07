Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EE5C79F89
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 04:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=um99HQvxm8U8bWkMubZ+aKjTZImXgaTd+AqHI5SXH5Q=; b=ENE7cKVVFzmlKyOlk/HmaoTYNz
	2w5Yipz8JthZqdp3ARg3ltCQ97olJiJL4sdIqGn9R9X9t1CaDizpNVo4RLfA0J1S0/ikAWJBNDCxG
	2nGEyrLpKY70OmUytMjklas740OoUNYZyFW6g6mVm6mWqaVuk1Ar2yqgxgTYWiwFuPriTYwvR8hxZ
	R/ZVmA1O2ZY4NUJ83GeBC1NQUWQu4JcmqZgEjYVKV4pTMbC7fvTQXsk/gG66aYccu0nYD5PmzhE0D
	8pRmQ/8j2Qyzu+9b0Mbhyi+AB9ZDu+Ozfhv3oCajU+PmmTE89mV2DzUeD4biSqiJmBpcVGXweUTvp
	Ie7yz7lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3QX5-00000005paY-1xXv;
	Mon, 07 Sep 2026 04:00:35 +0000
Received: from mail-ed1-x546.google.com ([2a00:1450:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3QX3-00000005pZy-11uY
	for kexec@lists.infradead.org;
	Mon, 07 Sep 2026 04:00:34 +0000
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-6a5d46edd1eso2781954a12.1
        for <kexec@lists.infradead.org>; Sun, 06 Sep 2026 21:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788753629; x=1789358429; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=um99HQvxm8U8bWkMubZ+aKjTZImXgaTd+AqHI5SXH5Q=;
        b=M6tJ9yyZWvnujmT0XvgGaZr4HSMs1YwoCGquVXhcKGGHjzb3kC2QspzHWo0XDjTpAW
         qDf4grHjtaZEvVgOTEYumXHxh6i0KbsTcBRJueYGkj5ekQ3GeVR5QMGGJ7nMSohgrBD8
         iktfDtW/EfRWvaTkdttfbju1xk2rYx31E17wALqfYm731Ap+kXJkvfaTyLb70vVMtBuT
         7tfIVtPgZZAtsHaLscInmeUWg/hH3iaZUrnrlgO921T6RPJB1Zaq9y4Qc9koqAqqmFyF
         VfobpcrEn3QCXW449NhDpDo0SBZDLvySe3G8TEXOlnfmSk4K9s0H6o5rLY6Ezlc4j9Dq
         LefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788753629; x=1789358429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=um99HQvxm8U8bWkMubZ+aKjTZImXgaTd+AqHI5SXH5Q=;
        b=Hj0I+mfPWbAr3GUaVSnD4GKKo48SKrwXUzBZx0mTdyJbJNrqQcIxy0VlKdDyW2rVEJ
         8fTv8u4Fw0288SyaVMqMlM+KvT/DoFoH9NR2kD3L7e4NqGV4pXvJDB+2hYNL4r9NnET6
         ReKZoZPUy8C4k2JjcnvUzMBueGmCTx6bGwBxjbTtrZsZ3pVIqYF7mIhkytUThg6vIBgV
         d717cZh3p78ewN8isDuDdEBYKgLB3DjvN5+RVIgjB4a1a8tg/OzIf+tZULZ1pMkIBTzt
         QaN5/ccH2KEJp6Qze9c5ScjZruNUjnBiM5xncCiuCFWKm4jB+19mUtYxNDWzEAfPh8jW
         aopQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYxqqAwiK2VzwZ1ZZExqpOYNspvQgGFBjxirQQCFPoFjt/eN7IUtlVGlzol+b0Agc6Mhi37g==@lists.infradead.org
X-Gm-Message-State: AFuF++kC+i29vTqNJBiFqbOTR2RbRzj/1hp/oRwz9r3cstqx4JCDzkJ9
	lXZgbDf9lN1GOFWuDZ+ZfB3RXVeAlLuw+a10Rr3FzEfYKsdIWgcvHsr3DQaAMXUpiIoykihw+OZ
	Iroh0VUFZi8iOVWXeYA==
X-Received: from edqt8.prod.google.com ([2002:aa7:d708:0:b0:6a7:60c4:e4ad])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3241:b0:6a6:32fa:1e9a with SMTP id 4fb4d7f45d1cf-6a7e90c2f67mr4994847a12.18.1788753628866;
 Sun, 06 Sep 2026 21:00:28 -0700 (PDT)
Date: Mon, 07 Sep 2026 04:00:28 +0000
In-Reply-To: <ap0_lSVF43FP3PPb@kernel.org>
Mime-Version: 1.0
References: <20260903155907.1065681-1-tarunsahu@google.com> <ap0_lSVF43FP3PPb@kernel.org>
Message-ID: <9huzwlsxk8wz.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH] memblock: use binary search to locate candidate regions
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_210033_345958_203E2B4A 
X-CRM114-Status: GOOD (  28.26  )
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

> Hi Tarun,
>
> On Thu, Sep 03, 2026 at 03:59:06PM +0000, Tarun Sahu wrote:
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
>
> We already have memblock_search() ;-)

Yes, I preferred to have saperate function because we need to search
lower bound but not the exact match, as new entry might not exist and
memblock_search will return -1 in that case.

To not duplicate the binary search code, we can update the
memblock_search as the wrapper of memblock_bsearch_start (Approach 1):

diff --git a/mm/memblock.c b/mm/memblock.c
index 88940474b020..d9a71234abcd 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2096,17 +2096,10 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
 {
-	unsigned int left = 0, right = type->cnt;
-
-	do {
-		unsigned int mid = (right + left) / 2;
-
-		if (addr < type->regions[mid].base)
-			right = mid;
-		else if (addr >= (type->regions[mid].base +
-				  type->regions[mid].size))
-			left = mid + 1;
-		else
-			return mid;
-	} while (left < right);
-	return -1;
+	int idx = memblock_bsearch_start(type, addr);
+
+	if (idx < type->cnt && addr >= type->regions[idx].base)
+		return idx;
+	return -1;
 }

OR Approach 2:

The above approach still introduce two function for doing the search.
So, I thought of updating the memblock_search(..., enum search_type) but
this will require changes to all the places of memblock_search also.

I prefer approach 1, As it will keep the binary_search code
within single function and have two function for two different type
return values.

WDYT?

>
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
>
> I think we can just kill for_each_memblock_type() and open code all loops
> that use it and make memblock_add_range() and memblock_isolate_range() use
> binary search.

Agree, there were three places memblock_add_range, memblock_dump,
memblock_isolate_range, This patch already updating two of them.
The for loop is not complex to be part of the macro, Open code sounds
good to me.


~Tarun
>
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
>> -- 
>> 2.55.0.970.g62bdec98f9-goog
>> 
>
> -- 
> Sincerely yours,
> Mike.

