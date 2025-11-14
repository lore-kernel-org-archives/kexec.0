Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82757CE8D60
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P85Bi3ZKtQRZnB23RdIsa8lwhMvYUwZo2MtEJouVc8U=; b=V1HVq4t5lPI7HV6RQiBDMl60tA
	cMSUZV5RbJKmm7c2gqxSUphl6vUpptVTR83JKJEiqogDCRNFEmdcb2q6UllljKLTi+uIqPT0CQk9Y
	GUzbXMVWIt5A31FCyLpzxCbZOA+GOt9EADZqT8ri3hoaxcc5qU7DjlVNaYxHYshE00DRITAlUXiGE
	C3dy8U7+WiIpPt9QeoGn/PDdGQ3+uSNAs7DpU9afvi6WhV9iUiGt5BKBm/Oy/IxYuTLfefl/mP02c
	5j4HYAaJkbdjS7uFvNbi+9+JtdtBhuv1AwqQGEnFLL06Mexpkg3rUReSkjjjs5VC/V9KzpBZBY48M
	pWAhpWkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxg7-0000000Cr27-42lp;
	Fri, 14 Nov 2025 17:33:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxg5-0000000Cr1l-140S
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:33:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F3C7436B6;
	Fri, 14 Nov 2025 17:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DDAC4CEF1;
	Fri, 14 Nov 2025 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763141618;
	bh=xiOmpAH22LBPrHl3S2bglBGW7v5HJxbVPsI9S3i0sCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WO8IcdGXQ0Tc67QzXNWENs/BXaSCO+3Ot1YABbffhiA/Howp0f1asS2WJ2hTHFol6
	 2+0mylwMssClZNggRszcaeyQA3lzVdacjpZ26hZ444vOwuWIa0gHSefxSNYM2rxkyW
	 G12fyasFzCVdPS0pAW6JmCaLYYbiC2S7KRUcjMdZEapajKk9XBkyznNBsKu5U4AHZD
	 BQ0WxH4g1bB1fOO8CX67HpxY6wzgifK0xiGcHzg5kqfX6b8xI7HsRZONHAv4STd0A2
	 W6TnzvubponvquD2Ryd/MeCJlamvEFPworipOdoXNEXWFg+pXCw8xM2oGaQ/NBkdt6
	 gfLooe6TTju1w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 11/13] kho: Allow memory preservation state updates
 after finalization
In-Reply-To: <20251114155358.2884014-12-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:56 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-12-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:33:35 +0100
Message-ID: <mafs0zf8o5xjk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_093341_356701_101BBFAD 
X-CRM114-Status: GOOD (  18.09  )
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, kho_preserve_* and kho_unpreserve_* return -EBUSY if
> KHO is finalized. This enforces a rigid "freeze" on the KHO memory
> state.
>
> With the introduction of re-entrant finalization, this restriction is
> no longer necessary. Users should be allowed to modify the preservation
> set (e.g., adding new pages or freeing old ones) even after an initial
> finalization.
>
> The intended workflow for updates is now:
> 1. Modify state (preserve/unpreserve).
> 2. Call kho_finalize() again to refresh the serialized metadata.
>
> Remove the kho_out.finalized checks to enable this dynamic behavior.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 27ef20565a5f..87e9b488237d 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -183,10 +183,6 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  	const unsigned long pfn_high = pfn >> order;
>  
>  	might_sleep();
> -
> -	if (kho_out.finalized)
> -		return -EBUSY;
> -
>  	physxa = xa_load(&track->orders, order);
>  	if (!physxa) {
>  		int err;
> @@ -815,9 +811,6 @@ int kho_unpreserve_folio(struct folio *folio)

This can be void now. This would make consumers a bit simpler, since
right now, the memfd preservation logic does a WARN_ON() if this
function fails. That can be dropped now that the function can never
fail.

Same for kho_unpreserve_pages() and kho_unpreserve_vmalloc().

>  	const unsigned int order = folio_order(folio);
>  	struct kho_mem_track *track = &kho_out.track;
>  
> -	if (kho_out.finalized)
> -		return -EBUSY;
> -
>  	__kho_unpreserve_order(track, pfn, order);
>  	return 0;
>  }
> @@ -885,9 +878,6 @@ int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
>  	const unsigned long start_pfn = page_to_pfn(page);
>  	const unsigned long end_pfn = start_pfn + nr_pages;
>  
> -	if (kho_out.finalized)
> -		return -EBUSY;
> -
>  	__kho_unpreserve(track, start_pfn, end_pfn);
>  
>  	return 0;
> @@ -1066,9 +1056,6 @@ EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
>   */
>  int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
>  {
> -	if (kho_out.finalized)
> -		return -EBUSY;
> -
>  	kho_vmalloc_free_chunks(preservation);
>  
>  	return 0;

-- 
Regards,
Pratyush Yadav

