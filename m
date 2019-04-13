Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3 3/4] arm64: kdump: support more than one crash kernel
 regions
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-4-chenzhou10@huawei.com>
 <20190410130917.GC17196@rapoport-lnx>
 <137bef2e-8726-fd8f-1cb0-7592074f7870@huawei.com>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <673b95eb-ebdc-6fb0-e118-3dac7e04d272@huawei.com>
Date: Sat, 13 Apr 2019 16:14:16 +0800
MIME-Version: 1.0
In-Reply-To: <137bef2e-8726-fd8f-1cb0-7592074f7870@huawei.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: wangkefeng.wang@huawei.com, horms@verge.net.au, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, takahiro.akashi@linaro.org, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Hi Mike,

On 2019/4/11 20:17, Chen Zhou wrote:
> Hi Mike,
> =

> This overall looks well.
> Replacing memblock_cap_memory_range() with memblock_cap_memory_ranges() w=
as what i wanted
> to do in v1, sorry for don't express that clearly.
> =

> But there are some issues as below. After fixing this, it can work correc=
tly.
> =

> On 2019/4/10 21:09, Mike Rapoport wrote:
>> Hi,
>>
>> On Tue, Apr 09, 2019 at 06:28:18PM +0800, Chen Zhou wrote:
>>> After commit (arm64: kdump: support reserving crashkernel above 4G),
>>> there may be two crash kernel regions, one is below 4G, the other is
>>> above 4G.
>>>
>>> Crash dump kernel reads more than one crash kernel regions via a dtb
>>> property under node /chosen,
>>> linux,usable-memory-range =3D <BASE1 SIZE1 [BASE2 SIZE2]>
>>>
>>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>>> ---
>>>  arch/arm64/mm/init.c     | 66 ++++++++++++++++++++++++++++++++++++++++=
--------
>>>  include/linux/memblock.h |  6 +++++
>>>  mm/memblock.c            |  7 ++---
>>>  3 files changed, 66 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 3bebddf..0f18665 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -65,6 +65,11 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>>  =

>>>  #ifdef CONFIG_KEXEC_CORE
>>>  =

>>> +/* at most two crash kernel regions, low_region and high_region */
>>> +#define CRASH_MAX_USABLE_RANGES	2
>>> +#define LOW_REGION_IDX			0
>>> +#define HIGH_REGION_IDX			1
>>> +
>>>  /*
>>>   * reserve_crashkernel() - reserves memory for crash kernel
>>>   *
>>> @@ -297,8 +302,8 @@ static int __init early_init_dt_scan_usablemem(unsi=
gned long node,
>>>  		const char *uname, int depth, void *data)
>>>  {
>>>  	struct memblock_region *usablemem =3D data;
>>> -	const __be32 *reg;
>>> -	int len;
>>> +	const __be32 *reg, *endp;
>>> +	int len, nr =3D 0;
>>>  =

>>>  	if (depth !=3D 1 || strcmp(uname, "chosen") !=3D 0)
>>>  		return 0;
>>> @@ -307,22 +312,63 @@ static int __init early_init_dt_scan_usablemem(un=
signed long node,
>>>  	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
>>>  		return 1;
>>>  =

>>> -	usablemem->base =3D dt_mem_next_cell(dt_root_addr_cells, &reg);
>>> -	usablemem->size =3D dt_mem_next_cell(dt_root_size_cells, &reg);
>>> +	endp =3D reg + (len / sizeof(__be32));
>>> +	while ((endp - reg) >=3D (dt_root_addr_cells + dt_root_size_cells)) {
>>> +		usablemem[nr].base =3D dt_mem_next_cell(dt_root_addr_cells, &reg);
>>> +		usablemem[nr].size =3D dt_mem_next_cell(dt_root_size_cells, &reg);
>>> +
>>> +		if (++nr >=3D CRASH_MAX_USABLE_RANGES)
>>> +			break;
>>> +	}
>>>  =

>>>  	return 1;
>>>  }
>>>  =

>>>  static void __init fdt_enforce_memory_region(void)
>>>  {
>>> -	struct memblock_region reg =3D {
>>> -		.size =3D 0,
>>> -	};
>>> +	int i, cnt =3D 0;
>>> +	struct memblock_region regs[CRASH_MAX_USABLE_RANGES];
>>
>> I only now noticed that fdt_enforce_memory_region() uses memblock_region=
 to
>> pass the ranges around. If we'd switch to memblock_type instead, the
>> implementation of memblock_cap_memory_ranges() would be really
>> straightforward. Can you check if the below patch works for you? =

>>
>> >From e476d584098e31273af573e1a78e308880c5cf28 Mon Sep 17 00:00:00 2001
>> From: Mike Rapoport <rppt@linux.ibm.com>
>> Date: Wed, 10 Apr 2019 16:02:32 +0300
>> Subject: [PATCH] memblock: extend memblock_cap_memory_range to multiple =
ranges
>>
>> The memblock_cap_memory_range() removes all the memory except the range
>> passed to it. Extend this function to recieve memblock_type with the
>> regions that should be kept. This allows switching to simple iteration o=
ver
>> memblock arrays with 'for_each_mem_range' to remove the unneeded memory.
>>
>> Enable use of this function in arm64 for reservation of multile regions =
for
>> the crash kernel.
>>
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>  arch/arm64/mm/init.c     | 34 ++++++++++++++++++++++++----------
>>  include/linux/memblock.h |  2 +-
>>  mm/memblock.c            | 45 ++++++++++++++++++++++-------------------=
----
>>  3 files changed, 47 insertions(+), 34 deletions(-)
>>
>>  =

>> -void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t siz=
e)
>> +void __init memblock_cap_memory_ranges(struct memblock_type *regions_to=
_keep)
>>  {
>> -	int start_rgn, end_rgn;
>> -	int i, ret;
>> -
>> -	if (!size)
>> -		return;
>> -
>> -	ret =3D memblock_isolate_range(&memblock.memory, base, size,
>> -						&start_rgn, &end_rgn);
>> -	if (ret)
>> -		return;
>> -
>> -	/* remove all the MAP regions */
>> -	for (i =3D memblock.memory.cnt - 1; i >=3D end_rgn; i--)
>> -		if (!memblock_is_nomap(&memblock.memory.regions[i]))
>> -			memblock_remove_region(&memblock.memory, i);
>> +	phys_addr_t start, end;
>> +	u64 i;
>>  =

