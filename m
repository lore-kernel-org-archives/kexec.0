From: John Donnelly <John.p.donnelly@oracle.com>
Date: Sat, 7 May 2022 12:30:33 -0500
Subject: [PATCH v24 3/6] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <20220506231032.GA122876@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
Message-ID: <b399d57a-3773-a78e-94f7-aa6829568080@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 5/6/22 6:10 PM, Baoquan He wrote:
> On 05/06/22 at 07:43pm, Zhen Lei wrote:
> ......
>> @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
>>   	if (crash_base)
>>   		crash_max = crash_base + crash_size;
>>   
>> -	/* Current arm64 boot protocol requires 2MB alignment */
>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>   					       crash_base, crash_max);
>>   	if (!crash_base) {
>>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
>>   		return;
>>   	}
>>   
> 
> There's corner case missed, e.g
> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> 2) ,high and ,low are specified, the whole system memory is under 4G.
> 
> Below judgement can filter them away:
>          
> 	if (crash_base > arm64_dma_phys_limit && crash_low_size &&
> 	    reserve_crashkernel_low(crash_low_size)) {
> 
> What's your opinion? Leave it and add document to notice user, or fix it
> with code change >
> I would suggest merging this series, Lei can add this corner case
> handling on top. Since this is a newly added support, we don't have
> to make it one step. Doing step by step can make reviewing easier.

Lets get this added and tested with a broader audience. It has been in 
review since March, 4th 2019 - 3+ years. I applaud Zhen for his 
endurance and patience in carrying this for so long.


> 
>> +	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>> +	}
>> +
>>   	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>   		crash_base, crash_base + crash_size, crash_size >> 20);
>>   
>> @@ -135,6 +183,9 @@ static void __init reserve_crashkernel(void)
>>   	 * map. Inform kmemleak so that it won't try to access it.
>>   	 */
>>   	kmemleak_ignore_phys(crash_base);
>> +	if (crashk_low_res.end)
>> +		kmemleak_ignore_phys(crashk_low_res.start);
>> +
>>   	crashk_res.start = crash_base;
>>   	crashk_res.end = crash_base + crash_size - 1;
>>   	insert_resource(&iomem_resource, &crashk_res);
>> -- 
>> 2.25.1
>>
> 


