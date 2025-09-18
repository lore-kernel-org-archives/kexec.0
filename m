Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB49CAC5A8
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTiwsv6wmG7rGTDBicxC7G7Ssu8qjovk7kpWxAu2Q3Q=; b=vWh53s6tAxgBoasBjImOpCjzLu
	5uYWXO49SspANqR29G3RNaEFd/ruFG5rYmWA51Nv3Cqu7t1scPJMsr8WqxYGzQ9vWbNVx6kmeSn0q
	eU8XC7bImytvtJOl7kLBeRTddw0PS3bSFICgctsxQvvuEUsXW1atNiKaXwLvtlIxX7R0yoUxxM73A
	z3zu6Q9QWxTFNr1prOII6MddfrMODyvvf9+9CjQYjLSpxYxesBt4jhPFRhVebSNL8kkCqSPX3/SAM
	Eeml5n3Q8Vyfz6jXPPP2hGKw51OAKEYU2JuvDTFSf/6IeYJs6oaN+BRI9u9ICquYUIrzGBNeSzwyv
	qgHKv38g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzCRK-0000000HAbs-1fpi;
	Thu, 18 Sep 2025 11:04:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzCRI-0000000HAbW-0QT2
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 11:04:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 78E0B4417B;
	Thu, 18 Sep 2025 11:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F35C4CEE7;
	Thu, 18 Sep 2025 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758193475;
	bh=NojJZ78hZ55rnnC8I9+5CwqPB0jcr195D5wT3H9zTxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQM8OClx5HgL5ZvYw9JdwnDSMBMqgop7DN5U1oBDH5u7NKxtvBIRZrHZpC+mii0VM
	 A/WZhFzpYbLjlUdWUz0QgklN1gUYyyKtJJASgRdpa3UzIDbMdRvFpsmopVfchHdbBt
	 Dxp7GO0SprZwOYRJYkiy7eNVYWs4EYt7Y3Mu2LDKcf1MXYmdPZZXKTWannvjeIarQV
	 /OqDRIzFlRBTEK7bSqw62VusRiNY5MASWXVeHcJWbPs+jqBMVuSt51gOluj5arU3zw
	 meNAbq1dRLWQ2kM9d5yXEXYJFe8kEWBQe8wpNRwE7pPjMEQ8+RvQgZZOfwWDd1yxDI
	 owCfxJVMadMPA==
Date: Thu, 18 Sep 2025 14:04:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] kho: replace kho_preserve_phys() with
 kho_preserve_pages()
Message-ID: <aMvnO2FH-cYzNPGl@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
 <20250917174033.3810435-3-rppt@kernel.org>
 <mafs05xdggifr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs05xdggifr.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_040436_182263_31BDE858 
X-CRM114-Status: GOOD (  28.34  )
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

Hi Pratyush,

On Thu, Sep 18, 2025 at 12:32:08PM +0200, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Wed, Sep 17 2025, Mike Rapoport wrote:
> 
> >  /**
> > - * kho_preserve_phys - preserve a physically contiguous range across kexec.
> > - * @phys: physical address of the range.
> > - * @size: size of the range.
> > + * kho_preserve_pages - preserve contiguous pages across kexec
> > + * @page: first page in the list.
> > + * @nr_pages: number of pages.
> >   *
> > - * Instructs KHO to preserve the memory range from @phys to @phys + @size
> > - * across kexec.
> > + * Preserve a contiguous list of order 0 pages. Must be restored using
> > + * kho_restore_page() on each order 0 page.
> 
> This is not true. The pages are preserved with the maximum order
> possible.
> 
> 	while (pfn < end_pfn) {
> 		const unsigned int order =
> 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> 
> 		err = __kho_preserve_order(track, pfn, order);
> 		[...]
> 
> So four 0-order pages will be preserved as one 2-order page. Restoring
> them as four 0-order pages is wrong. And my proposed patch for checking
> the magic [0] will uncover this exact bug.
> 
> I think you should either change the logic to always preserve at order
> 0, or maybe add a kho_restore_pages() that replicates the same order
> calculation.

Heh, it seems I shot myself in the foot when I suggested to move the sanity
checks to kho_restore_page() :-D

We surely don't want to preserve contiguous chunks of order-0 pages as
order 0, so kho_restore_pages() it is.
 
> [0] https://lore.kernel.org/lkml/20250917125725.665-2-pratyush@kernel.org/
> 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 117d963e677c..6ec3eaa4e8d1 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2516,8 +2516,10 @@ static int reserve_mem_kho_finalize(struct kho_serialization *ser)
> >  
> >  	for (i = 0; i < reserved_mem_count; i++) {
> >  		struct reserve_mem_table *map = &reserved_mem_table[i];
> > +		struct page *page = phys_to_page(map->start);
> > +		unsigned int nr_pages = map->size >> PAGE_SHIFT;
> >  
> > -		err |= kho_preserve_phys(map->start, map->size);
> > +		err |= kho_preserve_pages(page, nr_pages);
> 
> Unrelated to this patch, but since there is no
> kho_restore_{phys,pages}(), won't the reserve_mem memory end up with
> uninitialized struct pages, since preserved pages are
> memblock_reserved_mark_noinit()?

True, this is something we need to fix.
 
> That would also be a case for kho_restore_pages() I suppose?

Yes, just need to find the right place to stick it.
We cannot call kho_restore_pages() in reserve_mem_kho_revive() because at
that point there's still no memory map.

-- 
Sincerely yours,
Mike.

