Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC24ACD6E79
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ns7tVcW9XWyLcZvttsJ0K9GITGIgrVGAf3TGrFOv8Tc=; b=LWe7W8Hv3nqdGkbQxIki0ljU+U
	cG8+DmSTViuwiLysG2WWhLnRoIKjOCM8UWweFZLzWBPnLvhmFEJ2+HypF6BrDA9DXBeUAQ0jomzMn
	XXAwwL6IJoLNREUv37qux7dgdhTiIMS5OV2cTuLPDlAmgL9oRqSLJutaC+yGrjBy9n2MGHO1cKvSm
	bY8mqhXJ9bDezE/rOgsfIhIfNeGyrovGDbd81Dejz8eTPrwabqWEnSejyCcrQSE1eEc1NZHGzLkf1
	lmMaM5fkDzomChVkuU48AiAaY0gtPvEOg9ugUt7io+qdOJYcSFWDVyoyzr3mrJGXxPdakbHd4FdX7
	/jnisBnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWg4M-00000004KPG-3NbI;
	Mon, 08 Jun 2026 19:55:34 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWg4J-00000004KOq-3pmp
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 19:55:33 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-133362c30cfso33854c88.0
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780948530; x=1781553330; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ns7tVcW9XWyLcZvttsJ0K9GITGIgrVGAf3TGrFOv8Tc=;
        b=HLGVmRkZX7krTZ2EUhF3GuHorVTEnXafz1WuCND+9NU4YqqMEM9xCHKb5+2xPvO5JE
         yXRD4IrS+LDOw8pu32H27HbqwY3HmKh0tv15UgoqielF1QY+HYepjcxyK7X6yPEwyHPG
         AwFjxlHXa42+2ORFdIgPpHDny8JA2KeJqsIGwxtAk5i4EzRncEEOPWGh6EnhlOIwevOH
         6rGkOZwXQvuXSk0lcNhIXioySkGtcjVb71mc7/2Ce26MLaYIPbOIaj5COboyrrLhUNjg
         EytEpOMbvpNTHjt0CMpepuGKKeGTOpQpBrX1FcqG7VAfRKqslMMpl44Rpnl/K/ShiUxK
         Idhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948530; x=1781553330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns7tVcW9XWyLcZvttsJ0K9GITGIgrVGAf3TGrFOv8Tc=;
        b=W1mozuX+96y27QNBv9XCWwXkbFJno8/rZ88fTP/1dk+mDHAAnmrcF+qMHAAxxjyUXV
         0bb7+Gjrn6ZCSTdy6XYL/AAd+svAZFli8SdM/CBIEoeIqD6tknaQ30zKz7m37ZVMRLRD
         mUQmwM267PFD8LUmnndjueND8tydY0TUNKtimkjLOONWqdKY9eNDcBEcKHzejDtFpJOQ
         J0a8mA7bTpJ4OWd7fYlGx2mxTNXemVYJk+J27+gtfgghLoTRRNBQwkb6Imau4+wAghb7
         AoQJzZi5OZdXBNULQ+h58Y54hKJV2EVerKAwvfXOJfYxyE6WOFQKsXnEx779bGmY16Cw
         CfrA==
X-Forwarded-Encrypted: i=1; AFNElJ8Mhy0n4GefWKpzgb/rh0/zb0wH1w6MN9V126zypWBnFSEZzobmJH+CP3OjbwlXVhZY7reaFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YygWNB1YS+d7pcLHJmntwqez0RhN869YlMafrISLqHli43vyvZk
	OwQ15/DqFK2G+Z4WkQ1R1Ttk3PQ5rIf10mUHh+YOgiRKIGIQrTN9lFmnHN9PQp1o0A==
