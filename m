Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9839CDB47F
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uyPzc/lVYNWutlEG7aHFYV3dkzH3OXj7mqtnKUaIHcc=; b=J006LD63OUsP4VAtGybvu5aXUV
	GAjLOii1tn1X6vsPgpMUXbT4o/fz6e9oXQFQFLgrb8N+VyWeMOyhaQtI7xsRkAs750j2rYaGfZJoT
	2+mkJ4dzizv4l/Vn2nYAtMK6LNNFQZEbHRzsiqXGqSCJMmib1sSan1I7FN8puYJNPDuY3TACCPbID
	mUwzCHFp000zbpK7XeInTcxIvu+JD3M6JX8zYhFni8ZpsXL/zAFMlqQQbSwqMEEiKOJKPmNYk1bW2
	ZUA6ExTdACaebg7VOwtscyU8Y9xBUPHZpm6il6RLQA13WfLIESYOTwUYgU+eEp2j9ZNSZWTiJHLDD
	VWqJBYzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcSpl-00000008Exg-0Mqu;
	Wed, 24 Jun 2026 19:00:25 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcSpi-00000008Ewj-2nWf
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 19:00:23 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso9045ad.0
        for <kexec@lists.infradead.org>; Wed, 24 Jun 2026 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782327621; x=1782932421; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uyPzc/lVYNWutlEG7aHFYV3dkzH3OXj7mqtnKUaIHcc=;
        b=V5cOASF7zN3UzY/J9D3DY1KzZV/T4B3APucm1EchbDZiv1dDZir/UnX9sJ3p82fhnD
         fu8gQ65sXn+M5/Gd4vxB3R7iGdv3IvSnccfYhvIHayZ/f9reDxt7ZutJRia36yVRivXG
         i9yfeETAsXlFL5aE6zdl3RAIqFb945kXCi8Aoh6ynFqiX9VnHYeF0m5kffokMYu+sNWl
         U8B0/5Dt1V+Qio/5/Xtm2miSYJCt2b9Dbn8jBOGZWPL4tHlVeOnXNK+lI133T895gQ9T
         qeHAzoUeT8/KAhnXrCxzeyfDSloShbMk0aw782p9hhxbcKv9jj54rRusQK4niORkmWzB
         gjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327621; x=1782932421;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uyPzc/lVYNWutlEG7aHFYV3dkzH3OXj7mqtnKUaIHcc=;
        b=JqcXTnNGCG3qeXBdcTodTbCuNCX65woqwZK4Q6KJYkmCc1t8gNloAKB7dRnTuFpfGV
         1kOh9O6eMkjoWfLqLIcHANN2XdkuDqSKyUKAqe6UVhKB64P55nCSnFShDjRMV35wJnv1
         YvZeBghvbKjgAcoB9qx0w20DckNh2uKXpPloZaH7kxxQ09GDRZ6qoBWiM56AXVHlV96F
         n4nxuWJrIraYtVTpJ7W1VUc25YF3iI1w4P7M0OCG9FN8JPMVdRQc7niu3reNdCUkoWqE
         oR9b6Zw5h0BdY+cCZTt1aTesZLOSJHBOSRU0LUGteBDRZJQzloCvFYMNam36097zcf/y
         VU4A==
X-Forwarded-Encrypted: i=1; AHgh+RpgVbaj1Rg0XbfyF/pcKrnYm0pGJ6Pz9tMRXNEVYoAXPvm4gMhfkhJym4YAeknkxUPGLc092Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXQtJlquGgh3Zc7PdsrCm4i4l5U6EWwwFkq9kJQBcbTEM1bcgR
	HTSOAHrqonJPYAfb7gu5PYvgaVMLWELoEpzsr/yBGcVBUUGWQUh1mDgzbnu8G/0Btg==
X-Gm-Gg: AfdE7cllucI6Qs+Gi6geqJoTW67Y7/WeyBv0/9a6l1CvDOj8/JRXsuK3p5Mxv9x2yS7
	q217+u7iwjncmst9ceOwcAgFbT069Sz5XXhL/2WwohCxxIlPdaqYof7xMFDu7MGdXdPTOfq8r7C
	4TrVPhvrznHRjWOPotKg7iuKVPyvTLQs2R4ecHG4un9PpYNV0IO/hv4VwpKmFJyX14I19sCX+Z5
	LUWtLxyAwI7J3BTXWGenfjBmL0UueR4dKololTg/riwtj+bHveLR+hRRE+J6hwxYD076CR6sOWf
	N7h+YzD/DKzGhemj9IQoSVUzHCohav0l2wTpXXZKHlcRyZcp/15VA+X5ZdSOEAGFDRELCX0G9oq
	iB/adQm6xLnL4JhIIUVKqdCQcGiN2d8Ab44O8k/nsU12NSdAmPIyuvpm21pjuDxETK5QcpkvEs4
	Yc/BUkGvNpdp9/IWOeB8fAs0AHjqHWMQsyXBZp2Gsmq9Kzi+0cB9WmXsLZToYfBjD8x4Pim0H7a
	e+Iz6Wq
