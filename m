Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A417CD0E6E7
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 13:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NUoeADxT0VkKE4h/ybzz40S3j/EuiATzB88i1IlDQLY=; b=nuLZ89RaJ16lud2b0CLhmik52s
	XpSCtcQpJQsrp0mLVLVsNlt9iiYX8IP0ie7urzSZoRQYc42SXJuQCixOu8h28Gpshgy/aJd3lJpm3
	u0OGWS0pwycxAlsgQtEVDXRmZVdPT30u01vwjztuf77FvtST3KjZlT1Z/ktN0WoCMEmrR8O2r96Ty
	vP1EiVAHIDSlzbLQsVGVfwuuOiKTzc+leETa8hrFs0KSf7tWdC1Tbk1bDQEUh3xbiJ6+ebIDUIhCZ
	wylVplTYTt/F4EX/lQJxInADOPbOiHyoAZgiQtZlrUt+AvanWSGlx5uaZW9fyH++7/NyClrX5/WAK
	Fu5LyCXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNtMp-0000000DMy7-3SaA;
	Tue, 25 Nov 2025 13:46:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNtMo-0000000DMxm-0WJa
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 13:46:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 76E8E43912;
	Tue, 25 Nov 2025 13:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AF1C4CEF1;
	Tue, 25 Nov 2025 13:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764078361;
	bh=dl+oPp/GipwLpjlWzXAhu4z0Q+oNDkuAziTjJDqxIrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lcdV7eihvC0Jk/3ytxRRdD1z9X+DUj1r2zKdiNuXwXfrjInezOai08J/l1JHj6y6q
	 D+oZEsGd2nN6o3kXIQ6Hy088r0O9Dlb/9MC9Au1CiJkAMgMVRjSydFAXbT2eCotU8F
	 II2V4q2c8Z+rvPfCFLeV28/11PtXgJSt2sNd8h1uS8EtuQ2DgwocXLVKC9H6jiB2ru
	 2zx5oQvc2/ZQhDpylsX1dMA1abJhOct5KJzQ8lbCY63KpVKCMDBZuqht6RmEZox3cI
	 jrTnIwweJX49Woo4OG0ceQ14IrUTVX2FD6S8CO/jCW7l3Tt16OnyPd2T56NNwyDCQa
	 3XwYpK9VfYeSQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: fix restoring of contiguous ranges of order-0
 pages
In-Reply-To: <20251125110917.843744-3-rppt@kernel.org> (Mike Rapoport's
	message of "Tue, 25 Nov 2025 13:09:17 +0200")
References: <20251125110917.843744-1-rppt@kernel.org>
	<20251125110917.843744-3-rppt@kernel.org>
Date: Tue, 25 Nov 2025 14:45:59 +0100
Message-ID: <mafs0pl96w7hk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_054602_226211_48D1C4DF 
X-CRM114-Status: GOOD (  25.07  )
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

On Tue, Nov 25 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> When contiguous ranges of order-0 pages are restored, kho_restore_page()
> calls prep_compound_page() with the first page in the range and order as
> parameters and then kho_restore_pages() calls split_page() to make sure all
> pages in the range are order-0.
>
> However, since split_page() is not intended to split compound pages and
> with VM_DEBUG enabled it will trigger a VM_BUG_ON_PAGE().
>
> Update kho_restore_page() so that it will use prep_compound_page() when it
> restores a folio and make sure it properly sets page count for both large
> folios and ranges of order-0 pages.
>
> Reported-by: Pratyush Yadav <pratyush@kernel.org>
> Fixes: a667300bd53f ("kho: add support for preserving vmalloc allocations")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index e64ee87fa62a..61d17ed1f423 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -219,11 +219,11 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  	return 0;
>  }
>  
> -static struct page *kho_restore_page(phys_addr_t phys)
> +static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> +	unsigned int nr_pages, ref_cnt;
>  	union kho_page_info info;
> -	unsigned int nr_pages;
>  
>  	if (!page)
>  		return NULL;
> @@ -243,11 +243,16 @@ static struct page *kho_restore_page(phys_addr_t phys)
>  	/* Head page gets refcount of 1. */
>  	set_page_count(page, 1);
>  
> -	/* For higher order folios, tail pages get a page count of zero. */
> +	/*
> +	 * For higher order folios, tail pages get a page count of zero.
> +	 * For physically contiguous order-0 pages every pages gets a page
> +	 * count of 1
> +	 */
> +	ref_cnt = is_folio ? 0 : 1;
>  	for (unsigned int i = 1; i < nr_pages; i++)
> -		set_page_count(page + i, 0);
> +		set_page_count(page + i, ref_cnt);
>  
> -	if (info.order > 0)
> +	if (is_folio && info.order)

This is getting a bit difficult to parse. Let's separate out folio and
page initialization to separate helpers:

	/* Initalize 0-order KHO pages */
	static void kho_init_page(struct page *page, unsigned int nr_pages)
	{
		for (unsigned int i = 0; i < nr_pages; i++)
			set_page_count(page + i, 1);
	}
	
	static void kho_init_folio(struct page *page, unsigned int order)
	{
		unsigned int nr_pages = (1 << order);
	
		/* Head page gets refcount of 1. */
		set_page_count(page, 1);
	
		/* For higher order folios, tail pages get a page count of zero. */
		for (unsigned int i = 1; i < nr_pages; i++)
			set_page_count(page + i, 0);
	
		if (order > 0)
			prep_compound_page(page, order);
	}


>  		prep_compound_page(page, info.order);
>  
>  	adjust_managed_page_count(page, nr_pages);
> @@ -262,7 +267,7 @@ static struct page *kho_restore_page(phys_addr_t phys)
>   */
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
> -	struct page *page = kho_restore_page(phys);
> +	struct page *page = kho_restore_page(phys, true);
>  
>  	return page ? page_folio(page) : NULL;
>  }
> @@ -287,11 +292,10 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
>  	while (pfn < end_pfn) {
>  		const unsigned int order =
>  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> -		struct page *page = kho_restore_page(PFN_PHYS(pfn));
> +		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
>  
>  		if (!page)
>  			return NULL;
> -		split_page(page, order);
>  		pfn += 1 << order;
>  	}

-- 
Regards,
Pratyush Yadav

