Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF3DC55164
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 07:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8ZEcwCwLQetxV1WFtJMYHvZdqoS2LqCfUtFy76iNIQ=; b=Q1TxqFb4cXUELecj4WtOJxtUy7
	/W349xyIrctWGtTui14nozGL+buN+rURNgPQ71hZ9kgtVriBkhLDEN/La3gsQYgdDTgNKTgCwl7Dk
	tcza6g8oQWwC/RVcfFCfS+1xhMxOxhUR1Y05Rd3WdHgmjf5UusYIYAnorEZhiO3HpT5YwRx7Ntvbn
	4w+tkx6yPXLghp34emYKMiFRIWbb8Mh0mgW2hHTJk2yJp1ex4jBF23ESWR/CAZT61+68v5MvFlSxU
	H7lXDqDCvm7PTn2D7hqlQ7sTTRz+Abn2xzACgi8CDy7VqH4OBa8/WfmhOn/jMt78G/O2lLa9ly4j1
	7BvStQrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpLAI-00000009jvR-2WjR;
	Thu, 30 Jul 2026 07:26:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpLAH-00000009jv4-2ilu
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 07:26:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B151F600AA;
	Thu, 30 Jul 2026 07:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098F51F00A3A;
	Thu, 30 Jul 2026 07:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785396408;
	bh=Q8ZEcwCwLQetxV1WFtJMYHvZdqoS2LqCfUtFy76iNIQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RxfkodDJSo/HC0OF23G424dtbX5R0k/p/rIVXMGavtHl3+W7XKRuYoP6HD++eIW/E
	 Cd5LgJuI5/SmIbyn+zS+zhKdDtEw5puQbim/Z0grP4kIqj94kWP0NdmVWdfbByZEhb
	 +1RKyVeqOn02xB+tqh4Rpw/q84dmC7v5VLh5gSzr1fo9ZXD8aruKXhgo9T65K/n2MD
	 wr9/CaA82x9z0bQbI51bJe4HZG2u5U6ZFIr5KQK/Mokas7qcjVHU80tOP/8DZDdm5B
	 HTldpABea/BuPoj+0C1DqtvVXsOKBdD67TN0S7P9rXDIaonqncHi7QCfaD2wZL99ED
	 sezDkWd4N6prw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/2] kho: Introduce preserve/restore APIs for
 high-order pages
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260723204203.2997395-3-praan@google.com>
References: <20260723204203.2997395-1-praan@google.com>
 <20260723204203.2997395-3-praan@google.com>
Date: Thu, 30 Jul 2026 10:26:41 +0300
Message-Id: <178539640188.2151126.10266644348178621151.b4-review@b4>
X-Mailer: b4 0.16-dev
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

Hi Pranjal,

> The current KHO page preservation APIs (e.g. kho_preserve_pages) assume
> that multi-page blocks are split into independent 4KB pages during
> restoration. This is incompatible with high-order non-compound pages,
> such as DMA buffers, which must be restored with tail pages having a
> zero reference count.
> 
> Introduce explicit preserve and restore APIs for high-order pages,
> which preserve and restore a high-order page block as a single unit,
> applying a refcount of 1 to the head page while leaving tail pages at 0.
> Rename the existing internal helper to __kho_restore_page() and
> consolidate the common restoration code into it.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>
> @@ -457,10 +482,14 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
>  	while (pfn < end_pfn) {
>  		const unsigned int order =
>  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> -		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
> +		unsigned int info_order;
> +		struct page *page = __kho_restore_page(PFN_PHYS(pfn), &info_order);
>  
>  		if (!page)
>  			return NULL;
> +
> +		kho_init_pages(page, 1UL << info_order);
> +		adjust_managed_page_count(page, 1UL << info_order);

Seeing 

+		adjust_managed_page_count(page, 1UL << info_order);

for the third time hinted that something is off ;-)

-- 
Sincerely yours,
Mike.


