Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FFAC369B9
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7eU5yz+mYelNkps8vU4xc9f2q1ld+c1dkc02DygDhqk=; b=hqGJlGU1W9KlldaK02+18Vib3F
	TvfDABsS1aIq7lAw+D9yBDS6aM6EBxNY+LPfid68FUBArqwSVrpMTeTnvKkd/0gHBefYrW/wwsWSq
	K4OzsEHg1V101J8gmGnlBzAFSHajbc19L3BADdW0c3IOubcyYBK4RraHi4X/85b/t/md3iVzco+t5
	E7hyG6RdR6zYYHaO8RVH+UJwKPEv/CS3kMkZx30mNwXglFANaONSlrGhEt8ZgbvBT2gD796E7QY3X
	t+63zAOhdexYKoSw6qpe17auZmNCfGiY1PhopOLVh0+WkeKdkdxhbhkDzoPfTrX4pJgNjLxUl4S/k
	qbVCYYiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJN-000000017Nl-2ait;
	Mon, 14 Apr 2025 08:37:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1Sat-0000000FWxi-2z16;
	Sun, 06 Apr 2025 16:11:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3039860010;
	Sun,  6 Apr 2025 16:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001A8C4CEE3;
	Sun,  6 Apr 2025 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743955892;
	bh=Sz4kzjU47HEj+yUM/THf8yMkaaup6Rg7Dx4qH2/70CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGZ7ZIB/u5WG5waiYDZ9nIiO+DrHUzhyT9rGMi+NxU4/5VEXHubGIE8QIT+ddpOBL
	 GOhVn3oQOLm218mBHQbsLAHWcS++8ZJuwmz3m1kU8+IkHS6TDC0GcnlNzi9/4SHmbU
	 n/q318Sa5wo6I0DzVTV51I3h3a69SN9OmvLC4lzDr4mef97Y8OOvrZRURv5RkQ9gDF
	 qEs/aqPaBz3hyiHLDBlvO3mwumjpErkxZ3jfT0maQhp7YLf5gF2vjXvihOxf2Nh0mc
	 sx42TYyj+JrkURKv0e81e9pLvqoWQzIf5XwEystouNJqJ0yHOviPP/fW+j2gB4oiSj
	 /smAFmSyxIF9w==
Date: Sun, 6 Apr 2025 19:11:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z_KnovvW7F2ZyzhX@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404143031.GB1336818@nvidia.com>
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Fri, Apr 04, 2025 at 11:30:31AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 04, 2025 at 04:53:13PM +0300, Mike Rapoport wrote:
> > > Maybe change the reserved regions code to put the region list in a
> > > folio and preserve the folio instead of using FDT as a "demo" for the
> > > functionality.
> > 
> > Folios are not available when we restore reserved regions, this just won't
> > work.
> 
> You don't need the folio at that point, you just need the data in the
> page.
> 
> The folio would be freed after starting up the buddy allocator.

Maybe, but seems a bit far fetched to me.
 
> > > We know what the future use case is for the folio preservation, all
> > > the drivers and the iommu are going to rely on this.
> > 
> > We don't know how much of the preservation will be based on folios.
> 
> I think almost all of it. Where else does memory come from for drivers?

alloc_pages()? vmalloc()?
These don't use struct folio unless there's __GFP_COMP in alloc_pages()
call, and in my mind "folio" is memory described by struct folio.
 
> > Most drivers do not use folios
> 
> Yes they do, either through kmalloc or through alloc_page/etc. "folio"
> here is just some generic word meaning memory from the buddy allocator.

How about we find some less ambiguous term? Using "folio" for memory
returned from kmalloc is really confusing. And even alloc_pages() does not
treat all memory it returns as folios.

How about we call them ranges? ;-)
 
> The big question on my mind is if we need a way to preserve slab
> objects as well..
> 
> > and for preserving memfd* and hugetlb we'd need to have some dance
> > around that memory anyway.
> 
> memfd is all folios - what do you mean?

memfd is struct folios indeed, but some of them are hugetlb and even for
those that are not I'm not sure that kho_preserve_folio(struct *folio)
kho_restore_folio(some token?) will be enough. I totally might be wrong
here.
 
> hugetlb is moving toward folios.. eg guestmemfd is supposed to be
> taking the hugetlb special stuff and turning it into folios.

At some point yes. But I really hope KHO can happen faster than hugetlb and
guestmemfd convergence.
 
> > So I think kho_preserve_folio() would be a part of the fdbox or
> > whatever that functionality will be called.
> 
> It is part of KHO. Preserving the folios has to be sequenced with
> starting the buddy allocator, and that is KHO's entire responsibility.

