Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F84FEB64D9
	for <kexec@archiver.kernel.org>; Thu, 15 Jun 2023 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/HjzsycJbzGX1J+aWIdKDrRzm3sjl1J8TmVTMmf4pEw=; b=CWLIIaydT20ArP
	XW2IZjdFpsYAFRKBjxYAFMfislAf0LUfVMbNxRG/kAHwuA6EYYR6FKuSVS+6kmmlB+W7RhwwwPfc8
	LF037UEVfu9oFPjdHyw0jo+rS+zp0K8Jr2jRSvjF8IRWZlkUSAA/mF1KzdhTZ8zDa+T4NW1vHjZOh
	rKA0pmzzgGZ84VtRbNtt3JnrdumGe4/50H4iFNVplFmAIWRFLzQK1IEMXGTiH8C2zcOESVaqRdzzx
	T0H2/MQmqal8gdsZlKbRAkfz7Dcx+HIlMXN67eGSjGBsqPRBRyyY6B3gcku7dBRWoJ5H04O41tRh9
	N3XeB/MOJf047t1uDmgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jbY-00EMVJ-0E;
	Thu, 15 Jun 2023 09:49:24 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jbU-00EMT2-2y;
	Thu, 15 Jun 2023 09:49:23 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qhcs36BWrzLmp5;
	Thu, 15 Jun 2023 17:47:19 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 17:49:10 +0800
Message-ID: <852b8777-3c6e-f76b-0413-1c66629f33cd@huawei.com>
Date: Thu, 15 Jun 2023 17:49:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v5 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
To: Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230511085139.1039088-1-chenjiahao16@huawei.com>
 <20230511085139.1039088-2-chenjiahao16@huawei.com>
 <ZHwKFADVXyNYJBCp@MiWiFi-R3L-srv>
Content-Language: en-US
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZHwKFADVXyNYJBCp@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_024921_286565_D34D9C42 
X-CRM114-Status: GOOD (  18.99  )
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


On 2023/6/4 11:50, Baoquan He wrote:
> Hi Jiahao,
>
> On 05/11/23 at 04:51pm, Chen Jiahao wrote:
> ......
>> @@ -1300,14 +1325,34 @@ static void __init reserve_crashkernel(void)
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
>> +		search_end = memblock_end_of_DRAM();
>> +	} else if (ret || !crash_size) {
>> +		/* Invalid argument value specified */
>>   		return;
>> +	}
> The parsing part looks great, while you didn't mark if it's specified
> high reservation, please see later comment why it's needed.
>
>>   
>>   	crash_size = PAGE_ALIGN(crash_size);
>>   
>>   	if (crash_base) {
>> +		fixed_base = true;
>>   		search_start = crash_base;
>>   		search_end = crash_base + crash_size;
>>   	}
>> @@ -1320,17 +1365,31 @@ static void __init reserve_crashkernel(void)
>>   	 * swiotlb can work on the crash kernel.
>>   	 */
>>   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -					       search_start,
>> -					       min(search_end, (unsigned long) SZ_4G));
>> +					       search_start, search_end);
> If it's a specified high reservation, you have
> search_start = memblock_start_of_DRAM();
> search_end = memblock_end_of_DRAM();
>
> Then it attempts to search top down first time here.
>
>>   	if (crash_base == 0) {
>> -		/* Try again without restricting region to 32bit addressible memory */
>> +		if (fixed_base) {
>> +			pr_warn("crashkernel: allocating failed with given size@offset\n");
>> +			return;
>> +		}
>> +		search_end = memblock_end_of_DRAM();
>> +
>> +		/* Try again above the region of 32bit addressible memory */
>>   		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -						search_start, search_end);
>> +						       search_start, search_end);
> If crashkernel=,high case, the first attempt failed, here it assigns
> search_end with memblock_end_of_DRAM(). It's the exactly the same
> attempt, why is that needed? Why don't you use a local variable 'high'
> to mark the crashkernel=,hig, then judge when deciding how to adjsut the
> reservation range.
>
> Do I misunderstand the code?
>
> Thanks
> Baoquan

You are right. Here I use search_end = memblock_end_of_DRAM() for the
first attempt on "crashkernel=,high" case, but it will not distinct from
other cases if the first attempt fails.

I have read your latest refactor on Arm64, introducing the "high" flag
is a good choice, the logic gets more straightforward when handling
crashkernel=,high case and retrying.

Following that logic, here introducing and set "high" flag when parsing
cmdline, when the first attempt failed:

if fixed_base:
     failed and return;

if set high:
     search_start = memblock_start_of_DRAM();
     search_end = (unsigned long)dma32_phys_limit;
else:
     search_start = (unsigned long)dma32_phys_limit;
     search_end = memblock_end_of_DRAM();

second attempt with new {search_start, search_end}
...

This should handle "crashkernel=,high" case correctly and avoid cross
4G reservation.

Is that logic correct, or is any other problem missed?

Thanks,
Jiahao

>
>>   		if (crash_base == 0) {
>>   			pr_warn("crashkernel: couldn't allocate %lldKB\n",
>>   				crash_size >> 10);
>>   			return;
>>   		}
>> +
>> +		if (!crash_low_size)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +	}
>> +
>> +	if ((crash_base > dma32_phys_limit - crash_low_size) &&
>> +	    crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>>   	}
>>   
>>   	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
>> -- 
>> 2.31.1
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
