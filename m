Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB8C76196
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 01:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lxKY8Q49aCupSjOTQNOesTM1nqBdLQzrdLfPS1JA34E=; b=HyXukP3jRmArmnedXu3jtf2Y7q
	XddB50evlFyVp5AW3/7RtsMlRGu9+NJ3+OMfnDnmCJoSw3YHzEdD92yUy5pIfejUL54/+ZoMgIMZU
	6lEDrn2kg/L/oWGeeiNZXkItxA15z06cTYoYw9fgm7U+glQWqLUy5+8TugKywXj2UCzgH1gXVcRrT
	1PuoF5KyEG9plOvkF22xdHaT/CJYu0vE0jzb8xoyeWcrwc1tohcHC9ITbu4bbNn3XHqLyujV+z6lJ
	C9lNDWcfoyRjnSr4zQITKAQCPPL397g/OoUxTxuNhLHHcTdzTHOe7TlcwQpXMU/R09lppP6Vxubos
	dV7tgoIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pftAD-005xK9-22;
	Sat, 25 Mar 2023 01:57:49 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pftA9-005xIc-2X;
	Sat, 25 Mar 2023 01:57:48 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk2F13LTtzSp2s;
	Sat, 25 Mar 2023 09:54:13 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 09:57:40 +0800
Subject: Re: [PATCH 2/3] arm64: kdump: do not map crashkernel region
 specifically
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <will@kernel.org>, <kexec@lists.infradead.org>,
	<ardb@kernel.org>, <rppt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-3-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <36566d76-2e15-75c2-6c3b-2784aa8d2332@huawei.com>
Date: Sat, 25 Mar 2023 09:57:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230324131838.409996-3-bhe@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_185746_161582_60936867 
X-CRM114-Status: GOOD (  18.92  )
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
> After taking off the protection functions on crashkernel memory region,
> there's no need to map crashkernel region with page granularity during
> linear mapping.
> 
> With this change, the system can make use of block or section mapping
> on linear region to largely improve perforcemence during system bootup
> and running.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/mm/mmu.c | 43 -------------------------------------------
>  1 file changed, 43 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6f9d8898a025..7556020a27b7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -510,21 +510,6 @@ void __init mark_linear_text_alias_ro(void)
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
> @@ -554,16 +539,6 @@ static void __init map_mem(pgd_t *pgdp)
>  	 */
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>  
> -#ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map) {
> -		if (defer_reserve_crashkernel())
> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -		else if (crashk_res.end)
> -			memblock_mark_nomap(crashk_res.start,
> -			    resource_size(&crashk_res));
> -	}
> -#endif
> -
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
>  		if (start >= end)
> @@ -590,24 +565,6 @@ static void __init map_mem(pgd_t *pgdp)
>  	__map_memblock(pgdp, kernel_start, kernel_end,
>  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> -
> -	/*
> -	 * Use page-level mappings here so that we can shrink the region
> -	 * in page granularity and put back unused memory to buddy system
> -	 * through /sys/kernel/kexec_crash_size interface.
> -	 */
> -#ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map && !defer_reserve_crashkernel()) {
> -		if (crashk_res.end) {
> -			__map_memblock(pgdp, crashk_res.start,
> -				       crashk_res.end + 1,
> -				       PAGE_KERNEL,
> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
> -		}
> -	}
> -#endif
>  }
>  
>  void mark_rodata_ro(void)
> 

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
