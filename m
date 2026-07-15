Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8160BC4450E
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJCkfbD2BXoqIfkkjqhRJy5QsRRiDswbp3HwIn/Mlng=; b=NJuz9n9QQ4tgSXdD7oImbwHHli
	Mo4wdk2rgWMJEMe/BZkld3sKxcXC4X66Kp2k/NG5wAbbfhotJGBCGUtYs7DmYCTg+jA3Rb/Gp8pA2
	sw9QzwwuSHBlQ6B4m05FfvAOPIWAr/Vb0niZn/hz9ukvIANNVlW+7T5/ZLvekHTmS6JZBX3PlaibP
	eYjdv0g3+kCplPK0B085qmQ5EFQLOUUelOvnwD3hOhfznS9wkVxhhwKDaZTVNFubyC/7Fabn7xiWv
	XRHyCKt9ojd0dgv3MAcXsGURnkHPsJ29luzz1YXqcsjJ4rI8vQ24Ki2Lox6gi0OINGU6Z4Qs2JO5t
	dhpbeUQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1e-0000000EKt2-2VJ4;
	Wed, 15 Jul 2026 09:35:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1d-0000000EKsX-3XMg
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 09:35:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BD06600BB;
	Wed, 15 Jul 2026 09:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276401F00A3D;
	Wed, 15 Jul 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108133;
	bh=bJCkfbD2BXoqIfkkjqhRJy5QsRRiDswbp3HwIn/Mlng=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=acITzPKN8HBfcdcId1dHRqzht3bSI7I8sPDODy5fBAqtoRreiwHpKhQTYjdQGsDfl
	 Asi+nqvM7/sd4SmOqXlYb9G0UXtjGhVSkk4JapmRA+oMkrtF5K42itST1KCRNc5FRK
	 E7cW/Rgt8J5qFDE575dZBkiO9yNFEUqJgGjMmHN0w5TYUKTrIWeJnzk7XUvtoOlDTI
	 k6hGmVj/+f7aC6oYN1+aomPkB2kscaOD4eQ32WBYPe9AqqOCRIOrBv578bGmqaa9Cw
	 M8S4i6dmCqNPWP43UHNbQH+akA+NNGa5etbFJbX7z+VQtBqZe79twcagl+85VowH1y
	 0xmtVhRQZuRqQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 16/21] mm/mm_init: init deferred page migratetype in
 deferred_init_pages()
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260709173821.429921-17-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
 <20260709173821.429921-17-pratyush@kernel.org>
Date: Wed, 15 Jul 2026 12:35:19 +0300
Message-Id: <178410811938.820181.10032776847430752177.b4-review@b4>
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

> The deferred pages are initialized in deferred_init_pages(), but their
> migratetype is initialized later when freeing them in
> deferred_free_pages(). Setting the migrate type is part of initializing
> the pages, so move it to deferred_init_pages().
> 
> This simplifies the logic in deferred_free_pages(), which now only does
> the freeing. For non-max-order-aligned pages, it also drops the
> if (pageblock_aligned) for each freed page, which in theory should be a
> tiny bit faster.
> 
> Another motivation for this change is that in a coming patch, KHO will
> need to update the migrate type for its scratch pages. Moving all the
> pageblock init in one place makes that simpler.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 84d4b1c997bc2..bd9dc1829005b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1985,8 +1985,6 @@ static void __init deferred_free_pages(unsigned long pfn,
  
There's migratetype parameter in deferred_free_pages(), looks like it's
not needed anymore.

>  	/* Free a large naturally-aligned chunk if possible */
>  	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
> -		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
> -			init_pageblock_migratetype(page + i, mt, false);
>  		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
>  		return;
>  	}
> @@ -1994,11 +1992,8 @@ static void __init deferred_free_pages(unsigned long pfn,
>  	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
>  	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
>  
> -	for (i = 0; i < nr_pages; i++, page++, pfn++) {
> -		if (pageblock_aligned(pfn))
> -			init_pageblock_migratetype(page, mt, false);
> +	for (i = 0; i < nr_pages; i++, page++, pfn++)
>  		__free_pages_core(page, 0, MEMINIT_EARLY);
> -	}
>  }
>  
>  /* Completion tracking for deferred_init_memmap() threads */
> @@ -2017,15 +2012,23 @@ static inline void __init pgdat_init_report_one_done(void)
>   * Return number of pages initialized.
>   */
>  static unsigned long __init deferred_init_pages(struct zone *zone,
> -		unsigned long pfn, unsigned long end_pfn)
> +		unsigned long start_pfn, unsigned long end_pfn,
> +		enum migratetype mt)
>  {
>  	int nid = zone_to_nid(zone);
> -	unsigned long nr_pages = end_pfn - pfn;
> +	unsigned long nr_pages = end_pfn - start_pfn, pfn = start_pfn;

Let's declare pfn on a separate line please.

-- 
Sincerely yours,
Mike.


