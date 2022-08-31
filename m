Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC6BECAAA1
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 01:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=peTvdP2SXF/IQ2PDjhSRTJrDrru75C2gas5OtD64L88=; b=mKjRocBzSkwOlSMIe6lel7MKWj
	ScsEaAwVJDVEiak0H/cdrc73t/AHtHSvATaHPShkG8nUiU6UG44rwm0JBu2xGIrFRh5sGQCwiq2uT
	C8lkD+vBf1C3gox/d4thySpti9MjgHEfCB5MIUtOYhfpAmcFnTWeQxCsgtRC7qdcn/i4QzT0Kq2vJ
	WygqBVXQ+pmtfunv0ujrebVoibuaXaKMAe5dVyH5/X7Vcg8wGF7GWk3RNX+t3fDqbC3GhUGUIZvYF
	JUw2FxMdYWCNgVqZ45/7KGl80/CsLVXsrXhWyC4RVgUHSi+J6BiZjUnxvHeZ9KLC+FkOLkbGB2l9Y
	0krxqvzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCsY-0035y9-Rg; Wed, 31 Aug 2022 01:50:54 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCsS-0035tX-Cj; Wed, 31 Aug 2022 01:50:52 +0000
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHRr71C7LzlWYR;
	Wed, 31 Aug 2022 09:47:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 09:50:43 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 09:50:42 +0800
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<ardb@kernel.org>, <rppt@kernel.org>, <guanghuifeng@linux.alibaba.com>,
	<mark.rutland@arm.com>, <will@kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <kexec@lists.infradead.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <077ab34d-9d64-5cab-7a44-1c7222032db4@huawei.com>
Date: Wed, 31 Aug 2022 09:50:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220828005545.94389-2-bhe@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_185048_837611_A99A57D9 
X-CRM114-Status: GOOD (  30.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2022/8/28 8:55, Baoquan He wrote:
> Problem:
> =======
> On arm64, block and section mapping is supported to build page tables.
> However, currently it enforces to take base page mapping for the whole
> linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> crashkernel kernel parameter is set. This will cause longer time of the
> linear mapping process during bootup and severe performance degradation
> during running time.
> 
> Root cause:
> ==========
> On arm64, crashkernel reservation relies on knowing the upper limit of
> low memory zone because it needs to reserve memory in the zone so that
> devices' DMA addressing in kdump kernel can be satisfied. However, the
> limit on arm64 is variant. And the upper limit can only be decided late
> till bootmem_init() is called.
> 
> And we need to map the crashkernel region with base page granularity when
> doing linear mapping, because kdump needs to protect the crashkernel region
> via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
> support well on splitting the built block or section mapping due to some
> cpu reststriction [1]. And unfortunately, the linear mapping is done before
> bootmem_init().
> 
> To resolve the above conflict on arm64, the compromise is enforcing to
> take base page mapping for the entire linear mapping if crashkernel is
> set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
> performance is sacrificed.
> 
> Solution:
> =========
> To fix the problem, we should always take 4G as the crashkernel low
> memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
> With this, we don't need to defer the crashkernel reservation till
> bootmem_init() is called to set the arm64_dma_phys_limit. As long as
> memblock init is done, we can conclude what is the upper limit of low
> memory zone.
> 
> 1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
>   limit = PHYS_ADDR_MAX+1  (Corner cases)
> 2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
>    limit = 4G  (generic case)

If Raspberry Pi 4 doesn't need to be considered:
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

In fact, I also think, for the sake of a niche scene, sacrificing the mass scene,
the cart is put before the horse.


> 
> [1]
> https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/mm/init.c | 24 ++++++++++++++----------
>  arch/arm64/mm/mmu.c  | 38 ++++++++++++++++++++++----------------
>  2 files changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b9af30be813e..8ae55afdd11c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -90,10 +90,22 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #endif
>  
> +static phys_addr_t __init crash_addr_low_max(void)
> +{
> +	phys_addr_t low_mem_mask = U32_MAX;
> +	phys_addr_t phys_start = memblock_start_of_DRAM();
> +
> +	if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> +	     (phys_start > U32_MAX))
> +		low_mem_mask = PHYS_ADDR_MAX;
> +
> +	return min(low_mem_mask, memblock_end_of_DRAM() - 1) + 1;
> +}
> +
>  /* Current arm64 boot protocol requires 2MB alignment */
>  #define CRASH_ALIGN			SZ_2M
>  
> -#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> +#define CRASH_ADDR_LOW_MAX		crash_addr_low_max()
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>  
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
> @@ -389,8 +401,7 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (!defer_reserve_crashkernel())
> -		reserve_crashkernel();
> +	reserve_crashkernel();
>  
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
> @@ -434,13 +445,6 @@ void __init bootmem_init(void)
>  	 */
>  	dma_contiguous_reserve(arm64_dma_phys_limit);
>  
> -	/*
> -	 * request_standard_resources() depends on crashkernel's memory being
> -	 * reserved, so do it here.
> -	 */
> -	if (defer_reserve_crashkernel())
> -		reserve_crashkernel();
> -
>  	memblock_dump_all();
>  }
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e7ad44585f40..cdd338fa2115 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -547,13 +547,12 @@ static void __init map_mem(pgd_t *pgdp)
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>  
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map) {
> -		if (defer_reserve_crashkernel())
> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -		else if (crashk_res.end)
> -			memblock_mark_nomap(crashk_res.start,
> -			    resource_size(&crashk_res));
> -	}
> +	if (crashk_res.end)
> +		memblock_mark_nomap(crashk_res.start,
> +				    resource_size(&crashk_res));
> +	if (crashk_low_res.end)
> +		memblock_mark_nomap(crashk_low_res.start,
> +				    resource_size(&crashk_low_res));
>  #endif
>  
>  	/* map all the memory banks */
> @@ -589,16 +588,23 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * through /sys/kernel/kexec_crash_size interface.
>  	 */
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map && !defer_reserve_crashkernel()) {
> -		if (crashk_res.end) {
> -			__map_memblock(pgdp, crashk_res.start,
> -				       crashk_res.end + 1,
> -				       PAGE_KERNEL,
> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
> -		}
> +	if (crashk_res.end) {
> +		__map_memblock(pgdp, crashk_res.start,
> +			       crashk_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_res.start,
> +				     resource_size(&crashk_res));
>  	}
> +	if (crashk_low_res.end) {
> +		__map_memblock(pgdp, crashk_low_res.start,
> +			       crashk_low_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_low_res.start,
> +				     resource_size(&crashk_low_res));
> +	}
> +
>  #endif
>  }
>  
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