So if you call "folio" any memory range that comes from page allocator, I
do agree. But since it's not necessarily struct folio, and struct folio is
mostly used with file descriptors, the kho_preserve_folio(struct folio *)
API can be a part of fdbox.

Preserving struct folio is one of several case where we'd want to preserve
ranges. There's simplistic memblock case that does not care about any
memdesc, there's memory returned from alloc_pages() without __GFP_COMP,
there's vmalloc() and of course there's memory with struct folio.

But the basic KHO primitive should preserve ranges because they are the
common denominator of alloc_pages(), folio_alloc(), vmalloc() and memblock.
 
> I could see something like preserving slab being in a different layer,
> built on preserving folios.

Maybe, on top of ranges. slab is yet another memdesc.
 
> > Are they? 
> > The purpose of basic KHO is to make sure the memory we want to preserve is
> > not trampled over. Preserving folios with their orders means we need to
> > make sure memory range of the folio is preserved and we carry additional
> > information to actually recreate the folio object, in case it is needed and
> > in case it is possible. Hughetlb, for instance has its own way initializing
> > folios and just keeping the order won't be enough for that.
> 
> I expect many things will need a side-car datastructure to record that
> additional meta-data. hugetlb can start with folios, then switch them
> over to its non-folio stuff based on its metadata.
> 
> The point is the basic low level KHO mechanism is simple folios -
> memory from the buddy allocator with an neutral struct folio that the
> caller can then customize to its own memory descriptor type on restore.

I can't say I understand what do you mean by "neutral struct folio", but we
can't really use struct folio for memory that wasn't struct folio at the
first place. There's a ton of checks for flags etc in mm core that could
blow up if we use a wrong memdesc.

Hence the use of page->private for order of folios. It's stable (for now)
and can be used by any page owner.
 
> Eventually restore would allocate a caller specific memdesc and it
> wouldn't be "folios" at all. We just don't have the right words yet to
> describe this.
> 
> > As for the optimizations of memblock reserve path, currently it what hurts
> > the most in my and Pratyush experiments. They are not very representative,
> > but still, preserving lots of pages/folios spread all over would have it's
> > toll on the mm initialization.
> 
> > And I don't think invasive changes to how
> > buddy and memory map initialization are the best way to move forward and
> > optimize that.
> 
> I'm pretty sure this is going to be the best performance path, but I
> have no idea how invasive it would be to the buddy alloactor to make
> it work.

I'm not sure about the best performance, but if we are to completely bypass
memblock_reserve() we'd need an alternative memory map and free lists
initialization for KHO. I believe it's too premature to target that at this
point.
 
> > Quite possibly we'd want to be able to minimize amount of *ranges*
> > that we preserve.
> 
> I'm not sure, that seems backwards to me, we really don't want to have
> KHO mem zones! So I think optimizing for, and thinking about ranges
> doesn't make sense.

"folio" as "some generic word meaning memory from the buddy allocator" and
range are quite the same thing.
 
> The big ranges will arise naturally beacuse things like hugetlb
> reservations should all be contiguous and the resulting folios should
> all be allocated for the VM and also all be contigous. So vast, vast
> amounts of memory will be high order and contiguous.

So there won't be a problem with too many memblock_reserve() then.
 
> > Preserving folio orders with it is really straighforward and until we see
> > some real data of how the entire KHO machinery is used, I'd prefer simple
> > over anything else.
> 
> mapletree may not even work as it has a very high bound on memory
> usage if the preservation workload is small and fragmented. This is
> why I didn't want to use list of ranges in the first place.

But aren't "vast, vast amounts of memory will be high order and
contiguous."? ;-)

For small and fragmented workload bitmaps become really sparse and we are
wasting memory for nothing. Maple tree only tracks memory that is actually
used and coalesces adjacent ranges so although it's unbound in theory, in
practice it may be not that bad. 

> It also doesn't work so well if you need to preserve the order too :\

It does. In the example I've sent there's an unsigned long to store
"kho_mem_info_t", which definitely can contain order.

> Until we know the workload(s) and cost how much memory the maple tree
> version will use I don't think it is a good general starting point.
 
I did and experiment with preserving 8G of memory allocated with randomly
chosen order. For each order (0 to 10) I've got roughly 1000 "folios". I
measured time kho_mem_deserialize() takes with xarrays + bitmaps vs maple
tree based implementation. The maple tree outperformed by factor of 10 and
it's serialized data used 6 times less memory.

> Jason

-- 
Sincerely yours,
Mike.

