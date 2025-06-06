Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9C8C5B549
	for <kexec@archiver.kernel.org>; Fri,  6 Jun 2025 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBRokSnlcCHdaBMq6kQQ3GNFB/Ro65vdXeMklGW+M5g=; b=E6N0fvA76/+YDqMELYzxgfmtD1
	WkXILKWNSsw9RADhYtHP5Af8gJTp1btq5jrVyzNs753gZCe6k+beJPCA6jFIRFTFboxOwnXOwMHWT
	p2GDtZJYuLjbI9+HC/ePP8esd0vqnhVuWFkiKSzCymKjgIZSma3da42rdPyuLV1UsQr/iRa6cBtzD
	io4LhPP/PcvpL7McCppnNKrhQ0h8zJU91G1ek06EcWg897q+Djbg8/b824ZUC3oEHomfdc0iXlM9b
	GYfBQbvcenKPPUc3DubrstYFmNGkwsMRUmeY4+UymN1C0YIJfpEMAeQBK42xFmSb0EMbGspDWZZYH
	1OmTaEDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNS4J-0000000HN0Q-3crr;
	Fri, 06 Jun 2025 08:04:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNS4F-0000000HN05-2AKF
	for kexec@lists.infradead.org;
	Fri, 06 Jun 2025 08:04:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6940B4A658;
	Fri,  6 Jun 2025 08:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EB2C4CEEB;
	Fri,  6 Jun 2025 08:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749197086;
	bh=/eAbsE62fKUCaEC3zAvD15WyaOeeMA6jncyNVQwRldg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qV4jtDv+PQOS1Z54jDelm+RkHP6SZV4PHiNcZ7pa3FEoaNtqdWNmfGY+gApAqOlfr
	 wGx1+FACRrsQAzZ7HF9ROT3Oc5yRqgeEgYkSwrTVslT3taQMq7DRWpcBnKbjam0jkh
	 FzS4NAgwzQCOJUMLwIGww+BNzcXdv9D8Bu/UY5PY8mAeCL0jBg78dfowP/RdmO1GY/
	 8j3RSNfj4DPOJccGvQK70atOh8UnIKDqhJUl+2qw041PRIdtXhzL7igODq4SbPy5HR
	 5rPxt5E3JOIiJPjdgUc338VwGktz2mCgS5JNdfiK6ss7hQbT9oVG4g04Klb/wQr2zS
	 TmnoqI11hBOfQ==
Date: Fri, 6 Jun 2025 11:04:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Pratyush Yadav <ptyadav@amazon.de>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
Message-ID: <aEKhF3HcrvG77Ogb@kernel.org>
References: <20250605171143.76963-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605171143.76963-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_010447_597244_C8D19CAB 
X-CRM114-Status: GOOD (  28.20  )
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

On Thu, Jun 05, 2025 at 07:11:41PM +0200, Pratyush Yadav wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> Currently, when restoring higher order folios, kho_restore_folio() only
> calls prep_compound_page() on all the pages. That is not enough to
> properly initialize the folios. The managed page count does not
> get updated, the reserved flag does not get dropped, and page count does
> not get initialized properly.
> 
> Restoring a higher order folio with it results in the following BUG with
> CONFIG_DEBUG_VM when attempting to free the folio:
> 
>     BUG: Bad page state in process test  pfn:104e2b
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffffffffffffff pfn:0x104e2b
>     flags: 0x2fffff80000000(node=0|zone=2|lastcpupid=0x1fffff)
>     raw: 002fffff80000000 0000000000000000 00000000ffffffff 0000000000000000
>     raw: ffffffffffffffff 0000000000000000 00000001ffffffff 0000000000000000
>     page dumped because: nonzero _refcount
>     [...]
>     Call Trace:
>     <TASK>
>     dump_stack_lvl+0x4b/0x70
>     bad_page.cold+0x97/0xb2
>     __free_frozen_pages+0x616/0x850
>     [...]
> 
> Combine the path for 0-order and higher order folios, initialize the
> tail pages with a count of zero, and call adjust_managed_page_count() to
> account for all the pages instead of just missing them.
> 
> In addition, since all the KHO-preserved pages get marked with
> MEMBLOCK_RSRV_NOINIT by deserialize_bitmap(), the reserved flag is not
> actually set (as can also be seen from the flags of the dumped page in
> the logs above). So drop the ClearPageReserved() calls.
> 
> Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> ---
> 
> Side note: get_maintainers.pl for KHO only lists kexec@ as the mailing list.
> Since KHO has a bunch of MM bits as well, should we also add linux-mm@ to its
> MAINTAINERS entry?
> 
> Adding linux-mm@ to this patch at least, in case MM people have an opinion on
> this.
> 
>  kernel/kexec_handover.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index eb305e7e61296..5214ab27d1f8d 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  }
> 
>  /* almost as free_reserved_page(), just don't free the page */
> -static void kho_restore_page(struct page *page)
> +static void kho_restore_page(struct page *page, unsigned int order)
>  {
> -	ClearPageReserved(page);

So now we don't clear PG_Reserved even on order-0 pages? ;-)

> -	init_page_count(page);
> -	adjust_managed_page_count(page, 1);
> +	unsigned int i, nr_pages = (1 << order);

Can you please declare 'i' inside the loop, looks nicer IMHO.

> +
> +	/* Head page gets refcount of 1. */
> +	set_page_count(page, 1);

ClearPageReserved(page) here?

> +
> +	/* For higher order folios, tail pages get a page count of zero. */
> +	for (i = 1; i < nr_pages; i++)
> +		set_page_count(page + i, 0);

and here?

> +
> +	if (order > 0)
> +		prep_compound_page(page, order);
> +
> +	adjust_managed_page_count(page, nr_pages);
>  }
> 
>  /**
> @@ -179,15 +189,10 @@ struct folio *kho_restore_folio(phys_addr_t phys)
>  		return NULL;
> 
>  	order = page->private;
> -	if (order) {
> -		if (order > MAX_PAGE_ORDER)
> -			return NULL;
> -
> -		prep_compound_page(page, order);
> -	} else {
> -		kho_restore_page(page);
> -	}
> +	if (order > MAX_PAGE_ORDER)
> +		return NULL;
> 
> +	kho_restore_page(page, order);
>  	return page_folio(page);
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_folio);
> --
> 2.47.1
> 

-- 
Sincerely yours,
Mike.

