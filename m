Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byyGE-00056b-0W
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 09:43:14 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile issues many readpage_elf: Attempt to read
 non-existent page
Date: Tue, 25 Oct 2016 09:19:40 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E7A2F3@BPXM01GP.gisp.nec.co.jp>
References: <57E3DCDB.5020308@canonical.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E6B42E@BPXM01GP.gisp.nec.co.jp>
 <57ED187D.3040007@canonical.com>
 <CAL0thcP2Pp43nWLJ_jfwDQnW4RNRpP27fpymQ8pPtORPaeX8nQ@mail.gmail.com>
 <161d0e6f-5b1c-dfa9-aa28-5393e2a86d1d@canonical.com>
In-Reply-To: <161d0e6f-5b1c-dfa9-aa28-5393e2a86d1d@canonical.com>
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
To: Louis Bouchard <louis.bouchard@canonical.com>
Cc: "panand@redhat.com" <panand@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

>> I have now completed the kernel bisection between 4.7.8 and 4.8-rc1 and
>> identified the kernel modification that triggers the errors cited above :
>>
>>> commit 021182e52fe01c1f7b126f97fd6ba048dc4234fd
>>> Author: Thomas Garnier <thgarnie@google.com>
>>> Date:   Tue Jun 21 17:47:03 2016 -0700
>>>
>>>     x86/mm: Enable KASLR for physical mapping memory regions
>>>
>>>     Add the physical mapping in the list of randomized memory regions.
>>>
>>>     The physical memory mapping holds most allocations from boot and heap
>>>     allocators. Knowing the base address and physical memory size, an attacker
>>>     can deduce the PDE virtual address for the vDSO memory page. This attack
>>>     was demonstrated at CanSecWest 2016, in the following presentation:
>>>
>>>       "Getting Physical: Extreme Abuse of Intel Based Paged Systems":
>>>
>https://github.com/n3k/CansecWest2016_Getting_Physical_Extreme_Abuse_of_Intel_Based_Paging_Systems/blob/master/Prese
>ntation/CanSec2016_Presentation.pdf
>>>
>>>     (See second part of the presentation).
>>>
>>>     The exploits used against Linux worked successfully against 4.6+ but
>>>     fail with KASLR memory enabled:
>>>
>>>
>https://github.com/n3k/CansecWest2016_Getting_Physical_Extreme_Abuse_of_Intel_Based_Paging_Systems/tree/master/Demos
>/Linux/exploits
>>>
>>>     Similar research was done at Google leading to this patch proposal.
>>>
>>>     Variants exists to overwrite /proc or /sys objects ACLs leading to
>>>     elevation of privileges. These variants were tested against 4.6+.
>>>
>>>     The page offset used by the compressed kernel retains the static value
>>>     since it is not yet randomized during this boot stage.
>>>
>>>     Signed-off-by: Thomas Garnier <thgarnie@google.com>
>>>     Signed-off-by: Kees Cook <keescook@chromium.org>
>>>     Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
>> <truncated>
>>
>> The interesting change seems to be :
>>
>>> -#define __PAGE_OFFSET           _AC(0xffff880000000000, UL)
>>> +#define __PAGE_OFFSET_BASE      _AC(0xffff880000000000, UL)
>>> +#ifdef CONFIG_RANDOMIZE_MEMORY
>>> +#define __PAGE_OFFSET           page_offset_base
>>> +#else
>>> +#define __PAGE_OFFSET           __PAGE_OFFSET_BASE
>>> +#endif /* CONFIG_RANDOMIZE_MEMORY */
>>
>> I'll try to see if I can fix that.
>>
>> Kind regards,
>>
>> ...Louis
>>
>>
>>
>>
>
>Some more *important* information in this mostly monologue thread : Pratyush
>Anand has pushed a patch to the list earlier today that apparently fixes this
>issue :
>
>[PATCH Makedumpfile 1/4] x86_64: Calculate page_offset from pt_load[1]
>
>HTH,
>
>Kind regards,

Yeah, It appears so. I'm reviewing the patches,
please wait for that.
I appreciate your investigation for this issue.


Thanks,
Atsushi Kumagai

>...Louis
>
>[1] https://www.mail-archive.com/kexec@lists.infradead.org/msg16628.html
>--
>Louis Bouchard
>Software engineer, Cloud & Sustaining eng.
>Canonical Ltd
>Ubuntu developer                       Debian Maintainer
>GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
