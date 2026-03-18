Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E2C10854BE
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 09:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4vg5DApBLnRnveNhDxPd4z30pMeAh61oVheOSKulSZc=; b=ebp/sE1lMr+MCbyHBQBWIdgW0n
	qSKO2r7l3epr0Ucj08TuKh0QTaZwj/+vgruYPewYuvwCubbosSBklvyZ+Y7ZgUsgdSh6Y5WkHoqFC
	DXR+9psh0itqkdbMbv7sNcNp/+u/2VQxSddCwSHwk7ENQhBrri7HpxvuUHIoykupUGvE1MEOMdtMb
	Sh6cdV4ABelSNuJtF0ghlloNz13m15l++/YkgDT47RFCC+tlyuiGHe77p1G5r4V4xCvUKa7Zr3Aa3
	pQWnaunhJ5/OKPR3M6On8PmmIedxRbDcI2naXbNoTKOQfYFZ7HPmlZ6Cn7R0CraVTFzZLUIGtaP4X
	ioBA2DSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2n1W-000000087FK-0BSN;
	Wed, 18 Mar 2026 09:17:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2n1Q-000000087FD-0GgZ
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 09:17:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A67E60054;
	Wed, 18 Mar 2026 09:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1BAC19421;
	Wed, 18 Mar 2026 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773825418;
	bh=xreC6OjhR8b2vuZLjpAzaLuVTmeRPkmKaKfrFoVsz/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SatqFpHz9cPpL4L9ndUa2Q6S/y7v2dDfhqXQV+g3eARqBCjHhO9MFCQ2P55gjUWul
	 g7zwGiodabII84x0E11Xosw6CTV4bb/yzmzS/LGXeM2GWyyc8SagTIXrqGbTEVPNfx
	 IU9qETigMDz7cl8RW6taGT8IXfs5eO66iraSElrf/8a4PVuBHBUZV4jCgsV1n8+8M1
	 eC5AWdLXkpaxYdtzqWW2wPvCKfZpCYxkRmLSPOkuWjmzSVdGYSFeUmX5sZem/RgdVj
	 ZQCWpMv0zTq6MuG1sMxKK0zzaxCIvICxv9NQzoDIxUXWgCufqjn/qggVhXmbxGiczg
	 mJ+i5r0WZjRwQ==
Date: Wed, 18 Mar 2026 11:16:51 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 1/3] kho: make kho_scratch_overlap usable outside
 debugging
Message-ID: <abptg2AObfxkkxKf@kernel.org>
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-2-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317141534.815634-2-mclapinski@google.com>
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

Hi Michal,

On Tue, Mar 17, 2026 at 03:15:32PM +0100, Michal Clapinski wrote:
> Also return false if kho_scratch is NULL.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  include/linux/kexec_handover.h              |  6 +++++
>  kernel/liveupdate/Makefile                  |  1 -
>  kernel/liveupdate/kexec_handover.c          | 28 ++++++++++++++++++---
>  kernel/liveupdate/kexec_handover_debug.c    | 25 ------------------
>  kernel/liveupdate/kexec_handover_internal.h |  7 ++++--
>  5 files changed, 35 insertions(+), 32 deletions(-)
>  delete mode 100644 kernel/liveupdate/kexec_handover_debug.c
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index ac4129d1d741..6a0e572c3adc 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -35,6 +35,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
>  int kho_add_subtree(const char *name, void *fdt);
>  void kho_remove_subtree(void *fdt);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
> +bool kho_scratch_overlap(phys_addr_t phys, size_t size);
>  
>  void kho_memory_init(void);
>  
> @@ -109,6 +110,11 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> +{
> +	return false;
> +}
> +
>  static inline void kho_memory_init(void) { }
>  
>  static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> index d2f779cbe279..dc352839ccf0 100644
> --- a/kernel/liveupdate/Makefile
> +++ b/kernel/liveupdate/Makefile
> @@ -7,7 +7,6 @@ luo-y :=								\
>  		luo_session.o
>  
>  obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
> -obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
>  obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
>  
>  obj-$(CONFIG_LIVEUPDATE)		+= luo.o
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 532f455c5d4f..c9b982372d6e 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -820,7 +820,8 @@ int kho_preserve_folio(struct folio *folio)
>  	const unsigned long pfn = folio_pfn(folio);
>  	const unsigned int order = folio_order(folio);
>  
> -	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
> +	if (WARN_ON(kho_scratch_overlap_debug(pfn << PAGE_SHIFT,
> +					      PAGE_SIZE << order)))

Can't say I'm fond of kho_scratch_overlap_debug(). How about we make it

	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) &&
	    WARN_ON(kho_scratch_overlap(...)) 

>  		return -EINVAL;
>  
>  	return kho_radix_add_page(tree, pfn, order);
> @@ -864,10 +865,9 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
>  	unsigned long failed_pfn = 0;
>  	int err = 0;
>  
> -	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
> -					nr_pages << PAGE_SHIFT))) {
> +	if (WARN_ON(kho_scratch_overlap_debug(start_pfn << PAGE_SHIFT,
> +					      nr_pages << PAGE_SHIFT)))

Ditto.

>  		return -EINVAL;
> -	}
>  
>  	while (pfn < end_pfn) {
>  		unsigned int order =
> @@ -1327,6 +1327,26 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  }
>  EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
>  
> +bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> +{
> +	phys_addr_t scratch_start, scratch_end;
> +	unsigned int i;
> +
> +	if (!kho_scratch)
> +		return false;
> +
> +	for (i = 0; i < kho_scratch_cnt; i++) {
> +		scratch_start = kho_scratch[i].addr;
> +		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
> +
> +		if (phys < scratch_end && (phys + size) > scratch_start)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(kho_scratch_overlap);

I don't think we need to EXPORT_SYMBOL() it and it'd better grouped with
scratch allocation functions.

> +
>  static int __init kho_mem_retrieve(const void *fdt)
>  {
>  	struct kho_radix_tree tree;

-- 
Sincerely yours,
Mike.

