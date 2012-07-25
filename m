Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StpNt-0001pG-TZ
 for kexec@lists.infradead.org; Wed, 25 Jul 2012 00:23:37 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 80F363EE0C1
 for <kexec@lists.infradead.org>; Wed, 25 Jul 2012 09:23:17 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F93A45DE5F
 for <kexec@lists.infradead.org>; Wed, 25 Jul 2012 09:23:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F64745DE5C
 for <kexec@lists.infradead.org>; Wed, 25 Jul 2012 09:23:14 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6EC9A1DB8059
 for <kexec@lists.infradead.org>; Wed, 25 Jul 2012 09:23:14 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 13D801DB8050
 for <kexec@lists.infradead.org>; Wed, 25 Jul 2012 09:23:14 +0900 (JST)
Message-ID: <500F3B7C.70009@jp.fujitsu.com>
Date: Wed, 25 Jul 2012 09:19:08 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: revert "x86: Fix S4 regression"
References: <1339478463-31172-1-git-send-email-amwang@redhat.com>
 <5004D8BF.6050205@jp.fujitsu.com> <500D20A1.1030800@redhat.com>
 <500D340F.5080801@jp.fujitsu.com> <1343145331.16290.45.camel@cr0>
In-Reply-To: <1343145331.16290.45.camel@cr0>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: amwang@redhat.com
Cc: yinghai.lu@oracle.com, tiwai@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, hpa@zytor.com, xiyou.wangcong@gmail.com, akpm@linux-foundation.org, dyoung@redhat.com

(2012/07/25 0:55), Cong Wang wrote:
> On Mon, 2012-07-23 at 20:22 +0900, Takao Indoh wrote:
>> (2012/07/23 19:00), Dave Young wrote:
>>> On 07/17/2012 11:15 AM, Takao Indoh wrote:
>>>
>>>> Hi Cong,
>>>>
>>>> When I tested kdump with 3.5.0-rc6 kernel, I found a problem of kdump
>>>> kernel's panic in find_early_table_space().
>>>>
>>>> init_memory_mapping: [mem 0x00000000-0x36ffafff]
>>>> Kernel panic - not syncing: Cannot find space for the kernel page tables
>>>> Pid: 0, comm: swapper Not tainted 3.5.0-rc6 #17
>>>> Call Trace:
>>>>    [<ffffffff8158549b>] panic+0xb8/0x1c8
>>>>    [<ffffffff8158565d>] ? printk+0x48/0x4a
>>>>    [<ffffffff8157304c>] init_memory_mapping+0x46c/0x530
>>>>    [<ffffffff818a73c7>] setup_arch+0x669/0xb0e
>>>>    [<ffffffff8158565d>] ? printk+0x48/0x4a
>>>>    [<ffffffff818a3a1f>] start_kernel+0x9b/0x34a
>>>>    [<ffffffff818a332d>] x86_64_start_reservations+0x131/0x136
>>>>    [<ffffffff818a341f>] x86_64_start_kernel+0xed/0xf4
>>>>
>>>> In find_early_table_space(), a kernel tries to find free area below 512M
>>>> for pgtable using memblock_find_in_range, but it fails because kdump
>>>> kernel does not have enough free space below 512M due to the memmap
>>>> restriction. This is the memmap option specified against kdump kernel
>>>> when crashkernel=128M.
>>>>
>>>> memmap=560K@64K memmap=130492K@770608K
>>>>
>>>> Only 560KB area is available and it is not sufficient for pgtable (it
>>>> seems that about 1.8MB area is needed for pgtable). This problem is
>>>> fixed by your revert patch. I hope this patch gets merged.
>>>
>>>
>>> I can reproduce this issue as well, probably related to some x86 mm init
>>> commits, this alloc failure does not happen with reverting below commits:
>>>
>>> bd2753b2dda7bb43c7468826de75f49c6a7e8965
>>> 722bc6b16771ed80871e1fd81c86d3627dda2ac8
>> Yeah, my result of bisect is as follows and at first I thought the
>> commit 722bc6 caused this regression.
>>
>> 722bc6b16771ed80871e1fd81c86d3627dda2ac8 is the first bad commit
>> commit 722bc6b16771ed80871e1fd81c86d3627dda2ac8
>> Author: WANG Cong <xiyou.wangcong@gmail.com>
>> Date:   Mon Mar 5 15:05:13 2012 -0800
>>
>> IIUC, this commit just fixes a bug of counting pgtable entries. As the
>> result, another problem came up to the surface. In the case of my
>> machine(16GB memory), before applying 722bc6, find_early_table_space()
>> requests about 12KB free area and it can be got from 560K@64K area
>> luckily. I think the size find_early_table_space() requests was a bug.
>> After the bug is fixed by the commit 722bc6, find_early_table_space()
>> requires 1.8MB area and it fails as I wrote.
>
> Thanks for tracking this, Takao!
>
> I bet you are using x86_64 not x86 PAE? If so, could you try this patch
> https://patchwork.kernel.org/patch/1195751/
> ? I already reviewed it.

Great, I applied it and now kdump works. Thanks!

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
