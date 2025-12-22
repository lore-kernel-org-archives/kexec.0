Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7865DE677ED
	for <kexec@archiver.kernel.org>; Mon, 22 Dec 2025 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/JDjTyJFVUo7vfeacCyOxZOxyDerTlslTj9N9ct22Q=; b=qIYqSVRxQ8Vm/lhsUWn6sF/WjT
	Ke/tLKXR9OgWn8waaoBFUnZuVGiBW7ZpdeD7ZzM+gZWTBWhjbRBwSWWuv+XK1CObALfmX9N2e//WM
	L/zSjvxgtFlAhEnTJvFPwxl0Vo8UtRz/33iFO0vVVU0DZs5zI2XDziBpT4tIUEN2oDSEepp02Gr8T
	dCy1THMWF7jquNRxuoXDyox1hN6RDAZScqTeMWfRkWiHnd3XMMqClh7k7oyWjcFRya1DcsdQPpYfZ
	cNx+yfKjwoo/Wd1M7OFMQDsqpsNM48pgBLV6iktuC8dOUcDErzYyQqmauo+VHESVS5Eu+ZlAZ88+N
	/rvgiA+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXihk-0000000Dxup-3Q5Z;
	Mon, 22 Dec 2025 16:24:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXihj-0000000DxuR-1o6S
	for kexec@lists.infradead.org;
	Mon, 22 Dec 2025 16:24:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 69F436014C;
	Mon, 22 Dec 2025 16:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB14EC4CEF1;
	Mon, 22 Dec 2025 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766420654;
	bh=Bho3Ephj/9Cu96QbuGoz94Bq/j6VeyHgvvqBBYHo8T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i48/qyaHpO3sQRwas4fTznSqsEt2K7OlmhRVXNV5Fw6tW3bXOJ1e0vqBhOsb46hJI
	 yrmjZfUquyFJN/Ql2caT5qoUTjFhgd2XaVVNB//7DoSKLW35DNB/KKVtTlxk3S/cug
	 GZHKr9n/0jv35PnSXraG/hBWPjnOgM6PBn2TkNz4rtxMr0/gEPJw7Q9kVI+M3Qq7X2
	 WCHBGaQOUt+J0qtHbQNPbBAdwUGKXWrnmBVI8PPzdt0q05sZG/jdCnlewxBXsIMKSO
	 S2JEmnmQW+eozWBsgRIbg9qFTgOpOKJA9L8N7+bVDSpivhjp0MrBZPyVc16+GzdMRj
	 mIgv8dxfOOu5g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Evangelos Petrongonas <epetron@amazon.de>,  Alexander Graf
 <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jason Miu
 <jasonmiu@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
