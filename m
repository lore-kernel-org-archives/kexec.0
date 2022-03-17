From: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
Date: Thu, 17 Mar 2022 15:30:04 +0800
Subject: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
In-Reply-To: <YjKvUz+dKRkyxUAd@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <YjHUAi0xrUy+qk/L@MiWiFi-R3L-srv>
 <7d7a3e70-6a46-b722-ef48-7206a47185dd@huawei.com>
 <YjKeuFGtjI7944uy@MiWiFi-R3L-srv>
 <05a96786-cfe8-029f-f29a-60fb94129f91@huawei.com>
 <YjKvUz+dKRkyxUAd@MiWiFi-R3L-srv>
Message-ID: <eb26c623-6c7b-c3ba-acc8-654023ddd82b@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 2022/3/17 11:47, Baoquan He wrote:
> On 03/17/22 at 11:19am, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/3/17 10:36, Baoquan He wrote:
>>> On 03/16/22 at 09:11pm, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2022/3/16 20:11, Baoquan He wrote:
>>>>> On 02/27/22 at 11:07am, Zhen Lei wrote:
>>> ...... 
>>>
>>>>> Hi leizhen,
>>>>>
>>>>> I made change on reserve_crashkenrel(), inline comment may be slow.
>>>>> Please check and consider if they can be taken.
>>>>
>>>> That's great. Thank you very much.
>>>>
>>>>>
>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>> index 30ae6638ff54..f96351da1e3e 100644
>>>>> --- a/arch/arm64/mm/init.c
>>>>> +++ b/arch/arm64/mm/init.c
>>>>> @@ -109,38 +109,43 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>>>>>   * This function reserves memory area given in "crashkernel=" kernel command
>>>>>   * line parameter. The memory reserved is used by dump capture kernel when
>>>>>   * primary kernel is crashing.
>>>>> + *
>>>>> + * NOTE: Reservation of crashkernel,low is special since its existence
>>>>> + * is not independent, need rely on the existence of crashkernel,high.
>>>>> + * Hence there are different cases for crashkernel,low reservation:
>>>
>>> Considering to update the 3rd line as below:
>>>
>>>  * NOTE: Reservation of crashkernel,low is special since its existence
>>>  * is not independent, need rely on the existence of crashkernel,high.
>>>  * Here, four cases of crashkernel,low reservation are summarized: 
>>
>> OK. How about change "crashkernel,low" to "crashkernel low memory"?
>> "crashkernel=Y,low", "crashkernel=,low" and "crashkernel,low" are very similar,
>> may dazzle the reader.
> 
> Fine by me. 'crashkernel low memory' is formal, just make sentence a
> little longer. Please take what you think fitter.

OK, I will send v22 after v5.18-rc1.

