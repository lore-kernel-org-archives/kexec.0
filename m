Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC25C79F82
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mLY/ci2oR2yKic2vb+sEbJUZ8whxHO5esQUdSjd9KzA=; b=3QfuGds2eAwLK/9mjp2t1NUsMW
	IBC376tKfeLhgSBPW2GvOYMHv9hctcdlC3JVyiJhYD0nHCUMwcMpqeDYk3MWBo7l5QWTCaSaGZMW6
	Fa8bWHq6y9iLfSniztofO0YipsEqi35+MJpiUmWR4srfHsWnOvtRoVO++ZSgjZxXF6ECGFQaWauhT
	BSWNJwot7udj5NSZRhOaCW2fIOzBBPb5FaGh7tDlEiTyVW9Msg3201C69dTtMWVJh/+2u+CEXinVR
	eWFoCk7sEKLz76W8AVA1j7OWckIA4/be3Q26cWWI/8sREDr7IT/yahC5bY2Dqds3E7K1sPV003IAY
	ctoHTQ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2VGA-00000002RW3-2IHZ;
	Fri, 04 Sep 2026 14:51:18 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2VG8-00000002RTR-3AEP
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 14:51:18 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6a67fdea041so1016738a12.2
        for <kexec@lists.infradead.org>; Fri, 04 Sep 2026 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788533473; x=1789138273; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLY/ci2oR2yKic2vb+sEbJUZ8whxHO5esQUdSjd9KzA=;
        b=aNpL54TERoBNftoh+MiVQ/Qn98B+waQomBfrEq4FC27oQZ8jOo5bN2o3LQWOU/Hq6R
         cnGW15UX46a0a+Le1DihW1HOCSWwP3jCpMFQrpxcPvii0+XCp8q5DioGiJtDfIJbMiur
         MqnuOVJQTZz/fBLQFg0jkGaGaoEgGcQGGiltLRLAEo0auGsilbaKmLJviXvwe/rVe4UF
         noHGrsaJfcl4NIEC9CYRzjwsbMvseN+V7auGa38/1TaUHwihL/nnrcA1McToSPky7z2j
         kWx8LkGLWNE/Awx+XByB6lnOa7SQU/I3QWdLGnCnH5wJImvKyZYwRDwh9M+akAAsHX9J
         U6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533473; x=1789138273;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLY/ci2oR2yKic2vb+sEbJUZ8whxHO5esQUdSjd9KzA=;
        b=HM6CHf/tJgklP4GBNU0zmAjewXNMZZDydCoV9vQP9+Z/2WrfBb/MMc0YMUZVgeqoCA
         eGO4XeH2DJrgp5Op0f5B2x9tNtq55DGpFSv6e2mObI39iMqzao3uMsg9XECDjCWUosTx
         0GQ1yf6ObkjQYZwB1g7K5woh1qAHgAP/BVvpJIlHA2x6dC7NtDQCnwGMPPxplx/UQg/y
         rw+LR7tR7iWBdQZ7RmlcoKzh62Fxw0J9E8rNIBpSbKPBqroZhTlsVGTVbCfytoajF3Hu
         VSolTexDXktGAnYtcSHSzsYyzj1MOPNAiHW3E7XkQeqfI8IDZLvaAJz6kZHAwnyJGBIU
         Xyaw==
X-Forwarded-Encrypted: i=1; AKwUvBy7UAkFxNfcwxTeK97lcPZLVHvK4kOsQobLxCynrKstFcMN2/SA/NJ0Bu9Ay9sTNN7RiUuxEg==@lists.infradead.org
X-Gm-Message-State: AFuF++lSWOudhJed6hEg3uCS3Yhmb79dvYATqWtJE46Q0lcAHuU0iYEZ
	285UE7b3ugFiI2k20upZt8j+dhziAFFAWSdqiCwvnt5+YAB+JESc+KTXIZWSwjH2nH9/Rk3wWGD
	xXds04lQ+6lhlOVPvXw==
X-Received: from edgi19-n1.prod.google.com ([2002:a05:6402:a593:10b0:6a6:8587:3226])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:52c9:b0:6a6:32f5:5573 with SMTP id 4fb4d7f45d1cf-6a7e8f94ac4mr2595587a12.21.1788533473262;
 Fri, 04 Sep 2026 07:51:13 -0700 (PDT)
Date: Fri, 04 Sep 2026 14:51:12 +0000
In-Reply-To: <5c223d7d-4f7b-420c-8019-d4f343f0f232@oracle.com>
Mime-Version: 1.0
References: <20260903155907.1065681-1-tarunsahu@google.com> <5c223d7d-4f7b-420c-8019-d4f343f0f232@oracle.com>
Message-ID: <9huz7bl1134v.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH] memblock: use binary search to locate candidate regions
From: tarunsahu@google.com
To: Dongli Zhang <dongli.zhang@oracle.com>, dmatlack@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_075116_841337_11CB59F5 
X-CRM114-Status: GOOD (  36.49  )
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

