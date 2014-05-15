Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkqwC-0004kN-9F
 for kexec@lists.infradead.org; Thu, 15 May 2014 08:22:49 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: ARM: get correct mem_map offset
Date: Thu, 15 May 2014 08:21:16 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9721103D@BPXM01GP.gisp.nec.co.jp>
References: <1399443356-46732-1-git-send-email-sdu.liu@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720FA9B@BPXM01GP.gisp.nec.co.jp>
 <53702313.7090703@huawei.com>
In-Reply-To: <53702313.7090703@huawei.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "sdu.liu@huawei.com" <sdu.liu@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>>> When converting paddr to pfn, makedumpfile firstly minuses the
>>> offset of physical memory, and then do the right shift. But the
>>> kernel only does the right shift.

(This is a trivial comment)
makedumpfile do the right shift first, this description isn't right.

  #define paddr_to_pfn(X) \
          (((unsigned long long)(X) >> PAGESHIFT()) - ARCH_PFN_OFFSET)

>> Did you mean the patch below is wrong?
>>
>>   commit 1e93ee75f9d47c219e833210eb31e4a747cc3a8d
>>   Author: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
>>   Date:   Tue Jun 22 09:59:10 2010 +0300
>>
>>       use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn translations
>>
>> Your description sounds we should fix the way to convert paddr to pfn,
>> but there is no such fix in your patch.
>
>
>Yes, my first version does just as what you say. But the patch is huge.
>I thing this patch is much better.
>
>Though commit 1e93ee75f9d47c219e833210eb31e4a747cc3a8d brings some problems
>. But we can easy fix them.
>
>
>Make my platform for example: ARCH_PFN_OFFSET=0x80000 sparse memory model.
>mem 1G ; SECTION_SIZE_BITS 26
>
> (a) for the kernel
>
>    section number |phy start |  start pfn   | end pfn  |  valid  | mem_section  	|
>	0	   |0	      |   0          |  3fff    |   0	  |   [0]	|
> 	1	   |4000000   |   4000       |  7fff    |   0	  |   [1]	|
>	2	   |8000000   |   8000       |  bfff    |   0	  |   [2]	|
>
>    [cut ...]
>
>       32 	   |80000000  |  80000	     | 83fff	|   1	  |  [32]	|
>       33 	   |84000000  |  84000	     | 87fff	|   1	  |  [33]	|
>
>    [cut ...]
>
>       47 	   |bfc00000  |  bfc000	     | bffff	|   1	  |  [47]	|
>
>
>  (b) for makedumpfile
>
>
>       0	   |80000000  |    0         |  3fff    |   0	  |   [0]	|
>       1 	   |84000000  |  4000        |  7fff    |   0	  |   [1]	|
>
>    [cut ...]
>
>       15 	   |bfc00000  |  3c000       | 3ffff	|   1	  |  [15]	|
>
>
>So makedumpfile removes the offset of section number and pfn. The relationship between
>pfn and section number remains as before. So this will not introduce problem.
>
>But the section nember and mem_section array do not match each other.
>
>For paddr 80000000
>	kernel        : pfn 8000: mem_section: 32
>	makedumpfile  : pfn 0   : mem_section: 0
>
>And we do not remove the offset of array mem_section. So makedumofile can not
>get the right page struct. When fix this offset, everything is ok.

Thanks for your explanation, I understand the sparse_mem case.

>But If we revert 1e93ee75f9d:
>
>  (a) codes likes "for(pfn = 0" ,"for_each_cycle(0" and "for (section_nr = 0"  should be changed;
>  (b) Due to "set_bit_on_1st_bitmap(pfn, cycle)", we will waste some bits.
>  (c) crash utility should also be changed.
>
>BTW, when ARCH_PFN_OFFSET=0, section nember and mem_section matches each other..
>So no problem was intrduced
>
>>
>>> For the cases of ARCH_PFN_OFFSET=0 or non sparse memormy model,
>>> this introduces no problem.
>>>
>>> But for my arma9 platform with ARCH_PFN_OFFSET=0x80000 and sparse
>>> memory model. Makedumfile can not get the mem_map correctly. It it
>>> due to there is still offset for mem_map array.
>>
>> Why the other memory models are OK? There is no offset even if ARCH_PFN_OFFSET!=0?
>> I need more explanation to understand this issue.
>
>(1) For flatmem, the mem_map is continuous, And the start address of mem_map comes from
>the kernel symbol.
>
>For paddr 80000000
>	kernel        : pfn 8000: mem_map[0]
>	makedumpfile  : pfn 0   : mem_map[0]
>
>This will not introduce problem.

