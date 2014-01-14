Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W33cC-0002pt-MR
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 13:01:11 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 23F0B3EE0AE
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 22:00:41 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 177B845DE4E
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 22:00:41 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 002CE45DD76
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 22:00:40 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E83631DB8040
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 22:00:40 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 952451DB803E
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 22:00:40 +0900 (JST)
Message-ID: <52D534BF.3000704@jp.fujitsu.com>
Date: Tue, 14 Jan 2014 21:59:43 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] makedumpfile: for large memories
References: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971D878F@BPXM01GP.gisp.nec.co.jp>
 <20140109002523.GA30797@sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971DA820@BPXM01GP.gisp.nec.co.jp>
 <20140110182355.GC7498@sgi.com>
In-Reply-To: <20140110182355.GC7498@sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

(2014/01/11 3:23), Cliff Wickman wrote:
> On Fri, Jan 10, 2014 at 07:48:27AM +0000, Atsushi Kumagai wrote:
>> On 2014/01/09 9:26:20, kexec <kexec-bounces@lists.infradead.org> wrote:
>>> On Mon, Jan 06, 2014 at 09:27:34AM +0000, Atsushi Kumagai wrote:
>>>> Hello Cliff,
>>>>
>>>> On 2014/01/01 8:30:47, kexec <kexec-bounces@lists.infradead.org> wrote:
>>>>> From: Cliff Wickman <cpw@sgi.com>
>>>>>
>>>>> Gentlemen of kexec,
>>>>>
>>>>> I have been working on enabling kdump on some very large systems, and
>>>>> have found some solutions that I hope you will consider.
>>>>>
>>>>> The first issue is to work within the restricted size of crashkernel memory
>>>>> under 2.6.32-based kernels, such as sles11 and rhel6.
>>>>>
>>>>> The second issue is to reduce the very large size of a dump of a big memory
>>>>> system, even on an idle system.
>>>>>
>>>>> These are my propositions:
>>>>>
>>>>> Size of crashkernel memory
>>>>>    1) raw i/o for writing the dump
>>>>>    2) use root device for the bitmap file (not tmpfs)
>>>>>    3) raw i/o for reading/writing the bitmaps
>>>>>
>>>>> Size of dump (and hence the duration of dumping)
>>>>>    4) exclude page structures for unused pages
>>>>>
>>>>>
>>>>> 1) Is quite easy.  The cache of pages needs to be aligned on a block
>>>>>    boundary and written in block multiples, as required by O_DIRECT files.
>>>>>
>>>>>    The use of raw i/o prevents the growing of the crash kernel's page
>>>>>    cache.
>
> Today I posted V2 of both patches.  V2 of the first patch fixes a bug.
> V2 of the second patch make some of the changes that you and Hatayama-san
> requested.  But these updates don't address all of your points.
>
>
>>>> There is no reason to reject this idea, please re-post it as a formal patch.
>>>> If possible, I would like to know the benefit of only this.
>>>
>>> The motivation for using raw i/o was purely to be able to conserve memory,
>>> not for speed.
>
>> OK, 1) is also for removing cyclic mode, right ?
>
> I did disable cyclic mode for my testing.  I wanted to prove that makedumpfile
> can work in a small memory without cyclic mode.
> I think this is an alternative to cyclic mode, but I don't know all the
> issues.  This is a proof of concept only -- I hope that you guys who have
> the big picture of all the dump-capture issues can fit it in properly.
>
>> I think there is no need to conserve memory with 1) since 2) is enough to
>> remove cyclic mode.
>> (To be exact, there are some cases that we have to use cyclic mode as
>>   Hatayama-san said, but I don't mention that in this mail.)
>>
>>> However, I haven't noticed any significant degradation in speed.
>>> Memory is in 'very' short supply on a large machine (ironically) and a 2.6 or
>>> 3.0 kernel.  We're constrained to the low 4GB, and the kernel is putting other
>>> things in that memory that are related to memory size.
>>> The obvious solution is cyclic mode, but that requires at least 2x the page
>>> scans.  Once for the scan of unnecessary pages and several partial
>>> scans for the copy phase.
>>> But it is tmpfs and kernel page cache that are using up available memory.
>>> If we avoid those, a single page scan can work in about 350M of crashkernel
>>> memory.
>>> This is not a problem with 3.10+ kernels as we're not constrained to low 4G.
>>
>> Even if we can use 350M fully, 5TB is the limit system memory size
>> in non-cyclic mode unless 2), since the bitmap file requires 64MB
>> per 1TB RAM. So, I can't find an importance of 1).
>
> 1) raw i/o for writing the dump
> 2) use root device for the bitmap file (not tmpfs)
> 3) raw i/o for reading/writing the bitmaps
> Non-raw i/o for either of theses files is going to enlarge kernel page
> cache.  There doesn't seem to be any way to ask the kernel to limit
> that growth.  And writing to tmpfs is consuming memory.  The one file
> is much larger than the other, but to be consistent and not let i/o
> consume memory I think we have to do all three.
>
>>>>> 2) Is also quite easy.  My patch finds the path to the crash
>>>>>    kernel's root device by examining the dump pathname. Storing the bitmaps
>>>>>    to a file is otherwise not conserving memory, as they are being written
>>>>>    to tmpfs.
>>>>
>>>> Users will expect that the size of dump file is the same as the size of
>>>> RAM at most, they will prepare a disk which fit to save that.
>>>> But 2) breaks this estimation, I worry about it a little.
>>>
>>> The bit map file is very small compared to the dump. And the dump should be
>>> much smaller than RAM.  Particularly with 4), the excluding of unused page structures.
>>>>
>>>> Of course, I don't reject this idea just only for that reason,
>>>> but I would like to know the definite advantage of this.
>>>> I suppose that the improvement showed in your benchmarks may be came
>>>> from 1) and 4) mostly, so could you let me know that only 2) and 3)
>>>> can perform much faster than the current cyclic mode ?
>>>
>>> 2) and 3), the handling of the bitmap, are small contributors to the
>>> memory shortage issue.  They are a bigger issue the bigger the system.
>>> It's just that if we consistently avoid enlarging page cache and
>>> tmpfs we can avoid the 2nd page scan altogether.
>>> True, my benchmarks show only .2 min. and 1.1 min. improvements
>>> for 2TB and 8TB (2.0 vs 1.8, and 6.6 vs 5.5).
>>> But that's an improvement, not a loss.  And we're absolutely
>>> not going to run out of memory as the scan and copies proceed.
>>> This is important on these old kernels with minimal memory available.
>>
>> Does just changing TMPDIR to a disk meet that purpose ?
>> Is it necessary to add new codes ?
> Perhaps.  But page cache is going to grow.

But then what do you worry about? If using some disk of enough size,
you no longer need to worry about page cache for OOM issue.

On the other hand, another usecase of direct I/O I came up with in the past
was to suppress performance degradation on multiple CPUs due to a lot of TLB
flush. I saw the degradation on my benchmark I did some years ago using around
2.6.30 kernel. On these kernels, flush_tlb_others() was implemented using 8?
interrupt vectors (sorry, I no longer have good memory about the number)
and using more than 8 CPUs, performance no longer scaled.

But I have yet to investigate this usecase even now because I have
addressed other issues that affect scalability, and I might saw different
result on the same benchmark if using the improved recent environment.

For example, we have mmap() now, so we can choose larger mapping size than
ioremap(). This should be working well to drastically reduce the number of
TLB flush.

Also, the recent kernel uses smp_call_function() to call tlb flush handler
on each CPU, so there's no tlb_flush_others() above on recent kernel.

So, I expect situation is getting better than the past, but on multiple CPUS,
effect of page cache is bigger than on a single CPU. This is correct.
Alghouth I have yet to do benchmark on the recent environment, I might still
see some amount of distinguishable degradation caused by releasing page cache.
(Conversely speaking, it's ready to see how page cache affects performance
on multiple CPUs.)

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