X-Gm-Gg: Acq92OE9djc2qx1LJldgmN05Gd5MqSOFJeZNBixvIR5Hi/zUbFwDO29KWTrnsIMHTXy
	sxnYqwjW5DvVaQl5rHtSRScvDSjA858coxjWjf962EdV9zN2ddLGNw9i0jMS1BUrGmcB7NltPwl
	TvVFSBZsYmM8d/dl+qMn+f+pF5q4pk1BT4y2KL0v6RKyi6MBRb52czBzoMMbDq4tlq2O6tTdyGy
	2fJ825EonU4qnLf6tK53pypRjrzfdnSBY4D4MCJLSg/RJgatNqPEzY5pQnebt+iLXMVAfKxTBZB
	lEYqMy+AUcoJEvM+IRARA7kcacMTCBDcgHl6ev73rh1U8wFmk0y3+O83SgTgITwk6axBjm+tsMe
	lIEt76Q70thU+3DFFU3iqfzsXYSLTWWB08NfTcvkg7Kto7MhEVmKqk4nxPaWV4Ml5S2x2KNXPu8
	tJA5y3tzAnFMqu2lqy1v9c5m6U3twwcTOEFpzE8VdBDXZqoZd/yf7tKoyNxEAF9s9Ie4Nz2/I=
X-Received: by 2002:a05:7022:170e:b0:138:888:e99d with SMTP id a92af1059eb24-1380888eb22mr103345c88.32.1780948529234;
        Mon, 08 Jun 2026 12:55:29 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f6381fsm9666160eec.0.2026.06.08.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:55:28 -0700 (PDT)
Date: Mon, 8 Jun 2026 19:55:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <aiceKYmc323G7tBs@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-4-skhawaja@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_125531_967856_6DB36A9F 
X-CRM114-Status: GOOD (  36.12  )
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

On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
> Add an API to preserve/restore the DMA direct allocation for liveupdate.
> The underlying memory is preserved/restored using KHO. During restore
> the memory is setup based on the device configuration, gfp flags and
> allocation attributes. Once restored, the driver can use the usual
> dma_free* API to deallocate the restored DMA allocation.
> 
> This API will be used to add support in dma_alloc* APIs to
> preseve/restore the DMA allocations.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/dma-direct.h |  29 +++++++
>  kernel/dma/Kconfig         |   3 +
>  kernel/dma/direct.c        | 163 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
> 

[...]

> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index bfef21b4a9ae..d92852942c6c 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -265,3 +265,6 @@ config DMA_MAP_BENCHMARK
>  	  performance of dma_(un)map_page.
>  
>  	  See tools/testing/selftests/dma/dma_map_benchmark.c
> +
> +config DMA_LIVEUPDATE
> +	bool "Enable preservation of DMA direct allocations"

Nit: depends on LIVEUPDATE?

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..c2b98f91900a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -6,6 +6,8 @@
>   */
>  #include <linux/memblock.h> /* for max_pfn */
>  #include <linux/export.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/dma_alloc.h>
>  #include <linux/mm.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/scatterlist.h>
> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_DMA_LIVEUPDATE
> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
> +				   size_t size, dma_addr_t dma_handle,
> +				   unsigned long attrs, u64 *state)
> +{
> +	struct dma_alloc_ser *ser;
> +	int ret;
> +
> +	if (!kho_is_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_CMA))
> +		return -EOPNOTSUPP;
> +
> +	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> +	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
> +	    !dev_is_dma_coherent(dev) &&
> +	    !is_swiotlb_for_alloc(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> +	    !dev_is_dma_coherent(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> +	    dma_is_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
> +		return -EOPNOTSUPP;
> +
> +	ser = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);
> +
> +	ser->page_phys = dma_to_phys(dev, dma_handle);
> +	ser->force_decrypted = force_dma_unencrypted(dev);
> +	ser->size = size;
> +
> +	ret = kho_preserve_pages(phys_to_page(ser->page_phys),
> +				 size >> PAGE_SHIFT);

Should this be `PAGE_ALIGN(size) >> PAGE_SHIFT` OR 
`DIV_ROUND_UP(size, PAGE_SIZE)`?

Otherwise, if size is small, say, size == 64-bytes, we preserve 0 pages?

Also, IIRC, even with PAGE_ALIGN, preserving just the requested pgcount
is not enough because buddy allocator allocates in order-N.

For e.g. if a driver requests 20KB (5 pages), the buddy allocator 
fulfills it with an order-3 block (8 pages).

Now, if we only tell KHO to preserve 5 pages, the remaining 3 pages are 
free in the new kernel. When the driver eventually tears down and calls
dma_free_coherent(), dma_direct_free() will call 
__free_pages(page, get_order(size)), which will attempt to free all 8 
pages, causing a double-free panic on the 3 unpreserved pages?

Should we be preserving exactly 1 << get_order(size) pages as per buddy?
Same applies to unpreserve, and restore.

> +	if (ret) {
> +		kho_unpreserve_free(ser);
> +		return ret;
> +	}
> +
> +	*state = virt_to_phys(ser);
> +	return 0;
> +}
> +
> +void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
> +{
> +	struct dma_alloc_ser *ser;
> +
> +	if (!kho_is_enabled())
> +		return;
> +
> +	ser = phys_to_virt(state);
> +	kho_unpreserve_pages(phys_to_page(ser->page_phys),
> +			     ser->size >> PAGE_SHIFT);
> +	kho_unpreserve_free(ser);
> +}
> +
> +void *dma_direct_restore_allocation(struct device *dev, size_t size,
> +				    dma_addr_t *dma_handle, gfp_t gfp,
> +				    unsigned long attrs, u64 state)

