Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 2/3] arm64: kdump: support more than one crash kernel
 regions
References: <20190403030546.23718-1-chenzhou10@huawei.com>
 <20190403030546.23718-3-chenzhou10@huawei.com>
 <20190403112929.GA7715@rapoport-lnx>
 <f98a5559-3659-fb35-3765-15861e70a796@huawei.com>
 <20190404144408.GA6433@rapoport-lnx>
 <783b8712-ddb1-a52b-81ee-0c6a216e5b7d@huawei.com>
 <4b188535-c12d-e05b-9154-2c2d580f903b@huawei.com>
 <20190408065711.GA8403@rapoport-lnx>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <3fc772a2-292b-9c2a-465f-eabe86961dfd@huawei.com>
Date: Mon, 8 Apr 2019 16:39:59 +0800
MIME-Version: 1.0
In-Reply-To: <20190408065711.GA8403@rapoport-lnx>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: wangkefeng.wang@huawei.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, takahiro.akashi@linaro.org, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Mike,

On 2019/4/8 14:57, Mike Rapoport wrote:
> Hi,
> 
> On Fri, Apr 05, 2019 at 11:47:27AM +0800, Chen Zhou wrote:
>> Hi Mike,
>>
>> On 2019/4/5 10:17, Chen Zhou wrote:
>>> Hi Mike,
>>>
>>> On 2019/4/4 22:44, Mike Rapoport wrote:
>>>> Hi,
>>>>
>>>> On Wed, Apr 03, 2019 at 09:51:27PM +0800, Chen Zhou wrote:
>>>>> Hi Mike,
>>>>>
>>>>> On 2019/4/3 19:29, Mike Rapoport wrote:
>>>>>> On Wed, Apr 03, 2019 at 11:05:45AM +0800, Chen Zhou wrote:
>>>>>>> After commit (arm64: kdump: support reserving crashkernel above 4G),
>>>>>>> there may be two crash kernel regions, one is below 4G, the other is
>>>>>>> above 4G.
>>>>>>>
>>>>>>> Crash dump kernel reads more than one crash kernel regions via a dtb
>>>>>>> property under node /chosen,
>>>>>>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
>>>>>>>
>>>>>>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>>>>>>> ---
>>>>>>>  arch/arm64/mm/init.c     | 37 +++++++++++++++++++++++++------------
>>>>>>>  include/linux/memblock.h |  1 +
>>>>>>>  mm/memblock.c            | 40 ++++++++++++++++++++++++++++++++++++++++
>>>>>>>  3 files changed, 66 insertions(+), 12 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>>>> index ceb2a25..769c77a 100644
>>>>>>> --- a/arch/arm64/mm/init.c
>>>>>>> +++ b/arch/arm64/mm/init.c
>>>>>>> @@ -64,6 +64,8 @@ EXPORT_SYMBOL(memstart_addr);
>>>>>>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>>>>>>  
>>>>>>>  #ifdef CONFIG_KEXEC_CORE
>>>>>>> +# define CRASH_MAX_USABLE_RANGES        2
>>>>>>> +
>>>>>>>  static int __init reserve_crashkernel_low(void)
>>>>>>>  {
>>>>>>>  	unsigned long long base, low_base = 0, low_size = 0;
>>>>>>> @@ -346,8 +348,8 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
>>>>>>>  		const char *uname, int depth, void *data)
>>>>>>>  {
>>>>>>>  	struct memblock_region *usablemem = data;
>>>>>>> -	const __be32 *reg;
>>>>>>> -	int len;
>>>>>>> +	const __be32 *reg, *endp;
>>>>>>> +	int len, nr = 0;
>>>>>>>  
>>>>>>>  	if (depth != 1 || strcmp(uname, "chosen") != 0)
>>>>>>>  		return 0;
>>>>>>> @@ -356,22 +358,33 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
>>>>>>>  	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
>>>>>>>  		return 1;
>>>>>>>  
>>>>>>> -	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
>>>>>>> -	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
>>>>>>> +	endp = reg + (len / sizeof(__be32));
>>>>>>> +	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
>>>>>>> +		usablemem[nr].base = dt_mem_next_cell(dt_root_addr_cells, &reg);
>>>>>>> +		usablemem[nr].size = dt_mem_next_cell(dt_root_size_cells, &reg);
>>>>>>> +
>>>>>>> +		if (++nr >= CRASH_MAX_USABLE_RANGES)
>>>>>>> +			break;
>>>>>>> +	}
>>>>>>>  
>>>>>>>  	return 1;
>>>>>>>  }
>>>>>>>  
>>>>>>>  static void __init fdt_enforce_memory_region(void)
>>>>>>>  {
>>>>>>> -	struct memblock_region reg = {
>>>>>>> -		.size = 0,
>>>>>>> -	};
>>>>>>> -
>>>>>>> -	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
>>>>>>> -
>>>>>>> -	if (reg.size)
>>>>>>> -		memblock_cap_memory_range(reg.base, reg.size);
>>>>>>> +	int i, cnt = 0;
>>>>>>> +	struct memblock_region regs[CRASH_MAX_USABLE_RANGES];
>>>>>>> +
>>>>>>> +	memset(regs, 0, sizeof(regs));
>>>>>>> +	of_scan_flat_dt(early_init_dt_scan_usablemem, regs);
>>>>>>> +
>>>>>>> +	for (i = 0; i < CRASH_MAX_USABLE_RANGES; i++)
>>>>>>> +		if (regs[i].size)
>>>>>>> +			cnt++;
>>>>>>> +		else
>>>>>>> +			break;
>>>>>>> +	if (cnt)
>>>>>>> +		memblock_cap_memory_ranges(regs, cnt);
>>>>>>
>>>>>> Why not simply call memblock_cap_memory_range() for each region?
>>>>>
>>>>> Function memblock_cap_memory_range() removes all memory type ranges except specified range.
>>>>> So if we call memblock_cap_memory_range() for each region simply, there will be no usable-memory
>>>>> on kdump capture kernel.
>>>>
>>>> Thanks for the clarification.
>>>> I still think that memblock_cap_memory_ranges() is overly complex. 
>>>>
>>>> How about doing something like this:
>>>>
>>>> Cap the memory range for [min(regs[*].start, max(regs[*].end)] and then
>>>> removing the range in the middle?
>>>
>>> Yes, that would be ok. But that would do one more memblock_cap_memory_range operation.
>>> That is, if there are n regions, we need to do (n + 1) operations, which doesn't seem to
>>> matter.
>>>
>>> I agree with you, your idea is better.
>>>
>>> Thanks,
>>> Chen Zhou
>>
>> Sorry, just ignore my previous reply, I got that wrong.
>>
>> I think it carefully, we can cap the memory range for [min(regs[*].start, max(regs[*].end)]
>> firstly. But how to remove the middle ranges, we still can't use memblock_cap_memory_range()
>> directly and the extra remove operation may be complex.
>>
>> For more than one regions, i think add a new memblock_cap_memory_ranges() may be better.
>> Besides, memblock_cap_memory_ranges() is also applicable for one region.
>>
>> How about replace memblock_cap_memory_range() with memblock_cap_memory_ranges()?
> 
> arm64 is the only user of both MEMBLOCK_NOMAP and memblock_cap_memory_range()
> and I don't expect other architectures will use these interfaces.
> It seems that capping the memory for arm64 crash kernel the way I've
> suggested can be implemented in fdt_enforce_memory_region(). If we'd ever
> need such functionality elsewhere or CRASH_MAX_USABLE_RANGES will need to
> grow we'll rethink the solution.

Ok, i will implement that in fdt_enforce_memory_region() in next version.
And we will support at most two crash kernel regions now.

Thanks,
Chen Zhou

>  
>> Thanks,
>> Chen Zhou
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
