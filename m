Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA185CA1014
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G7m7HgAScPLaNuoY0WSUUhFXT4QObHzGrnYb0tG4G4M=; b=DDE0aOojN81Y9w2yfed9kq0Lmi
	YZOezMuBn4EGxolVN3CgiljLeeBPUPv2G5hM+rGm7GRaC/dNIfS/9OhtTgYerTxoodapZNYwQ/raD
	Hkcs2LzKCdy/XqMA+OpXb1Gf2x0dl90uBSxn/BvXAwjuXzxTlhseMq1p/kPeXM4P4crWIPnwQQbXJ
	Kf1m/6Z0CchilrOMpumqK533jVBGwKMO8FypoLMO9ejKYQcVQ9aHm5BJK/uK52i82ND9GNtNxd6V8
	kJPjgWcYFPvmen5cNNzXKU2ZBTgEPjHaNQdJcSCIIqRZlhcraVUMpaBnTZT4zKjGxdM4XNHje234c
	z8o16h5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uttZJ-00000007Uqz-0KmE;
	Wed, 03 Sep 2025 19:54:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utpYn-00000006weR-2ijn
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 15:38:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 18BF0600B0;
	Wed,  3 Sep 2025 15:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73FDC4CEE7;
	Wed,  3 Sep 2025 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756913888;
	bh=kPZ/HOC3SKupxm3BQU2AcDhJjHorr5M7H7D+uIJksLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0HiDuSBWD6RKvzMmsTgK0+L/QNoNUgURaef943FSpHKL181/qC/AAadQ1B+rFsgs
	 bwFMu4c8jwYCeyd+Fe+h2ZSm0HaPkWxMk850oIpz+Tn44thrU730jQE7Xup+QiRPXc
	 omi5lR254h3+m2tM/5haS2LtmkQi8QxwD+6XKlU81wmasOw6Gz7U6QCsG35fqnPCEA
	 FnH4Eqwg5SHGWjtKVULPk5EwlN0utT1jiOOKyQURj0czHTrIGS+iuhH+A4zeOB8tCl
	 rEwfZ1D3rZymmU/+l5QGmboLmcPDfdrmcafF6vaDmvA/bsnItmFaGjM7jVHmnRRObD
	 7J1vbX8rxRI9g==
Date: Wed, 3 Sep 2025 18:38:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <aLhg2Jli0KUe-CXC@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903125620.GG470103@nvidia.com>
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

On Wed, Sep 03, 2025 at 09:56:20AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 03, 2025 at 09:30:17AM +0300, Mike Rapoport wrote:
> > +int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
> > +{
> > +	struct kho_vmalloc_chunk *chunk, *first_chunk;
> > +	struct vm_struct *vm = find_vm_area(ptr);
> > +	int err;
> > +
> > +	if (!vm)
> > +		return -EINVAL;
> > +
> > +	/* we don't support HUGE_VMAP yet */
> > +	if (get_vm_area_page_order(vm))
> > +		return -EOPNOTSUPP;
> 
> This is a compatability problem.. Should have some way to indicate
> that future kernels have an incompatible serialization so restore can
> fail..

We can add version or flags to kho_vmalloc_chunk, e.g. make it

struct kho_vmalloc_hdr {
	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
	unsigned int total_pages;	/* only valid in the first chunk */
	unsigned short version;		/* only valid in the first chunk */
	unsigned short num_elms;
};

I'm thinking about actually adding support for HUGE_VMAP for the next
resping, but version/flags seems useful anyway.

> > +	chunk = new_vmalloc_chunk(NULL);
> > +	if (!chunk)
> > +		return -ENOMEM;
> > +	first_chunk = chunk;
> > +	first_chunk->hdr.total_pages = vm->nr_pages;
> > +
> > +	for (int i = 0; i < vm->nr_pages; i++) {
> > +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> > +
> > +		err = kho_preserve_phys(phys, PAGE_SIZE);
> 
> Don't call kho_preserve_phy if you already have a page!

Ok, I'll add kho_preserve_page() ;-P.

Now seriously, by no means this is a folio, so it's either
kho_preserve_phys() or __kho_preserve_order(). I don't mind switching to
latter, but I really see no point doing it.

> We should be getting rid of kho_preserve_phys() :(

How do you suggest to preserve memblock?

> Jason

-- 
Sincerely yours,
Mike.

