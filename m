Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40272C5AC67
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DPWu49UAIquK0mooC3SczFQJQjb35cm1cGYD8ZnZLE4=; b=1GaUa5iXPKrXSlqp1E1I2qayex
	8X/ffIY7Pyn1MrnUlkRkQYfFbw/hfTarDzHmqlA++NYWIYtmS0vFqk+PEWCBLoiniJebDGbh4epur
	oM4HGlYyUy+Nr39l+j/IEJwNq2fuaR5UEf9CDv36S6/cRoiMIGqIAh3PMY9FCJnp7fzUogPD9zXqb
	5vWj7f6+MqqDycAGcZmyOIrFt4FMkqP8qwZ8vBW1vSy7s6H6yUOohhsXtjXZIRIgw/Q33ezWzDH5t
	KIWboEYKVGy1WiEfD+ld2tguurOTIztQuSx2wvau++IjWroKMqanSQBRQo4qdES7W0fkwRAjBQR9i
	78Oftl5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkvq-0000000DxRY-1RLE;
	Tue, 11 Aug 2026 11:46:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkvp-0000000DxRI-0JHY
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 11:46:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C75D600AF;
	Tue, 11 Aug 2026 11:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2181F000E9;
	Tue, 11 Aug 2026 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786448767;
	bh=DPWu49UAIquK0mooC3SczFQJQjb35cm1cGYD8ZnZLE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=O0LQyHrX7jsyiG7KPdckuEvwsfNlhx8xvShxfdUKVqKOcPbsU9FWpM/0A6krX+tqb
	 LfECnN8Wssqbv5zYLvv72Pz/NuosWDlm/dvO1kT5i6FhI1746RG7E4r4yLunDR33FR
	 OTUNLVptVP3N0JQyGR509ecmhh8wKLI1yFpaZwKsTDDyUrsj8SVpiJeSK6kePHFucu
	 PmmAVOysWwyLgp4JtWpPv1lSrKDVsiTLHAF+tywocuQ1BndcjSFlQ4PRQ5k/FusNOS
	 93gezADSJsjA5xDIUF6uw1QZy3fiI2LjKDZP6xDpg1eBaZ84dTMntOZLYGpVPZ6Uhr
	 PorPSesmrdlMQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  pratyush@kernel.org,
  graf@amazon.com,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 2/2] kho: unwind restored pages on
 kho_restore_vmalloc error
In-Reply-To: <20260807075128.542806-3-duanchenghao@kylinos.cn> (Chenghao
	Duan's message of "Fri, 7 Aug 2026 15:51:28 +0800")
References: <20260807075128.542806-1-duanchenghao@kylinos.cn>
	<20260807075128.542806-3-duanchenghao@kylinos.cn>
Date: Tue, 11 Aug 2026 13:46:04 +0200
Message-ID: <2vxzcxvo518j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Aug 07 2026, Chenghao Duan wrote:

> In kho_restore_vmalloc(), when kho_restore_pages() succeeds, the
> recovered pages are handed to the buddy allocator (via
> adjust_managed_page_count()). If any later step (e.g.
> __get_vm_area_node() or vmap_pages_range()) fails, the original error
> path only called kvfree(pages), leaking those folio pages.
>
> Fix by tracking how many folio groups have been restored with
> restored_idx. On any failure, use err_unwind_restored to walk
> restored_idx backwards and return each folio group to the buddy via
> __free_pages() before freeing the pages array.
>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index ba03ff5baa9e..ed35405f59ab 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1161,6 +1161,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  	struct vm_struct *area;
>  	struct page **pages;
>  	unsigned int idx = 0;
> +	unsigned int restored_idx = 0;
>  	int err;
>  
>  	vm_flags = kho_flags_to_vmalloc(preservation->flags);
> @@ -1183,11 +1184,11 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  			phys_addr_t phys = chunk->phys[i];
>  
>  			if (idx + contig_pages > total_pages)
> -				goto err_free_pages_array;
> +				goto err_unwind_restored;
>  
>  			page = kho_restore_pages(phys, contig_pages);
>  			if (!page)
> -				goto err_free_pages_array;
> +				goto err_unwind_restored;
>  
>  			for (int j = 0; j < contig_pages; j++)
>  				pages[idx++] = page + j;
> @@ -1195,13 +1196,14 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  
>  		page = kho_restore_pages(virt_to_phys(chunk), 1);
>  		if (!page)
> -			goto err_free_pages_array;
> +			goto err_unwind_restored;
> +		restored_idx = idx;
>  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>  		__free_page(page);
>  	}
>  
>  	if (idx != total_pages)
> -		goto err_free_pages_array;
> +		goto err_unwind_restored;
>  
>  	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
>  				  vm_flags | VM_UNINITIALIZED,
> @@ -1209,7 +1211,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  				  NUMA_NO_NODE, GFP_KERNEL,
>  				  __builtin_return_address(0));
>  	if (!area)
> -		goto err_free_pages_array;
> +		goto err_unwind_restored;
>  
>  	addr = (unsigned long)area->addr;
>  	size = get_vm_area_size(area);
> @@ -1231,7 +1233,16 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  
>  err_free_vm_area:
>  	free_vm_area(area);
> -err_free_pages_array:
> +err_unwind_restored:
> +	/*
> +	 * Pages already restored via kho_restore_pages() have been given to
> +	 * the buddy allocator (via adjust_managed_page_count()). Return them
> +	 * to the buddy so that failure leaves the system in a clean state.
> +	 */
> +	while (restored_idx > 0) {
> +		restored_idx -= contig_pages;
> +		__free_pages(pages[restored_idx], order);
> +	}

This looks wrong. These are 0-order pages. You can't free them at order.

I sent a patch to do exactly this a while ago [0]. At the time it was
rejected with the below argument.

    Hm, I am not sure if KHO should be responsible for freeing the
    restored pages. We don't know the content of those pages, and what
    they are used for. They could be used by a hypervisor or a device.
    Therefore, it may be better to keep them leaked, and let the caller
    decide what to do next: i.e., boot into a maintenance mode, crash the
    kernel, or allow the leak until the next reboot.

Although thinking about this again, why would any device or hypervisor
use vmalloc buffers? They should only be used for metadata. So perhaps
we take another look at my patch? Pasha, what do you think?

[0] https://lore.kernel.org/all/20251118181811.47336-1-pratyush@kernel.org/

>  	kvfree(pages);
>  	return NULL;
>  }

-- 
Regards,
Pratyush Yadav

