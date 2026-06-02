Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BECECD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GO0ughoX6tIBN7Rfl1sxm5xunBsDcVGcFMz2bkL4sxs=; b=JgHxlBASXdCmWBVanzckvYsZ2e
	ZQfgmEDj8mhSEnyhUgJ7SHglpdWxORNTjBPf8DLjPiB2yKn6Dr94iurygwdS3zB1MghpRgdsTHSya
	0GoApszv+Kj9XGSzsClAJ5MAh8JJ+3VU4FPi7kBV2kpNZxBPmFpXMrTJ2/9cYRhIYhZ8LEFKsvn9Z
	8a0eEaEaTeJ9olsdbuvyipmCdY4wGSlgOrEX8MO0akydF2Fg7WoThn8n83t7CX1QIxutlitaxnm9s
	egX3cCJxG4jYTsKRqUeRYmqFZm4Iy+MOOFPhXwPU4qLNIZlSl/dCjn8EAXhhsPFKc0i4A6fq1ezsf
	r8OOGb0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUTFp-0000000Dbx7-0FgN;
	Tue, 02 Jun 2026 17:50:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUTFo-0000000Dbwv-1rXN
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:50:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D3CD60098;
	Tue,  2 Jun 2026 17:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE481F00893;
	Tue,  2 Jun 2026 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780422614;
	bh=GO0ughoX6tIBN7Rfl1sxm5xunBsDcVGcFMz2bkL4sxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NSmFgoehKN8l7Nu3qFjPX9PA1JKtgCb0OnvBI+IS4vrCZ3nnMOE6EM83u9fGdOUah
	 4xXfTfQB/neJj095AmqowvVzylbkcIxgu8Jk2pKdqQH4uACdBr5UHRJ7v33TdcKgvJ
	 E88mOvzEP8uCWRy7hie9kecWXK0/gaDvIfXTC+4gHrK9GB9AMFAVwlvK3Hj4RyjLUa
	 K105NrN4t1D0EqCEE9lcUmUiFRmpQ1XHDtQHq0KcM+4S2NxVRa2AxycnWf9bfs0mSU
	 7GfLZN3Lwc3KC2e6hqwYf5ZxrulvHck5J3aRNpfHCsunz8GxgLf7mXkzGHJy6HrsN8
	 +J9ORV2bzB5Mg==
Date: Tue, 2 Jun 2026 20:50:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/hugetlb: make bootmem allocation work with KHO
Message-ID: <ah8Xz3qc3cbHkiuK@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-13-pratyush@kernel.org>
 <agmS5yZRflzN1M8U@kernel.org>
 <2vxzo6i37bs6.fsf@kernel.org>
 <ahyAhyVGzXdrigIw@kernel.org>
 <2vxzpl29dpzj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzpl29dpzj.fsf@kernel.org>
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

On Tue, Jun 02, 2026 at 03:35:44PM +0200, Pratyush Yadav wrote:
> On Sun, May 31 2026, Mike Rapoport wrote:
> 
> > On Mon, May 25, 2026 at 05:24:09PM +0200, Pratyush Yadav wrote:
> >> On Sun, May 17 2026, Mike Rapoport wrote:
> >> > On Wed, Apr 29, 2026 at 03:39:14PM +0200, Pratyush Yadav wrote:
> >> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> So, in summary, I would like to pursue option 1 and try to make it more
> >> appetizing. But I would like to at least know if you hate the "extended
> >> scratch" (ignore the name) as a concept or only the code it results in.
> >
> > Let's retry this one :)
> >
> > I looked more closely, and it seems that mixing SCRATCH and SCRATCH_EXT
> > should be a lesser headache than going with option 4.
> 
> I also had some time to ruminate on this. I still think option 1 has the
> most promise, but my opinion on option 4 has improved a bit. While I
> still am not sure adding a 3rd phase to struct page/MM init (early ->
> deferred -> KHO reserved blocks) is a good idea, I think it might not be
> as bad as I first thought. Dunno...

Until (if ever) we enlighten memblock_free_all()/deferred_init_pages()
about KHO, small scattered reservation make memblock slower. It's hard to
tell if delaying more complex initialization of the large reserved chunks
until SMP is worth speedup in a few memblock operations between
kho_memory_init() and the end of deferred_init_pages().
 
> Anyway, for now I think I will try to make option 1 more appetizing.
> 
> Here's an idea I want to try out: I get rid of SCRATCH_EXT and mark the
> free blocks as SCRATCH. For HugeTLB, I can teach the special
> memblock_alloc_hugetlb_something() function to exclude scratch areas
> when looking for free memory ranges. So core memblock does not get a new
> memory type, and the complexity of hugepage allocation does not leak
> into memblock.
> 
> How does that sound?

It sounds fine, let's see how it looks :) 

> > Tracking the changes in gigantic pages in hugetlb also does not seem
> > something we'd like to pursue especially considering that memory from freed
> > or demoted gigantic pages could be reserved.
> >
> > If we add a dedicated memblock_something to allocate gigantic pages, we
> > can reduce branching in alloc_bootmem() to
> >
> > 	if (cma)
> > 		do_cma()
> > 	else
> > 		do_memblock()
> >
> > For hugetlb_cma we might want to teach CMA to create pre-allocated areas
> > and then it could reuse the same memblock API. This seems useful even
> > regardless of KHO.
> 
> Sorry, I don't get what you mean by this. What pre-allocated areas? When
> creating CMA areas it calls cma_alloc_mem() which calls into memblock.
> What would we change about this?

s/teach CMA to create/teach CMA to use/

I mean that we might want to be able first allocate gigantic pages and then
feed them to empty CMA areas.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

