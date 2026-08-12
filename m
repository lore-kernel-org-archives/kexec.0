Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB8BC5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=znC2CN88BG6IQTXeBQOiLpi+lQCW+d8WSF+YoUrBydg=; b=wqSM8zFDizWEpD16B/Gr/HgdrR
	1Ii/BiB/IFo5eIlSGMq3QYOH3EJ2VHQeRUTFCVEY0iMtHOA1LPC5oty8ZdoHyEu3E/GrvvSiqQfAs
	cNBktMo/rj/pn5yXj0ln8c0PI007JssasDr0oep1clKquRiB7mT3MYWTMaOy3CRHzvP6qWDwKDS3o
	o6V4W6+v6qd+jfFhhLdhJDaIjauXjG+NZjV9d/QVhEeLBzhbld/z7vo5p6RbC/N0sUnvvzQEpCr8y
	uIK/5CCSVipS9XS6qhZV8wQp3XWAHkVPUBVvbs0th4InRvxKS5oP4KI2dCX5LlQOdyqT0C1+5VkC3
	UqGRNQ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6E0-0000000FtlH-1yGI;
	Wed, 12 Aug 2026 10:30:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6Dy-0000000Ftkp-2F4W
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 10:30:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 000D6600E2;
	Wed, 12 Aug 2026 10:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5D81F000E9;
	Wed, 12 Aug 2026 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530617;
	bh=znC2CN88BG6IQTXeBQOiLpi+lQCW+d8WSF+YoUrBydg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=g9Pj1b9ipHHG2W5U2n9DOTv9GT3WIObObGyVdg4AXrJMTok+rEBVU/yGd27pzGe5c
	 M+U9LUonA5FZR/MChw7GAMz2dR44WLdqo4V9UqTUZ75fQD1OztSVvZwOXk2jKGHEdK
	 vPvIjxARoEBj+06H5kiPp5fOXskYC4dU3sdCQfsmaoPIB5wV8QOhlrtQm8Ae8nAPHn
	 /C9wyKMIu7Syu8tKA0f7PxBIBWNGt4MzIIWY0szW++/8f5f1OKpQzYuLDc7BI2+N7W
	 I3939Qy2s8tP7lEcddCXfZ/UVBVT4qC1uDzZaqkuTRD9BrqiCACQGj/9N2Q1iZ8dR+
	 nYLEcUAy36iuQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: Pratyush Yadav <pratyush@kernel.org>,  pasha.tatashin@soleen.com,
  rppt@kernel.org,  graf@amazon.com,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kexec@lists.infradead.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 2/2] kho: unwind restored pages on
 kho_restore_vmalloc error
In-Reply-To: <20260812064428.GA144642@chenghao-pc> (Chenghao Duan's message of
	"Wed, 12 Aug 2026 14:44:28 +0800")
References: <20260807075128.542806-1-duanchenghao@kylinos.cn>
	<20260807075128.542806-3-duanchenghao@kylinos.cn>
	<2vxzcxvo518j.fsf@kernel.org> <20260812064428.GA144642@chenghao-pc>
Date: Wed, 12 Aug 2026 12:30:14 +0200
Message-ID: <2vxzzeyr3a2x.fsf@kernel.org>
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

On Wed, Aug 12 2026, Chenghao Duan wrote:

