Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE61C5B567
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 06:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eh6eLhQmtQhniW+fbZTdsAuMJIxtRsDQYFqV7o5anTE=; b=ZMH+ZRRylUwWxdWeej/USgFPvi
	0LbRpctby6uUA9pxC+qhmAOaC3pcGEozzX5rAKl3RxleCFububRehXjAI/Ko0X0naOFB9EQNG56q5
	tHXyAbo34tqIQUAtg8alFiLK5eyRJI870ZGNKvK8yQ8hKJ3Dius03724djddGcy8eQG0tTd5xFRZd
	Rakb928Nt1aDq3PVlXybFfe22UvR0f7H2Ad2/3hZVGc1+G2kj6dVsxG4ovaLIFOydwr3Oj2GYoEsF
	z+ZyvPiyyPZqblRu5hlF/yVVer7b8z9Dhf0QQF630dznuy1WSy7gTBhxKFwh8IpyDEZAgZhT3MbJU
	XMwyWXDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu2hn-0000000FX0Y-3Vcd;
	Wed, 12 Aug 2026 06:44:51 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu2hk-0000000FWzq-4484
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 06:44:50 +0000
X-UUID: 456bcc9e961911f1aa26b74ffac11d73-20260812
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:37e11bf3-1a9c-4db9-9fdc-35547f909246,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:37e11bf3-1a9c-4db9-9fdc-35547f909246,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:cefc1da37ade92827dbe03e95d4a7c84,BulkI
	D:2608121444354N6M416F,BulkQuantity:0,Recheck:0,SF:10|64|66|78|80|81|82|83
	|102|127|136|841|850|865|898,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:
	99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 456bcc9e961911f1aa26b74ffac11d73-20260812
X-User: duanchenghao@kylinos.cn
Received: from localhost [(106.37.134.166)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1229026213; Wed, 12 Aug 2026 14:44:30 +0800
Date: Wed, 12 Aug 2026 14:44:28 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: pasha.tatashin@soleen.com, rppt@kernel.org, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kexec@lists.infradead.org, jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 2/2] kho: unwind restored pages on kho_restore_vmalloc
 error
Message-ID: <20260812064428.GA144642@chenghao-pc>
References: <20260807075128.542806-1-duanchenghao@kylinos.cn>
 <20260807075128.542806-3-duanchenghao@kylinos.cn>
 <2vxzcxvo518j.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2vxzcxvo518j.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_234449_339946_6D5622EC 
X-CRM114-Status: GOOD (  31.77  )
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

On Tue, Aug 11, 2026 at 01:46:04PM +0200, Pratyush Yadav wrote:
> On Fri, Aug 07 2026, Chenghao Duan wrote:
> 
> > In kho_restore_vmalloc(), when kho_restore_pages() succeeds, the
> > recovered pages are handed to the buddy allocator (via
> > adjust_managed_page_count()). If any later step (e.g.
> > __get_vm_area_node() or vmap_pages_range()) fails, the original error
> > path only called kvfree(pages), leaking those folio pages.
> >
> > Fix by tracking how many folio groups have been restored with
> > restored_idx. On any failure, use err_unwind_restored to walk
> > restored_idx backwards and return each folio group to the buddy via
> > __free_pages() before freeing the pages array.
> >
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index ba03ff5baa9e..ed35405f59ab 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -1161,6 +1161,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> >  	struct vm_struct *area;
> >  	struct page **pages;
> >  	unsigned int idx = 0;
> > +	unsigned int restored_idx = 0;
> >  	int err;
> >  
> >  	vm_flags = kho_flags_to_vmalloc(preservation->flags);
> > @@ -1183,11 +1184,11 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> >  			phys_addr_t phys = chunk->phys[i];
> >  
> >  			if (idx + contig_pages > total_pages)
> > -				goto err_free_pages_array;
> > +				goto err_unwind_restored;
> >  
> >  			page = kho_restore_pages(phys, contig_pages);
> >  			if (!page)
> > -				goto err_free_pages_array;
> > +				goto err_unwind_restored;
> >  
> >  			for (int j = 0; j < contig_pages; j++)
> >  				pages[idx++] = page + j;
> > @@ -1195,13 +1196,14 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> >  
> >  		page = kho_restore_pages(virt_to_phys(chunk), 1);
> >  		if (!page)
> > -			goto err_free_pages_array;
> > +			goto err_unwind_restored;
> > +		restored_idx = idx;
> >  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> >  		__free_page(page);
> >  	}
> >  
> >  	if (idx != total_pages)
> > -		goto err_free_pages_array;
> > +		goto err_unwind_restored;
> >  
> >  	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
> >  				  vm_flags | VM_UNINITIALIZED,
> > @@ -1209,7 +1211,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> >  				  NUMA_NO_NODE, GFP_KERNEL,
> >  				  __builtin_return_address(0));
> >  	if (!area)
> > -		goto err_free_pages_array;
> > +		goto err_unwind_restored;
> >  
> >  	addr = (unsigned long)area->addr;
> >  	size = get_vm_area_size(area);
> > @@ -1231,7 +1233,16 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> >  
> >  err_free_vm_area:
> >  	free_vm_area(area);
> > -err_free_pages_array:
> > +err_unwind_restored:
> > +	/*
> > +	 * Pages already restored via kho_restore_pages() have been given to
> > +	 * the buddy allocator (via adjust_managed_page_count()). Return them
> > +	 * to the buddy so that failure leaves the system in a clean state.
> > +	 */
> > +	while (restored_idx > 0) {
> > +		restored_idx -= contig_pages;
> > +		__free_pages(pages[restored_idx], order);
> > +	}
> 
> This looks wrong. These are 0-order pages. You can't free them at order.

Thanks for your review. I've looked into the preserve code. The order
defaults to 0. When CONFIG_HAVE_ARCH_HUGE_VMALLOC is enabled and huge
vmalloc allocation occurs (vm_flags & VM_ALLOW_HUGE_VMAP), order can be
greater than 0.

> 
> I sent a patch to do exactly this a while ago [0]. At the time it was
> rejected with the below argument.
> 
>     Hm, I am not sure if KHO should be responsible for freeing the
>     restored pages. We don't know the content of those pages, and what
>     they are used for. They could be used by a hypervisor or a device.
>     Therefore, it may be better to keep them leaked, and let the caller
>     decide what to do next: i.e., boot into a maintenance mode, crash the
>     kernel, or allow the leak until the next reboot.

Could you advise if there is an existing solution to handle this scenario
in the current logic? As things stand, taking the error path results in
leakage of buddy pages.

Regards,
Chenghao Duan

> 
> Although thinking about this again, why would any device or hypervisor
> use vmalloc buffers? They should only be used for metadata. So perhaps
> we take another look at my patch? Pasha, what do you think?
> 
> [0] https://lore.kernel.org/all/20251118181811.47336-1-pratyush@kernel.org/
> 
> >  	kvfree(pages);
> >  	return NULL;
> >  }
> 
> -- 
> Regards,
> Pratyush Yadav

