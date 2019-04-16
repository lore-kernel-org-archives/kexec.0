Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v4 3/5] memblock: add memblock_cap_memory_ranges for
 multiple ranges
References: <20190415105725.22088-1-chenzhou10@huawei.com>
 <20190415105725.22088-4-chenzhou10@huawei.com>
 <20190415190940.GA6081@rapoport-lnx>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <703cdbf0-b425-880b-b087-aaf3fe84673d@huawei.com>
Date: Tue, 16 Apr 2019 10:55:34 +0800
MIME-Version: 1.0
In-Reply-To: <20190415190940.GA6081@rapoport-lnx>
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
Cc: wangkefeng.wang@huawei.com, horms@verge.net.au, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, takahiro.akashi@linaro.org, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Hi Mike,

On 2019/4/16 3:09, Mike Rapoport wrote:
> Hi,
> 
> On Mon, Apr 15, 2019 at 06:57:23PM +0800, Chen Zhou wrote:
>> The memblock_cap_memory_range() removes all the memory except the
>> range passed to it. Extend this function to receive memblock_type
>> with the regions that should be kept.
>>
>> Enable this function in arm64 for reservation of multiple regions
>> for the crash kernel.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> I didn't work on this version, please drop the signed-off.

Sorry about this. I should ask you firstly before doing it this way. I will drop it.

		remove_size);
>> +	}
>> +
>> +	memblock_remove_range(&memblock.reserved,
>> +			regs[nr - 1].base + regs[nr - 1].size, PHYS_ADDR_MAX);
>> +}
>> +
> 
> I've double-checked and I see no problem with using
> for_each_mem_range_rev() iterators for removing some ranges. And with them
> this functions becomes much clearer and more efficient.
> 
> Can you please check if the below patch works for you?
> 
>>From e25e6c9cd94a01abac124deacc66e5d258fdbf7c Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Wed, 10 Apr 2019 16:02:32 +0300
> Subject: [PATCH] memblock: extend memblock_cap_memory_range to multiple ranges
> 
> The memblock_cap_memory_range() removes all the memory except the range
> passed to it. Extend this function to receive an array of memblock_regions
> that should be kept. This allows switching to simple iteration over
> memblock arrays with 'for_each_mem_range_rev' to remove the unneeded memory.
> 
> Enable use of this function in arm64 for reservation of multiple regions for
> the crash kernel.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/mm/init.c     | 34 ++++++++++++++++++++++++----------
>  include/linux/memblock.h |  2 +-
>  mm/memblock.c            | 44 ++++++++++++++++++++------------------------
>  3 files changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6bc1350..8665d29 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -64,6 +64,10 @@ EXPORT_SYMBOL(memstart_addr);
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  
>  #ifdef CONFIG_KEXEC_CORE
> +
> +/* at most two crash kernel regions, low_region and high_region */
> +#define CRASH_MAX_USABLE_RANGES	2
> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -280,9 +284,9 @@ early_param("mem", early_mem);
>  static int __init early_init_dt_scan_usablemem(unsigned long node,
>  		const char *uname, int depth, void *data)
>  {
> -	struct memblock_region *usablemem = data;
> -	const __be32 *reg;
> -	int len;
> +	struct memblock_type *usablemem = data;
> +	const __be32 *reg, *endp;
> +	int len, nr = 0;
>  
>  	if (depth != 1 || strcmp(uname, "chosen") != 0)
>  		return 0;
> @@ -291,22 +295,32 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
>  	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
>  		return 1;
>  
> -	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> -	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +	endp = reg + (len / sizeof(__be32));
> +	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> +		unsigned long base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +		unsigned long size = dt_mem_next_cell(dt_root_size_cells, &reg);
>  
> +		if (memblock_add_range(usablemem, base, size, NUMA_NO_NODE,
> +				       MEMBLOCK_NONE))
> +			return 0;
> +		if (++nr >= CRASH_MAX_USABLE_RANGES)
> +			break;
> +	}
>  	return 1;
>  }
>  
>  static void __init fdt_enforce_memory_region(void)
>  {
> -	struct memblock_region reg = {
> -		.size = 0,
> +	struct memblock_region usable_regions[CRASH_MAX_USABLE_RANGES];
> +	struct memblock_type usablemem = {
> +		.max = CRASH_MAX_USABLE_RANGES,
> +		.regions = usable_regions,
>  	};
>  
> -	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
> +	of_scan_flat_dt(early_init_dt_scan_usablemem, &usablemem);
>  
> -	if (reg.size)
> -		memblock_cap_memory_range(reg.base, reg.size);
> +	if (usablemem.cnt)
> +		memblock_cap_memory_ranges(usablemem.regions, usablemem.cnt);
>  }
>  
>  void __init arm64_memblock_init(void)
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 294d5d8..f5c029b 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -404,7 +404,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> -void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> +void memblock_cap_memory_ranges(struct memblock_region *regions, int count);
>  void memblock_mem_limit_remove_map(phys_addr_t limit);
>  bool memblock_is_memory(phys_addr_t addr);
>  bool memblock_is_map_memory(phys_addr_t addr);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e7665cf..8d4d060 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1605,36 +1605,31 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
>  			      PHYS_ADDR_MAX);
>  }
>  
> -void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
> -{
> -	int start_rgn, end_rgn;
> -	int i, ret;
> -
> -	if (!size)
> -		return;
> -
> -	ret = memblock_isolate_range(&memblock.memory, base, size,
> -						&start_rgn, &end_rgn);
> -	if (ret)
> -		return;
> -
> -	/* remove all the MAP regions */
> -	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
> -		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> -			memblock_remove_region(&memblock.memory, i);
> +void __init memblock_cap_memory_ranges(struct memblock_region *regions,
> +				       int count)
> +{
> +	struct memblock_type regions_to_keep = {
> +		.max = count,
> +		.cnt = count,
> +		.regions = regions,
> +	};
> +	phys_addr_t start, end;
> +	u64 i;
>  
> -	for (i = start_rgn - 1; i >= 0; i--)
> -		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> -			memblock_remove_region(&memblock.memory, i);
> +	/* truncate memory while skipping NOMAP regions */
> +	for_each_mem_range_rev(i, &memblock.memory, &regions_to_keep,
> +			       NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL)
> +		memblock_remove(start, end);

Yes, this works well.
A minor issue, replace memblock_remove(start, end) with memblock_remove(start, end - start).

>  
>  	/* truncate the reserved regions */
> -	memblock_remove_range(&memblock.reserved, 0, base);
> -	memblock_remove_range(&memblock.reserved,
> -			base + size, PHYS_ADDR_MAX);
> +	for_each_mem_range_rev(i, &memblock.reserved, &regions_to_keep,
> +			       NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL)
> +		memblock_remove_range(&memblock.reserved, start, end);

The same as above. Replace memblock_remove_range(&memblock.reserved, start, end) with
memblock_remove_range(&memblock.reserved, start, end - start).

Thanks,
Chen Zhou

>  }
>  
>  void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>  {
> +	struct memblock_region region = { 0 };
>  	phys_addr_t max_addr;
>  
>  	if (!limit)
> @@ -1646,7 +1641,8 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>  	if (max_addr == PHYS_ADDR_MAX)
>  		return;
>  
> -	memblock_cap_memory_range(0, max_addr);
> +	region.size = max_addr;
> +	memblock_cap_memory_ranges(&region, 1);
>  }
>  
>  static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
