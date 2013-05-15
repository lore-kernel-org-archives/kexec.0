Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcQ6u-0004OO-5w
 for kexec@lists.infradead.org; Wed, 15 May 2013 01:02:30 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2C0E93EE0BC
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 10:01:55 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 13B4145DE4E
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 10:01:55 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E418D45DE50
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 10:01:54 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id CC0F9E08001
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 10:01:54 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6DD871DB8037
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 10:01:54 +0900 (JST)
Message-ID: <5192DE39.7050903@jp.fujitsu.com>
Date: Wed, 15 May 2013 10:00:41 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: makedumpfile: question about memory hole
References: <20130319104137.b8aff16a428e6393e32e9d20@mxc.nes.nec.co.jp>
 <20130319.114220.118274790.d.hatayama@jp.fujitsu.com>
 <20130319164926.2f5a8bff1b5ee4ab4857df65@mxc.nes.nec.co.jp>
 <20130319.174745.69663044.d.hatayama@jp.fujitsu.com>
 <20130329171311.a6a58518c13a7a5dec600bd6@mxc.nes.nec.co.jp>
 <20130514105550.d5900332ed298f24f80897f3@mxc.nes.nec.co.jp>
In-Reply-To: <20130514105550.d5900332ed298f24f80897f3@mxc.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

