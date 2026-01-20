Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D90D2ECE9
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rm1+TH9fC63RHVsLPRFocRZcBTCLYTOhVyDXox1xIhw=; b=MfGgSrG00WF5ZHIM0lTl4BkmlW
	i/rhckoimWTfms85ZxgeHmcAZCXIqYCWY5JTMKh3J+nmUBJftA+6Kb98uZSvQR74rTm0ziWJjbMXK
	PRw0mzdSzfP3+otEwytxQPG7Z1jfWC4FyhFsmdbt4bAdXXtQpn9tBxYDSgQ6PiK7LXuqCxRhk+1TW
	ivk2b9Gs3wPlJNFmrLDPy8Z+4YHjLYAXRJSKqpUV53VIOLI6e6/VSxlN4GABMqdSsANk+aj2KKDC8
	2XGnhguSV5ingH1ZOgH4Y2hITvv/xy+wLhMjEOM7P6QW2UAyttw8pkUX5XRkXPVAeug0rWZdqPQ3f
	MHIqtSUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viBQ1-00000003t76-0jVq;
	Tue, 20 Jan 2026 13:05:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viBPy-00000003t6g-2nkH
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 13:05:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B97DE44136;
	Tue, 20 Jan 2026 13:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89D1C16AAE;
	Tue, 20 Jan 2026 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768914309;
	bh=nLvy/n1nlxvVvAZe/tXcawkxy7YqzQ4rJIes0g8gIsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVGSgD5Rp1+S26FlKdh30mQwBmeaUSion/wrJY6TRn2CeLWpMfYSoIijBm3rZOtDn
	 B8NnkxN7gQPYUZSnhffWRW3+IjJgN25XZc0kWkdEt4saUjL70y6fJCeIylbEOlrZY9
	 Vn64zowOOPPCSxLjw8cVHRskMwr76wGxWYl7Ngcb65fJziF4r6RXv84mJC1eMjatdh
	 GRfsVQ+Tp8dVRCRq2zwU7TWyQMFfqtMVPm+HnrBXiy2n51kutFv6xWmSzmP72dxjPu
	 hXba3PzVdw+dTB3OvyUtkXg126TGuRvrW961FdYoQU4imDSKPhL69VMV5atQqwOKnQ
	 aP0c/0ccLqYBQ==
Date: Tue, 20 Jan 2026 15:05:03 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 2/2] kho: simplify page initialization in
 kho_restore_page()
Message-ID: <aW99f7WAAAGtCfx9@kernel.org>
References: <20260116112217.915803-1-pratyush@kernel.org>
 <20260116112217.915803-3-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116112217.915803-3-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_050510_748688_9C3D45C1 
X-CRM114-Status: GOOD (  28.66  )
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

On Fri, Jan 16, 2026 at 11:22:15AM +0000, Pratyush Yadav wrote:
> When restoring a page (from kho_restore_pages()) or folio (from
> kho_restore_folio()), KHO must initialize the struct page. The
> initialization differs slightly depending on if a folio is requested or
> a set of 0-order pages is requested.
> 
> Conceptually, it is quite simple to understand. When restoring 0-order
> pages, each page gets a refcount of 1 and that's it. When restoring a
> folio, head page gets a refcount of 1 and tail pages get 0.
> 
> kho_restore_page() tries to combine the two separate initialization flow
> into one piece of code. While it works fine, it is more complicated to
> read than it needs to be. Make the code simpler by splitting the two
> initalization paths into two separate functions. This improves
> readability by clearly showing how each type must be initialized.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Changes in v2:
> - Use unsigned long for nr_pages.
> 
>  kernel/liveupdate/kexec_handover.c | 40 +++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 709484fbf9fd..92da76977684 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -219,11 +219,32 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  	return 0;
>  }
>  
> +/* For physically contiguous 0-order pages. */
> +static void kho_init_pages(struct page *page, unsigned long nr_pages)
> +{
> +	for (unsigned long i = 0; i < nr_pages; i++)
> +		set_page_count(page + i, 1);
> +}
> +
> +static void kho_init_folio(struct page *page, unsigned int order)
> +{
> +	unsigned long nr_pages = (1 << order);
> +
> +	/* Head page gets refcount of 1. */
> +	set_page_count(page, 1);
> +
> +	/* For higher order folios, tail pages get a page count of zero. */
> +	for (unsigned long i = 1; i < nr_pages; i++)
> +		set_page_count(page + i, 0);
> +
> +	if (order > 0)
> +		prep_compound_page(page, order);
> +}
> +
>  static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>  	unsigned long nr_pages;
> -	unsigned int ref_cnt;
>  	union kho_page_info info;
>  
>  	if (!page)
> @@ -241,20 +262,11 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  
>  	/* Clear private to make sure later restores on this page error out. */
>  	page->private = 0;
> -	/* Head page gets refcount of 1. */
> -	set_page_count(page, 1);
> -
> -	/*
> -	 * For higher order folios, tail pages get a page count of zero.
> -	 * For physically contiguous order-0 pages every pages gets a page
> -	 * count of 1
> -	 */
> -	ref_cnt = is_folio ? 0 : 1;
> -	for (unsigned long i = 1; i < nr_pages; i++)
> -		set_page_count(page + i, ref_cnt);
>  
> -	if (is_folio && info.order)
> -		prep_compound_page(page, info.order);
> +	if (is_folio)
> +		kho_init_folio(page, info.order);
> +	else
> +		kho_init_pages(page, nr_pages);
>  
>  	adjust_managed_page_count(page, nr_pages);
>  	return page;
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Sincerely yours,
Mike.

