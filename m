Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XlsDs-0003vH-46
 for kexec@lists.infradead.org; Wed, 05 Nov 2014 04:29:32 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 0/5] makedumpfile: --split: assign fair I/O workloads
 in appropriate time
Date: Wed, 5 Nov 2014 04:18:22 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D647C0@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701D58CD3@BPXM01GP.gisp.nec.co.jp>
 <20141028.152459.485895318.d.hatayama@jp.fujitsu.com>
 <544F386C.4080001@cn.fujitsu.com>
 <20141030.092114.461002253.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20141030.092114.461002253.d.hatayama@jp.fujitsu.com>
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
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "qiaonuohan@cn.fujitsu.com" <qiaonuohan@cn.fujitsu.com>
Cc: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>From: qiaonuohan <qiaonuohan@cn.fujitsu.com>
>Subject: Re: [PATCH v2 0/5] makedumpfile: --split: assign fair I/O workloads in appropriate time
>Date: Tue, 28 Oct 2014 14:32:12 +0800
>
>> On 10/28/2014 02:24 PM, HATAYAMA Daisuke wrote:
>>> From: Atsushi Kumagai<kumagai-atsushi@mxc.nes.nec.co.jp>
>>> Subject: RE: [PATCH v2 0/5] makedumpfile: --split: assign fair I/O
>>> workloads in appropriate time
>>> Date: Mon, 27 Oct 2014 07:51:56 +0000
>>>
>>>> Hello Zhou,
>>>>
>>>>> On 10/17/2014 11:50 AM, Atsushi Kumagai wrote:
>>>>>> Hello,
>>>>>>
>>>>>> The code looks good to me, thanks Zhou.
>>>>>> Now, I have a question on performance.
>>>>>>
>>>>>>> The issue is discussed at
>>>>>>> http://lists.infradead.org/pipermail/kexec/2014-March/011289.html
>>>>>>>
>>>>>>> This patch implements the idea of 2-pass algorhythm with smaller
>>>>>>> memory to manage splitblock table.
>>>>>>> Exactly the algorhythm is still 3-pass,but the time of second pass is
>>>>>>> much shorter.
>>>>>>> The tables below show the performence with different size of
>>>>>>> cyclic-buffer and splitblock.
>>>>>>> The test is executed on the machine having 128G memory.
>>>>>>>
>>>>>>> the value is total time (including first pass and second pass).
>>>>>>> the value in brackets is the time of second pass.
>>>>>>
>>>>>> Do you have any idea why the time of second pass is much larger when
>>>>>> the splitblock-size is 2G ? I worry about the scalability.
>>>>>>
>>>>> Hello,
>>>>>
>>>>> 	Since the previous machine can't be used for some reasons,I test several
>>>>> 	times using latest code
>>>>> in others, but that never happened. It seems that all things are
>>>>> right. Tests are executed in two machines(server,pc).
>>>>> Tests are based on:
>>>>
>>>> Well...OK, I'll take that as an issue specific to that machine
>>>> (or your mistakes as you said).
>>>> Now I have another question.
>>>>
>>>> calculate_end_pfn_by_splitblock():
>>>> 	...
>>>>          /* deal with incomplete splitblock */
>>>>          if (pfn_needed_by_per_dumpfile<  0) {
>>>>                  --*current_splitblock;
>>>>                  splitblock_inner -= splitblock->entry_size;
>>>>                  end_pfn = CURRENT_SPLITBLOCK_PFN_NUM;
>>>>                  *current_splitblock_pfns = (-1) * pfn_needed_by_per_dumpfile;
>>>>                  pfn_needed_by_per_dumpfile +=
>>>>                  read_value_from_splitblock_table(splitblock_inner);
>>>>                  end_pfn = calculate_end_pfn_in_cycle(CURRENT_SPLITBLOCK_PFN_NUM,
>>>>                                                       CURRENT_SPLITBLOCK_PFN_NUM +
>splitblock->page_per_splitblock,
>>>>                                                       end_pfn,pfn_needed_by_per_dumpfile);
>>>>          }
>>>>
>>>> This block causes the re-scanning for the cycle corresponding to the
>>>> current_splitblock, so the larger cyc-buf, the longer the time takes.
>>>> If cyc-buf is 4096 (this means the number of cycle is 1), the whole
>>>> page
>>>> scanning will be done in the second pass. Actually, the performance
>>>> when
>>>> cyc-buf=4096 was so bad.
>>>>
>>>> Is this process necessary ? I think splitting splitblocks is overkill
>>>> because I understood that splblk-size is the granularity of the
>>>> fairness I/O, tuning splblk-size is a trade off between fairness and
>>>> memory usage.
>>>> However, there is no advantage to reducing splblk-size in the current
>>>> implementation, it just consumes large amounts of memory.
>>>> If we remove the process, we can avoid the whole page scanning in
>>>> the second pass and reducing splblk-size will be meaningful as I
>>>> expected.
>>>>
>>>
>>> Yes, I don't think this rescan works with this splitblock method,
>>> too. The idea of this splitblock method is to reduce the number of
>>> filitering processing from 3-times to 2-times at the expence of at
>>> most splitblock-size difference of each dump file. Doing rescan here
>>> doesn't fit to the idea.
>>
>> Hello,
>>
>> The only things that bothers me is without getting the exact pfn, some
>> of the split files may be empty, with no page stored in it. If this is
>> not a issue, I think the re-scanning is useless.
>>
>
>It is within the idea I wrote above that empty files can occur. But
>there might be further improvement point to decrease possibility of
>empty files. For example, how about deriving default splitblock size
>from the actual number of dumpable pages, not constant 1GB?

Empty files don't cause any problems, it's just a secondary result
of allowing the difference within the splitblock size.
I don't think it's worth avoiding empty files, I prefer to keep the
code simple for this issue.


Thanks,
Atsushi Kumagai

>--
>Thanks.
>HATAYAMA, Daisuke
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
