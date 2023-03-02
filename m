Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A39BC7EE23
	for <kexec@archiver.kernel.org>; Thu,  2 Mar 2023 03:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=K+j0OxwFX7UECs3Jqlt27xRjU3rJjm0iqdZ52NMT1PI=; b=ZPfierSNcemSLnlv+nr+rVsIiZ
	/LF1bzjcfwJxYdAEhSkD7btS/9sYYMNUldZFONYkpR7UDYu4Konc6R6+zsgUGbXACYpDIw6MihRTm
	pUvUpDzIBuXFujiYO5PQnS5GvbxFfuyhm2Q8WmkczDhkWpDEdfGj/xBY/bc166HKymrZm7Ovc0wwf
	s+aO7n32zCgsBZ/WwsnUlT0urcP/A6Oli8y4/+jeIO2f8VhFGbzGYmNUzKm5mt3j6PZvLcA8UOvqJ
	7fW3dzU1BNEZe/Ha16yx22HyJZNoQj4JvZ7tA20/OtBT/wYoU1ClOAPsdHELESchSAarOQitA7ig+
	XsFehNhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZgs-000giZ-Ib; Thu, 02 Mar 2023 03:33:10 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZgo-000ggf-Fm; Thu, 02 Mar 2023 03:33:09 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRxSS15SbzfbPn;
	Thu,  2 Mar 2023 11:30:16 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 11:32:56 +0800
Subject: Re: [PATCH v3] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <will@kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20230223124532.128744-1-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
Date: Thu, 2 Mar 2023 11:32:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230223124532.128744-1-bhe@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_193306_946741_C7A750B0 
X-CRM114-Status: GOOD (  34.94  )
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



On 2023/2/23 20:45, Baoquan He wrote:
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
> Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
> system, or 4G if other normal systems.

There are two minor review comments, see below. Otherwise:

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
>  - Rephrase patch log to clarify the current crashkernel high
>    reservation could cross the high and low memory boundary, but not 
>    4G boundary only, because RPi4 of arm64 has high and low memory
>    boudary as 1G. The v3 patch log could mislead people that the RPi4
>    also use 4G as high,low memory boundary.
> v1->v2:
>  - Fold patch 2 of v1 into patch 1 for better reviewing.
>  - Update patch log to add more details.
>  arch/arm64/mm/init.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..b8cb780df0cb 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_low_size = 0;
> +	unsigned long long crash_base, crash_size, search_base;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_low_size = 0;
>  	char *cmdline = boot_command_line;
> -	int ret;
>  	bool fixed_base = false;
> +	bool high = false;
> +	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_ADDR_LOW_MAX;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
> +		high = true;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
>  		return;
> @@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
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
> +			pr_info("crashkernel reservation failed - memory is in use.\n");

How about changing pr_info to pr_warn?

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

Adding unlikely to indicate that it is rare would be better.

if (unlikely(high && crash_max == CRASH_ADDR_HIGH_MAX))

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
