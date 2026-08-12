Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC9C5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 10:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gcj6Nn0OFnz4GVFzatZ7HMT0a0oMws6ttw7Nr/ddbvA=; b=ua8kzLeFw0yTWTzkOyCb9R7tXb
	GeWPURp8bPj7Y3JMFAc2f+frFaNGevKRWVORXR58aPtqwM446Dl0BIYf66c+mPPqj0aaD0SIReNSK
	bYqoETJie5SOpm0PyW62DTSQ6+y8naSIX9NUqwHN1jy1Tl53iaZKi6sZAREw9fLyzN2DcjblxYft0
	vCsDhfVxGDBgqtD2qu22svf3QEorV2q2zs4fxAJm00L1hgnMtMiQD1c1vr12rNFINJceRe4nCvVci
	JkljMIaJiztLUKyUimqMPDzA318PYeWXrveODqub0y5++3FDoJZs+apEaxZWWm4roGR5ZsFH+M5AH
	r+v5Xy5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6bj-0000000FyQF-2XyH;
	Wed, 12 Aug 2026 10:54:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6bh-0000000FyPn-2ovX
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 10:54:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 222DF600E2;
	Wed, 12 Aug 2026 10:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF661F000E9;
	Wed, 12 Aug 2026 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532088;
	bh=gcj6Nn0OFnz4GVFzatZ7HMT0a0oMws6ttw7Nr/ddbvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=e4Kol6PvyyOtzPhPagi2RlBVhqqAA7P1Cs2LzWOU5K1eCStNaPc4a99nRCN1UdI6M
	 vVZzjgAnLWr9tk7FkTojT23M+CeDDUgNibnxOMEvO/aH/86z7TvLYW1sJmAFChKosU
	 jOb4iwX4pOZjt0f4Sk/0O9kKwQ5P0C3SKbEgXXQ1cuPk+BJrDgvIMJiZZD1MltiHN7
	 p8Sw1hpDwgA0fBhzysexJXQoMAwQxwdXSngbgu/YZtBpNHSvr7VumdzRLyG7LUhRnd
	 xhP939zAnPaZvj+3SVQDPxWI33MKbkpvx8+Zpl75fN9mjfoa89wePPk5BNR9FlrEPp
	 +1+GaVfGdRPyA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  David Matlack <dmatlack@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] kho: Introduce a helper to init high order pages
In-Reply-To: <20260803113944.3694290-2-praan@google.com> (Pranjal
	Shrivastava's message of "Mon, 3 Aug 2026 11:39:42 +0000")
References: <20260803113944.3694290-1-praan@google.com>
	<20260803113944.3694290-2-praan@google.com>
Date: Wed, 12 Aug 2026 12:54:45 +0200
Message-ID: <2vxzqzk338y2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Aug 03 2026, Pranjal Shrivastava wrote:

> The current KHO restoration logic assumes all multi-page blocks are
> split into independent 4KB pages. Break out a helper to prepare for
> supporting high-order non-compound pages.
>
> Extract kho_init_high_order_page() to handle the refcount pattern
> where only the head page is refcounted. Use the helper for folio
> restoration that requires a similar refcount logic.
>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 4834a809985a..e836efd98795 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  }
>  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
>  
> +/* For physically contiguous pages. */
> +static void kho_init_high_order_page(struct page *page, unsigned int order)
> +{
> +	unsigned long nr_pages = (1UL << order);
> +
> +	/* Head page gets refcount of 1. */
> +	set_page_count(page, 1);
> +	/* Clear head page's codetag to avoid accounting mismatch. */
> +	clear_page_tag_ref(page);
> +
> +	/* For high-order blocks, tail pages get a page count of zero. */
> +	for (unsigned long i = 1; i < nr_pages; i++) {
> +		set_page_count(page + i, 0);
> +		/* Clear each page's codetag to avoid accounting mismatch. */
> +		clear_page_tag_ref(page + i);
> +	}

That's sneaky...

The patch _almost_ looks like pure code movement, but then adds this
little change. I'm not saying this is intentionally sneaky or anything
of the sort, but these kind of things are easy to miss during code
movement and should get a patch of their own or at least be called out
in the commit message.

I don't know how page tags work, but IIRC when the change was originally
added by Ran, he said that we don't need to clear the tag for tail
pages. That held true for folios, does it not hold true for non-compound
high-order pages?

> +}
> +
>  /* For physically contiguous 0-order pages. */
>  static void kho_init_pages(struct page *page, unsigned long nr_pages)
>  {
> @@ -369,16 +387,7 @@ static void kho_init_pages(struct page *page, unsigned long nr_pages)
>  
>  static void kho_init_folio(struct page *page, unsigned int order)
>  {
> -	unsigned long nr_pages = (1 << order);
> -
> -	/* Head page gets refcount of 1. */
> -	set_page_count(page, 1);
> -	/* Clear head page's codetag to avoid accounting mismatch. */
> -	clear_page_tag_ref(page);
> -
> -	/* For higher order folios, tail pages get a page count of zero. */
> -	for (unsigned long i = 1; i < nr_pages; i++)
> -		set_page_count(page + i, 0);
> +	kho_init_high_order_page(page, order);
>  
>  	if (order > 0)
>  		prep_compound_page(page, order);

-- 
Regards,
Pratyush Yadav

