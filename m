Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9446DC76195
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 02:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SZXxvT71lTj1x/HDMb4yPNbvNW1Je7Uai0fipo5ayCA=; b=26UOYWFyjM5BdABg7m1KM4Iv8n
	q5nhalxqr0qhURiFwcqn1sxhbv2vnfv0HqavyARyx2sDpOjfoi68Z5Z2mM/Pr5lVEGLy6stfSzQVA
	UHVq9MH2V6AdmEYAdOJp6RiUd4KdFCtDnKiv69chnF13lI+FSvKhjzCz9l89zcnqdb2XeBWFdafvE
	E4slIdfdTyZdIgXfJsjnXd4h5I0PdyK/PlrGpVxm1NZuuusCZubOf1/NJjn4b8pkjfSqedlouGtuB
	tNSisdtkhecoTnx8ke2RLLQJ+i6HgQKGxmLivT4aaps1tEiWLNLBIp5qmLzRedSFKsfUenV1kvYUO
	nlZ6PuiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pftHw-005y27-36;
	Sat, 25 Mar 2023 02:05:48 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pftHu-005y1R-0N;
	Sat, 25 Mar 2023 02:05:48 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk2RJ4mFczKtNX;
	Sat, 25 Mar 2023 10:03:08 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 10:04:34 +0800
Subject: Re: [PATCH 3/3] arm64: kdump: defer the crashkernel reservation for
 platforms with no DMA memory zones
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <will@kernel.org>, <kexec@lists.infradead.org>,
	<ardb@kernel.org>, <rppt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-4-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3653555d-3302-fc40-c917-963b029fc839@huawei.com>
Date: Sat, 25 Mar 2023 10:04:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230324131838.409996-4-bhe@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_190546_516373_1F5B779F 
X-CRM114-Status: GOOD (  16.66  )
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



On 2023/3/24 21:18, Baoquan He wrote:
> In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), reserve_crashkernel() is called
> much earlier in arm64_memblock_init() to avoid causing base apge
> mapping on platforms with no DMA meomry zones.
> 
> With taking off protection on crashkernel memory region, no need to call
> reserve_crashkernel() specially in advance. The deferred invocation of
> reserve_crashkernel() in bootmem_init() can cover all cases.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/include/asm/memory.h | 5 -----
>  arch/arm64/mm/init.c            | 6 +-----
>  2 files changed, 1 insertion(+), 10 deletions(-)
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
> index 58a0bb2c17f1..b888de59e0b7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -408,9 +408,6 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (!defer_reserve_crashkernel())
> -		reserve_crashkernel();
> -
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
>  
> @@ -457,8 +454,7 @@ void __init bootmem_init(void)
>  	 * request_standard_resources() depends on crashkernel's memory being
>  	 * reserved, so do it here.
>  	 */
> -	if (defer_reserve_crashkernel())
> -		reserve_crashkernel();
> +	reserve_crashkernel();
>  
>  	memblock_dump_all();
>  }

Some comments also need to be deleted, above the definition of arm64_dma_phys_limit
in arch/arm64/mm/init.c

> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
