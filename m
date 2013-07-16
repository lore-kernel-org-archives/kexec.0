Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UytUh-0004z2-JR
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 00:51:57 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 78BED3EE0BC
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:51:29 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6822D45DE52
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:51:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4FB6D45DE4D
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:51:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 40CA11DB803F
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:51:29 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E32A91DB803C
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:51:28 +0900 (JST)
Message-ID: <51E498FD.7010905@jp.fujitsu.com>
Date: Tue, 16 Jul 2013 09:51:09 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
 <20130708142826.GA9094@redhat.com> <51DBA47C.8090708@jp.fujitsu.com>
 <20130710104252.479a0f92@holzheu> <51DD2E5A.1030200@jp.fujitsu.com>
 <20130710130017.468e0bdf@holzheu> <51E028AA.7070203@jp.fujitsu.com>
 <20130715112109.5eaa4dd9@mschwide>
In-Reply-To: <20130715112109.5eaa4dd9@mschwide>
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
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/07/15 18:21), Martin Schwidefsky wrote:
> On Sat, 13 Jul 2013 01:02:50 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>
>> (2013/07/10 20:00), Michael Holzheu wrote:
>>> On Wed, 10 Jul 2013 18:50:18 +0900
>>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>>>
>>> [snip]
>>>
>>>> (2013/07/10 17:42), Michael Holzheu wrote:
>>>>> My suggestion is to add the WARN_ONCE() for #ifndef CONFIG_S390. This has the same
>>>>> effect as your suggestion for all architectures besides of s390. And for s390 we
>>>>> take the risk that a programming error would result in poor /proc/vmcore
>>>>> performance.
>>>>>
>>>>
>>>> If you want to avoid looking up vmcore_list that takes linear time w.r.t. the number
>>>> of the elements, you can still calculate the range of offsets in /proc/vmcore
>>>> corresponding to HSA during /proc/vmcore initialization.
>>>>
>>>> Also, could you tell me how often and how much the HSA region is during crash dumping?
>>>> I guess the read to HSA is done mainly during early part of crash dumping process only.
>>>> According to the code, it appears at most 64MiB only. Then, I feel performance is not
>>>> a big issue.
>>>
>>> Currently it is 32 MiB and normally it is read only once.
>>>
>>>>
>>>> Also, cost of WARN_ONCE() is one memory access only in the 2nd and later calls. I don't
>>>> think it too much overhead...
>>>
>>> I was more concerned about in_valid_fault_range(). But I was most concerned the additional
>>> interface that introduces more complexity to the code. And that just to implement a
>>> sanity check that in our opinion we don't really need.
>>>
>>> And what makes it even worse:
>>>
>>
>> What you think the sanity check is unnecessary is perfectly wrong. You design page faults
>> always happens on HSA region. If page fault happens on the other parts, i.e. some point
>> of mmap()ed region, it means somehow page table on the address has not been created. This
>> is bug, possibly caused by mmap() itself, page table creation, other components in kernel,
>> bit-flip due to broken hardware, etc. Anyway, program cannot detect what kind of bug occurs
>> now. There's no guarantee that program runs safely, of course for page cache creation, too.
>> We cannot and must expect such buggy process to behave in invalid states just as our design.
>> It results in undefined behaviour. The only thing we can do is to kill the buggy process
>> as soon as possible.
>
> I don't quite get this point, please bear with me. If you compare the situation before and
> after the introduction of the fault handler the possible error scenarios are not almost
> identical:
> 1) If an access is made outside of the mapped memory region the first level fault handler
>     (do_exception for s390, __do_page_fault for x86) won't find a vma and force a SIGSEGV
>     right away, independent of the existance of a hole and the vmcore fault handler.
> 2) If there is a hardware bug that corrupts a page table the behaviour depends on how the
>     entries are corrupted. If the outcome is a valid pte an incorrect memory area will be
>     accessed, the same with or without the vmcore fault handler. If the corrupted pte is
>     an invalid pte it can come out as swap pte, file pte, or as empty pte. The behaviour
>     does not change for swap and file ptes, you will get funny results in both cases.
>     For empty ptes the new behaviour will call the vmcore fault handler for the address
>     in question. If the read() function can satisfy the request we will get a page cache
>     copy of the missing page, if the read function can not satisfy the request it returns
>     an error which is translated to a SIGBUS.
>     This new behaviour is IMHO better than the old one, it successfully recovers from at
>     least one type of corruption. For x86 that would be the case if the page table is
>     overwritten with zeroes, for s390 a specific bit pattern in the pte is required.

As you already noticed here, this senario works well only if there's page table corruption
only. Process could be corrupted more.

> 3) In the case of a programming error in regard to remap_pfn_range the new behaviour will
>     provide page cache copies and the dump will technically be correct. The performance
>     might suffer a little bit as the CPU will have to create the page cache copies but
>     compared to the I/O that is involved with writing a dump this is negligible, no?
>
> It seems to me that the warning message you want to see in the fault handler would be
> a debugging aid for the developer to see if the mmap() and the remap_pfn_range() calls
> match up. Something similar to a single VM_WARN_ON() messages would be appropriate, no?
>

warning message is meaningless, which doesn't stop process. I no longer consider debugging.
It's valid to kill the process as soon as possible. If there's page fault to the address we
don't intend, it's buggy, and so we don't guess how the buggy process behave. Please consider
the cases that system goes into more catastrophic situation after we leave the process running to
get warning messages for debugging purposes.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