> On Tue, Aug 11, 2026 at 01:46:04PM +0200, Pratyush Yadav wrote:
>> On Fri, Aug 07 2026, Chenghao Duan wrote:
>> 
>> > In kho_restore_vmalloc(), when kho_restore_pages() succeeds, the
>> > recovered pages are handed to the buddy allocator (via
>> > adjust_managed_page_count()). If any later step (e.g.
>> > __get_vm_area_node() or vmap_pages_range()) fails, the original error
>> > path only called kvfree(pages), leaking those folio pages.
>> >
>> > Fix by tracking how many folio groups have been restored with
>> > restored_idx. On any failure, use err_unwind_restored to walk
>> > restored_idx backwards and return each folio group to the buddy via
>> > __free_pages() before freeing the pages array.
>> >
>> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
>> > ---
>> >  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++++------
>> >  1 file changed, 17 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> > index ba03ff5baa9e..ed35405f59ab 100644
>> > --- a/kernel/liveupdate/kexec_handover.c
>> > +++ b/kernel/liveupdate/kexec_handover.c
>> > @@ -1161,6 +1161,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>> >  	struct vm_struct *area;
>> >  	struct page **pages;
>> >  	unsigned int idx = 0;
>> > +	unsigned int restored_idx = 0;
>> >  	int err;
>> >  
>> >  	vm_flags = kho_flags_to_vmalloc(preservation->flags);
>> > @@ -1183,11 +1184,11 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>> >  			phys_addr_t phys = chunk->phys[i];
>> >  
>> >  			if (idx + contig_pages > total_pages)
>> > -				goto err_free_pages_array;
>> > +				goto err_unwind_restored;
>> >  
>> >  			page = kho_restore_pages(phys, contig_pages);
>> >  			if (!page)
>> > -				goto err_free_pages_array;
>> > +				goto err_unwind_restored;
>> >  
>> >  			for (int j = 0; j < contig_pages; j++)
>> >  				pages[idx++] = page + j;
>> > @@ -1195,13 +1196,14 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>> >  
>> >  		page = kho_restore_pages(virt_to_phys(chunk), 1);
>> >  		if (!page)
>> > -			goto err_free_pages_array;
>> > +			goto err_unwind_restored;
>> > +		restored_idx = idx;
>> >  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>> >  		__free_page(page);
>> >  	}
>> >  
>> >  	if (idx != total_pages)
>> > -		goto err_free_pages_array;
>> > +		goto err_unwind_restored;
>> >  
>> >  	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
>> >  				  vm_flags | VM_UNINITIALIZED,
>> > @@ -1209,7 +1211,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>> >  				  NUMA_NO_NODE, GFP_KERNEL,
>> >  				  __builtin_return_address(0));
>> >  	if (!area)
>> > -		goto err_free_pages_array;
>> > +		goto err_unwind_restored;
>> >  
>> >  	addr = (unsigned long)area->addr;
>> >  	size = get_vm_area_size(area);
>> > @@ -1231,7 +1233,16 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>> >  
>> >  err_free_vm_area:
>> >  	free_vm_area(area);
>> > -err_free_pages_array:
>> > +err_unwind_restored:
>> > +	/*
>> > +	 * Pages already restored via kho_restore_pages() have been given to
>> > +	 * the buddy allocator (via adjust_managed_page_count()). Return them
>> > +	 * to the buddy so that failure leaves the system in a clean state.
>> > +	 */
>> > +	while (restored_idx > 0) {
>> > +		restored_idx -= contig_pages;
>> > +		__free_pages(pages[restored_idx], order);
>> > +	}
>> 
>> This looks wrong. These are 0-order pages. You can't free them at order.
>
> Thanks for your review. I've looked into the preserve code. The order
> defaults to 0. When CONFIG_HAVE_ARCH_HUGE_VMALLOC is enabled and huge
> vmalloc allocation occurs (vm_flags & VM_ALLOW_HUGE_VMAP), order can be
> greater than 0.

No. Higher order pages are allocated with vmalloc_huge(), but they are
split into 0-order pages once allocated. See the split_page() call in
vm_area_alloc_pages(). kho_restore_pages() follows the same behaviour.

>
>> 
>> I sent a patch to do exactly this a while ago [0]. At the time it was
>> rejected with the below argument.
>> 
>>     Hm, I am not sure if KHO should be responsible for freeing the
>>     restored pages. We don't know the content of those pages, and what
>>     they are used for. They could be used by a hypervisor or a device.
>>     Therefore, it may be better to keep them leaked, and let the caller
>>     decide what to do next: i.e., boot into a maintenance mode, crash the
>>     kernel, or allow the leak until the next reboot.
>
> Could you advise if there is an existing solution to handle this scenario
> in the current logic? As things stand, taking the error path results in
> leakage of buddy pages.

I think the question is if we want to handle this at all. Do we want to
free the partially restored pages at all or do we just leak them and
bail? I feel we _can_ get away with freeing them, but I also see why
doing so _might_ be problematic.

>
>> 
>> Although thinking about this again, why would any device or hypervisor
>> use vmalloc buffers? They should only be used for metadata. So perhaps
>> we take another look at my patch? Pasha, what do you think?
>> 
>> [0] https://lore.kernel.org/all/20251118181811.47336-1-pratyush@kernel.org/
>> 

-- 
Regards,
Pratyush Yadav

