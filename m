Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED14ECAAD5
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 01:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=G8UTsAIZARMx43l3ZoBkx48NWqTwcUC5SayWfyo8wPs=; b=ou7gkouPeNNia7uHwl8/mA6I7T
	rQM90avLjQIGBw2aVc/GWZtBT4qN1KwUaF+Ttl+V0il+zSt1TzvDjTS9CZy602DxSqK6HEyxbrLHe
	ywI6Ou602ZlDUlCHuIZJ+ZpUkzXKtmw+jmCYUve/kDTzuBlYy66eSuJUNezj7OvgS1qNyvvXzgnR4
	QGdykGcqzoDcnm+7gHpbHDZ3hohVYmx6u18oN+p3HpcFv8onnKkXI2pUelFbAzjWKPa0BZTdfo7Vp
	3bITbCLLgLzqhLyTmnyJoIgxR0+Roj/GUh/NmckKyOj2vMkCLOU89w6dnoDETr6kIQR+PVHwzIQ62
	4yh9Tfuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCtP-0036Ix-WA; Wed, 31 Aug 2022 01:51:48 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCtL-0036Fw-OC; Wed, 31 Aug 2022 01:51:46 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MHRrx33CVz1N7hL;
	Wed, 31 Aug 2022 09:48:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 09:51:27 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 09:51:26 +0800
Subject: Re: [PATCH 2/2] arm64: remove unneed defer_reserve_crashkernel() and
 crash_mem_map
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<ardb@kernel.org>, <rppt@kernel.org>, <guanghuifeng@linux.alibaba.com>,
	<mark.rutland@arm.com>, <will@kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <kexec@lists.infradead.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-3-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fb26388d-9b3e-28cb-5688-828f52c70d24@huawei.com>
Date: Wed, 31 Aug 2022 09:51:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220828005545.94389-3-bhe@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_185143_980387_6B472865 
X-CRM114-Status: GOOD (  14.97  )
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
> Now they are not needed any more, clean them up.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/include/asm/memory.h |  5 -----
>  arch/arm64/mm/mmu.c             | 15 ---------------
>  2 files changed, 20 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 9dd08cd339c3..b9e71583c9cb 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -363,11 +363,6 @@ static inline void *phys_to_virt(phys_addr_t x)
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
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cdd338fa2115..c3f8f426c3d8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -502,21 +502,6 @@ void __init mark_linear_text_alias_ro(void)
>  			    PAGE_KERNEL_RO);
>  }
>  
> -static bool crash_mem_map __initdata;
> -
> -static int __init enable_crash_mem_map(char *arg)
> -{
> -	/*
> -	 * Proper parameter parsing is done by reserve_crashkernel(). We only
> -	 * need to know if the linear map has to avoid block mappings so that
> -	 * the crashkernel reservations can be unmapped later.
> -	 */
> -	crash_mem_map = true;
> -
> -	return 0;
> -}
> -early_param("crashkernel", enable_crash_mem_map);
> -
>  static void __init map_mem(pgd_t *pgdp)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