X-Received: by 2002:a17:902:c952:b0:2ba:6518:e4d8 with SMTP id d9443c01a7336-2c7f77b6733mr402135ad.20.1782327619882;
        Wed, 24 Jun 2026 12:00:19 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23ccsm3593388b3a.36.2026.06.24.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:00:19 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:00:15 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <ajwmXYOW080zVRLw@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
 <aiceKYmc323G7tBs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiceKYmc323G7tBs@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_120022_742694_F4698DF9 
X-CRM114-Status: GOOD (  33.59  )
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

On Mon, Jun 08, 2026 at 07:55:21PM +0000, Pranjal Shrivastava wrote:
>On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
>> Add an API to preserve/restore the DMA direct allocation for liveupdate.
>> The underlying memory is preserved/restored using KHO. During restore
>> the memory is setup based on the device configuration, gfp flags and
>> allocation attributes. Once restored, the driver can use the usual
>> dma_free* API to deallocate the restored DMA allocation.
>>
>> This API will be used to add support in dma_alloc* APIs to
>> preseve/restore the DMA allocations.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/dma-direct.h |  29 +++++++
>>  kernel/dma/Kconfig         |   3 +
>>  kernel/dma/direct.c        | 163 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 195 insertions(+)
>>
>
>[...]
>
>> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>> index bfef21b4a9ae..d92852942c6c 100644
>> --- a/kernel/dma/Kconfig
>> +++ b/kernel/dma/Kconfig
>> @@ -265,3 +265,6 @@ config DMA_MAP_BENCHMARK
>>  	  performance of dma_(un)map_page.
>>
>>  	  See tools/testing/selftests/dma/dma_map_benchmark.c
>> +
>> +config DMA_LIVEUPDATE
>> +	bool "Enable preservation of DMA direct allocations"
>
>Nit: depends on LIVEUPDATE?

