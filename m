Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2034FEB64DC
	for <kexec@archiver.kernel.org>; Tue,  4 Jul 2023 02:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4fBJUqyNl95de4g3oxSNznjB5DQdKpVVA+kOmdywVbc=; b=zdrhTm4T3rkLb7
	goKSnxP1zOsMS3F1sv6zzNkqLqrOYARit0JP9uEXRFO3kGjnUV7P/YQRwpE2hj0DURHql5eKw2Qsb
	K2kOfqneq5mZ7b8S8SP7erGej7z3dbNjskNyfKnRWmq8ydEAwHX0f7Ak2hLsQr7VUalQlH58TOz6D
	EwxxdO9VOIMHoXRqGTvRbKFogbnam/COVrfl5MPAUbzUm8rWo7QXViumpvjmnvQdLeJHnCrvgXe7W
	rn2OwX1fsRF9UQmiQpQGuDsLPAyoX7l3771fvqIHfi0iXK03vLABxDLskS+gtaqCm3YWGjEYTVQqo
	fQiQF1ZXhBoC83U5GpHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGVcW-00BuKR-0n;
	Tue, 04 Jul 2023 02:18:24 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGVcS-00BuIs-0m;
	Tue, 04 Jul 2023 02:18:22 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qw5zV0z3YzqSMj;
	Tue,  4 Jul 2023 10:17:42 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 10:18:02 +0800
Message-ID: <6f4c80ba-ec61-2ce8-3034-08162f0ee9fd@huawei.com>
Date: Tue, 4 Jul 2023 10:18:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v6 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
 <20230701171138.1491206-2-chenjiahao16@huawei.com>
 <ZKD5N+e5DjgyJ5rw@MiWiFi-R3L-srv>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZKD5N+e5DjgyJ5rw@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_191820_630563_1D4F150E 
