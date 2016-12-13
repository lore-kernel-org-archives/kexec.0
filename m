Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cGhBw-0005dD-L2
 for kexec@lists.infradead.org; Tue, 13 Dec 2016 07:08:01 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH V2 2/4] x86_64: translate all VA to PA
 using page table values
Date: Tue, 13 Dec 2016 07:03:12 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E8AB1F@BPXM01GP.gisp.nec.co.jp>
References: <cover.1477901442.git.panand@redhat.com>
 <c72c3722595f7b86754c6d9835ffdc3c68361bb4.1477901442.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E87E88@BPXM01GP.gisp.nec.co.jp>
 <3d3fcf63-eb95-9adb-b645-9f906d5f900f@redhat.com> <20161209142515.GB6875@x1>
 <20161210012915.GA1034@x1> <20161210013330.GC1034@x1>
 <e6c2f494-e399-dcaf-5463-42995341e966@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E8867A@BPXM01GP.gisp.nec.co.jp>
 <20161212095020.GI1034@x1>
In-Reply-To: <20161212095020.GI1034@x1>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: Pratyush Anand <panand@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "louis.bouchard@canonical.com" <louis.bouchard@canonical.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On 12/12/16 at 08:40am, Atsushi Kumagai wrote:
>> >On Saturday 10 December 2016 07:03 AM, bhe@redhat.com wrote:
>> >> On 12/10/16 at 09:29am, Baoquan He wrote:
>> >>> On 12/09/16 at 10:25pm, Baoquan He wrote:
>> >>>> On 12/09/16 at 03:40pm, Pratyush Anand wrote:
>> >>>>>>> -	page_dir  = SYMBOL(init_level4_pgt);
>> >>>>>>> +	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;
>> >>>>>>
>> >>>>>> I found that this change breaks the backward compatibility for
>> >>>>>> kernel 2.6.21 or older since phys_base was introduced in kernel 2.6.22
>> >>>>>> by the commit below:
>> >>>>>>
>> >>>>>>   commit 1ab60e0f72f71ec54831e525a3e1154f1c092408
>> >>>>>>   Author: Vivek Goyal <vgoyal@in.ibm.com>
>> >>>>>>   Date:   Wed May 2 19:27:07 2007 +0200
>> >>>>>>
>> >>>>>>       [PATCH] x86-64: Relocatable Kernel Support
>> >>>>>>
>> >>>>>> There is no problem if phys_base is always 0 in older kernel, but
>> >>>>>> get_phys_base_x86_64() calculates "phys_base = 0x100000" from my vmcore:
>> >>>>
>> >>>> This is really awkward. Checked code, found PAGE_OFFSET is
>> >>>> 0xffff810000000000 before 2.6.26, then changed to 0xffff880000000000
>> >>>> after that. Can we check the page_offset calculated from pt_load
>> >>>> segments, meanwhile check if has VMCOREINFO and osrelease after 2.6.21.
>> >>>>
>> >>>> With both of above condition, we could set phys_vase to 0. Not sure if
>> >>>> this can solve the existing problem.
>> >>>
>> >>> I meant making a judgement:
>> >>>
>> >>
>> >> Sorry, should be:
>> >> if (page_offset == 0xffff810000000000 && !info->kernel_version > KERNEL_VERSION(2, 6, 21))
>> >> 	info->phys_base = 0;
>> >>
>> >
>> >
>> >But you can not read kernel_version because those version does not have
>> >VMCOREINFO. So, has_vmcoreinfo() still need to be used.
>>
>> Thanks for your comments, using has_vmcoreinfo() sounds like a good approach,
>> but not perfect way. VMCOREINFO has been introduced since 2.6.24,
>> 2.6.22 and 2.6.23 don't have VMCOREINFO but have phys_base.
>>
>> Conversely, 2.6.22 and 2.6.23 require vmlinux, so we can confirm the existence of
>> phys_base with that. My idea is:
>>
>> diff --git a/arch/x86_64.c b/arch/x86_64.c
>> index 010ea10..893cd51 100644
>> --- a/arch/x86_64.c
>> +++ b/arch/x86_64.c
>> @@ -67,6 +67,14 @@ get_phys_base_x86_64(void)
>>                 return TRUE;
>>         }
>>
>> +       /* linux-2.6.21 or older don't have phys_base, should be set to 0. */
>> +       if (!has_vmcoreinfo()) {
>> +               SYMBOL_INIT(phys_base, "phys_base");
>> +               if (SYMBOL(phys_base) == NOT_FOUND_SYMBOL) {
>> +                       return TRUE;
>> +               }
>> +       }
>> +
>>         for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
>>                 if (virt_start >= __START_KERNEL_map) {
>>
>>
>> This fix may resolve my issue, but now I have another question that
>> "Is the logic of get_phys_base_x86_64() correct in any kernel configuration ?"
>> I mean I'm worried about the possibility that another offset gets mixed with
>> the result of get_phys_base_x86_64() like my 2.6.21 case.
>> After phys_base was introduced, does it always equal to the offset which can be
>> calculated from PT_LOAD headers ?
>
>Don't worry. phys_base was introduced just after 2.6.21.
>
>commit 1ab60e0f72f71ec54831e525a3e1154f1c092408
>Author: Vivek Goyal <vgoyal@in.ibm.com>
>Date:   Wed May 2 19:27:07 2007 +0200
>
>    [PATCH] x86-64: Relocatable Kernel Support
>
>[bhe@x1 linux]$ git describe 1ab60e0f72f71ec54831e525a3e1154f1c092408
>v2.6.21-1836-g1ab60e0

All right, thanks.
I'll release v1.6.1 soon if there is nothing wrong with the retest.

Regards,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