Dongli Zhang <dongli.zhang@oracle.com> writes:

> On Thu, Sep 3, 2026 8:59:06AM -0700, Tarun Sahu wrote:
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
>
> I encountered this issue with my workload. Initially, it was because I forgot to
> set THP to "always", As a result, there were many 4K pages even though they were
> contiguous.
>
> Indeed, I noticed some delays or hiccups with my workload even with THP set to
> "always".
>
> In the past month, I used something like what I attached at the end of my reply
> to reduce the number of memblock_reserve() calls. I never realized the poor
> performance was caused by memblock_reserve() itself.
>
> [    0.231623] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> --> delay
> [   38.587378] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
>
> With your patch, I ran several rounds of tests with THP set to "never" (4K
> pages) and no longer noticed any hiccups or delays with my workload.
>
> [    0.247746] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.512019] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
>
>
> Thanks to this patch, I no longer have to put up with the delays or hiccups in
> my workload!
>
> Thank you very much!

Glad to know it helped and thanks for testing this.

>
> Dongli Zhang
>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..03e1f914c800 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -67,6 +67,8 @@ union kho_page_info {
>  static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
>
>  static bool kho_enable __ro_after_init =
> IS_ENABLED(CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT);
> +static phys_addr_t kho_preserved_batch_start __initdata;
> +static phys_addr_t kho_preserved_batch_end __initdata;
>
>  bool kho_is_enabled(void)
>  {
> @@ -610,25 +612,58 @@ static struct page *__init
> kho_get_preserved_page(phys_addr_t phys,
>  	return pfn_to_page(pfn);
>  }
>
> +static void __init kho_preserved_memory_batch_flush(void)
> +{
> +	phys_addr_t size;
> +
> +	if (kho_preserved_batch_start == kho_preserved_batch_end)
> +		return;
> +
> +	size = kho_preserved_batch_end - kho_preserved_batch_start;
> +	memblock_reserve(kho_preserved_batch_start, size);
> +	memblock_reserved_mark_noinit(kho_preserved_batch_start, size);
We can also combine these two function. IIUC, kho_preserved_batch_start
does not overlap with other reserved regions so, they will be mutually
exclusives ranges and can directly be marked noinit while adding to
reserved list.

~Tarun

> +
> +	kho_preserved_batch_start = 0;
> +	kho_preserved_batch_end = 0;
> +}
> +
> +static void __init kho_preserved_memory_batch_add(phys_addr_t phys,
> +						  unsigned int order)
> +{
> +	phys_addr_t size = 1ULL << (order + PAGE_SHIFT);
> +	phys_addr_t end = phys + size;
> +
> +	if (kho_preserved_batch_start == kho_preserved_batch_end) {
> +		kho_preserved_batch_start = phys;
> +		kho_preserved_batch_end = end;
> +		return;
> +	}
> +
> +	if (phys == kho_preserved_batch_end) {
> +		kho_preserved_batch_end = end;
> +		return;
> +	}
> +
> +	kho_preserved_memory_batch_flush();
> +	kho_preserved_batch_start = phys;
> +	kho_preserved_batch_end = end;
> +}
> +
>  static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
>  {
>  	union kho_page_info info;
>  	struct page *page;
>  	unsigned int order;
>  	phys_addr_t phys;
> -	u64 sz;
>
>  	phys = kho_decode_radix_key(key, &order);
>
> -	sz = 1UL << (order + PAGE_SHIFT);
>  	page = kho_get_preserved_page(phys, order);
>
> -	/* Reserve the memory preserved in KHO in memblock */
> -	memblock_reserve(phys, sz);
> -	memblock_reserved_mark_noinit(phys, sz);
>  	info.magic = KHO_PAGE_MAGIC;
>  	info.order = order;
>  	page->private = info.page_private;
> +	kho_preserved_memory_batch_add(phys, order);
>
>  	return 0;
>  }
> @@ -1687,8 +1722,13 @@ static void __init kho_mem_retrieve(void)
>  		.leaf = kho_preserved_memory_reserve,
>  	};
>
> -	if (kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL))
> +	kho_preserved_batch_start = 0;
> +	kho_preserved_batch_end = 0;
> +	if (kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL)) {
> +		kho_preserved_memory_batch_flush();
>  		goto err;
> +	}
> +	kho_preserved_memory_batch_flush();
>
>  	return;
>
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
>> -- 
>> 2.55.0.970.g62bdec98f9-goog
>> 
>> 