> 
>>
>>>
>>>>> + * 1) crashkernel=Y,low is specified explicitly, crashkernel,low takes Y;
>>>>> + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
>>>>> + *    take the default crashkernel,low value;
>>>>> + * 3) crashkernel=X is specified, while fallback to get a memory region
>>>>> + *    in high memory, take the default crashkernel,low value;
>>>>> + * 4) crashkernel='invalid value',low is specified, failed the whole
>>>>> + *    crashkernel reservation and bail out.
>>>>>   */
>>>>>  static void __init reserve_crashkernel(void)
>>>>>  {
>>>>>  	unsigned long long crash_base, crash_size;
>>>>>  	unsigned long long crash_low_size;
>>>>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>>>> -	int ret;
>>>>>  	bool fixed_base, high = false;
>>>>>  	char *cmdline = boot_command_line;
>>>>> +	int ret;
>>>>>  
>>>>>  	/* crashkernel=X[@offset] */
>>>>>  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>>>>  				&crash_size, &crash_base);
>>>>>  	if (ret || !crash_size) {
>>>>> -		/* crashkernel=X,high */
>>>>>  		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>>>>>  		if (ret || !crash_size)
>>>>>  			return;
>>>>>  
>>>>> -		/* crashkernel=Y,low */
>>>>>  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>>>>>  		if (ret == -ENOENT)
>>>>> -			/*
>>>>> -			 * crashkernel=Y,low is not specified explicitly, use
>>>>> -			 * default size automatically.
>>>>> -			 */
>>>>> +			/* case #2 of crashkernel,low reservation */
>>>>>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>>>  		else if (ret)
>>>>> -			/* crashkernel=Y,low is specified but Y is invalid */
>>>>> +			/* case #4 of crashkernel,low reservation */
>>>>>  			return;
>>>>>  
>>>>> -		/* Mark crashkernel=X,high is specified */
>>>>>  		high = true;
>>>>>  		crash_max = CRASH_ADDR_HIGH_MAX;
>>>>>  	}
>>>>> @@ -148,7 +153,6 @@ static void __init reserve_crashkernel(void)
>>>>>  	fixed_base = !!crash_base;
>>>>>  	crash_size = PAGE_ALIGN(crash_size);
>>>>>  
>>>>> -	/* User specifies base address explicitly. */
>>>>>  	if (fixed_base)
>>>>>  		crash_max = crash_base + crash_size;
>>>>>  
>>>>> @@ -172,11 +176,7 @@ static void __init reserve_crashkernel(void)
>>>>>  	}
>>>>>  
>>>>>  	if (crash_base >= SZ_4G) {
>>>>> -		/*
>>>>> -		 * For case crashkernel=X, low memory is not enough and fall
>>>>> -		 * back to reserve specified size of memory above 4G, try to
>>>>> -		 * allocate minimum required memory below 4G again.
>>>>> -		 */
>>>>> +		/* case #3 of crashkernel,low reservation */
>>>>>  		if (!high)
>>>>>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>>>  
>>>>>
>>>>>>  
>>>>>> -	/* Current arm64 boot protocol requires 2MB alignment */
>>>>>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>>>>>> +retry:
>>>>>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>>>>>  					       crash_base, crash_max);
>>>>>>  	if (!crash_base) {
>>>>>> +		/*
>>>>>> +		 * Attempt to fully allocate low memory failed, fall back
>>>>>> +		 * to high memory, the minimum required low memory will be
>>>>>> +		 * reserved later.
>>>>>> +		 */
>>>>>> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>>>>>> +			crash_max = CRASH_ADDR_HIGH_MAX;
>>>>>> +			goto retry;
>>>>>> +		}
>>>>>> +
>>>>>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>>>>>  			crash_size);
>>>>>>  		return;
>>>>>>  	}
>>>>>>  
>>>>>> +	if (crash_base >= SZ_4G) {
>>>>>> +		/*
>>>>>> +		 * For case crashkernel=X, low memory is not enough and fall
>>>>>> +		 * back to reserve specified size of memory above 4G, try to
>>>>>> +		 * allocate minimum required memory below 4G again.
>>>>>> +		 */
>>>>>> +		if (!high)
>>>>>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>>>> +
>>>>>> +		if (reserve_crashkernel_low(crash_low_size)) {
>>>>>> +			memblock_phys_free(crash_base, crash_size);
>>>>>> +			return;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>>>>>  		crash_base, crash_base + crash_size, crash_size >> 20);
>>>>>>  
>>>>>> @@ -107,6 +194,9 @@ static void __init reserve_crashkernel(void)
>>>>>>  	 * map. Inform kmemleak so that it won't try to access it.
>>>>>>  	 */
>>>>>>  	kmemleak_ignore_phys(crash_base);
>>>>>> +	if (crashk_low_res.end)
>>>>>> +		kmemleak_ignore_phys(crashk_low_res.start);
>>>>>> +
>>>>>>  	crashk_res.start = crash_base;
>>>>>>  	crashk_res.end = crash_base + crash_size - 1;
>>>>>>  	insert_resource(&iomem_resource, &crashk_res);
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>> -- 
>>>> Regards,
>>>>   Zhen Lei
>>>>
>>>
>>> .
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei

