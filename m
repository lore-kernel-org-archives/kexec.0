Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BDDCD4F25
	for <kexec@archiver.kernel.org>; Sat, 16 May 2026 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2w+A10RNn3haPdSCgGA8e51o+4+IUVl1uiDV7wnVml8=; b=J3SCeD+myVtPN2iX5kY4MLA2aN
	2zhK2WtcyDVwdp767Ckn2XEJPhd/J+j1KvVwTx6ovO1nrRrhRMmAVPZL57tUAZ/Ex6i8oAVlch3O6
	WYpLBj1GPRKRl/ELZQiR1NWepTy4ZQkR3UTt4st0+ccqmgTz9iknxoA/YaonAvNUb8AJ23J7vgvEV
	RMJ6qerK/wCiR02QS6N89+ud8pwMd0/eyT+5RyeXGFYCX3EBVIzzJM2V3HbysETPY4ylAwulFtRWg
	B3G1C+Oj8fCevgyMFoH97+wsDvsWMYtLKhS8ZD6CMA/iox7Q6YJ7g+7fcFmxGcLyKcBZQUahT3MjZ
	xg27bgfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO9cm-0000000AMwR-0Mqm;
	Sat, 16 May 2026 07:39:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO9cl-0000000AMw3-08R1
	for kexec@lists.infradead.org;
	Sat, 16 May 2026 07:39:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 21DBD60138;
	Sat, 16 May 2026 07:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A082C19425;
	Sat, 16 May 2026 07:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778917189;
	bh=9s5hcQU1qJOng7EpP/1GD0C/FrCAs0eJD5DJJG+YdWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOcGyOP3uRqRREsFCbj4kXH8iRAplLOSa9T+BwriiMyUVZeM+FfujrtfK2JKkSINy
	 SSWvrbC0Kuv8LsFRvtH3OrIRSdrrenlj56oLuZviMLTO009t1uXT54+CY6bj52Q9YJ
	 jX7dJRSJJf1rQuG7sVEFRL7OB4xaE00YsZDR0AnA6/IYwySA04l5XmeVJwOl1FoVVv
	 t9h7//o80okplijw+v2OJpIWSUs7Dql1EmKoqpNNwENUmwpYvMo7qWrvwUTZGRoA07
	 d0zVHd53GPaaX0UFCr9jMyhqrZ0c8s4B0lgoZp0AV9E5NOayydAJqrTb7zL5lpYaWv
	 J1lUcJCNSx46A==
Date: Sat, 16 May 2026 10:39:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] kho: Add kunit static stubs
Message-ID: <aggfP-0A-i-bYlP7@kernel.org>
References: <20260512195135.804833-1-skhawaja@google.com>
 <20260512195135.804833-2-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512195135.804833-2-skhawaja@google.com>
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

Hi Sami,

On Tue, May 12, 2026 at 07:51:33PM +0000, Samiullah Khawaja wrote:
> Add kunit stubs in kho_restore_folio() and kho_restore_pages() so the
> users can mock these functions in kunit tests.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d5718bef6d4d..1375291d9b07 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -11,6 +11,7 @@
>  #define pr_fmt(fmt) "KHO: " fmt
>  
>  #include <linux/cleanup.h>
> +#include <kunit/static_stub.h>

Can we include kunit headers before linux headers?

>  #include <linux/cma.h>
>  #include <linux/kmemleak.h>
>  #include <linux/count_zeros.h>
> @@ -437,7 +438,11 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>   */
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
> -	struct page *page = kho_restore_page(phys, true);
> +	struct page *page;
> +
> +	KUNIT_STATIC_STUB_REDIRECT(kho_restore_folio, phys);
> +
> +	page = kho_restore_page(phys, true);
>  
>  	return page ? page_folio(page) : NULL;
>  }
> @@ -459,6 +464,8 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
>  	const unsigned long end_pfn = start_pfn + nr_pages;
>  	unsigned long pfn = start_pfn;
>  
> +	KUNIT_STATIC_STUB_REDIRECT(kho_restore_pages, phys, nr_pages);
> +
>  	while (pfn < end_pfn) {
>  		const unsigned int order =
>  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

-- 
Sincerely yours,
Mike.

