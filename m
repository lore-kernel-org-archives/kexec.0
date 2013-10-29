Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VazHf-0007dy-Qi
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 02:43:57 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 12F053EE15B
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 11:43:28 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0492145DE56
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 11:43:28 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D850745DE54
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 11:43:27 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C82101DB8038
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 11:43:27 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8123F1DB802C
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 11:43:27 +0900 (JST)
Message-ID: <526F20A4.3080302@jp.fujitsu.com>
Date: Tue, 29 Oct 2013 11:42:44 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: print spinner in progress information
References: <5269CD32.200@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971B8EE2@BPXM01GP.gisp.nec.co.jp>
 <526F0EB0.20600@jp.fujitsu.com>
In-Reply-To: <526F0EB0.20600@jp.fujitsu.com>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

(2013/10/29 10:26), HATAYAMA Daisuke wrote:
> (2013/10/25 13:07), Atsushi Kumagai wrote:
>> Hello HATAYAMA-san,
>>
>> (2013/10/25 9:55), HATAYAMA Daisuke wrote:
>>> On system with huge memory, percentage in progress information is
>>> updated at very slow interval, because 1 percent on 1 TiB memory is
>>> about 10 GiB, which looks like as if system has freezed. Then,
>>> confused users might get tempted to push a reset button to recover the
>>> system. We want to avoid such situation as much as possible.
>>>
>>> To address the issue, this patch adds spinner that rotates in the
>>> order of /, |, \ and - next to the progress indicator in percentage,
>>> which helps users to get aware that system is still active and crash
>>> dump process is still in progress now.
>>>
>>> This code is borrowed from diskdump code.
>>>
>>> The example is like this:
>>>
>>> Copying data                       : [  0 %] /
>>> Copying data                       : [  8 %] |
>>> Copying data                       : [ 11 %] \
>>> Copying data                       : [ 14 %] -
>>> Copying data                       : [ 16 %] /
>>> ...
>>> Copying data                       : [ 99 %] /
>>> Copying data                       : [100 %] |
>>
>> I like it, but have a comment.
>>
>>       6109 int
>>       6110 write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
>>       6111                          struct page_desc *pd_zero, off_t *offset_data)
>>       6112 {
>>       ...
>>       6156         per = info->num_dumpable / 100;
>>       ...
>>       6178         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>       6179
>>       6180                 if ((num_dumped % per) == 0)
>>       6181                         print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
>>
>> The interval of calling print_progress() looks still long if
>> num_dumpable is huge.
>> So how about fix this, e.g., by changing the interval to time based ?
>>
>
> I wrote simple bench for time-based interval as below, which measures
> total time consumed for calling time system call with/without vDSO.
> It seems to me that both results are acceptable.
> I'll reflect this change in next version.
>
> $ ./bench
> total: 21.059131
> average: 0.000000
> total: 65.558263
> average: 0.000000
>

This conclusion was wrong. Sorry. For example on our FJ 12 TiB system we collected about 300 GiB
crash dump in about 40 minutes. If removing "if ((num_dumped % per) == 0)" and calling time()
in each loop in print_progress(), total time for invoking time() system call is about 65 * 12
= 780 sec = 13 min. This is about 20 % of a whole crash dump time. Obviously problematic.

Instead, I think it better to increase the number of calling print_progress() like:

   per = info->num_dumpable / 10000

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
