From: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
Date: Sat, 7 May 2022 17:35:32 +0800
Subject: [PATCH v24 3/6] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <9f6fdbb8-b6c5-3ca0-31b6-617175739e81@huawei.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
 <d9b21f31-6fd2-a898-9a70-c63ff4f36212@huawei.com>
 <YnXUSBcFmEpxaqBf@MiWiFi-R3L-srv>
 <9f6fdbb8-b6c5-3ca0-31b6-617175739e81@huawei.com>
Message-ID: <6e892914-74ae-2b8f-954e-342aaf4be870@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 2022/5/7 11:37, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/7 10:07, Baoquan He wrote:
>> On 05/07/22 at 09:34am, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2022/5/7 7:10, Baoquan He wrote:
>>>> On 05/06/22 at 07:43pm, Zhen Lei wrote:
>>>> ......  
>>>>> @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
>>>>>  	if (crash_base)
>>>>>  		crash_max = crash_base + crash_size;
>>>>>  
>>>>> -	/* Current arm64 boot protocol requires 2MB alignment */
>>>>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>>>>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>>>>  					       crash_base, crash_max);
>>>>>  	if (!crash_base) {
>>>>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>>>> @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
>>>>>  		return;
>>>>>  	}
>>>>>  
>>>>
>>>> There's corner case missed, e.g
>>>> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
>>>> 2) ,high and ,low are specified, the whole system memory is under 4G.
>>>>
>>>> Below judgement can filter them away:
>>>>         
>>>> 	if (crash_base > arm64_dma_phys_limit && crash_low_size &&
>>>> 	    reserve_crashkernel_low(crash_low_size)) {
>>>>
>>>> What's your opinion? Leave it and add document to notice user, or fix it
>>>> with code change?

I decided to modify the code and document. But the code changes aren't what
you suggested. For the following reasons:
1. The memory allocated for 'high' may be partially under 4G. So the low
   memory may not be enough. Of course, it's rare.
2. The second kernel can work properly only when the high and low memory
   are successfully applied for. For example, high=128M, low=128M, but the
   second kernel need 256M.

So for the cases you listed:
1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
   --> Follow you suggestion, ignore crashkernel=Y,low, don't allocate low memory.

@@ -100,6 +100,14 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
        unsigned long long low_base;

+       /*
+        * The kernel does not have any DMA zone, so the range of each DMA
+        * zone is unknown. Please make sure both CONFIG_ZONE_DMA and
+        * CONFIG_ZONE_DMA32 are also not set in the second kernel.
+        */
+       if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
+               return 0;
+

2) ,high and ,low are specified, the whole system memory is under 4G.
   --> two memory ranges will be allocated, the size is what 'high' and 'low' specified.
   --> Yes, the memory of 'low' may be above 'high', but the 'high' just hint allocation
   --> from top, try high memory first. Of course, this may cause kexec to fail to load.
   --> Because the memory of 'low' with small size will be used to store Image, etc..
   --> But the memory of 'low' above 'high' is almost impossible, we use memblock API to
   --> allocate memory from top to bottem, 'low' above 'high' need a sizeable memory block
   --> (128M, 256M?) to be freed at init phase.
   -->  Maybe I should add: crash_max = min(crash_base, CRASH_ADDR_LOW_MAX);
   --> to make sure the memory of 'low' is always under 'high'

>>>
>>> I think maybe we can leave it unchanged. If the user configures two memory ranges,
>>> we'd better apply for two. Otherwise, he'll be confused when he inquires. Currently,
>>> crash_low_size is non-zero only when 'crashkernel=Y,low' is explicitly configured.
>>
>> Then user need know the system information, e.g how much is the high
>> memory, low memory, if CONFIG_ZONE_DMA|DMA32 is enabled. And we need
>> describe these cases in document. Any corner case or exception need
>> be noted if we don't handle it in code.
>>
>> Caring about this very much because we have CI with existed test cases
>> to run on the system, and QA will check these manually too. Support
>> engineer need detailed document if anything special but happened.
>> Anything unclear or uncovered will be reported as bug to our kernel dev.
>> Guess your company do the similar thing like this.
>>
>> This crashkerne,high and crashkernel,low reservation is special if we
>> allow ,high, ,low existing in the same zone. Imagine on system with
>> CONFIG_ZONE_DMA|DMA32 disabled, people copy the crashkernel=512M,high
>> and crashkernel=128M,low from other system, and he could get
>> crash_res at [5G, 5G+512M], while crash_low_res at [6G, 6G+128M]. Guess
>> how they will judge us.
> 
> OK, I got it.
> 
>>
>>>
>>>>
>>>> I would suggest merging this series, Lei can add this corner case
>>>> handling on top. Since this is a newly added support, we don't have
>>>> to make it one step. Doing step by step can make reviewing easier.
>>>>
>>>>> +	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>>>>> +		memblock_phys_free(crash_base, crash_size);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>>>>  		crash_base, crash_base + crash_size, crash_size >> 20);
>>>>>  
>>>>> @@ -135,6 +183,9 @@ static void __init reserve_crashkernel(void)
>>>>>  	 * map. Inform kmemleak so that it won't try to access it.
>>>>>  	 */
>>>>>  	kmemleak_ignore_phys(crash_base);
>>>>> +	if (crashk_low_res.end)
>>>>> +		kmemleak_ignore_phys(crashk_low_res.start);
>>>>> +
>>>>>  	crashk_res.start = crash_base;
>>>>>  	crashk_res.end = crash_base + crash_size - 1;
>>>>>  	insert_resource(&iomem_resource, &crashk_res);
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>
>>>> .
>>>>
>>>
>>> -- 
>>> Regards,
>>>   Zhen Lei
>>>
>>
>> .
>>
> 

-- 
Regards,
  Zhen Lei

