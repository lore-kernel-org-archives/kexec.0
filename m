Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vay6F-0004p2-L2
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 01:28:04 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 85EA53EE0BD
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 10:27:40 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 92E8745DE60
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 10:27:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 73C4D45DE55
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 10:27:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5BDE31DB804B
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 10:27:39 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id F1F7D1DB8043
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 10:27:38 +0900 (JST)
Message-ID: <526F0EB0.20600@jp.fujitsu.com>
Date: Tue, 29 Oct 2013 10:26:08 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: print spinner in progress information
References: <5269CD32.200@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971B8EE2@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971B8EE2@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

(2013/10/25 13:07), Atsushi Kumagai wrote:
> Hello HATAYAMA-san,
> 
> (2013/10/25 9:55), HATAYAMA Daisuke wrote:
>> On system with huge memory, percentage in progress information is
>> updated at very slow interval, because 1 percent on 1 TiB memory is
>> about 10 GiB, which looks like as if system has freezed. Then,
>> confused users might get tempted to push a reset button to recover the
>> system. We want to avoid such situation as much as possible.
>>
>> To address the issue, this patch adds spinner that rotates in the
>> order of /, |, \ and - next to the progress indicator in percentage,
>> which helps users to get aware that system is still active and crash
>> dump process is still in progress now.
>>
>> This code is borrowed from diskdump code.
>>
>> The example is like this:
>>
>> Copying data                       : [  0 %] /
>> Copying data                       : [  8 %] |
>> Copying data                       : [ 11 %] \
>> Copying data                       : [ 14 %] -
>> Copying data                       : [ 16 %] /
>> ...
>> Copying data                       : [ 99 %] /
>> Copying data                       : [100 %] |
> 
> I like it, but have a comment.
> 
>      6109 int
>      6110 write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
>      6111                          struct page_desc *pd_zero, off_t *offset_data)
>      6112 {
>      ...
>      6156         per = info->num_dumpable / 100;
>      ...
>      6178         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>      6179
>      6180                 if ((num_dumped % per) == 0)
>      6181                         print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
> 
> The interval of calling print_progress() looks still long if
> num_dumpable is huge.
> So how about fix this, e.g., by changing the interval to time based ?
> 

I wrote simple bench for time-based interval as below, which measures
total time consumed for calling time system call with/without vDSO.
It seems to me that both results are acceptable.
I'll reflect this change in next version.

$ ./bench
total: 21.059131
average: 0.000000
total: 65.558263
average: 0.000000

==bench.c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static inline double getdtime(void)
{
        struct timeval tv;
        gettimeofday(&tv, NULL);
        return (double)tv.tv_sec + (double)tv.tv_usec * 1.0e-6;
}

int main(int argc, char **argv)
{
        unsigned long i;
        time_t t;
        double t1, t2, total;
        const int NR_time = 201;
        const unsigned long nr_repeat = (1UL << 40) / 4096;

        for (i = 0; i < nr_repeat; ++i) {
                t1 = getdtime();
                time(&t);
                t2 = getdtime();
                total += t2 - t1;
        }
        printf("total: %lf\n", total);
        printf("average: %lf\n", total / nr_repeat);

        for (i = 0; i < nr_repeat; ++i) {
                t1 = getdtime();
                syscall(NR_time, &t);
                t2 = getdtime();
                total += t2 - t1;
        }
        printf("total: %lf\n", total);
        printf("average: %lf\n", total / nr_repeat);

        return 0;
}
==

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
