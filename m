Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z9sl6-0001Sj-9n
 for kexec@lists.infradead.org; Tue, 30 Jun 2015 10:27:22 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v2 00/10] makedumpfile: parallel processing
Date: Tue, 30 Jun 2015 09:06:38 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DCAB4E@BPXM01GP.gisp.nec.co.jp>
References: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <558B6696.4020906@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DC9C14@BPXM01GP.gisp.nec.co.jp>
 <558CFEED.1040501@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DC9CF3@BPXM01GP.gisp.nec.co.jp>
 <5590E366.6020904@cn.fujitsu.com>
In-Reply-To: <5590E366.6020904@cn.fujitsu.com>
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

>On 06/26/2015 03:49 PM, Atsushi Kumagai wrote:
>> I attached 5 processors to the VM and I confirmed that all threads
>> consumed full cpu time by top(1) on the host:
>>
>>      PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>    17614 qemu      20   0 5792m 4.9g 5652 R 435.1 72.8  29:02.17 qemu-kvm
>>
>> So I think the performance must be improved...
>
>Since I can't get that result in all machines here, could you test it with the patch:time
>and show me the output?
>Using "./makedumpfile -c --num-threads 4 /proc/vmcore dumpfile" is OK.
>
>The attachment is the patch time.

Here is the result:

/ # makedumpfile -c --num-threads 4 /proc/vmcore /mnt/dumpfile
Copying data                       : [100.0 %] |
Copying data                       : [100.0 %] \

The dumpfile is saved to /mnt/dumpfile.

makedumpfile Completed.
lock time: 310s935500us
write time: 3s970037us
hit time: 6s316043us
find time: 317s926654us
loop_time: 37s321800us
thread consume_time: 0s0us
thread timea: 0s0us
thread timeb: 0s0us
read_time[0]: 8s637011us
lock_current_time[0]: 0s284428us
found_time[0]: 60s366795us
lock_consumed_time[0]: 2s782596us
compress_time[0]: 301s427073us
read_time[1]: 8s435914us
lock_current_time[1]: 0s271680us
found_time[1]: 60s329026us
lock_consumed_time[1]: 2s849061us
compress_time[1]: 302s98620us
read_time[2]: 8s380550us
lock_current_time[2]: 0s270388us
found_time[2]: 60s209376us
lock_consumed_time[2]: 3s297574us
compress_time[2]: 301s486768us
read_time[3]: 8s550662us
lock_current_time[3]: 0s278997us
found_time[3]: 60s476702us
lock_consumed_time[3]: 3s49184us
compress_time[3]: 301s718390us
count1: 172
count2: 70921401
count3: 0
count4: 0
count5: 0
count6: 0
count7: 0
exec time: 380s125494us


BTW, I fixed a small mistake before testing like:

- write_time = (write2.tv_sec - write1.tv_sec) * 1000000 + (write2.tv_usec - write1.tv_usec);
+ write_time += (write2.tv_sec - write1.tv_sec) * 1000000 + (write2.tv_usec - write1.tv_usec);


Thanks
Atsushi Kumagai
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