Agreed I will add this.
>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index ec887f443741..c2b98f91900a 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -6,6 +6,8 @@
>>   */
>>  #include <linux/memblock.h> /* for max_pfn */
>>  #include <linux/export.h>
>> +#include <linux/kexec_handover.h>
>> +#include <linux/kho/abi/dma_alloc.h>
>>  #include <linux/mm.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/scatterlist.h>
>> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>  	return NULL;
>>  }
>>
>> +#ifdef CONFIG_DMA_LIVEUPDATE
>> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
>> +				   size_t size, dma_addr_t dma_handle,
>> +				   unsigned long attrs, u64 *state)
>> +{
>> +	struct dma_alloc_ser *ser;
>> +	int ret;
>> +
>> +	if (!kho_is_enabled())
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_CMA))
>> +		return -EOPNOTSUPP;
>> +
>> +	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>> +	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
>> +	    !dev_is_dma_coherent(dev) &&
>> +	    !is_swiotlb_for_alloc(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
>> +	    !dev_is_dma_coherent(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>> +	    dma_is_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>> +		return -EOPNOTSUPP;
>> +
>> +	ser = kho_alloc_preserve(sizeof(*ser));
>> +	if (IS_ERR(ser))
>> +		return PTR_ERR(ser);
>> +
>> +	ser->page_phys = dma_to_phys(dev, dma_handle);
>> +	ser->force_decrypted = force_dma_unencrypted(dev);
>> +	ser->size = size;
>> +
>> +	ret = kho_preserve_pages(phys_to_page(ser->page_phys),
>> +				 size >> PAGE_SHIFT);
>
>Should this be `PAGE_ALIGN(size) >> PAGE_SHIFT` OR
>`DIV_ROUND_UP(size, PAGE_SIZE)`?
>
>Otherwise, if size is small, say, size == 64-bytes, we preserve 0 pages?
>
>Also, IIRC, even with PAGE_ALIGN, preserving just the requested pgcount
>is not enough because buddy allocator allocates in order-N.
>
>For e.g. if a driver requests 20KB (5 pages), the buddy allocator
>fulfills it with an order-3 block (8 pages).
>
>Now, if we only tell KHO to preserve 5 pages, the remaining 3 pages are
>free in the new kernel. When the driver eventually tears down and calls
>dma_free_coherent(), dma_direct_free() will call
>__free_pages(page, get_order(size)), which will attempt to free all 8
>pages, causing a double-free panic on the 3 unpreserved pages?
>
>Should we be preserving exactly 1 << get_order(size) pages as per buddy?
>Same applies to unpreserve, and restore.

Agreed. I will update this and also make sure it is covered in the kunit
tests.
>
>> +	if (ret) {
>> +		kho_unpreserve_free(ser);
>> +		return ret;
>> +	}
>> +
>> +	*state = virt_to_phys(ser);
>> +	return 0;
>> +}
>> +
>> +void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
>> +{
>> +	struct dma_alloc_ser *ser;
>> +
>> +	if (!kho_is_enabled())
>> +		return;
>> +
>> +	ser = phys_to_virt(state);
>> +	kho_unpreserve_pages(phys_to_page(ser->page_phys),
>> +			     ser->size >> PAGE_SHIFT);
>> +	kho_unpreserve_free(ser);
>> +}
>> +
>> +void *dma_direct_restore_allocation(struct device *dev, size_t size,
>> +				    dma_addr_t *dma_handle, gfp_t gfp,
>> +				    unsigned long attrs, u64 state)
>
>Are we relying on the caller to pass same attrs? So, a buffer with
>non-coherent attrs can be mapped with coherent attrs in the new kernel.
>Could this cause side-effects? Should we check for such driver bugs with
>a WARN here while comparing older attrs with the newer ones too?
>
>Coherency breaking due to subtle driver bugs is very painful to debug :/

Hmm... this is interesting. The dma_alloc API relies on the caller to
have consistent attrs accross allocation and free. But when updating
kernel where driver could have been updated, we have to be careful.

Agreed.. I will handle this properly by making sure that the new attr is
compatible with the preserved attr.
>
>> +{
>> +	bool remap = false, set_uncached = false;
>> +	struct dma_alloc_ser *ser = NULL;
>> +	struct page *page;
>> +	void *cpu_addr;
>> +
>> +	if (!kho_is_enabled())
>> +		return NULL;
>> +
>> +	ser = phys_to_virt(state);
>> +	page = phys_to_page(ser->page_phys);
>
>[...]
>
>> +
>> +	/*
>> +	 * Remapping will be blocking so return error. The preserved memory
>> +	 * might be already decrypted in the previous kernel, but the decryption
>> +	 * call is not guaranteed to be non-blocking so return error always if
>> +	 * decryption is required.
>> +	 */
>> +	if ((remap || force_dma_unencrypted(dev)) &&
>> +	    dma_direct_use_pool(dev, gfp))
>> +		return NULL;
>> +
>> +	/*
>> +	 * Encryption scheme changed between two kernels and this might cause
>> +	 * issues if device/driver is not handling it properly.
>> +	 */
>> +	WARN_ON_ONCE(ser->force_decrypted != force_dma_unencrypted(dev));
>> +
>> +	/*
>> +	 * arch_dma_prep_coherent() should make sure that any cache lines from
>> +	 * the previous kernel, if the device was coherent previously or cached
>> +	 * mapping in this kernel during init are not problamatic for
>> +	 * non-coherent allocations.
>> +	 */
>> +	if (remap) {
>> +		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>> +
>> +		if (force_dma_unencrypted(dev))
>> +			prot = pgprot_decrypted(prot);
>> +
>> +		arch_dma_prep_coherent(page, size);
>> +
>> +		cpu_addr = dma_common_contiguous_remap(page, size, prot,
>> +						       __builtin_return_address(0));
>> +		if (!cpu_addr)
>> +			return NULL;
>
>Should we be kho_restore_free-ing on all these error paths?
>We only seem to be kho_restore_free-ing on the success path.
>Same for kho_restore_pages.. if we return an error here, we don't
>restore the preserved pages? Are we leaking those too?

This is purposefully leaking the memory here. This is because during
liveupdate, this device could be using this memory and freeing it means
that this might cause a memory corruption that would pretty difficult to
debug.
>
>> +	} else {
>> +		cpu_addr = page_address(page);
>> +		if (dma_set_decrypted(dev, cpu_addr, size))
>> +			return NULL;
>> +	}
>> +
>> +	if (set_uncached) {
>> +		arch_dma_prep_coherent(page, size);
>> +		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
>> +		if (IS_ERR(cpu_addr))
>> +			return NULL;
>> +	}
>> +
>> +	*dma_handle = phys_to_dma_direct(dev, ser->page_phys);
>> +
>> +	/*
>> +	 * Cannot free the restored pages on error here as these might be in use
>> +	 * by a device with direct allocation in the previous kernel.
>> +	 */


Check this comment that explains the logic behind not freeing. I think I
will move it up.
>> +	WARN_ON(!kho_restore_pages(ser->page_phys,
>> +				   ser->size >> PAGE_SHIFT));
>> +	kho_restore_free(ser);
>> +	return cpu_addr;
>> +}
>> +#endif
>> +
>>  void dma_direct_free(struct device *dev, size_t size,
>>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>>  {
>
>Thanks,
>Praan

Thanks,
Sami

