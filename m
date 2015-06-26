Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z8OQH-0006tp-1E
 for kexec@lists.infradead.org; Fri, 26 Jun 2015 07:51:41 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v2 00/10] makedumpfile: parallel processing
Date: Fri, 26 Jun 2015 07:49:22 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DC9CF3@BPXM01GP.gisp.nec.co.jp>
References: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <558B6696.4020906@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DC9C14@BPXM01GP.gisp.nec.co.jp>
 <558CFEED.1040501@cn.fujitsu.com>
In-Reply-To: <558CFEED.1040501@cn.fujitsu.com>
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On 06/26/2015 03:07 PM, Atsushi Kumagai wrote:
>> Hello Zhou,
>>
>>> >Hello Atsushi Kumagai,
>>> >
>>> >I test this patch set in several machines and the following is the benchmark.
>> Thanks for your report, it looks good as before.
>> I also did simple test on kernel 3.19 on a 5GB Virtual Machine,
>> but I can't get such good result as below:
>>
>> / # time makedumpfile -c --num-threads 0 /proc/vmcore /mnt/dumpfile
>> Copying data                       : [100.0 %] /
>>
>> The dumpfile is saved to /mnt/dumpfile.
>>
>> makedumpfile Completed.
>> real    0m 44.40s
>> user    0m 43.62s
>> sys     0m 0.69s
>> / #
>>
>> / # time makedumpfile -c --num-threads 4 /proc/vmcore /mnt/dumpfile
>> Copying data                       : [100.0 %] -
>> Copying data                       : [100.0 %] /
>>
>> The dumpfile is saved to /mnt/dumpfile.
>>
>> makedumpfile Completed.
>> real    5m 29.54s
>> user    6m 8.18s
>> sys     16m 33.25s
>> / #
>>
>>
>> There is a big performance degradation.
>> Do you have any ideas why this happens ?
>
>Does your Virtual Machine have more than 2 processors?
>If so, check the value:nr_cpus in KDUMP_COMMANDLINE_APPEND of /etc/sysconfig/kdump.
>It should be also set to the number larger than 2.
>
>To "--num-threads 4", the most suitable number of processors is 5.

I attached 5 processors to the VM and I confirmed that all threads
consumed full cpu time by top(1) on the host:

    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  17614 qemu      20   0 5792m 4.9g 5652 R 435.1 72.8  29:02.17 qemu-kvm

So I think the performance must be improved...


Thanks
Atsushi Kumagai
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