Are we relying on the caller to pass same attrs? So, a buffer with 
non-coherent attrs can be mapped with coherent attrs in the new kernel.
Could this cause side-effects? Should we check for such driver bugs with
a WARN here while comparing older attrs with the newer ones too?

Coherency breaking due to subtle driver bugs is very painful to debug :/

> +{
> +	bool remap = false, set_uncached = false;
> +	struct dma_alloc_ser *ser = NULL;
> +	struct page *page;
> +	void *cpu_addr;
> +
> +	if (!kho_is_enabled())
> +		return NULL;
> +
> +	ser = phys_to_virt(state);
> +	page = phys_to_page(ser->page_phys);

[...]

> +
> +	/*
> +	 * Remapping will be blocking so return error. The preserved memory
> +	 * might be already decrypted in the previous kernel, but the decryption
> +	 * call is not guaranteed to be non-blocking so return error always if
> +	 * decryption is required.
> +	 */
> +	if ((remap || force_dma_unencrypted(dev)) &&
> +	    dma_direct_use_pool(dev, gfp))
> +		return NULL; 
> +
> +	/*
> +	 * Encryption scheme changed between two kernels and this might cause
> +	 * issues if device/driver is not handling it properly.
> +	 */
> +	WARN_ON_ONCE(ser->force_decrypted != force_dma_unencrypted(dev));
> +
> +	/*
> +	 * arch_dma_prep_coherent() should make sure that any cache lines from
> +	 * the previous kernel, if the device was coherent previously or cached
> +	 * mapping in this kernel during init are not problamatic for
> +	 * non-coherent allocations.
> +	 */
> +	if (remap) {
> +		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
> +
> +		if (force_dma_unencrypted(dev))
> +			prot = pgprot_decrypted(prot);
> +
> +		arch_dma_prep_coherent(page, size);
> +
> +		cpu_addr = dma_common_contiguous_remap(page, size, prot,
> +						       __builtin_return_address(0));
> +		if (!cpu_addr)
> +			return NULL;

Should we be kho_restore_free-ing on all these error paths?
We only seem to be kho_restore_free-ing on the success path.
Same for kho_restore_pages.. if we return an error here, we don't
restore the preserved pages? Are we leaking those too?

> +	} else {
> +		cpu_addr = page_address(page);
> +		if (dma_set_decrypted(dev, cpu_addr, size))
> +			return NULL;
> +	}
> +
> +	if (set_uncached) {
> +		arch_dma_prep_coherent(page, size);
> +		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
> +		if (IS_ERR(cpu_addr))
> +			return NULL;
> +	}
> +
> +	*dma_handle = phys_to_dma_direct(dev, ser->page_phys);
> +
> +	/*
> +	 * Cannot free the restored pages on error here as these might be in use
> +	 * by a device with direct allocation in the previous kernel.
> +	 */
> +	WARN_ON(!kho_restore_pages(ser->page_phys,
> +				   ser->size >> PAGE_SHIFT));
> +	kho_restore_free(ser);
> +	return cpu_addr;
> +}
> +#endif
> +
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {

Thanks,
Praan

