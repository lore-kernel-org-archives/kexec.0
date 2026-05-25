Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03F3CD5BD1
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1Nukes//tK5IIic5W7fXiatpAoFLru1ePDI3tJnewI=; b=pHMb1Fuv3J6nivkIIF9TgWPplb
	axJsI4BP3f2BmCrTLeoXGU8bAutWmntg6jxrrC0mprFeGG4uBetxMBsqxr2515Hwbmxv4zz9E7YVo
	QlYoH/DX/2JusTXwrG0kBSLleIYvIdDGF47bfrSvrj+mJe56vs06dsz+o4JbeL3laKFY0uVocJ7P0
	og7fLtZBXbLHUoS4aB+we9+Py6EZLSnDcrjlSHOuGrRii6pCHolTWcUj3q2+vtS+/9WYc2ccFxDQw
	05qe8nsVHW6d/AJZkgGCaMKr47173JIUgmzAB2PdxSLVc9GMeWE10vDebdWx3dnvjx+hJebPeHgQb
	ucRcmqKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXA8-0000000HVuh-0xh5;
	Mon, 25 May 2026 15:24:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXA5-0000000HVuJ-39yT
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 15:24:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B5415402B6;
	Mon, 25 May 2026 15:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBEB1F000E9;
	Mon, 25 May 2026 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722652;
	bh=w1Nukes//tK5IIic5W7fXiatpAoFLru1ePDI3tJnewI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dv+TCYCCKH+uwHpqFa6O1X8AzYC4SenCV6+XXikkYpbiF7jlOzbKbHxaGhh0e1yPY
	 o8oeGtL0FSUXuD/g+ZWMTpgI0zMr0eNFiIlKeHLePGOfduMUdn8Ljd2K0p8gNZxDWN
	 ff1KdaDe/sAGCHLtdYiTmzbMmoxqfcThy4gqzveZD6hEHQQlgZJXhisff3DWEhutux
	 C+Bmj1rirmJhxPa8Un0gCDzPYbWf03l+j/XkK5V6y+T6UGaSoIOkhWMVJY10MuHSkJ
	 Xy4tCQcA9UnwruU4tt0rW/O0G4du+UO6urEVDvZXFsCSvihZVHUy4uEX5bQq6NTNLF
	 gp4tgUom5sTmw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/hugetlb: make bootmem allocation work with KHO
In-Reply-To: <agmS5yZRflzN1M8U@kernel.org> (Mike Rapoport's message of "Sun,
	17 May 2026 13:05:27 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-13-pratyush@kernel.org>
	<agmS5yZRflzN1M8U@kernel.org>
Date: Mon, 25 May 2026 17:24:09 +0200
Message-ID: <2vxzo6i37bs6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_082413_836960_83112FF9 
X-CRM114-Status: GOOD (  64.85  )
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

Hi Mike,

On Sun, May 17 2026, Mike Rapoport wrote:

> Hi Pratyush,
>
> On Wed, Apr 29, 2026 at 03:39:14PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Gigantic page allocation is somewhat broken currently when KHO is used.
>> 
>> Firstly, they break KHO scratch size accounting. RSRV_KERN is used to
>> track how much memory is reserved for use by the kernel. Since
>> alloc_bootmem() calls the memblock_alloc*() APIs, the hugepages
>> allocated also get marked as RSRV_KERN.
>
> The intended semantics of RSRV_KERN was to distinguish memory reserved
> because it's in use by firmware from the memory reserved or allocated by
> the kernel. It does not have to be directly used by the kernel, some of
> PG_Reserved memory is mapped to user-space and it's not only hugetlb. There
> are zero pages, VDSO and maybe something else, I don't remember.
>
>> Allocations marked RSRV_KERN are used by KHO to calculate how much
>> scratch space it should reserve to make sure the next kernel has enough
>> memory to boot when it is in scratch-only phase. Counting hugepages in
>
> The size of RSRV_KERN allocations is also used in
> memblock_estimated_nr_free_pages() that's currently used by
> set_max_threads() to set several rlimits and by s390 to allocate colored
> zero pages. Excluding hugetlb from that will skew the calculations there.

Oh, I didn't know that. I thought it was only for KHO.

>
>> that blows up scratch size, and can lead to the scratch allocation
>> failing, making KHO unusable. This will show up when huge pages make up
>> more than 50% of the system, which is a fairly common use case.
>> 
>> Secondly, while not supported right now, huge pages are user memory and
>> can be preserved via KHO. The scratch spaces should not have any
>> preserved memory. Allocating hugepages from scratch (on a KHO boot) can
>> lead to them being un-preservable.
>> 
>> Introduce memblock_alloc_nid_user(). This does two things: first, it
>> instructs __memblock_alloc_range_nid() to not use scratch areas to
>> fulfill allocation. If KHO is in scratch-only mode, allocations will
>> only be made from extended scratch areas. Second, it removes RSRV_KERN
>> from the allocation to make sure it doesn't mess up scratch size
>> accounting.
>> 
>> To reduce duplication, introduce __memblock_alloc_range_nid() which does
>> exactly what memblock_alloc_range_nid() used to do, but takes the flags
>> from its caller. Then make memblock_alloc_range_nid() a wrapper to it.
>> This lets memblock_alloc_nid_user() re-use most of the logic without
>> causing churn to update all callers of memblock_alloc_range_nid() and
>> adding yet another argument to it.
>
> That's neat :)
>
> But I'm not too fond of the memblock_alloc_nid_user() as a concept. That
> early at boot everything is still kernel, even though hugetlb pages might
> become user afterwards if they are actually consumed.
> Another thing, is that adding such global API to memblock could be abused
> and suddenly some early code will clear RSRV_KERN for a random pieces of
> memory.
>
> If we'd still need a special memblock function for gigantic pages
> allocation I'd rather make it explicit that it's for hugetlb and keep it in
> mm/internal.h

Sure, that would work I think.

>
> I was thinking about possible alternative solutions and here's what I came
> up with

Thanks for the ideas, much appreciated!

>
> 1. SCRATCH_EXT nicely increases the memory pool available to memblock, but
>    the decision which memory can be used for which allocations becomes more
>    complex. It should make sure that SCRATCH is not used for hugetlb, but
>    OTOH it's preferred for other early allocations. With implicit
>    interaction between choose_memblock_flags() and should_skip_region()
>    this seems to me quite a headache.

Yep, I agree. I can try to refactor some of the logic to make this
easier to understand, but I am not sure how successful I would be.

>    memblock_reserved_clear_kern() should be changed to something else to
>    keep set_max_threads() working. And, IMHO, memblock_alloc_nid_user()
>    should be turned into memblock_alloc_gigantic_hugetlb() and only exposed
>    to MM code. It's even possible that it will duplicate some of
>    memblock_alloc_range_nid) rather than use it because hugetlb is always a
>    special case.