(2013/05/14 10:55), Atsushi Kumagai wrote:
> Hello HATAYAMA-san,
> 
> Sorry for the delayed response, again...
> 
> On Fri, 29 Mar 2013 17:13:11 +0900
> Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> 
>> Hello HATAYAMA-san,
>>
>> Sorry for the delayed response.
>>
>> On Tue, 19 Mar 2013 17:47:45 +0900 (JST)
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>>
>>>>>>> What I don't understand well is that the part here:
>>>>>>>
>>>>>>>                  pfn_start = paddr_to_pfn(phys_start);
>>>>>>>                  pfn_end   = paddr_to_pfn(phys_end);
>>>>>>>
>>>>>>>                  if (!is_in_segs(pfn_to_paddr(pfn_start)))
>>>>>>>                          pfn_start++;
>>>>>>>
>>>>>>> phys_start and pfn_to_paddr(pfn_start) should belong to the same page
>>>>>>> frame, so I suspect the pfn_start should be included in vmcore.
>>>>>>>
>>>>>>> Looking into kexec-tool side, I don't see additional modification made
>>>>>>> to phys_start after it's parsed from /proc/iomem or counterpart on EFI
>>>>>>> interface. Is there any assumption about memory holes behind kernel?
>>>>>>
>>>>>> Here is a PT_LOAD segment of ia64 machine which I actually use:
>>>>>>
>>>>>>    Type           Offset             VirtAddr           PhysAddr
>>>>>>                   FileSiz            MemSiz              Flags  Align
>>>>>> [...]
>>>>>>    LOAD           0x000000015fd0b490 0xe0000040ffda5000 0x00000040ffda5000
>>>>>>                   0x000000000005a000 0x000000000005a000  RWE    0
>>>>>>
>>>>>> In this case, pfn_to_paddr(pfn_start) is aligned to 0x40ffda4000
>>>>>> because the page size is 16KiB, and this address is out of PT_LOAD
>>>>>> segment.
>>>>>>
>>>>>>           phys_start
>>>>>>           = 0x40ffda5000
>>>>>>              |------------- PT_LOAD ----------------
>>>>>>       ----+----------+----------+----------+--------
>>>>>>           |   pfn:N  |  pfn:N+1 | pfn:N+2  |  ...
>>>>>>       ----+----------+----------+----------+--------
>>>>>>           |
>>>>>>     pfn_to_paddr(pfn:N)
>>>>>>     = 0x40ffda4000
>>>>>>
>>>>>> The statement you said is for care the case that phys_start isn't aligned
>>>>>> with the page size.
>>>>>>
>>>>>> BTW, I'll add a comment to explain this intention into here.
>>>>>
>>>>> Thanks for the pictorial explanation. It's easy to understand.
>>>>>
>>>>> Still I think pfn:N should be included in vmcore. The current
>>>>> implementation drops [0x40ffda5000, 0x40ffda8000] that is contained in
>>>>> the PT_LOAD. Or, the range must be hole or other kinds of unnecessary
>>>>> memory from some kernel-side assumption?
>>>>
>>>> Oh, I understand your question correctly now.
>>>>
>>>> When Ohmichi-san wrote this code, he thought the page which include
>>>> memory hole isn't be used. This came from the fact that the basic
>>>> unit of memory management is *page*, but there is no detailed
>>>> investigation.
>>>
>>> You mean on at least IA64 case such parts are always holes?
>>
>> I showed the IA64 case just to say that the statement can be executed
>> actually and it's meaningful code, and this is from my misunderstanding
>> of your question.
>> Whether such parts are holes or not is another matter, and I haven't
>> enough information to decide it now.
>>   
>>>>
>>>> So, if there is any case where pfn:N is actually used, this statement
>>>> should be removed. Maybe, does this question come from an idea of such
>>>> cases ?
>>>
>>> I'm wondering if such case can actually happens.
>>
>> I checked a memory map on another IA64 machine and found the regions
>> that not be aligned by page-size:
>>
>>    # cat /proc/iomem  | grep System
>>    ...
>>    4040000000-40fea09fff : System RAM
>>    40fea0a000-40fef5ffff : System RAM       // include"pfn:N" 40fea0a000-
>>    40fef60000-40fef63fff : System RAM
>>
>> According to this, it seems that such regions can be exist normally
>> at least on IA64.　So, what we should investigate is how does kernel
>> manage such regions (e.g. [0x40fea0a000, 0x40fea0c000]).
>> And this is the "kernel-side assumption" you said first, right ?
> 
> First, the memory map(iomem_resource) is made from EFI memory map
> with efi_initialize_iomem_resources(), then no rounding occurs.
> And EFI page size is 4KB(EFI_PAGE_SHIFT == 12), so it is natural
> that some regions aren't aligned by linux kernel page size.
> 
> Anyway, I found the case that "pfn:N" mentioned in previous mail was
> actually used on the IA64 machine.
> 
>>>>>>              |------------- PT_LOAD ----------------
>>>>>>       ----+----------+----------+----------+--------
>>>>>>           |   pfn:N  |  pfn:N+1 | pfn:N+2  |  ...
>>>>>>       ----+----------+----------+----------+--------
> 
> Here is the machine's /proc/iomem and dmesg:
> 
>    # cat /proc/iomem  | grep System
>    ...
>    4040000000-40fea09fff : System RAM
>    40fea0a000-40fef5ffff : System RAM       // start address corresponds to "pfn:N"
>    40fef60000-40fef63fff : System RAM
> 
>    # dmesg
>    ...
>    rsvd_region[0]: [0xe000000001000000, 0xe0000000010000a8)
>    rsvd_region[1]: [0xe000000004000000, 0xe000000004e94e68)
>    rsvd_region[2]: [0xe0000040fea0a010, 0xe0000040fea0a060)  // stored in "pfn:N"
>    rsvd_region[3]: [0xe0000040fea0dfd8, 0xe0000040fea0e010)
>    rsvd_region[4]: [0xe0000040fea10000, 0xe0000040fef5fc79)
>    rsvd_region[5]: [0xe0000040fefd0010, 0xe0000040fefd0790)
>    rsvd_region[6]: [0xffffffffffffffff, 0xffffffffffffffff)
>    
>    // these are virtual addresses, __pa(0xe0000040fea0a010) = 0x40fea0a010
> 
> According to reserve_memory(), rsvd_region[2] is used to save
> ia64_boot_param->command_line. This means that "pfn:N" can
> include valid dates, we shouldn't remove it as holes.
> 
> Thank you for pointing out this issue, I'll fix it.

Thanks for your investigation. I'm now very clear to what's happening there.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
