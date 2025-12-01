Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC77D116E2
	for <kexec@archiver.kernel.org>; Mon,  1 Dec 2025 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfnxiyig/VfJvWqtVCcPQgBGGzc0M6lW4gRh+8zP8B4=; b=qq5ScvzcXkE4mIznjJnmMmTORw
	c6bVYFDU2jZkRp4ExRRcufN0eIhJcbX6biHZQqOORzSncIEIUpSDP9W0CEPoSxqxaUOjfl3BspLSp
	hCn9N67rhzSgoP7rx901h1J+REzkekEbz3ovzgwqqk/kYx3SgxsxmiUnAEOqG7uOQGiiI2x/L7kg+
	sHENe3IRcGh1fHmhycAroXXmSZCQYGPJgQGRqezCHf76i5T0+x3P7GRsOyy5C+o1ybWiX272WIUyR
	gypgS9tobg0/SM4GGfhcCha1H/M2vkVk1UkUz5gyOF9oCZ1zIFYcSOuJg3LhfoklcEaMpg1zOcLI2
	YwL6Ahlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxoB-000000031Mc-2tNQ;
	Mon, 01 Dec 2025 06:54:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxo7-000000031MR-1A8c
	for kexec@lists.infradead.org;
	Mon, 01 Dec 2025 06:54:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3A0AA6014B;
	Mon,  1 Dec 2025 06:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAD2C4CEF1;
	Mon,  1 Dec 2025 06:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764572083;
	bh=GZa2G5potCEIy2zDYWbNMaWHtJEpt1+etp9afgwxZe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdAKNk1hWm3DX8qCSqa7BmET/VUYWlGAiMYdrMjsuaX41rYPyBHVMB+q12pm22Vrv
	 rBqn9IWfSxYleSP6P4jyohMRicda6JSV2BzlKydRxOh2xWNEVtFbxmPDlSVisR316X
	 q7x4fgGqRjOPywcvXoPk+yXbBb9pxIPyEPJ2lChanfBYSjqzo55+npSk53iJZOXWuJ
	 x5NVxFEMeCE6kkUHB1rwzRx88EOl5OJuOth3QofJnhftx81+He3b3ZKev+26Kkj7ll
	 ewUlqp6vlnDeSar9607LapxHYwgAVguPFqBDrkcfVxONYTkGHcKzzgTUr8Vpn7fblO
	 Z7gUz3+bu5Q8g==
Date: Mon, 1 Dec 2025 08:54:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: fix restoring of contiguous ranges of order-0
 pages
Message-ID: <aS07racwRsh4ep_L@kernel.org>
References: <20251125110917.843744-1-rppt@kernel.org>
 <20251125110917.843744-3-rppt@kernel.org>
 <mafs0pl96w7hk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0pl96w7hk.fsf@kernel.org>
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

On Tue, Nov 25, 2025 at 02:45:59PM +0100, Pratyush Yadav wrote:
> On Tue, Nov 25 2025, Mike Rapoport wrote:

...

> > @@ -243,11 +243,16 @@ static struct page *kho_restore_page(phys_addr_t phys)
> >  	/* Head page gets refcount of 1. */
> >  	set_page_count(page, 1);
> >  
> > -	/* For higher order folios, tail pages get a page count of zero. */
> > +	/*
> > +	 * For higher order folios, tail pages get a page count of zero.
> > +	 * For physically contiguous order-0 pages every pages gets a page
> > +	 * count of 1
> > +	 */
> > +	ref_cnt = is_folio ? 0 : 1;
> >  	for (unsigned int i = 1; i < nr_pages; i++)
> > -		set_page_count(page + i, 0);
> > +		set_page_count(page + i, ref_cnt);
> >  
> > -	if (info.order > 0)
> > +	if (is_folio && info.order)
> 
> This is getting a bit difficult to parse. Let's separate out folio and
> page initialization to separate helpers:
 
Sorry, I've missed this earlier and now the patches are in akpm's -stable
branch.
Let's postpone these changes for the next cycle, maybe along with support
for deferred initialization of struct page.

> 	/* Initalize 0-order KHO pages */
> 	static void kho_init_page(struct page *page, unsigned int nr_pages)
> 	{
> 		for (unsigned int i = 0; i < nr_pages; i++)
> 			set_page_count(page + i, 1);
> 	}
> 	
> 	static void kho_init_folio(struct page *page, unsigned int order)
> 	{
> 		unsigned int nr_pages = (1 << order);
> 	
> 		/* Head page gets refcount of 1. */
> 		set_page_count(page, 1);
> 	
> 		/* For higher order folios, tail pages get a page count of zero. */
> 		for (unsigned int i = 1; i < nr_pages; i++)
> 			set_page_count(page + i, 0);
> 	
> 		if (order > 0)
> 			prep_compound_page(page, order);
> 	}

-- 
Sincerely yours,
Mike.

