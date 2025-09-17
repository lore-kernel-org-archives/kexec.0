Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93872CAC59A
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQjHIFDkC1WkWh0EEfJ/NlvfY0iZZfOI5h7O8E+zWgQ=; b=0wA8btNwkEDU8GR8knKwTXifsc
	r/jLLISai7r84biUo8F+kARxqChQRF6yJdEOEn4d/L8CvFW7vdwiZJ/tvTKbVcxknap+VccjN7iqn
	HjmBAAe25KxzpGCVGOhVRrGYqNc+ORxf6maBTZfzD3ru7Zjv6C6YvbaZvzC07aryZCGQObxjPSFBQ
	4JYzvZrxwoA/w/ok3IFFMQpb3VfAMmSVTv5fTqjipnSN2s1Gbrf0aMAwIX/AgyhA/2EkcvgXVaBVL
	n/uBY2RkWfoDQeTGFxzo2JaVBGWvQSYnQjwDo15JEFJqG9ANXcRfGncDc0EhyyVGItuwm1ww5Chpe
	nIJex8xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uytCM-0000000CFSR-0Ijy;
	Wed, 17 Sep 2025 14:31:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uytCK-0000000CFS4-2Q2H
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 14:31:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BC83860240;
	Wed, 17 Sep 2025 14:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FADCC4CEF5;
	Wed, 17 Sep 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119511;
	bh=k9cG3kz/ofV3MOY4tO3NxTa8C0lQ0KwhYvMThaTJklY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQEqNcn0RVU/IcZMKtRGuPfTEkCa0ftTy/KsYvzMc3vySV8NIyQSfoyOOB2AZ0qf7
	 uvKDbh8G2D1egXCoXYyAkAROQqrV/L6uYZ7WwgHjGV6vU8XN/U2gdNN/81/ykgz74x
	 BKM5zcBdLMGa9+WaH5hvAylH3sHfMjkc4ahHvOAvCLfYgVwBPOFIVTbNicQsvWEIor
	 nkYqUQw2pr2C/CaUkc+/SWb3ZjvoyWXxJZ8jQhUlkTcGlL0mShtgbI6PzxxuQVbuiO
	 duNhZzx8ephb7lWkr8DQmTnrYbA5pTXGmjtpRlB4u3M1eBQqoK/0aWk+CWHFSahNCV
	 GweR5D4v6nbEA==
Date: Wed, 17 Sep 2025 17:31:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] kho: move sanity checks to kho_restore_page()
Message-ID: <aMrGT9IyHBFe5-nH@kernel.org>
References: <20250917125725.665-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917125725.665-1-pratyush@kernel.org>
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

On Wed, Sep 17, 2025 at 02:56:53PM +0200, Pratyush Yadav wrote:
> While KHO exposes folio as the primitive externally, internally its
> restoration machinery operates on pages. This can be seen with
> kho_restore_folio() for example. It performs some sanity checks and
> hands it over to kho_restore_page() to do the heavy lifting of page
> restoration. After the work done by kho_restore_page(),
> kho_restore_folio() only converts the head page to folio and returns it.
> Similarly, deserialize_bitmap() operates on the head page directly to
> store the order.
> 
> Move the sanity checks for valid phys and order from the public-facing
> kho_restore_folio() to the private-facing kho_restore_page(). This makes
> the boundary between page and folio clearer from KHO's perspective.
> 
> While at it, drop the comment above kho_restore_page(). The comment is
> misleading now. The function stopped looking like free_reserved_page()
> since 12b9a2c05d1b4 ("kho: initialize tail pages for higher order folios
> properly"), and now looks even more different.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Changes in v2:
>     
>     - New in v2.
> 
>  kernel/kexec_handover.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index ecd1ac210dbd7..69cab82abaaef 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -183,10 +183,18 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  	return 0;
>  }
>  
> -/* almost as free_reserved_page(), just don't free the page */
> -static void kho_restore_page(struct page *page, unsigned int order)
> +static struct page *kho_restore_page(phys_addr_t phys)
>  {
> -	unsigned int nr_pages = (1 << order);
> +	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> +	unsigned int nr_pages, order;
> +
> +	if (!page)
> +		return NULL;
> +
> +	order = page->private;
> +	if (order > MAX_PAGE_ORDER)
> +		return NULL;
> +	nr_pages = (1 << order);
>  
>  	/* Head page gets refcount of 1. */
>  	set_page_count(page, 1);
> @@ -199,6 +207,7 @@ static void kho_restore_page(struct page *page, unsigned int order)
>  		prep_compound_page(page, order);
>  
>  	adjust_managed_page_count(page, nr_pages);
> +	return page;
>  }
>  
>  /**
> @@ -209,18 +218,9 @@ static void kho_restore_page(struct page *page, unsigned int order)
>   */
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
> -	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> -	unsigned long order;
> -
> -	if (!page)
> -		return NULL;
> -
> -	order = page->private;
> -	if (order > MAX_PAGE_ORDER)
> -		return NULL;
> +	struct page *page = kho_restore_page(phys);
>  
> -	kho_restore_page(page, order);
> -	return page_folio(page);
> +	return page ? page_folio(page) : NULL;
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_folio);
>  
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