That's fine by me I think. Perhaps we can also hide the complexity of
the allocation strategy here? For example, we won't have to expose the
semantic of SCRATCH_EXT only allocations to the rest of the memblock
allocation machinery.

>
> 2. Split memblock_reserve() part from kho_mem_retrieve() to run before
>    hugetlb allocations. With this we won't need new types and APIs, we can
>    ensure that hugetlb allocations do not use SCRATCH by reserving scratch
>    areas before hugetlb allocations and releasing them afterwards.
>    Obviously this is the slowest option as it will slow down all memblock
>    allocations from the point we memblock_reserve() preserved memory. Still
>    realistically I wouldn't expect large impact on performance because the
>    heaviest part there is reserving of the preserved memory that has to
>    happen anyway. Also, I don't thing that a system that uses a lot of
>    gigantic pages will have a lot of preserved chunks scattered around.

This option would make my life easier (in the short term) because I
think it is the easiest to implement. But I don't think this is good for
KHO long term.

First, I think the memblock_reserve() calls are band-aid and we should
get rid of them entirely. They scale terribly. With even a few gigabytes
of memory they go in the order of seconds. I ran a quick experiment, and
with around 4 GiB of 4k preservations, it takes around 650 ms on my test
machine.

And this isn't a theoretical use case. We are looking to preserve
similar sized memfds on our machines. This would be on top of having a
few terabytes in 1G huge pages. I think we should integrate KHO more
deeply into the memblock -> buddy handover sequence.

Second, while you pay the same cost on doing the memblock_reserve(), the
reservations need to happen much sooner. Right now, the reservations
happen right before memblock_free_all(). With this we would need to move
the reservations to mm_core_init_early() which happens right after
setup_arch(). So every allocation after mm_core_init_early() will take a
hit. While I haven't measured the performance impact with this, I
imagine it won't be trivial.

>
> 3. Move the complexity into hugetlb and make it preserve all the gigantic
>    pages with KHO. This means, though, that we won't be able to increase
>    the number of gigantic pages after the first boot (although decreasing
>    it seems easy) and that we need to let scratch auto scaling understand
>    what were the "normal" memblock allocations and what were the
>    allocations of the gigantic pages.

This is a viable option. There is of course the limitation of not being
able to add more gigantic pages but I suppose most workloads should be
able to live with that. The obvious downside is that you don't have a
fallback if scratch runs out so KHO will be a little less resilient.

The complexity with this comes with correctly preserving all the
gigantic pages. Hugepages can be removed at runtime, so we would need to
plug into the removal mechanism. There's also demotion and other things
that need to be taken care of. The reason we need to track this is
because what if the freed hugepage now contains preserved memory from
something else.

>
> 4. Invert SCRATCH_EXT logic and instead of freeing large chunks around the
>    preserved memory to SCRATCH_EXT, reserve memory surrounding the
>    preserved areas and release scratch_only before hugetlb allocations.
>    We'd still need to somehow prevent hugetlb allocation spilling into
>    scratch and there's a nasty piece of releasing the memory around the
>    preserved chunks. On the bright side, I think it's feasible to defer the
>    release of those regions and free them when we are already
>    multithreaded. This probably the most involved alternative but it also
>    could help with the bottleneck of kho_mem_retrieve() creating too many
>    memblock.reserved regions.

I think we should fix kho_mem_retrieve() by making memblock_free_all()
and deferred_free_pages() aware of KHO. I feel that splitting the
freeing of pages into two phases is going to make the early boot more
complicated than it needs to. And on top of all this we still need to do
the special case thing for hugetlb anyway. So I am not sure if this is a
good idea...

>
> Thoughts?

I personally like option 1 the most (maybe because it is very similar to
my patchset). My point is, if you think the "extended scratch" is fine
as a concept and we only need to clean up the neighbouring stuff like
memblock allocation strategy, then I would like to pursue this since I
think this has the most potential.

I think option 3 is also viable. While I personally am not a huge fan, I
don't have it either. So if you really dislike 1 then I can try to make
3 work.

Option 4 can kind of work, but it just gives me a bad feeling that it
will make early boot memory management more complex and might result in
flaky boot failures.

Option 2 is the worst of the lot I think. It is the easiest to
implement, but I think it just adds to the tech debt that
memblock_reserve() is.

So, in summary, I would like to pursue option 1 and try to make it more
appetizing. But I would like to at least know if you hate the "extended
scratch" (ignore the name) as a concept or only the code it results in.

-- 
Regards,
Pratyush Yadav

