Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150B2C43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bTtHLLXkDckXLsTZ5c1jk/iglU4PY26Dt8wxlN3Kfqk=; b=T1uU0zcRwOvI8mmrPmt+HibRQS
	NSSrs86RUsUKtOGNQ7BrmV204WRdhKp08EmkDRUlX5HkWmnvDCprY7bM1X/5l226wFdrzysJZeKCO
	zgWOsqg4/v0fokNZjrlfqQe0KbeZJvjZ1Y8BP5yF5htHz+HXrc7tW23qgsd/8v2melA0PkGyd0N/5
	Or03WSLK0EVUIQOb4LD7DUrkRPm66W7sf/CW2afcjKO6oaHH0CLjJ/BZ4Cem0uj47CkE0FRACjNqy
	v0NV/tu52fVI12viTwAO1ka519rjN5x0WwzdQvCuZCDmyVMw6CwDF+1HsxFa86mNHPnKejlB6vL82
	byPo/7HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1Ab-0000000ETjE-0Lnx;
	Tue, 07 Jul 2026 08:28:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1Aa-0000000ETia-1fhW
	for kexec@lists.infradead.org;
	Tue, 07 Jul 2026 08:28:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D4AA0618A8;
	Tue,  7 Jul 2026 08:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4B91F00A3A;
	Tue,  7 Jul 2026 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412923;
	bh=bTtHLLXkDckXLsTZ5c1jk/iglU4PY26Dt8wxlN3Kfqk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=DUplStSVMjQ4eMbQb1O4U3hnTIRLMbLr+7eVVek9js6dIYtO3/cRtjHE2vV9GyzRc
	 SB2PKKP1OJ7HHAz6SFw6xObPp6N0e/gn0fyHiY/NTB7+QF7ltiwGt89ArCgiaZorES
	 4Opz3NETbD/AZV/Eq3UjOibyjjdpH3EoCHQzEyJEFhm7ycoXi4btnH8Vn6LeZU9oIC
	 tx4tkriauR/+NflqKKFHY75H7H+jRRGlqLik8nOaxmmYv+G44vOFLp57DbbSEApRj4
	 WyqsJmAAJ3MTa0Ta++TZUEU2TSzhMGdNZS3jhXcQTI9e8EZ05eDouhf8XzUc88sQe3
	 NrA/OfWrTalpQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 3/4] kho: Implement page-aware refcount restoration
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260703020832.1731864-4-praan@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <20260703020832.1731864-4-praan@google.com>
Date: Tue, 07 Jul 2026 11:28:28 +0300
Message-Id: <178341290877.3292146.335016287917708290.b4-review@b4>
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

> The KHO restoration logic currently forces a refcount of 1 on every
> page of a multi-page block. While that is correct for split pages, it
> violates the expectations of the buddy allocator for high-order
> non-compound pages allocated by kernel user (like the DMA allocator),
> where tail pages are expected to have a refcount of 0.
> 
> Update the restoration path to respect the preserved page type stored
> in the page->private metadata. For KHO_PAGE_CONTIG blocks, only the
> head page is given a reference count of 1. For KHO_PAGE_SPLIT blocks,
> every page is given a reference count of 1.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d6e81f72fe5de..f6ca5e24c7407 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -375,11 +375,18 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  }
>  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
>  
> -/* For physically contiguous 0-order pages. */
> -static void kho_init_pages(struct page *page, unsigned long nr_pages)
> +/* For physically contiguous pages. */
> +static void kho_restore_refcounts(struct page *page, unsigned long nr_pages,
> +				  enum kho_page_type type)

Why did you change the function name?
It's there to ensure proper initialization of struct pages for preserved
memory and refcount is the only part of that.

>  {
> -	for (unsigned long i = 0; i < nr_pages; i++) {
> -		set_page_count(page + i, 1);
> +	/* Head page always gets refcount of 1. */
> +	set_page_count(page, 1);
> +	clear_page_tag_ref(page);
> +
> +	for (unsigned long i = 1; i < nr_pages; i++) {
> +		unsigned int count = (type == KHO_PAGE_SPLIT) ? 1 : 0;

The count is same for all iterations, why not initialize it outside the
loop?

> +
> +		set_page_count(page + i, count);
>  		/* Clear each page's codetag to avoid accounting mismatch. */
>  		clear_page_tag_ref(page + i);
>  	}
> @@ -387,16 +394,7 @@ static void kho_init_pages(struct page *page, unsigned long nr_pages)
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
> +	kho_restore_refcounts(page, 1 << order, KHO_PAGE_CONTIG);

Ah, I see you wanted to reuse the same code for folios.
In this case you could add a helper for refcount initialization and call
it from here and from kho_init_pages().

-- 
Sincerely yours,
Mike.


