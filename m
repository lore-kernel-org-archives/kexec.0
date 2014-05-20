Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WmfC1-0004y1-5x
 for kexec@lists.infradead.org; Tue, 20 May 2014 08:14:38 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: ARM: get correct mem_map offset
Date: Tue, 20 May 2014 08:12:55 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97212378@BPXM01GP.gisp.nec.co.jp>
References: <1399443356-46732-1-git-send-email-sdu.liu@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720FA9B@BPXM01GP.gisp.nec.co.jp>
 <53702313.7090703@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9721103D@BPXM01GP.gisp.nec.co.jp>
 <5379C052.50108@huawei.com>
In-Reply-To: <5379C052.50108@huawei.com>
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

>>>> Did you mean the patch below is wrong?
>>>>
>>>>   commit 1e93ee75f9d47c219e833210eb31e4a747cc3a8d
>>>>   Author: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
>>>>   Date:   Tue Jun 22 09:59:10 2010 +0300
>>>>
>>>>       use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn translations
>>>>
>>>> Your description sounds we should fix the way to convert paddr to pfn,
>>>> but there is no such fix in your patch.
>>>
>>>
>>> Yes, my first version does just as what you say. But the patch is huge.
>>> I thing this patch is much better.
>>>
>>> Though commit 1e93ee75f9d47c219e833210eb31e4a747cc3a8d brings some problems
>>> . But we can easy fix them.
>>>
>>>
>>> Make my platform for example:	80000 sparse memory model.
>>> mem 1G ; SECTION_SIZE_BITS 26
>>>
>>> (a) for the kernel
>>>
>>>    section number |phy start |  start pfn   | end pfn  |  valid  | mem_section  	|
>>> 	0	   |0	      |   0          |  3fff    |   0	  |   [0]	|
>>> 	1	   |4000000   |   4000       |  7fff    |   0	  |   [1]	|
>>> 	2	   |8000000   |   8000       |  bfff    |   0	  |   [2]	|
>>>
>>>    [cut ...]
>>>
>>>       32 	   |80000000  |  80000	     | 83fff	|   1	  |  [32]	|
>>>       33 	   |84000000  |  84000	     | 87fff	|   1	  |  [33]	|
>>>
>>>    [cut ...]
>>>
>>>       47 	   |bfc00000  |  bfc000	     | bffff	|   1	  |  [47]	|
>>>
>>>
>>>  (b) for makedumpfile
>>>
>>>
>>>       0	   |80000000  |    0         |  3fff    |   0	  |   [0]	|
>>>       1 	   |84000000  |  4000        |  7fff    |   0	  |   [1]	|
>>>
>>>    [cut ...]
>>>
>>>       15 	   |bfc00000  |  3c000       | 3ffff	|   1	  |  [15]	|
>>>
>>>
>>> So makedumpfile removes the offset of section number and pfn. The relationship between
>>> pfn and section number remains as before. So this will not introduce problem.
>>>
>>> But the section nember and mem_section array do not match each other.
>>>
>>> For paddr 80000000
>>> 	kernel        : pfn 8000: mem_section: 32
>>> 	makedumpfile  : pfn 0   : mem_section: 0
>>>
>>> And we do not remove the offset of array mem_section. So makedumofile can not
>>> get the right page struct. When fix this offset, everything is ok.
>>
>> Thanks for your explanation, I understand the sparse_mem case.
>>
>>> But If we revert 1e93ee75f9d:
>>>
>>>  (a) codes likes "for(pfn = 0" ,"for_each_cycle(0" and "for (section_nr = 0"  should be changed;
>>>  (b) Due to "set_bit_on_1st_bitmap(pfn, cycle)", we will waste some bits.
>>>  (c) crash utility should also be changed.
>>>
>>> BTW, when ARCH_PFN_OFFSET=0, section nember and mem_section matches each other..
>>> So no problem was intrduced
>>>
>>>>
>>>>> For the cases of ARCH_PFN_OFFSET=0 or non sparse memormy model,
>>>>> this introduces no problem.
>>>>>
>>>>> But for my arma9 platform with ARCH_PFN_OFFSET=0x80000 and sparse
>>>>> memory model. Makedumfile can not get the mem_map correctly. It it
>>>>> due to there is still offset for mem_map array.
>>>>
>>>> Why the other memory models are OK? There is no offset even if ARCH_PFN_OFFSET!=0?
>>>> I need more explanation to understand this issue.
>>>
>>> (1) For flatmem, the mem_map is continuous, And the start address of mem_map comes from
>>> the kernel symbol.
>>>
>>> For paddr 80000000
>>> 	kernel        : pfn 8000: mem_map[0]
>>> 	makedumpfile  : pfn 0   : mem_map[0]
>>>
>>> This will not introduce problem.
>>
>> I understand that alloc_node_mem_map() allocates mem_map for flatmem and it
>> considers ARCH_PFN_OFFSET like:
>>
>>         if (pgdat == NODE_DATA(0)) {
>>                 mem_map = NODE_DATA(0)->node_mem_map;
>> #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>>                 if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
>>                         mem_map -= (pgdat->node_start_pfn - ARCH_PFN_OFFSET);
>> #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>
>In all cases, mem_map indicates the start address of the mem_map.
>
>I think this is the inner process for the kernel, which we should not consider. Because once
>we get the mem_map symbol value and the maxpfn from the vmcore. We know the start and length
>of mem_map. And we can get every page struct correctly.
>
>For makedumpfile:
>
> get_mm_flatmem(void)
>{
>  ....
>2409         if (!readmem(VADDR, SYMBOL(mem_map), &mem_map, sizeof mem_map)//get the mem_map value
>  ....
>2421         if (is_xen_memory())
>2422                 dump_mem_map(0, info->dom0_mapnr, mem_map, 0);
>2423         else
>2424                 dump_mem_map(0, info->max_mapnr, mem_map, 0);
>
>}
>
>So for flat memory model, makedumpfile can always get the correct mem_map.

I don't worry that we can't get the start address of the mem_map.

You said the kernel doesn't consider ARCH_PFN_OFFSET when converting paddr
to pfn, this sounds the kernel doesn't make an exception for the pages lower
than ARCH_PFN_OFFSET in page management to me.
I mean I worry about a situation like below:

(For example, ARCH_PFN_OFFSET=0x4)

      phys addr   |   pfn for    |  pfn for       |  valid  |  mem_map  
                  |   kernel     |  makedumpfile  |         |(struct page)
    --------------+--------------+----------------+---------+------------
        0 -  fff  |      0       |       X        |    0    |    [0]    
     1000 - 1fff  |      1       |       X        |    0    |    [1]    
     2000 - 2fff  |      2       |       X        |    0    |    [2]    
     3000 - 3fff  |      3       |       X        |    0    |    [3]    
     4000 - 4fff  |      4       |       0        |    1    |    [4]    
     5000 - 5fff  |      5       |       1        |    1    |    [5]    
     6000 - 6fff  |      6       |       2        |    1    |    [6]    
         ...

When we check the page flag of the page[4000-4fff] in makedumpfile, we
have to read mem_map[4], but makedumpfile reads mem_map[0] due to
paddr_to_pfn(). This is my worry.

Actually, the similar gap exists in the sparse_mem case as you described,
so I suspect we have to take care of it also for other memory models.

>>         }
>>
>> So there is no problem in this model since the top of mem_map corresponds to
>> ARCH_PFN_OFFSET, right?
>
>I don't think so. Is it clear for my words above?
>
>>
>>> (2) For discontigmem, it manages the mem_map with node_memblk. commit
>>> 1e93ee75f9d47c21 also does no harm.
>>
>> alloc_node_mem_map() allocates mem_map also for discontigmem, but I can't find
>> any codes to consider ARCH_PFN_OFFSET for this model.
>> So I suspect the mismatch between the pfn for makedumpfile and the actual content
>> of mem_map can exist. Could you explain why this case is OK in more detail?
>>
>Actually I did not test this memory model. I reach my conclusion via the codes.
>
>get_mm_discontigmem
>{
>....
>for (i = 0; i < vt.numnodes; i++) {  //loop for every node
>2591                 if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_start_pfn),
>2592                     &pfn_start, sizeof pfn_start)) {           //get pfn_start for this node
>....
>2596                 if (!readmem(VADDR,pgdat+OFFSET(pglist_data.node_spanned_pages),
>2597                     &node_spanned_pages, sizeof node_spanned_pages)) { //get the number of pages in this node
>
>2603                 if (SYMBOL(vmem_map) == NOT_FOUND_SYMBOL) {
>2604                         if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_mem_map),  //get the mem_map for this
>node.
>2605                             &mem_map, sizeof mem_map)) {
>2606                                 ERRMSG("Can't get mem_map.\n");
>2607                                 return FALSE;
>2608                         }
>2609                 } else
>2610                         mem_map = vmem_map + (SIZE(page) * pfn_start);
>....
>}
>
>So I think for discontigmem, makedumpfile can get the start address and length of mem_map from vmcore directly.
>And Everything can go well without ARCH_PFN_OFFSET.

The same can be said, is it not needed to consider ARCH_PFN_OFFSET
to get a page struct from the mem_map?


Thanks
Atsushi Kumagai

>
>Perhaps I need some tests on discontigmem. Did I explan my idea clearly?
>
>
>
>>
>> Thanks
>> Atsushi Kumagai
>>
>>> What do you think?
>>>
>>> Thanks,
>>> Liu Hua
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
