Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FF0C4332F
	for <kexec@archiver.kernel.org>; Mon, 21 Nov 2022 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1LVWS1DOkA3FnP4UtSHb7nAiXc0c2nc89kX4ITnjq4k=; b=essvvs9/T9K0tkzCICfKKPvs4Q
	I80x+zWjvHKoVcu9Nz/L6YJWTdtlM09AiVOZfj+l6oRfQY7ioYyNjQEEwPlfzOD1BLpuBxdhOpB1X
	sx1LruI0EcpYyJa8RTgB7BscLSOJxo9LLsPMI+9DT61zAyTNY0M8K7K5S+WNR0wZDdtkSsgUlQ3PC
	ih8/QlvkFEtNMsjJm+lia7oS3XOGh1wSZJ/0ElKC6hzLATjH3K8tMK+SAFMT644scymCY2clBYbET
	o1fKKDVHMflyvxrmmTQeNpocHDMbFPbbFtLdxC0PGDIpTlu9uMl0VbCRWTgdyL17eSXZ1JcFkW/zY
	MpOXxuwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox5TM-00DA2y-Bd; Mon, 21 Nov 2022 12:00:24 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox5TJ-00D9xc-Hf; Mon, 21 Nov 2022 12:00:23 +0000
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG5Xv5FzGzmW5v;
	Mon, 21 Nov 2022 19:59:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 20:00:12 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 20:00:11 +0800
Subject: Re: [PATCH v4 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
To: Baoquan He <bhe@redhat.com>
CC: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou
	<dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>, "Dave
 Kleikamp" <dave.kleikamp@oracle.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
 <20221116121044.1690-3-thunder.leizhen@huawei.com>
 <Y3s3ZCYj+ZbI3whB@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0c3358aa-251f-cd47-e6d6-6408abacdea5@huawei.com>
Date: Mon, 21 Nov 2022 20:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3s3ZCYj+ZbI3whB@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_040021_953782_496763B7 
X-CRM114-Status: GOOD (  30.39  )
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



On 2022/11/21 16:31, Baoquan He wrote:
> On 11/16/22 at 08:10pm, Zhen Lei wrote:
>> For crashkernel=X without '@offset', select a region within DMA zones
>> first, and fall back to reserve region above DMA zones. This allows
>> users to use the same configuration on multiple platforms.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>>  arch/arm64/mm/init.c                            | 17 ++++++++++++++++-
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a7b7147447b8bf8..ef6d922ed26b9dc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -842,7 +842,7 @@
>>  			memory region [offset, offset + size] for that kernel
>>  			image. If '@offset' is omitted, then a suitable offset
>>  			is selected automatically.
>> -			[KNL, X86-64] Select a region under 4G first, and
>> +			[KNL, X86-64, ARM64] Select a region under 4G first, and
>>  			fall back to reserve region above 4G when '@offset'
>>  			hasn't been specified.
>>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ba7227179822d10..58a0bb2c17f18cf 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -132,6 +132,7 @@ static void __init reserve_crashkernel(void)
>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>  	char *cmdline = boot_command_line;
>>  	int ret;
>> +	bool fixed_base = false;
>>  
>>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>>  		return;
>> @@ -163,12 +164,26 @@ static void __init reserve_crashkernel(void)
>>  	crash_size = PAGE_ALIGN(crash_size);
>>  
>>  	/* User specifies base address explicitly. */
>> -	if (crash_base)
>> +	if (crash_base) {
>> +		fixed_base = true;
>>  		crash_max = crash_base + crash_size;
>> +	}
>>  
>> +retry:
>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>  					       crash_base, crash_max);
> 
> This pachset looks good to me. While we observed a unexpected case,
> where a reserved region cross the high and low meomry region. I noticed
> Catalin has pointed that out. Even with the suggested code, we could
> have the kernel parameters like: crashkernel=512M,high
> crashkernel=128M,low, we finally have [4G-126M, 4G+386M], [1G, 1G+128M]
> regions in running kernel. This looks strange.

Is high-end memory fragmented? Add boot option memblock=debug and watch?

> 
> I am wondering if we can specify explicit search_base in
> memblock_phys_alloc_range() to avoid above case. Like this,
> crashkernel,high region will only exist in high memory, crashkernel,low
> region only exists in low memory region. I made a draft patch based on
> this patchset to present what the code looks like.

Looks good to me.

> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..fd9d35e17a62 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -127,7 +127,7 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> +	unsigned long long crash_base, crash_size, search_base;

search_base needs to be initialized to 0.

>  	unsigned long long crash_low_size = 0;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	char *cmdline = boot_command_line;
> @@ -155,6 +155,7 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_ADDR_LOW_MAX;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
> @@ -166,12 +167,13 @@ static void __init reserve_crashkernel(void)
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
>  		 * If the first attempt was for low memory, fall back to
> @@ -180,6 +182,7 @@ static void __init reserve_crashkernel(void)
>  		 */
>  		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}
> @@ -189,7 +192,7 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> +	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
>  	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
> 
> .
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
