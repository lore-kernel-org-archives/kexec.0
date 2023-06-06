Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343AAC77B7A
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QdAazUBSRgUMhVfdL3nvRVx4qGQgeCJHufFIAGl3AHw=; b=Ad41ZrjY/G9E2ySUwkXwW2ynQk
	RRJtyTnqggdHL8MxLE/sm6xdcTgMUm0tNu5CUUcUUpETMIzNA+47SWT2qCSpfCcEtWT1q9pWR+Z2R
	zu3RU9RyFOG4stHaYbopUWiuur8MCbEjBzY/kh4i0rEKfryB4mCpEdN3Mk52SmiJsYm4tJ6LhmmD9
	ST2FB1UpjO0ky72cqKGi/gAbDMbE04JtsvYz21tNhw6cxDtj/AOaGAIG5I3czX47L32e3wEJpiUdP
	bIQAkB2yhP6xlAjK5/VBzWfhXUFxoJvXFPxSIO3bQ1O7ZwKVU1gMMBikt+pCRAUAizwQGfPO0wJ4e
	cukEec0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6VGD-001VdL-27;
	Tue, 06 Jun 2023 11:54:01 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6VG9-001VXk-2j;
	Tue, 06 Jun 2023 11:54:00 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb82R3PfhztQZC;
	Tue,  6 Jun 2023 19:51:27 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 19:53:48 +0800
Subject: Re: [PATCH v6 RESEND 1/2] arm64: kdump: simplify the reservation
 behaviour of crashkernel=,high
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20230515060259.830662-1-bhe@redhat.com>
 <20230515060259.830662-2-bhe@redhat.com> <ZGIBSEoZ7VRVvP8H@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <52743932-b071-6dd4-d891-b463946a3017@huawei.com>
Date: Tue, 6 Jun 2023 19:53:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZGIBSEoZ7VRVvP8H@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_045358_295386_48513B31 
X-CRM114-Status: GOOD (  34.81  )
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



On 2023/5/15 17:54, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crashkernel high region crossing low and high memory boudary will bring
> issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> low and high memory boundary, then user will see two memory regions in
> low memory, and one memory region in high memory. The two crashkernel
> low memory regions are confusing as shown in above example.
> 
> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses low and high memory
> boundary and the part of crashkernel high reservation below boundary is
> bigger than y, the expected crahskernel low reservation will be skipped.
> But the expected crashkernel high reservation is shrank and could not
> satisfy user space requirement.
> 
> 3) The crossing boundary behaviour of crahskernel high reservation is
> different than x86 arch. On x86_64, the low memory end is 4G fixedly,
> and the memory near 4G is reserved by system, e.g for mapping firmware,
> pci mapping, so the crashkernel reservation crossing boundary never happens.
>>From distros point of view, this brings inconsistency and confusion. Users
> need to dig into x86 and arm64 system details to find out why.
> 
> For kernel itself, the impact of issue 3) could be slight. While issue
> 1) and 2) cause actual impact because it brings obscure semantics and
> behaviour to crashkernel=,high reservation.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region only in high memory. If failed, try reserving the suitable
> region only in low memory. Like this, the crashkernel high region will
> only exist in high memory, and crashkernel low region only exists in low
> memory. The reservation behaviour for crashkernel=,high is clearer and
> simpler.
> 
> Note: RPi4 has different zone ranges than normal memory. Its DMA zone is
> 0~1G, and DMA32 zone is 1G~4G if CONFIG_ZONE_DMA|DMA32 are enabled by
> default. The low memory end is 1G in order to validate all devices, high
> memory starts at 1G memory. However, for being consistent with normla

normla --> normal

> arm64 system, its low memory end is still 1G, while reserving crashkernel
> high memory from 4G if crashkernel=size,high specified. This will remove
> confusion.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> With above change applied, summary of arm64 crashkernel reservation range:
> 1)
> RPi4(zone DMA:0~1G; DMA32:1G~4G):
>  crashkernel=size
>   0~1G: low memory | 1G~top: high memory
> 
>  crashkernel=size,high
>   0~1G: low memory | 4G~top: high memory
> 
> 2)
> Other normal system:
>  crashkernel=size
>  crashkernel=size,high
>   0~4G: low memory | 4G~top: high memory
> 
> 3)
> Systems w/o zone DMA|DMA32
>  crashkernel=size
>  crashkernel=size,high
>   0~top: low memory
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> v6-RESEND:
>  - Remove the relic of local patch merging at the end of patch log.
>  - Add Catalin's Reviewed-by tag.
> 
>  arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 66e70ca47680..c28c2c8483cc 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -69,6 +69,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  
>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
>  
>  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
>  
> @@ -101,12 +102,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_low_size = 0;
> +	unsigned long long crash_low_size = 0, search_base = 0;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_base, crash_size;
>  	char *cmdline = boot_command_line;
> -	int ret;
>  	bool fixed_base = false;
> +	bool high = false;
> +	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -129,7 +131,9 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_HIGH_SEARCH_BASE;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
> +		high = true;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
>  		return;
> @@ -140,31 +144,51 @@ static void __init reserve_crashkernel(void)
>  	/* User specifies base address explicitly. */
>  	if (crash_base) {
>  		fixed_base = true;
> +		search_base = crash_base;
>  		crash_max = crash_base + crash_size;
>  	}
>  
>  retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> +					       search_base, crash_max);
>  	if (!crash_base) {
>  		/*
> -		 * If the first attempt was for low memory, fall back to
> -		 * high memory, the minimum required low memory will be
> -		 * reserved later.
> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> +		 * message if can't reserve the specified region.
>  		 */
> -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +		if (fixed_base) {
> +			pr_warn("crashkernel reservation failed - memory is in use.\n");
> +			return;
> +		}
> +
> +		/*
> +		 * For crashkernel=size[KMG], if the first attempt was for
> +		 * low memory, fall back to high memory, the minimum required
> +		 * low memory will be reserved later.
> +		 */
> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}
>  
> +		/*
> +		 * For crashkernel=size[KMG],high, if the first attempt was
> +		 * for high memory, fall back to low memory.
> +		 */
> +		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
> +			crash_max = CRASH_ADDR_LOW_MAX;
> +			search_base = 0;
> +			goto retry;
> +		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> +	     reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
