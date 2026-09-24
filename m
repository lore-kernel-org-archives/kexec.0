Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F54C98317
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctwayjHvAj5rO/ALkHWHVIPs9SRT5FDkZw4zngF4FsM=; b=qDipFp69gKqYb0FKsaUu+2tZWS
	DEuBVqwW2NX4OrPJjZg8fpflV3WDNCvMqFoPY9dGI0+1VDQqTEN6JaNPszUhVVJljqsS5afsRnm10
	kL4KJRQpCxvZ2kx3r3t2wtHDT31WpLbFKBuABDnnksEmfNamfZYxZrN1c+Io9QSM4RDRyLdeywA+N
	cH80g7trwnehAwpG+41pfTzuQQUWh996AyqgiXEKqRLYS+hC/ykpLnpNwUCs8De0/IxcvW1AU5Kgl
	D6oPEKuJdLtCvGLWgmBjMc6KxosnyUP2G+DGhYINHwtU51FGZUHr9rGRDHPP7Y/d7CNaUE1nXhARp
	6sivgYPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9hWp-0000000AqoJ-3xSu;
	Thu, 24 Sep 2026 11:22:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9hWo-0000000Aqo9-123J
	for kexec@lists.infradead.org;
	Thu, 24 Sep 2026 11:22:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A2D9600AA;
	Thu, 24 Sep 2026 11:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9961F00893;
	Thu, 24 Sep 2026 11:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790248932;
	bh=ctwayjHvAj5rO/ALkHWHVIPs9SRT5FDkZw4zngF4FsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SLcpADPq4EEZy7CYxm/FfpTvXhOBlV7k27ge46+15mUNqtekLfytiC8znGla+1Snm
	 PSbv92RSUcUv8ktM2tceZ9jdbEwC8TEK3PQTCtuySbOVTtsTySc7dsgsv/ScPTeVF8
	 +JF2qqpHzRTVTTLnIT7nMcFBnjMaGkSGLudLCsU3Ix3do4DOJ90KnBEK+xYnM0mcGj
	 H5k6GSwsaDxcQo4fcythrZ1YRBgmS802wUIdl4m/qMSmatE8+BseUx2JXkwVVqypy0
	 ezrylZ6VcLud0LgaGtIs5YFzeuzIQDJh4PMRLOmx9POlfqEiLVL+b/y1OT7BZwTuEG
	 GQ56tSjWThlVw==
Message-ID: <cf2fe0bb-a79a-420e-8b65-3c8dfa5fadbb@kernel.org>
Date: Thu, 24 Sep 2026 13:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] drivers/base/memory: count inherited poisoned
 frames into the block
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 kas@kernel.org, kexec@lists.infradead.org, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Brendan Jackman
 <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 hannes@cmpxchg.or, shakeel.butt@linux.dev, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com,
 riel@surriel.com, harry@kernel.org, linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev, kernel-team@meta.com
References: <20260915-hwpoison-kho-v5-7-3bc7a57bd503@debian.org>
 <de41b78a-8471-4832-be0c-35d410a4499a@kernel.org>
 <aqpczrtIwSG948iv@gmail.com>
 <b8ad366a-a019-4462-9dce-f687f60ee7f2@kernel.org>
 <aqvHHHuWJ-y4WRJZ@gmail.com>
 <caac2cb9-8faa-49bc-ae8a-47c5fd7b7e58@kernel.org>
 <aq1RaH0eE0hZfNpr@gmail.com>
 <fb2237be-f7bc-4ad6-bcb0-7c3ef53136ef@kernel.org>
 <arE3UjqPsxctWckg@gmail.com>
 <ad2ed3ed-959a-4af3-a2f5-4c21e5af62d6@kernel.org>
 <arJqVWN-prvI_0NP@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <arJqVWN-prvI_0NP@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/22/26 14:34, Breno Leitao wrote:
> Hello David,
> 
> On Tue, Sep 22, 2026 at 01:33:51PM +0200, David Hildenbrand (Arm) wrote:
>> On 9/21/26 16:31, Breno Leitao wrote:
>>>
>>> The EFI table is only written when there is a memory failure. That is
>>> the only thing that writes to it:
>>>
>>> 	action_result() -> efi_hwpoison_record_pfn() -> set_bit()
>>>
>>> You can see it on patch "mm/memory-failure: efi: record
>>> hardware-poisoned frames into the poisoned-memory table"
>>>
>>> Then, when the kernel kexecs into a second kernel, the EFI config table
>>> is queried and the pages are poisoned from it at boot, as they are
>>> getting into the buddy allocator, in __free_pages_core().
>>
>> I am not sure that is really the right place. That means we only poison free
>> memory.
> 
> Right, and that is a real gap. A frame only reaches __free_pages_core()
> if it is handed to the buddy allocator, so anything this kernel already
> took from memblock -- the memmap itself, early page tables, percpu --
> can be sitting on a recorded frame with nobody noticing.
> 
>> Shouldn't we poison as soon as we initialize the memmap, and check
>> whether any memblock allocations ended up on that poisoned memory and bail out?
> 

Thanks for the history on this.

> 
> That is close to what I had until v2, where the bitmap was walked at EFI
> parse time and every set unit was memblock_reserve()d:
> 
> 	for (off = 0; off < bitmap_size; off += PAGE_SIZE) {
> 		...
> 		for_each_set_bit(bit, map, nbits) {
> 			u64 unit = off * BITS_PER_BYTE + bit;
> 
> 			memblock_reserve(phys_base + unit * unit_size, unit_size);
> 			nr_units++;
> 		}
> 		...
> 	}