I understand that alloc_node_mem_map() allocates mem_map for flatmem and it
considers ARCH_PFN_OFFSET like:

        if (pgdat == NODE_DATA(0)) {
                mem_map = NODE_DATA(0)->node_mem_map;
#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
                if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
                        mem_map -= (pgdat->node_start_pfn - ARCH_PFN_OFFSET);
#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
        }

So there is no problem in this model since the top of mem_map corresponds to
ARCH_PFN_OFFSET, right?

>(2) For discontigmem, it manages the mem_map with node_memblk. commit
>1e93ee75f9d47c21 also does no harm.

alloc_node_mem_map() allocates mem_map also for discontigmem, but I can't find
any codes to consider ARCH_PFN_OFFSET for this model.
So I suspect the mismatch between the pfn for makedumpfile and the actual content
of mem_map can exist. Could you explain why this case is OK in more detail?


Thanks
Atsushi Kumagai

>What do you think?
>
>Thanks,
>Liu Hua
>
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>>>
>>> This patch introduces the offset of the mem_map.
>>>
>>> But I have no environment to test this patch for other paltfrom.
>>> So I am not sure this patch works on other platforms.
>>>
>>> Signed-off-by: Liu Hua <sdu.liu@huawei.com>
>>> ---
>>> makedumpfile.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>> index 94515f6..6cf6e24 100644
>>> --- a/makedumpfile.c
>>> +++ b/makedumpfile.c
>>> @@ -2807,6 +2807,7 @@ int
>>> get_mm_sparsemem(void)
>>> {
>>> 	unsigned int section_nr, mem_section_size, num_section;
>>> +	unsigned int section_start;
>>> 	mdf_pfn_t pfn_start, pfn_end;
>>> 	unsigned long section, mem_map;
>>> 	unsigned long *mem_sec = NULL;
>>> @@ -2817,6 +2818,7 @@ get_mm_sparsemem(void)
>>> 	 * Get the address of the symbol "mem_section".
>>> 	 */
>>> 	num_section = divideup(info->max_mapnr, PAGES_PER_SECTION());
>>> +	section_start = ARCH_PFN_OFFSET / PAGES_PER_SECTION();
>>> 	if (is_sparsemem_extreme()) {
>>> 		info->sections_per_root = _SECTIONS_PER_ROOT_EXTREME();
>>> 		mem_section_size = sizeof(void *) * NR_SECTION_ROOTS();
>>> @@ -2842,7 +2844,7 @@ get_mm_sparsemem(void)
>>> 		goto out;
>>> 	}
>>> 	for (section_nr = 0; section_nr < num_section; section_nr++) {
>>> -		section = nr_to_section(section_nr, mem_sec);
>>> +		section = nr_to_section(section_nr + section_start, mem_sec);
>>> 		if (section == NOT_KV_ADDR) {
>>> 			mem_map = NOT_MEMMAP_ADDR;
>>> 		} else {
>>> @@ -2851,7 +2853,7 @@ get_mm_sparsemem(void)
>>> 				mem_map = NOT_MEMMAP_ADDR;
>>> 			} else {
>>> 				mem_map = sparse_decode_mem_map(mem_map,
>>> -								section_nr);
>>> +								section_nr + section_start);
>>> 				if (!is_kvaddr(mem_map))
>>> 					mem_map = NOT_MEMMAP_ADDR;
>>> 			}
>>> --
>>> 1.9.0
>>
>>
>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