>> -	for (i =3D start_rgn - 1; i >=3D 0; i--)
>> -		if (!memblock_is_nomap(&memblock.memory.regions[i]))
>> -			memblock_remove_region(&memblock.memory, i);
>> +	/* truncate memory while skipping NOMAP regions */
>> +	for_each_mem_range(i, &memblock.memory, regions_to_keep, NUMA_NO_NODE,
>> +			   MEMBLOCK_NONE, &start, &end, NULL)
>> +		memblock_remove(start, end);
> =

> 1. use memblock_remove(start, size) instead of memblock_remove(start, end=
).
> =

> 2. There is a another hidden issue. We couldn't mix __next_mem_range()(ca=
lled by for_each_mem_range) operation
> with remove operation because __next_mem_range() records the index of las=
t time. If we do remove between
> __next_mem_range(), the index may be mess.
> =

> Therefore, we could do remove operation after for_each_mem_range like thi=
s, solution A:
>  void __init memblock_cap_memory_ranges(struct memblock_type *regions_to_=
keep)
>  {
> -	phys_addr_t start, end;
> -	u64 i;
> +	phys_addr_t start[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> +	phys_addr_t end[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> +	u64 i, nr =3D 0;
> =

>  	/* truncate memory while skipping NOMAP regions */
>  	for_each_mem_range(i, &memblock.memory, regions_to_keep, NUMA_NO_NODE,
> -			   MEMBLOCK_NONE, &start, &end, NULL)
> -		memblock_remove(start, end);
> +			   MEMBLOCK_NONE, &start[nr], &end[nr], NULL)
> +		nr++;
> +	for (i =3D 0; i < nr; i++)
> +		memblock_remove(start[i], end[i] - start[i]);
> =

>  	/* truncate the reserved regions */
> +	nr =3D 0;
>  	for_each_mem_range(i, &memblock.reserved, regions_to_keep, NUMA_NO_NODE,
> -			   MEMBLOCK_NONE, &start, &end, NULL)
> -		memblock_remove_range(&memblock.reserved, start, end);
> +			   MEMBLOCK_NONE, &start[nr], &end[nr], NULL)
> +		nr++;
> +	for (i =3D 0; i < nr; i++)
> +		memblock_remove_range(&memblock.reserved, start[i],
> +				end[i] - start[i]);
>  }
> =

> But a warning occurs when compiling:
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      mm/memblock.o
> mm/memblock.c: In function =91memblock_cap_memory_ranges=92:
> mm/memblock.c:1635:1: warning: the frame size of 36912 bytes is larger th=
an 2048 bytes [-Wframe-larger-than=3D]
>  }
> =

