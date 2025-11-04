Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4FECCFA0C
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8h3zkk6XvoyFPdG4z5IRHQ5HEXCtEyF3cXPVMqWwBU=; b=Gy0jq2EmXx7aP46e+sZvGE7K50
	fJiuROJejqI/ist++oP/tro8QJiuRKT2qMhrmPqMoYqc/You8TNP/KpSxlRZapofAw1JDExhKDYmb
	f6DDAFf6mSAHbW/PTw1bh8eadS5E7t4sjqAowcSpKQBG2aBYIGPeLBW/UHpyDDGLvLHbw+2DHTpgH
	rf2SJEluSD0YPYZKQt1g6tJp4nR65D2M512AwA1UIjnmv0I9mRDeThHqiYvWn67HRKVhW7Vwz/zI9
	rErlMkAw0r+EHLpeMqPE8ATd3cEi2KryEhnLDcyo/qwQDt7QcCj6OLU0bhJ1qp11IFM5s4FIJLmWF
	oIVi4M2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGI5d-0000000Bz6A-0Acl;
	Tue, 04 Nov 2025 14:32:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGI5a-0000000Bz5k-0Tik
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 14:32:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 511E640481;
	Tue,  4 Nov 2025 14:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6212DC116B1;
	Tue,  4 Nov 2025 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762266769;
	bh=RORlDZODXaQvDU2xYSdqK34eg3g039xujjqxDT3MR80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu/DmIlAB5Kq9YX5KdYPEScDdxOcvtnhommT7pX+0QcphEpKxyk1bEZbEyk8V0NEk
	 a0wrz3MWKZhMkalsjp3HtpQS1Eym66KN0kQm2gCu6/zd8BkRtQ+Cff5zRUZ+JpyOnZ
	 hxM3eNqaBWAsZoCe6WoOlQhhLmxyWYo7WGWF64mUjG1Z0hOQRJg7xLa8RPmtRjsJst
	 gqyR5LibszsQsOEBd3iV9M5JM2WueL0l5P4Bc7Q86iT3hTijngXJIJu5oHWXNc49YV
	 GhBxMUrUvh7aeIABcXutqnbfg1UTsicDuZUCRD1X5Fm6R+IBQGxxVKU1xJhlrJMtDA
	 HWUJvljcoDm3A==
Date: Tue, 4 Nov 2025 16:32:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: warn and exit when unpreserved page wasn't
 preserved
Message-ID: <aQoOinskO4_BzzeQ@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
 <20251103180235.71409-3-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103180235.71409-3-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_063250_169118_54C1A157 
X-CRM114-Status: GOOD (  16.69  )
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

On Mon, Nov 03, 2025 at 07:02:32PM +0100, Pratyush Yadav wrote:
> Calling __kho_unpreserve() on a pair of (pfn, end_pfn) that wasn't
> preserved is a bug. Currently, if that is done, the physxa or bits can
> be NULL. This results in a soft lockup since a NULL physxa or bits
> results in redoing the loop without ever making any progress.
> 
> Return when physxa or bits are not found, but WARN first to loudly
> indicate invalid behaviour.
> 
> Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index c2bcbb10918ce..e5fd833726226 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -167,12 +167,12 @@ static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
>  		const unsigned long pfn_high = pfn >> order;
>  
>  		physxa = xa_load(&track->orders, order);
> -		if (!physxa)
> -			continue;
> +		if (WARN_ON_ONCE(!physxa))
> +			return;
>  
>  		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> -		if (!bits)
> -			continue;
> +		if (WARN_ON_ONCE(!bits))
> +			return;
>  
>  		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
>  
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

