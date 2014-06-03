Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WriNL-00069r-HT
 for kexec@lists.infradead.org; Tue, 03 Jun 2014 06:39:12 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: ARM: get correct mem_map offset
Date: Tue, 3 Jun 2014 06:37:20 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97216F04@BPXM01GP.gisp.nec.co.jp>
References: <1399443356-46732-1-git-send-email-sdu.liu@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720FA9B@BPXM01GP.gisp.nec.co.jp>
 <53702313.7090703@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9721103D@BPXM01GP.gisp.nec.co.jp>
 <5379C052.50108@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97212378@BPXM01GP.gisp.nec.co.jp>
 <5382CE50.4050807@huawei.com>
In-Reply-To: <5382CE50.4050807@huawei.com>
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

Hello Liu,

I rechecked the current code, then I lost the necessity of
1e93ee75f9d47c219e833210eb31e4a747cc3a8d...

>Sorry, I missed the point.
>
>(1)for flatmem model, kernel get the page struct after minusing ARCH_PFN_OFFSET
> 28 #if defined(CONFIG_FLATMEM)
> 29
> 30 #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
> 31 #define __page_to_pfn(page)     ((unsigned long)((page) - mem_map) + \
> 32                                  ARCH_PFN_OFFSET)
>
>So, 1e93ee75f9d47c219e833210eb31e4a747cc3a8d do no harm.

I understand that the base of the kernel's mem_map is ARCH_PFN_OFFSET
and makedumpfile gets the its address as:

    dump_mem_map(0, info->max_mapnr, mem_map, 0);
                ^^^ 
               doesn't consider the offset

so makedumpfile's mem_map[] has the offset at this point.
The filtering process(exclude_unnecessary_pages()) doesn't consider the offset
while the writing process(write_kdump_pages()) considers it.
This thing will make the gap between the page descriptor and the page itself.

>(2)for discontigmem model
>
> 18 #ifndef arch_local_page_offset
> 19 #define arch_local_page_offset(pfn, nid)        \
> 20         ((pfn) - NODE_DATA(nid)->node_start_pfn)
> 21 #endif
> 22
> 23 #endif /* CONFIG_DISCONTIGMEM */
>
>.....
>
> 33 #elif defined(CONFIG_DISCONTIGMEM)
> 34
> 35 #define __pfn_to_page(pfn)                      \
> 36 ({      unsigned long __pfn = (pfn);            \
> 37         unsigned long __nid = arch_pfn_to_nid(__pfn);  \
> 38         NODE_DATA(__nid)->node_mem_map + arch_local_page_offset(__pfn, __nid);\
> 39 })
>
>
>The kernel minuses "NODE_DATA(nid)->node_start_pfn". So relative postion is got
>for the tranfser.

Hmm, I think the process above just means each NODE_DATA(nid)->node_mem_map
corresponds to its own region which starts at NODE_DATA(nid)->node_start_pfn.
It looks kernel's mem_map doesn't have the offest and makedumpfile get it
as it is, so makedumpfile's mem_map[] has no offset.

>So to get page struct
>
>kernel        :  paddr --> pfn  -[consider ARCH_PFN_OFFSET ] -> page
>makedumpfile  :  paddr -[consider ARCH_PFN_OFFSET] -> pfn  --> page

Why does ARCH_PFN_OFFSET appear here ? I couldn't find the code.

Anyway, the gap between the page descriptor and the page itself will appear
like flatmem.

>
>So I think commit 1e93ee75f9d47c219e833210eb31e4a747cc3a8d can fit discontigmem and flatmem.
>After applying this patch, it also fits sparsemem model. What do you think?

If my understanding is correct, I think we should fix get_mm_flatmem() instead of
1e93ee75f9d47c219e833210e and your patch like below:

   ...
   dump_mem_map(0, ARCH_PFN_OFFSET, NOT_MEMMAP_ADDR, 0);
   dump_mem_map(ARCH_PFN_OFFSET, info->max_mapnr, mem_map, 1);
   ...

"paddr:0x0 == pfn:0" is easy to understand.


Thanks
Atsushi Kumagai

>
>Thanks,
>Liu Hua
>
>>
>> Actually, the similar gap exists in the sparse_mem case as you described,
>> so I suspect we have to take care of it also for other memory models.
>>
>>>>         }
>>>>
>>>> So there is no problem in this model since the top of mem_map corresponds to
>>>> ARCH_PFN_OFFSET, right?
>>>
>>> I don't think so. Is it clear for my words above?
>>>
>>>>
>>>>> (2) For discontigmem, it manages the mem_map with node_memblk. commit
>>>>> 1e93ee75f9d47c21 also does no harm.
>>>>
>>>> alloc_node_mem_map() allocates mem_map also for discontigmem, but I can't find
>>>> any codes to consider ARCH_PFN_OFFSET for this model.
>>>> So I suspect the mismatch between the pfn for makedumpfile and the actual content
>>>> of mem_map can exist. Could you explain why this case is OK in more detail?
>>>>
>>> Actually I did not test this memory model. I reach my conclusion via the codes.
>>>
>>> get_mm_discontigmem
>>> {
>>> ....
>>> for (i = 0; i < vt.numnodes; i++) {  //loop for every node
>>> 2591                 if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_start_pfn),
>>> 2592                     &pfn_start, sizeof pfn_start)) {           //get pfn_start for this node
>>> ....
>>> 2596                 if (!readmem(VADDR,pgdat+OFFSET(pglist_data.node_spanned_pages),
>>> 2597                     &node_spanned_pages, sizeof node_spanned_pages)) { //get the number of pages in this node
>>>
>>> 2603                 if (SYMBOL(vmem_map) == NOT_FOUND_SYMBOL) {
>>> 2604                         if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_mem_map),  //get the mem_map for this
>>> node.
>>> 2605                             &mem_map, sizeof mem_map)) {
>>> 2606                                 ERRMSG("Can't get mem_map.\n");
>>> 2607                                 return FALSE;
>>> 2608                         }
>>> 2609                 } else
>>> 2610                         mem_map = vmem_map + (SIZE(page) * pfn_start);
>>> ....
>>> }
>>>
>>> So I think for discontigmem, makedumpfile can get the start address and length of mem_map from vmcore directly.
>>> And Everything can go well without ARCH_PFN_OFFSET.
>>
>> The same can be said, is it not needed to consider ARCH_PFN_OFFSET
>> to get a page struct from the mem_map?
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>>>
>>> Perhaps I need some tests on discontigmem. Did I explan my idea clearly?
>>>
>>>
>>>
>>>>
>>>> Thanks
>>>> Atsushi Kumagai
>>>>
>>>>> What do you think?
>>>>>
>>>>> Thanks,
>>>>> Liu Hua
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
