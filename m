Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z2tWI-0003mb-54
 for kexec@lists.infradead.org; Thu, 11 Jun 2015 03:51:11 +0000
Message-ID: <557904DB.8000307@cn.fujitsu.com>
Date: Thu, 11 Jun 2015 11:47:39 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 00/11] makedumpfile: parallel processing
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DBBA33@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DBBA33@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

hello,

though --split can parallel process, it can't just produce one core.
more processes, better performance. but it also means more split cores.
people may want to just produce one core, however they still prefer parallel
processing for its better performance.

so, parallel processing by multiple threads is needed.
in the future, multiple threads can also be used in each split process to
accelerate process.


On 06/10/2015 02:06 PM, Atsushi Kumagai wrote:
> Hello Zhou,
>
>> This patch set implements parallel processing by means of multiple threads.
>> With this patch set, it is available to use multiple threads to read
>> and compress pages. This parallel process will save time.
>> This feature only supports creating dumpfile in kdump-compressed format from
>> vmcore in kdump-compressed format or elf format. Currently, sadump and
>> xen kdump are not supported.
>
> makedumpfile already has a parallel processing feature (--split),
> it parallelizes not only page compression but also disk i/o, so
> I think --split includes what you want to do by this patch.
>
> In what case do you think this patch will be effective, what is
> the advantage of this patch ?
>
>
> Thanks
> Atsushi Kumagai
>
>>
>> Qiao Nuohan (11):
>>   Add readpage_kdump_compressed_parallel
>>   Add mappage_elf_parallel
>>   Add readpage_elf_parallel
>>   Add read_pfn_parallel
>>   Add function to initial bitmap for parallel use
>>   Add filter_data_buffer_parallel
>>   Add write_kdump_pages_parallel to allow parallel process
>>   Add write_kdump_pages_parallel_cyclic to allow parallel process in
>>     cyclic_mode
>>   Initial and free data used for parallel process
>>   Make makedumpfile available to read and compress pages parallelly
>>   Add usage and manual about multiple threads process
>>
>> Makefile       |    2 +
>> erase_info.c   |   29 +-
>> erase_info.h   |    2 +
>> makedumpfile.8 |   24 +
>> makedumpfile.c | 1505 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>> makedumpfile.h |   79 +++
>> print_info.c   |   16 +
>> 7 files changed, 1652 insertions(+), 5 deletions(-)
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec


-- 
Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
