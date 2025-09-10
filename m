Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6BACA101F
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R4SFRua4tQ0Gijz9/yISvfIst143Bm6fRH6N/9ViY+I=; b=fLldD0tr3GzqKR9xu/CFRidogj
	MtfbY8xUNjhN2KYHoPGNk+aNPo2ZmLkdzjz4OQhU+IECGEUJ60Jeh8gVJNroIxh97QAV/SHLxHGjS
	R0wUuhPbRqLdr8oB9JeaLtCDrf77EJbg29axhIKba70OodfisBuHfwWyNfg+/bGjQxbjMMZhHIx3q
	gdgIr3/z0TTV0jeeXSHrsJThAiFclO9d/5F3xFtsFPFlx57/qEyH6T/Y78ZNqNPwf8WuhcO1L9+2O
	Am9ZmhiRGxMHgORWuQQN0bM2FH4I4U41in+0YdK+FAS47CiAirQKAASvcxZiyYmwMcEo3X2MYLMfc
	TGcm/7Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwN0H-0000000FD5w-24HU;
	Wed, 10 Sep 2025 15:45:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwN0E-0000000FD5C-3795
	for kexec@bombadil.infradead.org;
	Wed, 10 Sep 2025 15:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R4SFRua4tQ0Gijz9/yISvfIst143Bm6fRH6N/9ViY+I=; b=FSMyqJWavJW0jS2IPwJx7uChbi
	cZ/019mkqwHp/YhwTm1qRUdfMyJY9tfXzu0mC/NzBeOJFfIA59vSJAdJxdqLJK6oDI6Id4Qw5shm+
	EGZiLadAf3XGfTFRCJCKeMVaFYgWw+XMUP5m5Si0tifUSxC0YG9mbTVuIIXqPeaemUgEpx2D1C17z
	BwwCct5LxRl8l6L81FM8dFyJjfrfcRIyripTxvuwz4DynYz9Ue6lWf+I1/ZBlIDye77tvLB4H+dBC
	LLhp11tT9dma8uO8uhPwbRFjSv9IalKx2GOEyK6UfkQhuF6KeLuHFr4msk8nsTEaAULjpxK14OTXr
	omP5A99g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwN0C-0000000BKmy-3NsY;
	Wed, 10 Sep 2025 15:44:56 +0000
Date: Wed, 10 Sep 2025 16:44:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
Message-ID: <aMGc-ExhkqwAyY_C@casper.infradead.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153443.95049-1-pratyush@kernel.org>
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

On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> +
> +/*
> + * KHO uses page->private, which is an unsigned long, to store page metadata.
> + * Use it to store both the magic and the order.
> + */
> +union kho_page_info {
> +	unsigned long page_private;
> +	struct {
> +		unsigned int order;
> +		unsigned int magic;
> +	};

KHO is only supported on 64-bit?

> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> -	unsigned long order;
> +	union kho_page_info info;
>  
>  	if (!page)
>  		return NULL;
>  
> -	order = page->private;
> -	if (order > MAX_PAGE_ORDER)
> +	info.page_private = page->private;
> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>  		return NULL;
>  
> -	kho_restore_page(page, order);
> +	kho_restore_page(page, info.order);
>  	return page_folio(page);

This all looks very confused.  Before your patch as well as after it.
I don't see anything in the current KHO code that requires the
phys_addr_t to be order-aligned.