X-CRM114-Status: GOOD (  24.53  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 2023/7/2 12:12, Baoquan He wrote:
> On 07/01/23 at 05:11pm, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Here introduce the parameter option crashkernel=X,[high,low].
>>
>> One can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low".
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>> Acked-by: Guo Ren <guoren@kernel.org>
>> ---
>>   arch/riscv/kernel/setup.c |  5 +++
>>   arch/riscv/mm/init.c      | 84 +++++++++++++++++++++++++++++++++++----
>>   2 files changed, 82 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 971fe776e2f8..376f5d49ce85 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -178,6 +178,11 @@ static void __init init_resources(void)
>>   		if (ret < 0)
>>   			goto error;
>>   	}
>> +	if (crashk_low_res.start != crashk_low_res.end) {
>> +		ret = add_resource(&iomem_resource, &crashk_low_res);
>> +		if (ret < 0)
>> +			goto error;
>> +	}
>>   #endif
>>   
>>   #ifdef CONFIG_CRASH_DUMP
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 4b95d8999120..eeb31c2cc843 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1298,6 +1298,28 @@ static inline void setup_vm_final(void)
>>   }
>>   #endif /* CONFIG_MMU */
>>   
>> +/* Reserve 128M low memory by default for swiotlb buffer */
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
>> +
>> +static int __init reserve_crashkernel_low(unsigned long long low_size)
>> +{
>> +	unsigned long long low_base;
>> +
>> +	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
>> +	if (!low_base) {
>> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>> +		low_base, low_base + low_size, low_size >> 20);
>> +
>> +	crashk_low_res.start = low_base;
>> +	crashk_low_res.end = low_base + low_size - 1;
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * reserve_crashkernel() - reserves memory for crash kernel
>>    *
>> @@ -1309,8 +1331,12 @@ static void __init reserve_crashkernel(void)
>>   {
>>   	unsigned long long crash_base = 0;
>>   	unsigned long long crash_size = 0;
>> +	unsigned long long crash_low_size = 0;
>>   	unsigned long search_start = memblock_start_of_DRAM();
>> -	unsigned long search_end = memblock_end_of_DRAM();
>> +	unsigned long search_end = (unsigned long)dma32_phys_limit;
>> +	char *cmdline = boot_command_line;
>> +	bool fixed_base = false;
>> +	bool high = false;
>>   
>>   	int ret = 0;
>>   
>> @@ -1326,14 +1352,36 @@ static void __init reserve_crashkernel(void)
>>   		return;
>>   	}
>>   
>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>   				&crash_size, &crash_base);
>> -	if (ret || !crash_size)
>> +	if (ret == -ENOENT) {
>> +		/* Fallback to crashkernel=X,[high,low] */
>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>> +		if (ret || !crash_size)
>> +			return;
>> +
>> +		/*
>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>> +		 * is passed.
>> +		 */
>> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>> +		if (ret == -ENOENT)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +		else if (ret)
>> +			return;
>> +
>> +		search_start = (unsigned long)dma32_phys_limit;
>> +		search_end = memblock_end_of_DRAM();
>> +		high = true;
>> +	} else if (ret || !crash_size) {
>> +		/* Invalid argument value specified */
>>   		return;
>> +	}
>>   
>>   	crash_size = PAGE_ALIGN(crash_size);
>>   
>>   	if (crash_base) {
>> +		fixed_base = true;
>>   		search_start = crash_base;
>>   		search_end = crash_base + crash_size;
>>   	}
>> @@ -1346,17 +1394,39 @@ static void __init reserve_crashkernel(void)
>>   	 * swiotlb can work on the crash kernel.
>>   	 */
>>   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -					       search_start,
>> -					       min(search_end, (unsigned long) SZ_4G));
>> +					       search_start, search_end);
>>   	if (crash_base == 0) {
>> -		/* Try again without restricting region to 32bit addressible memory */
>> +		if (fixed_base) {
>> +			pr_warn("crashkernel: allocating failed with given size@offset\n");
>> +			return;
>> +		}
>> +
>> +		if (high) {
>> +			/* Fall back to lower 32G reservation */
>> +			search_start = memblock_start_of_DRAM();
>> +			search_end = (unsigned long)dma32_phys_limit;
>> +		} else {
>> +			/* Try again above the region of 32bit addressible memory */
>> +			search_start = (unsigned long)dma32_phys_limit;
>> +			search_end = memblock_end_of_DRAM();
>> +		}
>> +
>>   		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -						search_start, search_end);
>> +						       search_start, search_end);
>>   		if (crash_base == 0) {
>>   			pr_warn("crashkernel: couldn't allocate %lldKB\n",
>>   				crash_size >> 10);
>>   			return;
>>   		}
>> +
>> +		if (!crash_low_size)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> How do you differentiate the case user specifies crashkernel=0M,low
> explicitly with the case that user doesn't specify crashkernel=,low, but
> only specify crsahkernel=xM,high? I saw you don't have the test case
> crashkernel=xM,high crashkernel=0M,low listed in your cover letter.

Yes, here is indeed a point not exactly aligned with Arm64 code.
But testcases below seem to have the same result with Arm64:

crashkernel=512M,high	//high=512M, low=128M (default)
crashkernel=512M,high crashkernel=0M,low   //high=512M, low=0M
crashkernel=512M,high crashkernel=256M,low   //high=512M, low=256M


When the first allocation succeed, it will not fallback into
the if (crash_base == 0) case, the allocation result is the same
as Arm64, both for explicitly given "crashkernel=0M,low" or not.

The problem you mentioned might occurs when the first allocation
failed.

My logic here is when crashkernel=xM,high is specified, no matter
crashkernel=0M,low is explicitly given or not, "high" flag is set.
It will fallback to lower 4G allocation, additional lower 4G region
with "crash_low_size" will never get reserved.

So the results between Arm64 and riscv when crashkernel=,low is
specified or not are the same. Is there any problem with my logic,
or have I misunderstood your comment above?

>
>> +	}
>> +
>> +	if ((crash_base >= dma32_phys_limit) && crash_low_size &&
>> +	     reserve_crashkernel_low(crash_low_size)) {

Here, additional lower memory region will not reserve when
crashkernel=xM,high is given

>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>>   	}
>>   
>>   	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
>> -- 
>> 2.34.1
>>
Thanks,

Jiahao



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
