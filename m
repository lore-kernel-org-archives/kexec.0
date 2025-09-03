Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AAFCA1010
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EUhagBJ1/j4PgqvRx1RFIGu/KN6tTSm9ODHSfQrEMNo=; b=dbPiytzYa9ROvHUskIyH8BcO5X
	UQZb01WC1+Aw+20OiDLyE2BpEIC86zpbAeum7m/gRQTs+8f+up6oxshoDEkZCAS2dGCEbHYILbujY
	HL8IC6uNX8RWQdN9tL+N6rUj6GMKdmBLc2zuZdX0r4yaFYhE7WAbmslu2yObwQS0tCK4v64nyMuWT
	+qm2cXo7pqfEeGEePlhRnbBpQJaP+MxILorWzFsQgP9mWqRPxlOKC0KM9r22CT697HbTVVx7UkJI2
	EixIFeFITs/r3x/eI5GMV2cQNpxL0VgurhnWDO1QN7ZjmVKPjEwWcBpzkfSZcbT1Mf19crwb/nub+
	D1N63bSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utwhn-00000007tCy-24RE;
	Wed, 03 Sep 2025 23:15:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utt6U-00000007SJ0-4C6r
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 19:25:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 67A676013F;
	Wed,  3 Sep 2025 19:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA59EC4CEE7;
	Wed,  3 Sep 2025 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927510;
	bh=NBbsDMjSKsI2AUxX91Gb4WbI92rKyuNDqjM76TYzfBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adGL9oZgYPs04NhMzOYDFe9H2zXCIScCmhp8FCYjAVCIaThHiJXOKPyFhhI426ebE
	 k1bk9ze6Ty/eCH+cYXBYDRWSUo2bNGShsPuDahO15R/7AM35F+xpGfrHCIEUgCqrzv
	 y0Iup37vzMUHfXI4vtdfimIlD1BKXSnwdfF5tBXXe7IVS/eBu8QkYieuXYB2jPNdOo
	 8w7+0baLFy4wDDUWyccec8EJ8oxOHuyWAvPfOxyAbH4GSxG0k+a+0AofpgoYzsaQtl
	 kzpeMlLyMrc6gOFAJBSyYLqQnrCguEuLzG10UvjAZxXT/sq8OUwW7bqAWeviAC5ejz
	 UFSY/7caqab2g==
Date: Wed, 3 Sep 2025 22:25:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <aLiWDl3sq3RTkdfJ@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
 <aLhg2Jli0KUe-CXC@kernel.org>
 <20250903170631.GK470103@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903170631.GK470103@nvidia.com>
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

On Wed, Sep 03, 2025 at 02:06:31PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 03, 2025 at 06:38:00PM +0300, Mike Rapoport wrote:
> > > Don't call kho_preserve_phy if you already have a page!
>  
> > Now seriously, by no means this is a folio, 
> 
> It really is. The entire bitmap thing is about preserving folios/page
> which are basically the same thing ATM. folio is the prefered type for
> what used to be compound pages.
 
> As Matthew moves ahead it will effectively become preserving
> memdescs. This may even start to happen this year..
> 
> Every memdesc has a type, so when ever the physical pages are restored
> KHO will need to recreate the struct page and page->memdesc with the
> correct values, including the memdesc type code and any memdesc
> allocation that Matthew plans.
> 
> Meaning everything should be struct page or folio based at this API
> level, and restore functions should be logically paired with the
> allocation functions that created the memory in the first place.
> 
> vmalloc() is calling alloc_pages_bulk_node_noprof() to allocate the
> memory, so the restore of that memory should also have a 'kho restore
> page' type of name that clearly refers back to the allocator it pairs
> with.

I'm actually all for having a single entry point
kho_{preserve,restore}_page() that will do

	if (folio)
		do_folio()
	else if (vmalloc)
		do_vmalloc()

etc.

It seems that our major disagreement is about using 'folio' vs 'page' in
the naming.

In my view calling everything 'folio' is a bad idea as we are moving fast
from Ottawa interpretation to New York interpretation of folio.

I'd rather stick to the good old 'page' and when the time comes we can
's/page/memdesc/g' supposing Matthew actually plans for it.

This way we won't need to handle the fallback from divorce of folio from
page. This indeed is less relevant to KHO, but there are a lot of
folio_alloc() in LUO and PCI patches that will have to be changed to a
different allocation apparently this year.

> In the more general case this should be setting the cgroup and
> charging it as well.

Yes, eventually :)

> > How do you suggest to preserve memblock?
> 
> Does the memory have a struct page? Then it should be a preserved
> folio list so you get back struct pages in the right state for what

page list you mean ;-)

> memblock is doing. Someday that will turn into some specific memdesc
> type and so on.

> If it doesn't have a struct page then it shouldn't be in the bitmaps
> at all.

There is a struct page for everything that's memblock_alloc()ed. And we can
do page list, but for large  physically contiguous allocation it does not
make sense. 

I'd rather replace kho_preserve_phys() with kho_preserve_memblock() and add
a restore counterpart to properly set the struct pages for it which we lack
now.

> Jason

-- 
Sincerely yours,
Mike.