> another solution is my implementation in v1, solution B:
> +void __init memblock_cap_memory_ranges(struct memblock_type *regions_to_=
keep)

----------
> +{
> +   int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS];
> +   int i, j, ret, nr =3D 0;
> +   memblock_region *regs =3D regions_to_keep->regions;
> +
> +   nr =3D regions_to_keep -> cnt;
> +   if (!nr)
> +       return;
----------
Sorry, i sent the drafts by mistake. I mixed the drafts with my tested vers=
ion.
These lines replace with below.

+       int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS=
];
+       int i, j, ret, nr =3D 0;
+       struct memblock_region *regs =3D regions_to_keep->regions;
+
+       for (i =3D 0; i < regions_to_keep->cnt; i++) {
+               ret =3D memblock_isolate_range(&memblock.memory, regs[i].ba=
se,
+                               regs[i].size, &start_rgn[i], &end_rgn[i]);
+               if (ret)
+                       break;
+               nr++;
+       }
+       if (!nr)
+               return;

Thanks,
Chen Zhou

> +
> +   /* remove all the MAP regions */
> +   for (i =3D memblock.memory.cnt - 1; i >=3D end_rgn[nr - 1]; i--)
> +       if (!memblock_is_nomap(&memblock.memory.regions[i]))
> +           memblock_remove_region(&memblock.memory, i);
> +
> +   for (i =3D nr - 1; i > 0; i--)
> +       for (j =3D start_rgn[i] - 1; j >=3D end_rgn[i - 1]; j--)
> +           if (!memblock_is_nomap(&memblock.memory.regions[j]))
> +               memblock_remove_region(&memblock.memory, j);
> +
> +   for (i =3D start_rgn[0] - 1; i >=3D 0; i--)
> +       if (!memblock_is_nomap(&memblock.memory.regions[i]))
> +           memblock_remove_region(&memblock.memory, i);
> +
> +   /* truncate the reserved regions */
> +   memblock_remove_range(&memblock.reserved, 0, regs[0].base);
> +
> +   for (i =3D nr - 1; i > 0; i--)
> +       memblock_remove_range(&memblock.reserved,
> +               regs[i - 1].base + regs[i - 1].size,
> +		regs[i].base - regs[i - 1].base - regs[i - 1].size);
> +
> +   memblock_remove_range(&memblock.reserved,
> +           regs[nr - 1].base + regs[nr - 1].size, PHYS_ADDR_MAX);
> +}
> =

> solution A: 	phys_addr_t start[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> 		phys_addr_t end[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> start, end is physical addr
> =

> solution B: 	int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_=
REGIONS];
> start_rgn, end_rgn is rgn index		=

> =

> Solution B do less remove operations and with no warning comparing to sol=
ution A.
> I think solution B is better, could you give some suggestions?
> =

>>  =

>>  	/* truncate the reserved regions */
>> -	memblock_remove_range(&memblock.reserved, 0, base);
>> -	memblock_remove_range(&memblock.reserved,
>> -			base + size, PHYS_ADDR_MAX);
>> +	for_each_mem_range(i, &memblock.reserved, regions_to_keep, NUMA_NO_NOD=
E,
>> +			   MEMBLOCK_NONE, &start, &end, NULL)
>> +		memblock_remove_range(&memblock.reserved, start, end);
> =

> There are the same issues as above.
> =

>>  }
>>  =

>>  void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>>  {
>> +	struct memblock_region rgn =3D {
>> +		.base =3D 0,
>> +	};
>> +
>> +	struct memblock_type region_to_keep =3D {
>> +		.cnt =3D 1,
>> +		.max =3D 1,
>> +		.regions =3D &rgn,
>> +	};
>> +
>>  	phys_addr_t max_addr;
>>  =

>>  	if (!limit)
>> @@ -1646,7 +1644,8 @@ void __init memblock_mem_limit_remove_map(phys_add=
r_t limit)
>>  	if (max_addr =3D=3D PHYS_ADDR_MAX)
>>  		return;
>>  =

>> -	memblock_cap_memory_range(0, max_addr);
>> +	region_to_keep.regions[0].size =3D max_addr;
>> +	memblock_cap_memory_ranges(&region_to_keep);
>>  }
>>  =

>>  static int __init_memblock memblock_search(struct memblock_type *type, =
phys_addr_t addr)
>>
> =

> Thanks,
> Chen Zhou
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
