Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054D9CAC597
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5a5kwMi33I+A3Y2PADe+7+W+ASlKPSpUDe01fp//o8=; b=TcbNbScKSXGU82y0ITBiqc45lh
	F71sZQyv7l6OOWJgF8PuOSbmAP9KwGG7DYsDr0jfe+WrxeWPj5r89+rek5wCiqxnGxGn68IprJbVy
	yPkLKYNyiHfnWvUci0+wqGl/mCivYAaPfC3pRHy9/xxhps5CgBgYI0PyrxDk0DFuYm0FjXJjOTxoG
	BJ4Ph4luNN9Lpz5dEy1SYhq1lDVqFTmnwKvft1omuS3FYQ9Oi6UucIX5MEkyVuTBojduLn95Z5gUA
	vgWiz1orc+qE8gC9ZbgV+j7553n3R/RyHpEW5EEBnoCMj3gcFjfmOlFuFh98P4bD64kTjxUpIyJIA
	fCp+qZRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBvy-0000000H5KR-2wuO;
	Thu, 18 Sep 2025 10:32:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBvv-0000000H5JN-3Nom
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 10:32:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DB6544A06;
	Thu, 18 Sep 2025 10:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E8C4CEFC;
	Thu, 18 Sep 2025 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191531;
	bh=yy2/qGmH2QA2swtXgVVOAHnOxEMhRZ0NhObdYrFdpP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=smkYQj59cJEB2MBpLMWEo/hAvXX7jkJTDCXOe2YP6B8kjmfCFAlaw29s3ux/BKgAB
	 BN87ihWMAGN0M8GH5XkkXR5gSQpGbFfOkSdZVWemcu7XAPnuioH89tfzj4ndhqDfRM
	 mrfhGj0JEG72SS2jkPZ4pVFACZ4hfclVKHHxc6f/4ESFCWacU7MYgbI6XOZ/g6HCZ9
	 Vmq73d/+GCK2p37SXDMw+YFGDctVpPmeikPcp/k3Um83y5bPqrAZTTxnAGCeF2lpS7
	 zLE1C7TdB7kXGrUvzq9wunjrmFRxhcoyiGYcu2Ij8YlqqHofGS5VPp0T5kp9hz09v+
	 KWqav/GLcplpA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] kho: replace kho_preserve_phys() with
 kho_preserve_pages()
In-Reply-To: <20250917174033.3810435-3-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-3-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:32:08 +0200
Message-ID: <mafs05xdggifr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_033211_884495_842734C0 
X-CRM114-Status: GOOD (  27.92  )
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

Hi Mike,

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> to make it clear that KHO operates on pages rather than on a random
> physical address.
>
> The kho_preserve_pages() will be also used in upcoming support for
> vmalloc preservation.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/kexec_handover.h |  5 +++--
>  kernel/kexec_handover.c        | 25 +++++++++++--------------
>  mm/memblock.c                  |  4 +++-
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 348844cffb13..cc5c49b0612b 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -18,6 +18,7 @@ enum kho_event {
>  
>  struct folio;
>  struct notifier_block;
> +struct page;
>  
>  #define DECLARE_KHOSER_PTR(name, type) \
>  	union {                        \
> @@ -42,7 +43,7 @@ struct kho_serialization;
>  bool kho_is_enabled(void);
>  
>  int kho_preserve_folio(struct folio *folio);
> -int kho_preserve_phys(phys_addr_t phys, size_t size);
> +int kho_preserve_pages(struct page *page, unsigned int nr_pages);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
> @@ -65,7 +66,7 @@ static inline int kho_preserve_folio(struct folio *folio)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
> +static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index f421acc58c1f..3ad59c5f9eaa 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -698,26 +698,23 @@ int kho_preserve_folio(struct folio *folio)
>  EXPORT_SYMBOL_GPL(kho_preserve_folio);
>  
>  /**
> - * kho_preserve_phys - preserve a physically contiguous range across kexec.
> - * @phys: physical address of the range.
> - * @size: size of the range.
> + * kho_preserve_pages - preserve contiguous pages across kexec
> + * @page: first page in the list.
> + * @nr_pages: number of pages.
>   *
> - * Instructs KHO to preserve the memory range from @phys to @phys + @size
> - * across kexec.
> + * Preserve a contiguous list of order 0 pages. Must be restored using
> + * kho_restore_page() on each order 0 page.

This is not true. The pages are preserved with the maximum order
possible.

	while (pfn < end_pfn) {
		const unsigned int order =
			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));

		err = __kho_preserve_order(track, pfn, order);
		[...]

So four 0-order pages will be preserved as one 2-order page. Restoring
them as four 0-order pages is wrong. And my proposed patch for checking
the magic [0] will uncover this exact bug.

I think you should either change the logic to always preserve at order
0, or maybe add a kho_restore_pages() that replicates the same order
calculation.

[0] https://lore.kernel.org/lkml/20250917125725.665-2-pratyush@kernel.org/

>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_preserve_phys(phys_addr_t phys, size_t size)
> +int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  {
> -	unsigned long pfn = PHYS_PFN(phys);
> +	struct kho_mem_track *track = &kho_out.ser.track;
> +	const unsigned long start_pfn = page_to_pfn(page);
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +	unsigned long pfn = start_pfn;
>  	unsigned long failed_pfn = 0;
> -	const unsigned long start_pfn = pfn;
> -	const unsigned long end_pfn = PHYS_PFN(phys + size);
>  	int err = 0;
> -	struct kho_mem_track *track = &kho_out.ser.track;
> -
> -	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
> -		return -EINVAL;
>  
>  	while (pfn < end_pfn) {
>  		const unsigned int order =
> @@ -737,7 +734,7 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
>  
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(kho_preserve_phys);
> +EXPORT_SYMBOL_GPL(kho_preserve_pages);
>  
>  /* Handling for debug/kho/out */
>  
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 117d963e677c..6ec3eaa4e8d1 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2516,8 +2516,10 @@ static int reserve_mem_kho_finalize(struct kho_serialization *ser)
>  
>  	for (i = 0; i < reserved_mem_count; i++) {
>  		struct reserve_mem_table *map = &reserved_mem_table[i];
> +		struct page *page = phys_to_page(map->start);
> +		unsigned int nr_pages = map->size >> PAGE_SHIFT;
>  
> -		err |= kho_preserve_phys(map->start, map->size);
> +		err |= kho_preserve_pages(page, nr_pages);

Unrelated to this patch, but since there is no
kho_restore_{phys,pages}(), won't the reserve_mem memory end up with
uninitialized struct pages, since preserved pages are
memblock_reserved_mark_noinit()?

That would also be a case for kho_restore_pages() I suppose?

-- 
Regards,
Pratyush Yadav

