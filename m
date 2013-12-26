Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vvylr-0001eX-Hu
 for kexec@lists.infradead.org; Thu, 26 Dec 2013 00:25:52 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 777D03EE0C1
 for <kexec@lists.infradead.org>; Thu, 26 Dec 2013 09:25:26 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 690EB45DD77
 for <kexec@lists.infradead.org>; Thu, 26 Dec 2013 09:25:26 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 48EDC45DD76
 for <kexec@lists.infradead.org>; Thu, 26 Dec 2013 09:25:26 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3BECE1DB803B
 for <kexec@lists.infradead.org>; Thu, 26 Dec 2013 09:25:26 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DFF501DB8032
 for <kexec@lists.infradead.org>; Thu, 26 Dec 2013 09:25:25 +0900 (JST)
Message-ID: <52BB776B.4030000@jp.fujitsu.com>
Date: Thu, 26 Dec 2013 09:25:15 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
References: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
 <52B39878.3030403@jp.fujitsu.com> <20131220141321.GA27063@redhat.com>
In-Reply-To: <20131220141321.GA27063@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>

(2013/12/20 23:13), Vivek Goyal wrote:
> On Fri, Dec 20, 2013 at 10:08:08AM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>>
>>> cat /proc/iomem:
>>> 00000000-00000fff : reserved
>>> 00001000-0009ffff : System RAM
>>> 000a0000-000bffff : PCI Bus 0000:00
>>> 000f0000-000fffff : System ROM
>>> 00100000-3d162017 : System RAM
>>>    01000000-015cab9b : Kernel code
>>>    015cab9c-019beb3f : Kernel data
>>>    01b4f000-01da9fff : Kernel bss
>>>    30000000-37ffffff : Crash kernel
>>> 3d162018-3d171e57 : System RAM
>>> 3d171e58-3d172017 : System RAM
>>> 3d172018-3d17ae57 : System RAM
>>> 3d17ae58-3dc10fff : System RAM
>>
>> this part is consecutive but somehow is divided into 4 entries.
>> You called your environment as ``EFI virtual machine'', could you tell
>> me precisely what it mean? qemu/KVM or VMware guest system? I do want
>> to understand how this kind of memory map was created. I think this
>> kind of memory mapping is odd and I guess this is caused by the fact
>> that the system is a virtual environment.
>>
>> And for Vivek, this case is a concrete example of multiple RAM entries
>> appearing in a single page I suspected in the mmap failure patch,
>> although these entries are consecutive in physical address and can be
>> represented by a single entry by merging them in a single entry. But
>> then it seems to me that there could be more odd case that multiple
>> RAM entries but not consecutive. I again think this should be addressed
>> in the patch for the mmap failure issue. How do you think?
>
> Hi Hatayama,
>
> This indeed looks very odd. See if a very small number of systems have it,
> the only thing we will do is allocate extra page in second kernel for
> a memory range. It will not make mmap() fail. So it is just a matter of
> optimization.
>

Yes, mmap doesn't fail. Without the optimization, we get the first System RAM
data only from multiple System RAM entries in a single page. vmcore_list
contains entries for each entry in the multiple System RAM entries, although
we cannot look up the entries except for the 1st one since they have the same
offset.

> Given the fact I have not seen many systems with this anomaly, I am not
> too worried about it even if you don't this optimization in your patch
> series. We can always take care of it later if need be.
>
> At the same time, if you feel strongly about it and want to fix it in
> same patch series, I don't mind.
>

I think some part of System RAM is dropped off from crash dump is a problem.
But I also think it important to fix this issue as soon as possible. So,
I want to introduce basic copying mechanism first, and then focus on the
optimization.

By the way, I guess one of what you worry about is how to make sure whether
the logic of dividing each System RAM area into at most three parts, is
correct or not. Is it better to describe a simple proof somewhere as comment?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
