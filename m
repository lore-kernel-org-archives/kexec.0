Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjPh6-0003fH-0w
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 08:33:01 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 966663EE1D9
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 17:32:33 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8380745DE4E
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 17:32:33 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C4BA45DE4C
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 17:32:33 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B5A81DB802C
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 17:32:33 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 088AC1DB8046
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 17:32:33 +0900 (JST)
Message-ID: <528DC4F2.5040000@jp.fujitsu.com>
Date: Thu, 21 Nov 2013 17:31:46 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131113204130.GD7613@redhat.com> <5284A689.70903@jp.fujitsu.com>
 <20131114151359.GA3913@redhat.com> <5285EC60.1060906@jp.fujitsu.com>
 <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
 <20131118135511.GA30637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C3862@BPXM01GP.gisp.nec.co.jp>
 <20131120145901.GB27924@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C43E3@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971C43E3@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/11/21 14:00), Atsushi Kumagai wrote:
> Hello Vivek,
> 
> On 2013/11/21 0:00:01, kexec <kexec-bounces@lists.infradead.org> wrote:
>>>>>> Is there any chance that you could look into fixing this. I
>>>>>> have no experience writing code for makedumpfile.
>>>>>
>>>>> I'll send a patch to fix this soon.
>>>>
>>>> Thanks Atsushi.
>>>>
>>>> Vivek
>>>
>>> Vivek, could you test this patch ?
>>>
>>> Thanks
>>> Atsushi Kumagai
>>>
>>>
>>> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>>> Date: Wed, 20 Nov 2013 10:05:03 +0900
>>> Subject: [PATCH] Disable mmap() for reading fractional pages.
>>>
>>> Since mmap() was introduced on /proc/vmcore, it fails for fractional
>>> pages which don't start or end at page boundary due to kernel issue.
>>> This patch disables mmap() temporarily for fractional pages to avoid
>>> this issue, so mmap() will be used only for aligned pages.
>>>
>>> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>>
>> Hi Atsushi,
>>
>> Even with this patch applied I see mmap() failure.
>>
>> mem_map (39)
>>    mem_map    : ffffea0004e00000
>>    pfn_start  : 138000
>>    pfn_end    : 140000
>> read /proc/vmcore with mmap()
>> Excluding unnecessary pages        : [100.0 %] |STEP [Excluding
>> unnecessary pages] : 0.035925 seconds
>> Excluding unnecessary pages        : [100.0 %] \STEP [Excluding
>> unnecessary pages] : 0.035774 seconds
>> Excluding unnecessary pages        : [100.0 %] -STEP [Excluding
>> unnecessary pages] : 0.035229 seconds
>> Copying data                       : [ 40.9 %] -Can't map
>> [b98fd000-b9cfd000] with mmap()
>> read_from_vmcore: Can't read the dump memory(/proc/vmcore) with mmap().
>> readpage_elf: Can't read the dump memory(/proc/vmcore).
>> readmem: type_addr: 1, addr:bffba000, size:4096
>> read_pfn: Can't get the page data.
>>   Resource temporarily unavailable
>> makedumpfile Failed.
>> kdump: saving vmcore failed
>>
>> Following is part of /proc/iomem on my system.
>>
>> 00100000-bffc283f : System RAM
>>    01000000-018c551d : Kernel code
>>    018c551e-01ef3f3f : Kernel data
>>    0204a000-02984fff : Kernel bss
>>    2e000000-35ffffff : Crash kernel
>> bffc2840-bfffffff : reserved
>>
>> This is a different system than what I used last time. So I am not sure if this is same error or something else. But one thing is clear that System RAM last page is partial and we should face mmap() failure.
> 
> Thanks for your testing, I've found my mistake.
> 
> My patch tries to disable mmap() when a partial page is found, but
> actually mmap() has already been called because update_mmap_range()
> calls mmap() for every 4MB region in advance.
> If we try to keep using mmap() as much as possible, update_mmap_range()
> has to check whether the target region of mmap() includes the partial
> pages before calling mmap(), but it's too tough as workaround.
> 
> So I think the patch I sent is enough, the policy will be simpler as
> "Don't use mmap() for buggy kernels".
> 
> [PATCH] Fall back to read() when mmap() fails.
> http://lists.infradead.org/pipermail/kexec/2013-November/010199.html
> 

I think logic becomes not so complex. For example, if input vmcore
format is ELF, then:

o in update_mmap_range():
  - first calculate a range of the corresponding PT_LOAD entry truncated with
    PAGE_SIZE.
  - Then, truncate range of mmap() by the truncated range of the corresponding
    PT_LOAD entry, i.e., exlucde partial pages from mmap() target range.
  - Then determine offsets of two partial pages; the number of partial pages
    are always at most two. The offsets can easily be calculated from the
    original range of the corresponding PT_LOAD entry

o in read_from_vmcore(), if a given offset belongs to either of two partial
  pages, then go to read() path; if not, go to mmap() path.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