In-Reply-To: <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
	(Pasha Tatashin's message of "Mon, 22 Dec 2025 10:55:34 -0500")
References: <20251216084913.86342-1-epetron@amazon.de>
	<aUFJH9xzJXYOt_X8@kernel.org>
	<CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
	<aUF4fsWwD9BswkFh@kernel.org>
	<CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
	<aUUYprAotKYMiEs0@kernel.org>
	<CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
	<861pkpkffh.fsf@kernel.org>
	<CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
	<86jyyecyzh.fsf@kernel.org>
	<CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
Date: Mon, 22 Dec 2025 17:24:07 +0100
Message-ID: <863452cwns.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Dec 22 2025, Pasha Tatashin wrote:

>> > NUMA node boundaries are SECTION_SIZE aligned. Since SECTION_SIZE is
>> > larger than MAX_PAGE_ORDER it is mathematically impossible for a
>> > single chunk to span multiple nodes.
>>
>> For folios, yes. The whole folio should only be in a single node. But we
>> also have kho_preserve_pages() (formerly kho_preserve_phys()) which can
>> be used to preserve an arbitrary size of memory and _that_ doesn't have
>> to be in the same section. And if the memory is properly aligned, then
>> it will end up being just one higher-order preservation in KHO.
>
> Both restore pages and folios we use: kho_restore_page() which has the
> following:
>
> /*
> * deserialize_bitmap() only sets the magic on the head page. This magic
> * check also implicitly makes sure phys is order-aligned since for
> * non-order-aligned phys addresses, magic will never be set.
> */
> if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
> return NULL;

See my patch that drops this restriction:
https://lore.kernel.org/linux-mm/20251206230222.853493-2-pratyush@kernel.org/

I think it was wrong to add it in the first place.

>
> My understanding the head page can never be more than MAX_PAGE_ORDER
> hence why I am saying it will be less than SECTION_SIZE. With HugeTLB
> the order can be more than MAX_PAGE_ORDER, but in that case it still
> has to be within a single NID, since a huge page cannot be split
> across multiple nodes.

For a "proper" page/folio, that either comes from the page allocator or
from HugeTLB, you are right. But see again how kho_preserve_pages()
works:

	while (pfn < end_pfn) {
		const unsigned int order =
			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
	
		err = __kho_preserve_order(track, pfn, order);
		[...]

It combines contiguous order-aligned pages into one KHO preservation.

So say I have two nodes, each 64G. If I call kho_preserve_pages() for
62G to 66G, I will get _one_ 4G preservation at 62G. kho_restore_page()
will split it into 0-order pages on restore.

>
>> >> > This approach seems to give us the best of both worlds: It avoids the
>> >> > memblock dependency during restoration. It keeps the serial work in
>> >> > deserialize_bitmap() to a minimum (O(1)O(1) per region). It allows the
>> >> > heavy lifting of tail page initialization to be done later in the boot
>> >> > process, potentially in parallel, as you suggested.
>> >>
>> >> Here's another idea I have been thinking about, but never dug deep
>> >> enough to figure out if it actually works.
>> >>
>> >> __init_page_from_nid() loops through all the zones for the node to find
>> >> the zone id for the page. We can flip it the other way round and loop
>> >> through all zones (on all nodes) to find out if the PFN spans that zone.
>> >> Once we find the zone, we can directly call __init_single_page() on it.
>> >> If a contiguous chunk of preserved memory lands in one zone, we can
>> >> batch the init to save some time.
>> >>
>> >> Something like the below (completely untested):
>> >>
>> >>
>> >>         static void kho_init_page(struct page *page)
>> >>         {
>> >>                 unsigned long pfn = page_to_pfn(page);
>> >>                 struct zone *zone;
>> >>
>> >>                 for_each_zone(zone) {
>> >>                         if (zone_spans_pfn(zone, pfn))
>> >>                                 break;
>> >>                 }
>> >>
>> >>                 __init_single_page(page, pfn, zone_idx(zone), zone_to_nid(zone));
>> >>         }
>> >>
>> >> It doesn't do the batching I mentioned, but I think it at least gets the
>> >> point across. And I think even this simple version would be a good first
>> >> step.
>> >>
>> >> This lets us initialize the page from kho_restore_folio() without having
>> >> to rely of memblock being alive, and saves us from doing work during
>> >> early boot. We should only have a handful of zones and nodes in
>> >> practice, so I think it should perform fairly well too.
>> >>
>> >> We would of course need to see how it performs in practice. If it works,
>> >> I think it would be cleaner and simpler than splitting the
>> >> initialization into two separate parts.
>> >
>> > I think your idea is clever and would work. However, consider the
>> > cache efficiency: in deserialize_bitmap(), we must write to the head
>> > struct page anyway to preserve the order. Since we are already
>> > bringing that 64-byte cacheline in and dirtying it, and since memblock
>> > is available and fast at this stage, it makes sense to fully
>> > initialize the head page right then.
>>
>> You will also bring in the cache line and dirty it during
>> kho_restore_folio() since you need to write the page refcounts. So I
>> don't think the cache efficiency makes any difference between either
>> approach.
>>
>> > If we do that, we get the nid for "free" (cache-wise) and we avoid the
>> > overhead of iterating zones during the restore phase. We can then
>> > simply inherit the nid from the head page when initializing the tail
>> > pages later.
>>
>> To get the nid, you would need to call early_pfn_to_nid(). This takes a
>> spinlock and searches through all memblock memory regions. I don't think
>> it is too expensive, but it isn't free either. And all this would be
>> done serially. With the zone search, you at least have some room for
>> concurrency.
>>
>> I think either approach only makes a difference when we have a large
>> number of low-order preservations. If we have a handful of high-order
>> preservations, I suppose the overhead of nid search would be negligible.
>
> We should be targeting a situation where the vast majority of the
> preserved memory is HugeTLB, but I am still worried about lower order
> preservation efficiency for IOMMU page tables, etc.

Yep. Plus we might get VMMs stashing some of their state in a memfd too.

>
>> Long term, I think we should hook this into page_alloc_init_late() so
>> that all the KHO pages also get initalized along with all the other
>> pages. This will result in better integration of KHO with rest of MM
>> init, and also have more consistent page restore performance.
>
> But we keep KHO as reserved memory, and hooking it up into
> page_alloc_init_late() would make it very different, since that memory
> is part of the buddy allocator memory...

The idea I have is to have a separate call in page_alloc_init_late()
that initalizes KHO pages. It would traverse the radix tree (probably in
parallel by distributing the address space across multiple threads?) and
initialize all the pages. Then kho_restore_page() would only have to
double-check the magic and it can directly return the page.

Radix tree makes parallelism easier than the linked lists we have now.

>
>> Jason's radix tree patches will make that a bit easier to do I think.
>> The zone search will scale better I reckon.
>
> It could, perhaps early in boot we should reserve the radix tree, and
> use it as a source of truth look-ups later in boot?

Yep. I think the radix tree should mark its own pages as preserved too
so they stick around later in boot.

-- 
Regards,
Pratyush Yadav

