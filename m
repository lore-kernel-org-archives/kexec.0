Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4NZ9-0007gX-Nl
 for kexec@lists.infradead.org; Mon, 15 Jun 2015 06:08:17 +0000
Message-ID: <557E6B98.9020404@cn.fujitsu.com>
Date: Mon, 15 Jun 2015 14:07:20 +0800
From: qiaonuohan <qiaonuohan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 00/11] makedumpfile: parallel processing
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DBBA33@BPXM01GP.gisp.nec.co.jp>
 <557904DB.8000307@cn.fujitsu.com> <557E318C.504@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DC517C@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DC517C@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 06/15/2015 01:57 PM, Atsushi Kumagai wrote:
> Hello Qiao,
>
>>> On 06/10/2015 02:06 PM, Atsushi Kumagai wrote:
>>>> Hello Zhou,
>>>>
>>
>> Hello Atsushi,
>>
>>>>> This patch set implements parallel processing by means of multiple threads.
>>>>> With this patch set, it is available to use multiple threads to read
>>>>> and compress pages. This parallel process will save time.
>>>>> This feature only supports creating dumpfile in kdump-compressed format from
>>>>> vmcore in kdump-compressed format or elf format. Currently, sadump and
>>>>> xen kdump are not supported.
>>>>
>>>> makedumpfile already has a parallel processing feature (--split),
>>>> it parallelizes not only page compression but also disk i/o, so
>>>> I think --split includes what you want to do by this patch.
>>>>
>>>> In what case do you think this patch will be effective, what is
>>>> the advantage of this patch ?
>>
>> Since commit 428a5e99eea929639ab9c761f33743f78a961b1a(kdumpctl: Pass
>> disable_cpu_apicid to kexec of capture kernel) has been merged. It is possible for
>> us to use multiple cpus in 2nd kernel.
>>
>> Using multiple threads is trying to take advantage of multiple cpus in 2nd kernel.
>> Since memory becomes bigger and bigger, dumping spends more time. Why not take
>> advantage of multiple cpus?
>>
>> OTOH, --split does a lot help to improve performance. But more processes
>> means more files, saving multiple files and managing those files is not that
>> convenient.
>
> I see, actually I guess some users may feel lazy to use --split since
> it requires concatenation for analyzing, and it seems that some improvements
> by using multiple threads can be expected at least in the zlib case.
> So I agree with the concept.
>
>> Multiple threads do have some merit in improving performance. And later, as zhou
>> said, we can also try to combine --split with multiple threads to save more time.
>
> At first I thought it's enough to modify --split path to generate single vmcore.
> However, if the compression process is the bottleneck, we should allot multiple
> cpus to each i/o process when doing parallel i/o. For that reason, it's good to
> introduce the new feature to create multiple threads in addition to --split.

I see.

>
> Just one thing, when you make the complete version, please make it on the devel
> branch because cyclic/non-cyclic codes have been changed from v1.5.8.

Yes, we will start rebasing the code.

>
>
> Thanks
> Atsushi Kumagai
>
>
>> --
>> Regards
>> Qiao Nuohan
>>
>>>>
>>>>
>>>> Thanks
>>>> Atsushi Kumagai
>>>>
>>>>>
>>>>> Qiao Nuohan (11):
>>>>>    Add readpage_kdump_compressed_parallel
>>>>>    Add mappage_elf_parallel
>>>>>    Add readpage_elf_parallel
>>>>>    Add read_pfn_parallel
>>>>>    Add function to initial bitmap for parallel use
>>>>>    Add filter_data_buffer_parallel
>>>>>    Add write_kdump_pages_parallel to allow parallel process
>>>>>    Add write_kdump_pages_parallel_cyclic to allow parallel process in
>>>>>      cyclic_mode
>>>>>    Initial and free data used for parallel process
>>>>>    Make makedumpfile available to read and compress pages parallelly
>>>>>    Add usage and manual about multiple threads process
>>>>>
>>>>> Makefile       |    2 +
>>>>> erase_info.c   |   29 +-
>>>>> erase_info.h   |    2 +
>>>>> makedumpfile.8 |   24 +
>>>>> makedumpfile.c | 1505 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>> makedumpfile.h |   79 +++
>>>>> print_info.c   |   16 +
>>>>> 7 files changed, 1652 insertions(+), 5 deletions(-)
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> kexec mailing list
>>>>> kexec@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>
>>>
>


-- 
Regards
Qiao Nuohan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
