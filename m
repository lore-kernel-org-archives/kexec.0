Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8ECD72355
	for <kexec@archiver.kernel.org>; Fri, 23 Jan 2026 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HPHstnKyauJbBsO6lryFaPd+v/fRclj9G8DTiqOAAcM=; b=DhUvjOqits/kDN/FwR2Bt2IWXr
	3sozVlP6SDHkm60xJSQ0TYS9uS40i4jAtokn4N0etR9YtMzrxMu0rPuRJdDMhoRSvkOIhzeT9jepV
	xlUalp8ui8uQV7HTEMT2RMqgpjKGPuoUZt37J2+NZyEWEapW+nxScjbk4qqOwSCL2KR+gD6huJfpC
	LhhS3yqWh7068N4+9o7AuD0JF/+16rPaVOxNz3N8AEhjAYzHmEMMlatMkqRvHikOphBmCiN77rOQG
	iFOtE1Zf3cjEPLmR7shD05MiPyylSDZu7oZVg9fIAH5drTv5wR5mHX6hzPCLlkpg3fd+1h7VkOANJ
	57flJcOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjCxi-00000008VeY-39cR;
	Fri, 23 Jan 2026 08:56:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjCxh-00000008VeS-2oyu
	for kexec@lists.infradead.org;
	Fri, 23 Jan 2026 08:56:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7542A600C3;
	Fri, 23 Jan 2026 08:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51951C4CEF1;
	Fri, 23 Jan 2026 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158542;
	bh=qipa/leqAcHIoHoVIyTRuSK7iSLnI0bYyPtkyQuKOwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoJ0nypqalaeViN45nqZS61DwLJvLaxS6Va7RYXhmCPffYKzA4qdEjCMvwy+oegw3
	 aKfV7IBM1CmTPICv1FsvAfImMRMKEOCG5X7MpI/dePfmYI/JByz/LZYC0ZjrjP55Ao
	 1SLnMSBL0Ke+sW43iPtgeIe6b9D4ydUSHzhKWjeaNBWdI0tlqCKYh3EUSBhdXc6j4g
	 Syov6+OE4ubSQiSv1TfW/S9MSNsX9kLpZ7rHBdyf0+q1aYZRzbIOAAPe6UFwRdniIj
	 QulhEZGmEzx4jlQmft7zPoZK+lQp6gZSh8Julc8gkPGTBfQXKSy2OVFVJHkJx/uMUy
	 Jy70fsy4UJnYQ==
Date: Fri, 23 Jan 2026 10:55:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: ranxiaokai627@163.com
Cc: pratyush@kernel.org, surenb@google.com, akpm@linux-foundation.org,
	pasha.tatashin@soleen.com, kent.overstreet@linux.dev,
	graf@amazon.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, ran.xiaokai@zte.com.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3] kho: init alloc tags when restoring pages from
 reserved memory
Message-ID: <aXM3hgqsCaleOh8p@kernel.org>
References: <20260122132740.176468-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122132740.176468-1-ranxiaokai627@163.com>
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

On Thu, Jan 22, 2026 at 01:27:40PM +0000, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
> 
> alloc_tag was not set
> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
> RIP: 0010:___free_pages+0xb8/0x260
>  kho_restore_vmalloc+0x187/0x2e0
>  kho_test_init+0x3c4/0xa30
>  do_one_initcall+0x62/0x2b0
>  kernel_init_freeable+0x25b/0x480
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x2d1/0x360
> 
> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> fix this.
> 
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> v2 -> v3: 
>  - also call clear_page_tag_ref() for non-compound order-0 tail pages
> 
>  kernel/liveupdate/kexec_handover.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d4482b6e3cae..96767b106cac 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -255,6 +255,14 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  	if (is_folio && info.order)
>  		prep_compound_page(page, info.order);
>  
> +	/* Always mark headpage's codetag as empty to avoid accounting mismatch */
> +	clear_page_tag_ref(page);
> +	if (!is_folio) {
> +		/* Also do that for the non-compound tail pages */
> +		for (unsigned int i = 1; i < nr_pages; i++)
> +			clear_page_tag_ref(page + i);
> +	}
> +
>  	adjust_managed_page_count(page, nr_pages);
>  	return page;
>  }
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.

