Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WT2lw-00044z-2U
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 05:22:38 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: --split: assign fair I/O workloads for
 each process
Date: Thu, 27 Mar 2014 05:18:41 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FA0E5@BPXM01GP.gisp.nec.co.jp>
References: <20140318.120939.49114730.d.hatayama@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F90A2@BPXM01GP.gisp.nec.co.jp>
 <533119A4.8040900@jp.fujitsu.com>
 <20140326.063828.455925185.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140326.063828.455925185.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> (2014/03/25 10:14), Atsushi Kumagai wrote:
>>>> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>>>>
>>>> When --split option is specified, fair I/O workloads should be
>>>> assigned for each process to maximize amount of performance
>>>> optimization by parallel processing.
>>>>
>>>> However, the current implementation of setup_splitting() in cyclic
>>>> mode doesn't care about filtering at all; I/O workloads for each
>>>> process could be biased easily.
>>>>
>>>> This patch deals with the issue by implementing the fair I/O workload
>>>> assignment as setup_splitting_cyclic().
>>>>
>>>> Note: If --split is specified in cyclic mode, we do filtering three
>>>> times: in get_dumpable_pages_cyclic(), in setup_splitting_cyclic() and
>>>> in writeout_dumpfile(). Filtering takes about 10 minutes on system
>>>> with huge memory according to the benchmark on the past, so it might
>>>> be necessary to optimize filtering or setup_filtering_cyclic().
>>>
>>> Sorry, I lost the result of that benchmark, could you give me the URL?
>>> I'd like to confirm that the advantage of fair I/O will exceed the
>>> 10 minutes disadvantage.
>>>
>>
>> Here are two benchmarks by Jingbai Ma and myself.
>>
>> http://lists.infradead.org/pipermail/kexec/2013-March/008515.html
>> http://lists.infradead.org/pipermail/kexec/2013-March/008517.html
>>
>>
>> Note that Jingbai Ma's results are sum of get_dumpable_cyclic() and writeout_dumpfile(), so apparently it looks
>twice larger than mine, but actually they show almost same performance.
>>
>> In summary, each result shows about 40 seconds per 1TiB. So, most of systems is not affected very much. On 12TiB
>memory, which is the current maximum memory size of Fujitsu system, we needs 480 seconds == 8 minutes more. But this
>is stable in the sense that time never become long suddenly in some rare worst case, so it seems to me optimistic
>in this sense.
>>
>> The other ideas to deal with the issue are:
>>
>> - paralellize the counting up processes. But it might be difficult to paralellize the 2nd pass, which seems inherently
>serial processing.
>>
>> - Insead of doing the 2nd pass, make the terminating proces join to still running process. But it might be combersome
>to implement this not using pthread.
>>
>
>I noticed that it's able to create a table of dumpable pages with a
>relatively small amount of memory by manging a memory as blocks. This
>is just kind of a page table management.
>
>For example, define a block 1 GiB boundary region and assume a system
>with 64 TiB physical memory (which is current maximum on x86_64).
>
>Then,
>
>  64 TiB / 1 GiB = 64 Ki blocks
>
>A table we consdier here have the number of dumpable pages for each 1
>GiB boundary in each entry of 8 bytes. So, total size of the table is:
>
>  8 B * 64 Ki blocks = 512 KiB
>
>Counting up dumpable pages in each GiB boundary can be done by 1 pass
>only; get_dumpable_cyclic() does that too.
>
>Then, it's assign amount of I/O to each process fairly enough. The
>difference is at most 1 GiB. If disk speed is 100 MiB/sec, 1 GiB
>corresponds to about 10 seconds only.
>
>If you think 512 KiB not small enough, it would be able to increase
>block size a little more. If choosing 8 GiB block, table size is 64
>KiB only, and the 8 GiB data corresponds to about 80 seconds on
>typical disks.
>
>How do you think this?

Good, I prefer this to the first one. 
Even the first one can't achieve complete fairness due to zero pages,
we should also accept the 1 GiB difference.

I think 512KiB will not cause a problem in practice,
you should go on with this idea.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