Yes, that what I have in mind.

> 
> Set the full v2 patch at
> https://lore.kernel.org/all/20260821-hwpoison-kho-v2-6-5743791e48e6@debian.org/
> 
> Kiryl raised some concerns, such as x86 does not keep memblock past
> boot,

The memmap contains that information. If it's a scalability problem with
thousands of hwpoisoned 2M ranges, don't try to keep kernels running on utterly
broken systems, seriously.

> and kexec picks placement from iomem_resource via
> walk_system_ram_res(), which memblock_reserve() does not touch. 

Where we could scan the memmap. If we find scalability problems with that they
should be addressed there.

> So the
> frames stay out of buddy, but the next image can still be placed on
> them, and since nothing sets PG_hwpoison none of the existing hwpoison
> users see them either.

Memblock knows which ranges were poisoned. It shouldn't hand these out, neither
to memblock users or the buddy.

And is it knows that these ranges are poisoned, it should be marking them as
hwpoisoned when we initialize the memmap.

Kiryl probably remembered the unaccepted-memory hammer and thought of hwpoison
of being just another nail. It's not. hwpoison is a proper kernel infrastructure.

> 
> Most of the discussion happened here:
> https://lore.kernel.org/all/aog_uH5fTsJzXjjx@thinkstation/
> 
> v3 then poisoned the frames from mm_core_init(), right after
> memblock_free_all(), taking them back off buddy. 

They should have never been exposed to the buddy.

> That breaks with
> CONFIG_DEFERRED_STRUCT_PAGE_INIT, where the struct pages above
> first_deferred_pfn do not exist yet at that point, and Kiryl's other
> point was that the shape was wrong regardless: flag the frame on its
> first add to buddy, not after buddy is up.

The flags should be set earlier and pages never even handed to the buddy.

Handing out poisoned pages from one allocator to hide them from another
allocator is stupid.

> 
> See the discussion at:
> https://lore.kernel.org/all/apGbDOnPm5VXP5ez@thinkstation/
> 
> Which is how it ended up in __free_pages_core().
>>>> From that point on, the memmap should be our reliable source of information.
> 
> Sure, is this approach better?
> 
>   - the bitmap is read as the struct pages are initialised, and the only
>     thing it does there is SetPageHWPoison();
> 
>   - __free_pages_core() keeps the hook but tests PageHWPoison() instead
>     of the table, so a recorded frame is still held back before it can
>     enter buddy;
> 
>   - nothing else queries the table.

Why should we give pages we know are poisoned to the buddy? And why should we
let memblock hand out poisoned ranges?

I'm sorry, it's all hacky.

I see why we want a bitmap from kernel A to kernel B, but once the kernel is up
we have established infrastrcture to identify poisoned pages.

Just look at the mess in the patch here I replied to. Pairing bitmap scans with
memmap scans ... hacky.

> 
> One caveat on "exactly once": if that means one pass at one point in
> boot, it is what v3[1] did -- hwpoison_init_boot() from mm_core_init(),
> right after memblock_free_all() -- and it does not work. With
> CONFIG_DEFERRED_STRUCT_PAGE_INIT the struct pages above
> first_deferred_pfn are not there yet at that point.
> 
> Link: https://lore.kernel.org/all/20260826-hwpoison-kho-v3-5-6f79c4b605bc@debian.org/
> 
> So I _think_ we want to do it once per frame, as that frame's struct
> page comes up. __init_single_page() is the single function they all pass
> through. Is __init_single_page() the right place to query the bitmap and
> mark is as poisoned?

That's what I originally had in mind, but I am not sure if it's the right time
to query it.

Assume we tell memblock about the poisoned ranges early and it would not hand
them out.

memblock_free_pages() would never get called in the first place.

All pages would look like they are simply allocated by memblock.

We'd have to traverse the poisoned ranges in memblock once to set the hwpoisoned
bits.

> 
>> For this code here, just remember globally whether we hwpoisoned any page. If
>> so, just walk the memmap. If not (the 99.9999% of all systems, no need to scan
>> anything).
> 
> Yes, and the counter already exists: num_poisoned_pages and we can query
> it. I am also planning to add something similar in the EFI table, like
> an ->empty field, which will be cleared when a bit is set, avoiding
> doing bitmap walk on the happy path (not a single poisoned page).
> 
> Anyway, range_hwpoison() short-circuits on it today,
> 
>       if (!size || !atomic_long_read(&num_poisoned_pages))
>               return poison;
> 
> so memblk_nr_poison_init() can gate on the same thing and walk the
> memmap, with no EFI call left in drivers/base/memory.c at all. That
> disposes of the misleading name there too, which was where this
> started.
> 
> Now, the half I am less sure about is checking whether a memblock
> allocation landed on a recorded frame. Poisoning at memmap init cannot
> prevent that -- the memmap is itself a memblock allocation, so the
> struct pages do not exist while the early allocations are being made --
> it can only detect it afterwards, as a pass over memblock.reserved
> before memblock_free_all().
> 
> The alternative is to bring v2's memblock_reserve() back purely to keep
> the early allocator off those frames, and still poison at memmap init
> so the flag is there for everyone else. That gets both properties, at
> the cost of frames that are Reserved and HWPoison and never in buddy,
> which I have not thought through for unpoison.


Thanks for the history on this. I tried to summarize my thoughts above. I might
be wrong.

-- 
Cheers,

David

