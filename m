Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADA9CAC597
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atSd9tw1aLbC1YFHebDFztayclxsChQLwGxI3nriSmw=; b=4G/KuM9dS4vtbk+b1rx+TT3ncK
	krA/F/9J2FSThe5yN2FuiJZHHSnyyPL4Ak+i93sD9NnOeZMowM6ra1eJIo9nj9xPf5sHo4JlqzK1X
	ZcCdxC57knfywNkuyO7teceXsGNWPlkFYOXvoXJ5/JQU5aoUNfXxXMjXH4EJlHN/GoTtf7ecx2lti
	LipLla7PqbQFz3Ge8o0xRTzsVx51BIXABFbqEMueYoENrjS/2C4YJi9pCqPmM9+X7FAd/+pj0nA/p
	cRKyM07kZZCS6CENz+MMIrSxYI0AHAy2PRrIGS/XF9ImTXbt6FjeI68VPLXlJPUYBs/wzaat55SzP
	OpoR+LAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9lb-00000004YCm-2T8j;
	Mon, 15 Sep 2025 14:01:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9la-00000004YC3-2Lmw
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 14:01:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 33A4960231;
	Mon, 15 Sep 2025 14:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AE7C4CEF1;
	Mon, 15 Sep 2025 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944870;
	bh=8olvie8tLQ2mhtW55gwpyxifDR7KCERuklBIHTYWwxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+u9tdzpymz6xsyciaB6n3rt32DVJ8+TkdA7u70VzV72+k5dfIPdjeJj4BiAV+zKq
	 JwdqgqXiaXa9ZOFhYxBmdHIQQ1J+YbxXvkezAfMpAbWdM/v3gmNMLZr4DryGCc0xuJ
	 4aGtt9LYRSI+K270uEvon56jV/zEAzOjadorNAY2R31CCG0DUgHOcjSy7qVwIID+VC
	 FOYjTJhwajK4xIOdABSmdLMyKmZWIKZweFortDGA/PR7vnLLl2lleaO2D2wJAckTYY
	 KoaZWXsO7U5wdxe+NIb4cIKw8/UmhlyUFgs2mOlYNKMzs9veniITYpVrrQbm2szDQ1
	 Y4K+eoPfacPAg==
Date: Mon, 15 Sep 2025 17:01:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMgcHWxsEWnKzzcN@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <20250908141423.GJ616306@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908141423.GJ616306@nvidia.com>
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

On Mon, Sep 08, 2025 at 11:14:23AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 01:35:27PM +0300, Mike Rapoport wrote:
> > +static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
> > +{
> > +	struct kho_vmalloc_chunk *chunk;
> > +	int err;
> > +
> > +	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!chunk)
> > +		return NULL;
> > +
> > +	err = kho_preserve_phys(virt_to_phys(chunk), PAGE_SIZE);
> > +	if (err)
> > +		goto err_free;
> 
> kzalloc() cannot be preserved, the only thing we support today is
> alloc_page(), so this code pattern shouldn't exist.
 
kzalloc(PAGE_SIZE) can be preserved, it's page aligned and we don't have to
restore it into a slab cache. But this maybe indeed confusing for those who
copy paste the code, so I'll change it.

> Call alloc_page() and use a kho_preserve_page/folio() like the luo
> patches were doing. The pattern seems common it probably needs a small
> alloc/free helper.
> 
> > +	for (int i = 0; i < vm->nr_pages; i += (1 << order)) {
> > +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> > +
> > +		err = __kho_preserve_order(track, PHYS_PFN(phys), order);
> > +		if (err)
> > +			goto err_free;
> 
> I think you should make a helper inline to document what is happening here:
> 
> /*
>  * Preserve a contiguous aligned list of order 0 pages that aggregate
>  * to a higher order allocation. Must be restored using
>  * kho_restore_page() on each order 0 page.
>  */
> kho_preserve_pages(page, order);

Maybe.
 
> Jason

-- 
Sincerely yours,
Mike.

