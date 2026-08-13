Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62669C5B572
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E0q0foin1r7ZJY1ZfoJ0F+Tbh2/pSdHGZVciFlboEyA=; b=Y8B0xIcnGabeYwYSb0UuOw1e3S
	+i/YR83XQg72qDKGKJJV/k36uSOkIeo1EMABsWOQPRUNNDbYpPIT2UUlBe5o/yWOGIfp+XTM9lw2A
	4EnS5YmH75ZrT43aP3zgw2i1ZAq7iTVZq0CxQyCcb8djfJKfvBVL8+xu5+CAtrsMmEiUpkudUnvoa
	N5muJkSg7X5S/3kxmJBokXRQPMCPV5qDtkklYQsC2g6EAAfkQKFqw/mKgtYJavHydF3t4hZqLIFqC
	rwyMShZiz2QBUmi0JxUc0D3grbvYDK+/rAzBYmZwcZwFYslL3nw5hKxlnkfDe+QxfYYnMIm9lPq/d
	Y+HD5Y8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTl5-00000000Zd8-3Ov8;
	Thu, 13 Aug 2026 11:38:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTl5-00000000Zcy-06jG
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 11:38:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7612A600AD;
	Thu, 13 Aug 2026 11:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609681F000E9;
	Thu, 13 Aug 2026 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621082;
	bh=E0q0foin1r7ZJY1ZfoJ0F+Tbh2/pSdHGZVciFlboEyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xr4HrNQwh1yloKOrotLUQovwW+pRON76NvZ3uDr+evkMZafPCejupzsd5yBqPJ1UI
	 8c1Z7UFUcFosV32c+w6CUUBxTlQGVry1vPNCGrZ4hZdeIv5MIq6KaRCuf74zQTgL7P
	 f/bjtoRUhw9dKOgimuT6IBOIGFXYRiy7udigDY2AXqW6VvR71WzkIrRG3OBWiip83n
	 1WOnqeLkXpb3LbsR1fVpm96w86faUihlVa7V+kU0jXqSfZEI1PnVw2/TM213tS2FrZ
	 jBEVHg85KNMML/cnocL9oX73xBHkE93gLGMGs17bZsag4n2O0hp3IxCaBMlQOiAPZp
	 4W+30ugtrf2SA==
Date: Thu, 13 Aug 2026 14:37:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] kho: Introduce a helper to init high order pages
Message-ID: <an2skkjrNXBTFagK@kernel.org>
References: <20260803113944.3694290-1-praan@google.com>
 <20260803113944.3694290-2-praan@google.com>
 <2vxzqzk338y2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzqzk338y2.fsf@kernel.org>
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

(added Suren)

On Wed, Aug 12, 2026 at 12:54:45PM +0200, Pratyush Yadav wrote:
> On Mon, Aug 03 2026, Pranjal Shrivastava wrote:
> 
> > The current KHO restoration logic assumes all multi-page blocks are
> > split into independent 4KB pages. Break out a helper to prepare for
> > supporting high-order non-compound pages.
> >
> > Extract kho_init_high_order_page() to handle the refcount pattern
> > where only the head page is refcounted. Use the helper for folio
> > restoration that requires a similar refcount logic.
> >
> > Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 4834a809985a..e836efd98795 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
> >  }
> >  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
> >  
> > +/* For physically contiguous pages. */
> > +static void kho_init_high_order_page(struct page *page, unsigned int order)
> > +{
> > +	unsigned long nr_pages = (1UL << order);
> > +
> > +	/* Head page gets refcount of 1. */
> > +	set_page_count(page, 1);
> > +	/* Clear head page's codetag to avoid accounting mismatch. */
> > +	clear_page_tag_ref(page);
> > +
> > +	/* For high-order blocks, tail pages get a page count of zero. */
> > +	for (unsigned long i = 1; i < nr_pages; i++) {
> > +		set_page_count(page + i, 0);
> > +		/* Clear each page's codetag to avoid accounting mismatch. */
> > +		clear_page_tag_ref(page + i);
> > +	}
> 
> That's sneaky...
> 
> The patch _almost_ looks like pure code movement, but then adds this
> little change. I'm not saying this is intentionally sneaky or anything
> of the sort, but these kind of things are easy to miss during code
> movement and should get a patch of their own or at least be called out
> in the commit message.
> 
> I don't know how page tags work, but IIRC when the change was originally
> added by Ran, he said that we don't need to clear the tag for tail
> pages. That held true for folios, does it not hold true for non-compound
> high-order pages?
> 
> > +}
> > +
> >  /* For physically contiguous 0-order pages. */
> >  static void kho_init_pages(struct page *page, unsigned long nr_pages)
> >  {
> > @@ -369,16 +387,7 @@ static void kho_init_pages(struct page *page, unsigned long nr_pages)
> >  
> >  static void kho_init_folio(struct page *page, unsigned int order)
> >  {
> > -	unsigned long nr_pages = (1 << order);
> > -
> > -	/* Head page gets refcount of 1. */
> > -	set_page_count(page, 1);
> > -	/* Clear head page's codetag to avoid accounting mismatch. */
> > -	clear_page_tag_ref(page);
> > -
> > -	/* For higher order folios, tail pages get a page count of zero. */
> > -	for (unsigned long i = 1; i < nr_pages; i++)
> > -		set_page_count(page + i, 0);
> > +	kho_init_high_order_page(page, order);
> >  
> >  	if (order > 0)
> >  		prep_compound_page(page, order);
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

