Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StGnI-0002f6-AL
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 11:27:28 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 637D73EE0BD
 for <kexec@lists.infradead.org>; Mon, 23 Jul 2012 20:27:10 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 404C645DE53
 for <kexec@lists.infradead.org>; Mon, 23 Jul 2012 20:27:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 27FF645DE4D
 for <kexec@lists.infradead.org>; Mon, 23 Jul 2012 20:27:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1BF1B1DB803B
 for <kexec@lists.infradead.org>; Mon, 23 Jul 2012 20:27:10 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C22FA1DB8041
 for <kexec@lists.infradead.org>; Mon, 23 Jul 2012 20:27:09 +0900 (JST)
Message-ID: <500D340F.5080801@jp.fujitsu.com>
Date: Mon, 23 Jul 2012 20:22:55 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: revert "x86: Fix S4 regression"
References: <1339478463-31172-1-git-send-email-amwang@redhat.com>
 <5004D8BF.6050205@jp.fujitsu.com> <500D20A1.1030800@redhat.com>
In-Reply-To: <500D20A1.1030800@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: dyoung@redhat.com
Cc: yinghai.lu@oracle.com, amwang@redhat.com, tiwai@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, hpa@zytor.com, xiyou.wangcong@gmail.com, akpm@linux-foundation.org

(2012/07/23 19:00), Dave Young wrote:
> On 07/17/2012 11:15 AM, Takao Indoh wrote:
> 
>> Hi Cong,
>>
>> When I tested kdump with 3.5.0-rc6 kernel, I found a problem of kdump
>> kernel's panic in find_early_table_space().
>>
>> init_memory_mapping: [mem 0x00000000-0x36ffafff]
>> Kernel panic - not syncing: Cannot find space for the kernel page tables
>> Pid: 0, comm: swapper Not tainted 3.5.0-rc6 #17
>> Call Trace:
>>   [<ffffffff8158549b>] panic+0xb8/0x1c8
>>   [<ffffffff8158565d>] ? printk+0x48/0x4a
>>   [<ffffffff8157304c>] init_memory_mapping+0x46c/0x530
>>   [<ffffffff818a73c7>] setup_arch+0x669/0xb0e
>>   [<ffffffff8158565d>] ? printk+0x48/0x4a
>>   [<ffffffff818a3a1f>] start_kernel+0x9b/0x34a
>>   [<ffffffff818a332d>] x86_64_start_reservations+0x131/0x136
>>   [<ffffffff818a341f>] x86_64_start_kernel+0xed/0xf4
>>
>> In find_early_table_space(), a kernel tries to find free area below 512M
>> for pgtable using memblock_find_in_range, but it fails because kdump
>> kernel does not have enough free space below 512M due to the memmap
>> restriction. This is the memmap option specified against kdump kernel
>> when crashkernel=128M.
>>
>> memmap=560K@64K memmap=130492K@770608K
>>
>> Only 560KB area is available and it is not sufficient for pgtable (it
>> seems that about 1.8MB area is needed for pgtable). This problem is
>> fixed by your revert patch. I hope this patch gets merged.
> 
> 
> I can reproduce this issue as well, probably related to some x86 mm init
> commits, this alloc failure does not happen with reverting below commits:
> 
> bd2753b2dda7bb43c7468826de75f49c6a7e8965
> 722bc6b16771ed80871e1fd81c86d3627dda2ac8
Yeah, my result of bisect is as follows and at first I thought the
commit 722bc6 caused this regression.

722bc6b16771ed80871e1fd81c86d3627dda2ac8 is the first bad commit
commit 722bc6b16771ed80871e1fd81c86d3627dda2ac8
Author: WANG Cong <xiyou.wangcong@gmail.com>
Date:   Mon Mar 5 15:05:13 2012 -0800

IIUC, this commit just fixes a bug of counting pgtable entries. As the
result, another problem came up to the surface. In the case of my
machine(16GB memory), before applying 722bc6, find_early_table_space()
requests about 12KB free area and it can be got from 560K@64K area
luckily. I think the size find_early_table_space() requests was a bug.
After the bug is fixed by the commit 722bc6, find_early_table_space()
requires 1.8MB area and it fails as I wrote.

Thanks,
Takao Indoh

> 
>>
>> Thanks,
>> Takao Indoh
>>
>> (2012/06/12 14:21), Cong Wang wrote:
>>> From: Cong Wang <xiyou.wangcong@gmail.com>
>>>
>>> This reverts the following commit:
>>>
>>> 	commit 8548c84da2f47e71bbbe300f55edb768492575f7
>>> 	Author: Takashi Iwai <tiwai@suse.de>
>>> 	Date:   Sun Oct 23 23:19:12 2011 +0200
>>>
>>> 	    x86: Fix S4 regression
>>> 	
>>> 	    Commit 4b239f458 ("x86-64, mm: Put early page table high") causes a S4
>>> 	    regression since 2.6.39, namely the machine reboots occasionally at S4
>>> 	    resume.  It doesn't happen always, overall rate is about 1/20.  But,
>>> 	    like other bugs, once when this happens, it continues to happen.
>>> 	
>>> 	    This patch fixes the problem by essentially reverting the memory
>>> 	    assignment in the older way.
>>>
>>> According to the previous discussion:
>>> http://marc.info/?l=linux-kernel&m=133161674120253&w=2
>>> it seems that so far the best solution is just reverting it.
>>>
>>> Takashi, could you help to test if the S4 regression is still
>>> there after this patch?
>>>
>>> Reported-by: CAI Qian <caiqian@redhat.com>
>>> Cc: Dave Young <dyoung@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>>> Cc: Yinghai Lu <yinghai.lu@oracle.com>
>>> Cc: Takashi Iwai <tiwai@suse.de>
>>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>>>
>>> ---
>>>    arch/x86/mm/init.c |    3 ++-
>>>    1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
>>> index bc4e9d8..7ab7975 100644
>>> --- a/arch/x86/mm/init.c
>>> +++ b/arch/x86/mm/init.c
>>> @@ -74,8 +74,9 @@ static void __init find_early_table_space(struct map_range *mr, unsigned long en
>>>    #ifdef CONFIG_X86_32
>>>    	/* for fixmap */
>>>    	tables += roundup(__end_of_fixed_addresses * sizeof(pte_t), PAGE_SIZE);
>>> -#endif
>>> +
>>>    	good_end = max_pfn_mapped << PAGE_SHIFT;
>>> +#endif
>>>    
>>>    	base = memblock_find_in_range(start, good_end, tables, PAGE_SIZE);
>>>    	if (!base)
>>>
> 
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
