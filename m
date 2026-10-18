Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E3BCCF2C9
	for <kexec@archiver.kernel.org>; Sun, 18 Oct 2026 04:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DYBq7xeKvEEfhwWtcg1/NmSK9WIDoGWbifeYKQ6iaPU=; b=2+jJXpOejIbUBLrhId6dtJR4Jd
	y53j3336l7KSe50qvoLNUBYEe0MV8gbESb2zoIbfKhKDHFU7g9/QS9DShbAoaU5GkQwKT9PwK5/0A
	s+qEUccYx7ZeuWnqaBLpmXGrjqlvrKHTDOwZhg3o6dcmHBBMgTDiDzBhdf5wMocM6K74ZYF34JsJP
	F7YAywLalT5PM1vigV+5ovtoLDCPFGjjmN6chpl1EuL6rvEfAZbRll0pk7+k/sebJaksK4A9XBI8K
	e9YYIpX9rhsuiCRfXzQUapTFNF1MZBgIQDSr6DNMAeDbNP5S7oDiivVcLjlO1xaakrLFqDrvuhzK1
	T0EmnK3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIIYb-00000005Wjk-3U82;
	Sun, 18 Oct 2026 04:31:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIIYX-00000005WjQ-0Z6z
	for kexec@lists.infradead.org;
	Sun, 18 Oct 2026 04:31:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9610A423BF;
	Sun, 18 Oct 2026 04:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750251F000C6;
	Sun, 18 Oct 2026 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792297892;
	bh=DYBq7xeKvEEfhwWtcg1/NmSK9WIDoGWbifeYKQ6iaPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mb9BXWxt88MpB9qYnzbH95e1QrRQzxEiEgi7/2F/8hxj4Nvv6oj2/BHBk3Qm4gqWL
	 GWeQP4oq2b0cRa2vq/YWt+VON52QmcgZEKdFhblV4sG21cPhx+3wEiJL7g1rSNBGWZ
	 DOZEbwSUVAdSZaOr+LHmaj0c+P27fOkNdwnZBKUVKBPukBo5ykBFnYtk4P3++breFR
	 YZGcdhdHz4Cl+8ot9hRaARiYvlfxC5HqpAX3YTCviIkNyGZ8iborIKNboR1PAQKiyL
	 zuVTGaL39gigLDweKWhWXmrbSyUlNv6nhWP+3qMkdZIIEuciRIZYaqsahz6mAOn8+W
	 LWEfQ2qVRcwDw==
Date: Sun, 18 Oct 2026 07:31:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Federico Parola <fparola@amazon.de>
Cc: stable@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH 6.18.y 2/2] kho: free phys_bits bitmaps using free_page()
 in __kho_abort()
Message-ID: <atRLncxeTcA2dRD6@kernel.org>
References: <20261015144529.76911-1-fparola@amazon.de>
 <20261015144529.76911-3-fparola@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015144529.76911-3-fparola@amazon.de>
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

On Thu, Oct 15, 2026 at 02:45:29PM +0000, Federico Parola wrote:
> Commit fa759cd75bce ("kho: allocate metadata directly from the buddy
> allocator") switched the allocation of preserved memory bitmaps to
> get_zeroed_page(), but __kho_abort() still releases them with kfree().
> kfree() on a buddy page that is not a large kmalloc allocation hits the
> WARN_ON_ONCE() in free_large_kmalloc() and returns without freeing it,
> so every aborted finalization leaks all bitmap pages.
> 
> Free the bitmaps with free_page() instead.
> 
> This is a stable-only patch. Upstream fixed it as a side effect of
> commit 99cd2ffac697 ("kho: don't unpreserve memory during abort"), which
> removes the tracking teardown from __kho_abort() altogether. That change
> builds on commit 36f8f7ef7fd2 ("kho: add interfaces to unpreserve
> folios, page ranges, and vmalloc") and commit 70f9133096c8 ("kho: drop
> notifiers"). In 6.18.y, KHO users still preserve memory from the
> KEXEC_KHO_FINALIZE notifier and have no interface to unpreserve it, so
> the teardown on abort is the only way their preservations get dropped.
> Backporting that commit would make preservations outlive every abort,
> so keep the teardown and fix only the mismatched free.
> 
> Fixes: fa759cd75bce ("kho: allocate metadata directly from the buddy allocator")
> Signed-off-by: Federico Parola <fparola@amazon.de>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 9fe5d14f1ec54..9691f6bc2fba7 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1054,7 +1054,7 @@ static int __kho_abort(void)
>  		unsigned long phys;
>  
>  		xa_for_each(&physxa->phys_bits, phys, bits)
> -			kfree(bits);
> +			free_page((unsigned long)bits);
>  
>  		xa_destroy(&physxa->phys_bits);
>  		kfree(physxa);
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

