Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE08C44520
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzgvdGaBXPxbJtRAgq9ARlle9808crpesqVqNAEMGi8=; b=O9MzfLyfzhsh5+bbf6N+Nduh2I
	A9hzPhNiQZSGXUP1zhTf5OakLsPrCiFuOpo4TimLxPS+cVZM9bGbJPOhojTlnBu0NvjnXPnk4ms1Q
	/aKFh6xvcB1YanMO8eu3fHoUUmsEwPFYlzQex5WtWMSjW/VDJqQnInbenpY++wCvheP0M/L07kRY0
	/Iqu6S57YzwmOl5QmjTtKYJ6nIjMZpA1NuzhkwShRIAkMS5ERCFVSHDOj4AZLhqGi8+GFaMrF0Y14
	8EEBkeuATe2xrsZYWiQQjpAo/lUOo5dRkMtxbmnQJSxvtDT/uTboyRAykzUnerMVkvbSIipANJScr
	N/sTJ/IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrJ2-00000007SKu-3Xyy;
	Mon, 20 Jul 2026 16:57:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrIy-00000007SKF-47Dp
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 16:57:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BA583438CA;
	Mon, 20 Jul 2026 16:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5402C1F000E9;
	Mon, 20 Jul 2026 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566644;
	bh=nzgvdGaBXPxbJtRAgq9ARlle9808crpesqVqNAEMGi8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kyHApj0dUNBqwBC58GbBTZLUb4b4dcFlgiNJZR2Te6/T04N1HJDmajqDNUHSQQ+vs
	 V3qzHdcvj/B+1Rg4ZYNYn/xYejq5pyqykcOAaenZ6N+xOSmjXycxZl2yB4TNOGQe4R
	 xkY/2GWfR/t2f1qyssFWXiDmZ7HfU1ej64mFuA7G5Wc28h0ezEMRjWF3j98Txi5j6u
	 dyrnKVeViNjML3XQYHToDSb58x9g5ckHkvH6xCWhkgD6TWlDoPdk7ieRFLSacZMmqJ
	 ntBWJMpu0/Ahm42Q7lyZJcSwpSHloo85X28s0ZFrQRds7NclUZaMPmZo4324Y8faVV
	 WDsUk2+oKPzoQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v2 2/2] kho: Introduce preserve/restore APIs for
 unsplit pages
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260713204935.3069000-3-praan@google.com>
References: <20260713204935.3069000-1-praan@google.com>
 <20260713204935.3069000-3-praan@google.com>
Date: Mon, 20 Jul 2026 19:57:15 +0300
Message-Id: <178456663513.143128.14871307686052703561.b4-review@b4>
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

> The current KHO page preservation APIs (e.g. kho_preserve_pages) assume
> that multi-page blocks are split into independent 4KB pages during
> restoration. This is incompatible with high-order non-compound pages,
> such as DMA buffers, which must be restored with tail pages having a
> zero reference count.
> 
> Introduce explicit preserve and restore APIs for unsplit pages,

                                 high-order non-compound ^

> which preserve and restore a high-order page block as a single unit,
> applying a refcount of 1 to the head page while leaving tail pages at 0.
> Rename the existing internal helper to __kho_restore_page().
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 8968c56d2d73e..6e2c75b16209c 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -22,6 +22,8 @@ bool is_kho_boot(void);
>  
>  int kho_preserve_folio(struct folio *folio);
>  void kho_unpreserve_folio(struct folio *folio);
> +int kho_preserve_page(struct page *page, unsigned int order);
> +void kho_unpreserve_page(struct page *page, unsigned int order);
>  int kho_preserve_pages(struct page *page, unsigned long nr_pages);
>  void kho_unpreserve_pages(struct page *page, unsigned long nr_pages);
>  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
> @@ -30,6 +32,7 @@ void *kho_alloc_preserve(size_t size);
>  void kho_unpreserve_free(void *mem);
>  void kho_restore_free(void *mem);
>  struct folio *kho_restore_folio(phys_addr_t phys);
> +struct page *kho_restore_page(phys_addr_t phys);
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
>  int kho_add_subtree(const char *name, void *blob, size_t size);
> @@ -65,6 +68,13 @@ static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  
>  static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
>  
> +static inline int kho_preserve_page(struct page *page, unsigned int order)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void kho_unpreserve_page(struct page *page, unsigned int order) { }
> +
>  static inline int kho_preserve_vmalloc(void *ptr,
>  				       struct kho_vmalloc *preservation)
>  {
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 07f6f453cd69d..43ae3e2de5da2 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -393,7 +393,7 @@ static void kho_init_folio(struct page *page, unsigned int order)
>  		prep_compound_page(page, order);
>  }
>  
> -static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
> +static struct page *__kho_restore_page(phys_addr_t phys, bool is_folio)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>  	unsigned long nr_pages;
> @@ -432,12 +432,44 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>   */
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
> -	struct page *page = kho_restore_page(phys, true);
> +	struct page *page = __kho_restore_page(phys, true);
>  
>  	return page ? page_folio(page) : NULL;
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_folio);
>  
> +/**
> + * kho_restore_page - restore a higher-order unsplit page block.
> + * @phys: physical address of the first page.
> + *
> + * Restore a higher-order unsplit page block that was preserved with
> + * kho_preserve_page().
> + *
> + * Return: the head page on success, NULL on failure.
> + */
> +struct page *kho_restore_page(phys_addr_t phys)
> +{
> +	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> +	unsigned long nr_pages;
> +	union kho_page_info info;
> +
> +	if (!page)
> +		return NULL;
> +
> +	info.page_private = page->private;
> +	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC))
> +		return NULL;
> +
> +	nr_pages = (1UL << info.order);
> +	page->private = 0;
> +
> +	kho_init_unsplit_pages(page, info.order);
> +	adjust_managed_page_count(page, nr_pages);
> +
> +	return page;

Hmm, it copies a lot from __kho_init_page().
We should keep the common part of order-0 page/folio/high-order page
initialization in a single place.

-- 
Sincerely yours,
Mike.


