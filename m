Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B40EE4988
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nVrdMXUw00hgV69sSSBMiYwuTELWJbA+S6oR8mm1axQ=; b=M3xCdcsTJuXStrbPduf8uBXtBH
	BesMq6o8/PnkwkCt3VFjKGfdL5ss+FYvw4fx7jVnr4OK2e5c+pQfV6yAnG7Es8V1YNnU0uZdw/kHg
	gxXqygAWJh9WP0tb7KNGrCG6VgAV3USYrXgYqLvbksi18AB+0pE/rMVami9e0P2SM54csO8o4E0B2
	emxQwQgPqSMWRiEsR2LMf3cV9ByXOs7VXoPoWHZee46Xr9gqPTI6wYAgnwV8tDy1lyXjgbpynWRxB
	E04ITIrqXAG+cO0U5RsRLedWR9KZg9j09WeuJ89yU0K51OSAt05VEj7Sih5diE6THMAH58vDJVZ10
	+mr7RKow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacMX-000000052kM-2qlB;
	Tue, 30 Dec 2025 16:14:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacMW-000000052kA-3RPx
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 16:14:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D457E60010;
	Tue, 30 Dec 2025 16:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D5EC4CEFB;
	Tue, 30 Dec 2025 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111259;
	bh=v6ym8j7jR1OnzDUiF+SxHOJ0RzBeUWzfVU7NjEmGKwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXuWam/Q60CMdaUb9LOVyCAv/k+xdqrez982rFsuoRV51Hsfrnw/yKmWktD1qTXl3
	 P3oqkVSHmJQtlQA940ReBDH4okDLq4fWwHP97Nf3NO1MxC7ArNmOuCiZAS5Tdccqie
	 vhAuknkHy0FizIBpyyTqB06XRtHc0m7TQYm+VZ+anGZB9rvL4wGRMXfgOpHhOJtRzw
	 5MZRGIpfyt3feaBb4NyNme2I8oIgWeLDz4WbOKbnmPZMH6pM0rhjVK/pPGKLDN7soQ
	 8arfwuwNWh9169+K28yHTHYtVwKehZZKVl+Kk1J21YRDgoZyWKqy25ZtOjKCvB9ZJ9
	 fmqNqVSyGxuiA==
Date: Tue, 30 Dec 2025 18:14:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aVP6VO5Ycr5xynwj@kernel.org>
References: <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
 <aUUYprAotKYMiEs0@kernel.org>
 <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
 <861pkpkffh.fsf@kernel.org>
 <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org>
 <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org>
 <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
 <864ip99f1a.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864ip99f1a.fsf@kernel.org>
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

On Mon, Dec 29, 2025 at 10:03:29PM +0100, Pratyush Yadav wrote:
> On Tue, Dec 23 2025, Pasha Tatashin wrote:
> 
> >> > if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
> >> > return NULL;
> >>
> >> See my patch that drops this restriction:
> >> https://lore.kernel.org/linux-mm/20251206230222.853493-2-pratyush@kernel.org/
> >>
> >> I think it was wrong to add it in the first place.
> >
> > Agree, the restriction can be removed. Indeed, it is wrong as it is
> > not enforced during preservation.
> >
> > However, I think we are going to be in a world of pain if we allow
> > preserving memory from different topologies within the same order. In
> > kho_preserve_pages(), we have to check if the first and last page are
> > from the same nid; if not, reduce the order by 1 and repeat until they
> > are. It is just wrong to intermix different memory into the same
> > order, so in addition to removing that restriction, I think we should
> > implement this enforcement.
> 
> Sure, makes sense.
> >
> > Also, perhaps we should pass the NID in the Jason's radix tree
> > together with the order. We could have a single tree that encodes both
> > order and NID information in the top level, or we can have one tree
> > per NID. It does not really matter to me, but that should help us with
> > faster struct page initialization.

