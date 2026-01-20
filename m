Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F29D2ECE9
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HK2XDqvr0szkHQ7whJ4JBYHd5Ew9QIOfMDRmAhXuEc=; b=0Jl97qZM9dZIqz3C2AH/QLtkjL
	yPPCbgYaAxsG1GyfTyLu0ciDY9cab1gFpCzhLHKXMM5pDKN7Azl6wztg8gcNXLPUIycj0142qCslw
	DfESQ9zLiNm7HoYmBfzshfwPy3GBssa9cp8be1yWZvWkWNMyAIHZ1MNNcaxmsGAuyVro2TIGE7Eal
	3gWS4rqErKZovkvGXF1KZfB9C5un8o485h8EXOPr/1Z0WnpICKWmhCk3YTIwsS5y8HiphgvYviuKj
	PjKlrvgt74NNQQ6zLKw1D49b2MgfWb4g4b5DhgQNeMB4godl+Lk0h8I2WYWHkxwztnOpk7jSimBzB
	+6bbsy4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viBOm-00000003t0Z-3OhD;
	Tue, 20 Jan 2026 13:03:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viBOl-00000003t0N-30zX
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 13:03:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D49AE60018;
	Tue, 20 Jan 2026 13:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C6FC16AAE;
	Tue, 20 Jan 2026 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768914234;
	bh=VjNsk+rGW49szc0ZaDC/PxUEhkP0A5D50M/kBU1Njlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjSYQTxZO9zOdD8dgFokigXt6el1iimLLAw18aUnWCJHji5YWJKX+76HBlEkC0+nm
	 shaw36qPYg7q8aymOeUc3lZgVkWU+ZuL3raurQsht2qGETyMlHKnqwl1f/1l2xOSE7
	 iiEEMdG7DRfOK6PIa5SEklmz+dMki95fKZ3WxKkzgQ9ShoxwBZ4bDZveME7VZL4SoY
	 OgiNyNxxlSRXkBaBmCB5/xXtUVHl/OrU5jFCwY1TWAblP/9hShU2Xm5skNyRpr0Aa9
	 6aK5NAYPw03LVj7OBXyWXzxMYZ1YG7auxZS7kGxuTX3RoBC9pZ7UpoE/YXaPqlD1pQ
	 aEr2k0DRRsGLg==
Date: Tue, 20 Jan 2026 15:03:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 1/2] kho: use unsigned long for nr_pages
Message-ID: <aW99NEjHAZ8n-uwW@kernel.org>
References: <20260116112217.915803-1-pratyush@kernel.org>
 <20260116112217.915803-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116112217.915803-2-pratyush@kernel.org>
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

On Fri, Jan 16, 2026 at 11:22:14AM +0000, Pratyush Yadav wrote:
> With 4k pages, a 32-bit nr_pages can span up to 16 TiB. While it is a
> lot, there exist systems with terabytes of RAM. gup is also moving to
> using long for nr_pages. Use unsigned long and make KHO future-proof.
> 
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Changes in v2:
> - New in v2.
> 
>  include/linux/kexec_handover.h     |  6 +++---
>  kernel/liveupdate/kexec_handover.c | 11 ++++++-----
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 5f7b9de97e8d..81814aa92370 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -45,15 +45,15 @@ bool is_kho_boot(void);
>  
>  int kho_preserve_folio(struct folio *folio);
>  void kho_unpreserve_folio(struct folio *folio);
> -int kho_preserve_pages(struct page *page, unsigned int nr_pages);
> -void kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
> +int kho_preserve_pages(struct page *page, unsigned long nr_pages);
> +void kho_unpreserve_pages(struct page *page, unsigned long nr_pages);
>  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
>  void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
>  void *kho_alloc_preserve(size_t size);
>  void kho_unpreserve_free(void *mem);
>  void kho_restore_free(void *mem);
>  struct folio *kho_restore_folio(phys_addr_t phys);
> -struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
> +struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
>  int kho_add_subtree(const char *name, void *fdt);
>  void kho_remove_subtree(void *fdt);
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9dc51fab604f..709484fbf9fd 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -222,7 +222,8 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> -	unsigned int nr_pages, ref_cnt;
> +	unsigned long nr_pages;
> +	unsigned int ref_cnt;
>  	union kho_page_info info;
>  
>  	if (!page)
> @@ -249,7 +250,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  	 * count of 1
>  	 */
>  	ref_cnt = is_folio ? 0 : 1;
> -	for (unsigned int i = 1; i < nr_pages; i++)
> +	for (unsigned long i = 1; i < nr_pages; i++)
>  		set_page_count(page + i, ref_cnt);
>  
>  	if (is_folio && info.order)
> @@ -283,7 +284,7 @@ EXPORT_SYMBOL_GPL(kho_restore_folio);
>   *
>   * Return: 0 on success, error code on failure
>   */
> -struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
> +struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
>  {
>  	const unsigned long start_pfn = PHYS_PFN(phys);
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> @@ -829,7 +830,7 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_preserve_pages(struct page *page, unsigned int nr_pages)
> +int kho_preserve_pages(struct page *page, unsigned long nr_pages)
>  {
>  	struct kho_mem_track *track = &kho_out.track;
>  	const unsigned long start_pfn = page_to_pfn(page);
> @@ -873,7 +874,7 @@ EXPORT_SYMBOL_GPL(kho_preserve_pages);
>   * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
>   * preserved blocks is not supported.
>   */
> -void kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> +void kho_unpreserve_pages(struct page *page, unsigned long nr_pages)
>  {
>  	struct kho_mem_track *track = &kho_out.track;
>  	const unsigned long start_pfn = page_to_pfn(page);
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Sincerely yours,
Mike.

