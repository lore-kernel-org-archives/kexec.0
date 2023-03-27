Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6FEC7619A
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 01:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=y/uVeD3hWnyjQIa/Xo9ryAunTGzft0QGpBGU9JDLn04=; b=vP7jFIJiQSjaWC1Nn0lDusPykO
	+ilXpcNH/Jm2salthwJq2SGkxLXi0csZMeVz2vtQm+f40RBAmOJaC9jUwWWSuh6sEzcBHsWglSCKn
	XPT/nkLdlaTP1+E5riv/THIOTH1ZSXai+1lKXi1iOwh/C1CtnkF/qfsb+iYXMmx5Z5y5NcdUaeK/u
	qZQIISV2pgANs4C+LCfZkPSNjH4orpICUxfBNvVY0PP+YzKcKw/vz0m+DwziCJ5qFk7jjo3YRgA/h
	inkK7FDT+rgna+A8QWYZtBeIPeyV47bU1BSj7Of1r8TmILXy5sXXsleAlAYR4l7CR4Yqtg74PUnO0
	TeIqZy/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgbdZ-009Sx5-0Z;
	Mon, 27 Mar 2023 01:27:05 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgbdW-009Sw1-05;
	Mon, 27 Mar 2023 01:27:04 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PlFSL5pXMzSpGF;
	Mon, 27 Mar 2023 09:23:14 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 09:26:46 +0800
Subject: Re: [PATCH v2 3/3] arm64: kdump: defer the crashkernel reservation
 for platforms with no DMA memory zones
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <will@kernel.org>, <kexec@lists.infradead.org>,
	<ardb@kernel.org>, <rppt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-4-bhe@redhat.com> <ZCBCgkiJ1/QPfgSt@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cf446196-d9fa-5787-8072-9f664c10433a@huawei.com>
Date: Mon, 27 Mar 2023 09:26:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZCBCgkiJ1/QPfgSt@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_182702_424510_6E2D74C1 
X-CRM114-Status: GOOD (  27.01  )
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



On 2023/3/26 21:02, Baoquan He wrote:
> In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), reserve_crashkernel() is called
> much earlier in arm64_memblock_init() to avoid causing base apge
> mapping on platforms with no DMA meomry zones.
> 
> With taking off protection on crashkernel memory region, no need to call
> reserve_crashkernel() specially in advance. The deferred invocation of
> reserve_crashkernel() in bootmem_init() can cover all cases. So revert
> the commit 031495635b46 now.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v2:
> - When trying to revert commit 031495635b46, two hunks were missed in v1
>   post. Remove them in v2. Thanks to Leizhen for pointing out this. 
>   - Remove code comment above arm64_dma_phys_limit definition added
>     in commit 031495635b46;
>   - Move the arm64_dma_phys_limit assignment back into zone_sizes_init()
>     when both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are not enabled.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
>  arch/arm64/include/asm/memory.h |  5 -----
>  arch/arm64/mm/init.c            | 34 +++------------------------------
>  2 files changed, 3 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 78e5163836a0..efcd68154a3a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
>  })
>  
>  void dump_mem_limit(void);
> -
> -static inline bool defer_reserve_crashkernel(void)
> -{
> -	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
> -}
>  #endif /* !ASSEMBLY */
>  
>  /*
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..66e70ca47680 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -61,34 +61,8 @@ EXPORT_SYMBOL(memstart_addr);
>   * unless restricted on specific platforms (e.g. 30-bit on Raspberry Pi 4).
>   * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
>   * otherwise it is empty.
> - *
> - * Memory reservation for crash kernel either done early or deferred
> - * depending on DMA memory zones configs (ZONE_DMA) --
> - *
> - * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
> - * here instead of max_zone_phys().  This lets early reservation of
> - * crash kernel memory which has a dependency on arm64_dma_phys_limit.
> - * Reserving memory early for crash kernel allows linear creation of block
> - * mappings (greater than page-granularity) for all the memory bank rangs.
> - * In this scheme a comparatively quicker boot is observed.
> - *
> - * If ZONE_DMA configs are defined, crash kernel memory reservation
> - * is delayed until DMA zone memory range size initialization performed in
> - * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
> - * memory range to avoid overlap allocation.  So crash kernel memory boundaries
> - * are not known when mapping all bank memory ranges, which otherwise means
> - * not possible to exclude crash kernel range from creating block mappings
> - * so page-granularity mappings are created for the entire memory range.
> - * Hence a slightly slower boot is observed.
> - *
> - * Note: Page-granularity mappings are necessary for crash kernel memory
> - * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
>   */
> -#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
>  phys_addr_t __ro_after_init arm64_dma_phys_limit;
> -#else
> -phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> -#endif
>  
>  /* Current arm64 boot protocol requires 2MB alignment */
>  #define CRASH_ALIGN			SZ_2M
> @@ -248,6 +222,8 @@ static void __init zone_sizes_init(void)
>  	if (!arm64_dma_phys_limit)
>  		arm64_dma_phys_limit = dma32_phys_limit;
>  #endif
> +	if (!arm64_dma_phys_limit)
> +		arm64_dma_phys_limit = PHYS_MASK + 1;
>  	max_zone_pfns[ZONE_NORMAL] = max_pfn;
>  
>  	free_area_init(max_zone_pfns);
> @@ -408,9 +384,6 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (!defer_reserve_crashkernel())
> -		reserve_crashkernel();
> -
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
>  
> @@ -457,8 +430,7 @@ void __init bootmem_init(void)
>  	 * request_standard_resources() depends on crashkernel's memory being
>  	 * reserved, so do it here.
>  	 */
> -	if (defer_reserve_crashkernel())
> -		reserve_crashkernel();
> +	reserve_crashkernel();
>  
>  	memblock_dump_all();
>  }
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