To setup page links we need nid and zone. AFAIR we have 7 or 8 upper bits
free in the radix tree, so to support the general case of up to 3 bits per
zone and up to 10 bits per node we'll need to implement two versions of
detection of zone and node for a page.
I'd wait with this optimization for a while.
 
> Can we use NIDs in ABI? Do they stay stable across reboots? I never
> looked at how NIDs actually get assigned.

Node ids are assigned by the firmware, so unless firmware changes or there
are hotplugged/hotremoved memory they are stable.
And we can't really do hotplug/hotremove with KHO/LUO anyway :)
 
> Not sure if we should target it for the initial merge of the radix tree,
> but I think this is something we can try to figure out later down the
> line.
> 
> >
> >> >> To get the nid, you would need to call early_pfn_to_nid(). This takes a
> >> >> spinlock and searches through all memblock memory regions. I don't think
> >> >> it is too expensive, but it isn't free either. And all this would be
> >> >> done serially. With the zone search, you at least have some room for
> >> >> concurrency.
> >> >>
> >> >> I think either approach only makes a difference when we have a large
> >> >> number of low-order preservations. If we have a handful of high-order
> >> >> preservations, I suppose the overhead of nid search would be negligible.
> >> >
> >> > We should be targeting a situation where the vast majority of the
> >> > preserved memory is HugeTLB, but I am still worried about lower order
> >> > preservation efficiency for IOMMU page tables, etc.
> >>
> >> Yep. Plus we might get VMMs stashing some of their state in a memfd too.
> >
> > Yes, that is true, but hopefully those are tiny compared to everything else.
> >
> >> >> Long term, I think we should hook this into page_alloc_init_late() so
> >> >> that all the KHO pages also get initalized along with all the other
> >> >> pages. This will result in better integration of KHO with rest of MM
> >> >> init, and also have more consistent page restore performance.
> >> >
> >> > But we keep KHO as reserved memory, and hooking it up into
> >> > page_alloc_init_late() would make it very different, since that memory
> >> > is part of the buddy allocator memory...
> >>
> >> The idea I have is to have a separate call in page_alloc_init_late()
> >> that initalizes KHO pages. It would traverse the radix tree (probably in
> >> parallel by distributing the address space across multiple threads?) and
> >> initialize all the pages. Then kho_restore_page() would only have to
> >> double-check the magic and it can directly return the page.

page_alloc_init_late() is probably too late and some subsystems might need
to call kho_restore_*() before it.

> > I kind of do not like relying on magic to decide whether to initialize
> > the struct page. I would prefer to avoid this magic marker altogether:
> > i.e. struct page is either initialized or not, not halfway
> > initialized, etc.
> 
> The magic is purely sanity checking. It is not used to decide anything
> other than to make sure this is actually a KHO page. I don't intend to
> change that. My point is, if we make sure the KHO pages are properly
> initialized during MM init, then restoring can actually be a very cheap
> operation, where you only do the sanity checking. You can even put the
> magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I think
> it is useful enough to keep in production systems too.
> 
> >
> > Magic is not reliable. During machine reset in many firmware
> > implementations, and in every kexec reboot, memory is not zeroed. The
> > kernel usually allocates vmemmap using exactly the same pages, so
> > there is just too high a chance of getting magic values accidentally
> > inherited from the previous boot.
> 
> I don't think that can happen. All the pages are zeroed when
> initialized, which will clear the magic. We should only be setting the
> magic on an initialized struct page.
 
Currently we set the magic on an initialized struct page because we don't
support deferred struct page initialization. If we want to enable it, lots
of struct pages are uninitialized by the time kho_mem_deserialize() runs.

To ensure there are no concerns with the stale data in the memory map we
either need to initialize struct pages in kho_mem_deserialize() before
setting page->private or let memmap_init_reserved_pages() initialize them
(e.g by splitting memblock_reserve() out of kho_mem_deserialize() and
calling it before memmap_init_reserved_pages())

It seems that hugetlb support anyway requires moving of memblock_reserve()
earlier, so maybe we can do it as a part of deferred initialization work.

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

