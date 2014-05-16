Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WlCWd-000823-4w
 for kexec@lists.infradead.org; Fri, 16 May 2014 07:25:52 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v3 1/2] Generic handling of multi-page exclusions
Date: Fri, 16 May 2014 07:24:02 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97211576@BPXM01GP.gisp.nec.co.jp>
References: <1399482403-3656-2-git-send-email-ptesarik@suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9721099E@BPXM01GP.gisp.nec.co.jp>
 <20140514.193723.161348018.d.hatayama@jp.fujitsu.com>
 <20140514.195428.247303438.d.hatayama@jp.fujitsu.com>
 <20140514143832.16136269@hananiah.suse.cz>
In-Reply-To: <20140514143832.16136269@hananiah.suse.cz>
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Wed, 14 May 2014 19:54:28 +0900 (JST)
>HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>
>> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> Subject: Re: [PATCH v3 1/2] Generic handling of multi-page exclusions
>> Date: Wed, 14 May 2014 19:37:23 +0900
>>
>> > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> > Subject: RE: [PATCH v3 1/2] Generic handling of multi-page exclusions
>> > Date: Wed, 14 May 2014 07:54:17 +0000
>> >
>> >> Hello Petr,
>> >>
>> >>>When multiple pages are excluded from the dump, store the extents in
>> >>>struct cycle and check if anything is still pending on the next invocation
>> >>>of __exclude_unnecessary_pages. This assumes that:
>> >>>
>> >>>  1. after __exclude_unnecessary_pages is called for a struct mem_map_data
>> >>>     that extends beyond the current cycle, it is not called again during
>> >>>     that cycle,
>> >>>  2. in the next cycle, __exclude_unnecessary_pages is not called before
>> >>>     this final struct mem_map_data.
>> >>>
>> >>>Both assumptions are met if struct mem_map_data segments:
>> >>>
>> >>>  1. do not overlap,
>> >>>  2. are sorted by physical address in ascending order.
>> >>
>> >> In ELF case, write_elf_pages_cyclic() processes PT_LOAD entries from
>> >> PT_LOAD(0), this can break both assumptions unluckily.
>> >> Actually this patch doesn't work on my machine:
>> >>
>> >> LOAD (0)
>> >>   phys_start : 1000000
>> >>   phys_end   : 182f000
>> >>   virt_start : ffffffff81000000
>> >>   virt_end   : ffffffff8182f000
>> >> LOAD (1)
>> >>   phys_start : 1000
>> >>   phys_end   : 9b400
>> >>   virt_start : ffff810000001000
>> >>   virt_end   : ffff81000009b400
>> >> LOAD (2)
>> >>   phys_start : 100000
>> >>   phys_end   : 27000000
>> >>   virt_start : ffff810000100000
>> >>   virt_end   : ffff810027000000
>> >> LOAD (3)
>> >>   phys_start : 37000000
>> >>   phys_end   : cff70000
>> >>   virt_start : ffff810037000000
>> >>   virt_end   : ffff8100cff70000
>> >> LOAD (4)
>> >>   phys_start : 100000000
>> >>   phys_end   : 170000000
>> >>   virt_start : ffff810100000000
>> >>   virt_end   : ffff810170000000
>> >>
>> >>
>> >> PT_LOAD(2) includes PT_LOAD(0) and there physical addresses aren't sorted.
>> >>
>> >> If there is the only "sort issue", it may easy to fix it with a new iterator
>> >> like "for_each_pt_load()", it iterates PT_LOAD entries in ascending order
>> >> by physical address.
>> >> However, I don't have a good idea to solve the overlap issue now...
>> >>
>> >
>> > Is it enough to merge them? Prepare a modified version of PTLOAD list
>> > and refer to it in actual processing. I think this also leads to
>> > cleaning up readpage_elf() that addresses some overapping memory map
>> > issue on ia64.
>> >
>>
>> I'm saying this because I don't find anywhere virt_start or virt_end
>> is used. We look up page table to convert virtual address to physical
>> address, not PT_LOAD entries.

I thought it's better to keep the original PT_LOAD list at first, but the
current code can split it already. So I think we shouldn't worry about
modification to PT_LOAD entries now.
If crash doesn't use virt_start and virt_end too, your idea sounds good to me.

>Oh, you're right! Why does the ordering of PT_LOAD segments matter here?
>If makedumpfile fails on your machine after applying my patches, then
>it's quite likely because of something else.

Hatayama-san must said a VtoP mapping included in a PT_LOAD will be lost
by merging PT_LOADs and it looks no problem for makedumpfile in practice.

I meant the ELF path calls for_each_cycle(PT_LOAD[i].pfn_start, PT_LOAD[i].pfn_end)
from i=0, so the PFNs aren't sorted and they are overlapping in some cases
like mine. OTOH, the kdump path calls for_each_cycle(0, info->max_mapnr) always,
so there is no problem.

I explain why the problem I met happen below, each paragraph means the flow
of for_each_cycle():

1. PT_LOAD(0): pfn [0x00001000 - 0x0000182f]
  There are free pages [0x1820-0x1840] and exclude_range(0x1820, 0x1840)
  was called. Then, exclude_pfn_start was set as 0x182f and exclude_pfn_end
  was set as 0x1840. (I'll express this like "exclude_pfn [0x182f-0x1840]")

2. PT_LOAD(1): pfn [0x00000001 - 0x0000009c]
  At the top of __exclude_unnecessary_pages(), exclude_range(0x182f, 0x1840) 
  was called since exclude_pfn was [0x182f-0x1840]. This exclude_range() didn't
  any operations for bitmaps because the PFNs are out of the cycle. However,
  exclude_pfn was set as [0x9c-0x1840] in the function.

3. PT_LOAD(2): pfn [0x00000100 - 0x00027000]
  Here, exclude_pfn was [0x9c-0x1840], so exclude_range(0x9c, 0x1840) was called.
  A part of the PFNs are on the cycle unluckily, they are excluded wrongly.
  The PFNs that should be excluded are only [0x182f-0x1840], this is the problem.

4. PT_LAOD(3): pfn [0x00037000 - 0x000cff70]
  There is no problem here.

5. PT_LOAD(4): pfn [0x00100000 - 0x00170000]
  There is no problem here too.

Like this, the unsorted issue causes wrong setting of 
exclude_pfn_(start|end) and the combination of the overlapping issue and
wrong exclude_pfn_(start|end) causes wrong bitmap operations.


Thanks
Atsushi Kumagai

>FWIW I verified on a few dumpfiles that makedumpfile produced exactly
>the same output before and after applying the patches.
>
>OTOH I can see a warning when writing an ELF file. Before the patch:
>
>Excluding unnecessary pages        : [100.0 %] \WARNING: PFN out of cycle range. (pfn:c00, cycle:[3fc00-3ffd0])
>
>After the patch:
>
>Excluding unnecessary pages        : [100.0 %] \WARNING: PFN out of cycle range. (pfn:26c00, cycle:[0-1ff6])
>
>I'm unsure why there are out-of-cycle PFNs. Researching...
>
>Petr T
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
