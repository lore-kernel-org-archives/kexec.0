Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20E0CCFA04
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nb1bYuG05zbFdQL1R98XA+IFCzV7NinUKDDK2JN4fzI=; b=DKROhlDKFhdAebpB1vjsRSs7y1
	RNxCME5/kiJ55OcT0t4zEFFbpxgHbtWGl3+VYDuKpAKTvC3+A9mliURi3mdc/E19hhBP4Gud7+Sh6
	NEfTSnX1b7urrLwtv5//RcrA6wxlf35LLbN863Uh39nZ9rGC5YfSg0Oi4DO9oLSin/SWjfTt/ls8x
	nRiidJG7NKAW34wRTrprO5vVegpXEd9NmF3Ue+eGu7MMr4AQWwUUN3KPAr8ik64qjyBBGvgQ92BCd
	ZxppBWt1gowKWIGsSDuYojM+6mvE1nmacd/ecpYIIj+rZY7w1RIb2bi9PduiRvhaO9+rQSoCio69V
	rdh1TPhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGI4p-0000000Bz03-2ytO;
	Tue, 04 Nov 2025 14:32:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGI4o-0000000Byzl-1m8t
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 14:32:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D43C601EB;
	Tue,  4 Nov 2025 14:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD56C116B1;
	Tue,  4 Nov 2025 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762266721;
	bh=8W4axGtzep0PSa+t2A3pgDKAtbFw4XdyrfNDp7pGJnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnaL4sZQvfUoDwrR8UBqQ5So4v/ALu+u4JJclBYQEgXnbBy1fQMQxod8h80BQRPux
	 YWEvy3nrChwSkoq1bXsoyPkyl0so63krb67i2xL5N7xeslpYw7ok8e0IQvANfsGUiL
	 S+cK8pbsHqL0La+kI9pQgqUW4kS2a/2Re1Q9NIawUGMEYUVwvj/Wvrlp66w/gtF4//
	 opsJTg6nCMLJd96BsYddpZW1PyYxrqkaTBcFGvynSnd9elqBWbyjPG6Gz+otq57fK5
	 bwk8+LWv7a3zghpNBuu4fse44vxjAkY0KhdEaJfsA7gICwvoGA30Ezvc/ekZwkgpKL
	 6KEN/WRMMJtfA==
Date: Tue, 4 Nov 2025 16:31:54 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: fix unpreservation of higher-order vmalloc
 preservations
Message-ID: <aQoOWtjJWjr81lBj@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
 <20251103180235.71409-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103180235.71409-2-pratyush@kernel.org>
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

On Mon, Nov 03, 2025 at 07:02:31PM +0100, Pratyush Yadav wrote:
> kho_vmalloc_unpreserve_chunk() calls __kho_unpreserve() with end_pfn as
> pfn + 1. This happens to work for 0-order pages, but leaks higher order
> pages.
> 
> For example, say order 2 pages back the allocation. During preservation,
> they get preserved in the order 2 bitmaps, but
> kho_vmalloc_unpreserve_chunk() would try to unpreserve them from the
> order 0 bitmaps, which should not have these bits set anyway, leaving
> the order 2 bitmaps untouched. This results in the pages being carried
> over to the next kernel. Nothing will free those pages in the next boot,
> leaking them.
> 
> Fix this by taking the order into account when calculating the end PFN
> for __kho_unpreserve().
> 
> Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     When Pasha's patch [0] to add kho_unpreserve_pages() is merged, maybe it
>     would be a better idea to use kho_unpreserve_pages() here? But that is
>     something for later I suppose.
>     
>     [0] https://lore.kernel.org/linux-mm/20251101142325.1326536-4-pasha.tatashin@soleen.com/
> 
>  kernel/kexec_handover.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index cc5aaa738bc50..c2bcbb10918ce 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -862,7 +862,8 @@ static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur
>  	return NULL;
>  }
>  
> -static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
> +static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
> +					 unsigned short order)
>  {
>  	struct kho_mem_track *track = &kho_out.ser.track;
>  	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
> @@ -871,7 +872,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
>  
>  	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
>  		pfn = PHYS_PFN(chunk->phys[i]);
> -		__kho_unpreserve(track, pfn, pfn + 1);
> +		__kho_unpreserve(track, pfn, pfn + (1 << order));
>  	}
>  }
>  
> @@ -882,7 +883,7 @@ static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
>  	while (chunk) {
>  		struct kho_vmalloc_chunk *tmp = chunk;
>  
> -		kho_vmalloc_unpreserve_chunk(chunk);
> +		kho_vmalloc_unpreserve_chunk(chunk, kho_vmalloc->order);
>  
>  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>  		free_page((unsigned long)tmp);
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

