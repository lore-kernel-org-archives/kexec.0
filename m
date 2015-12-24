Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aC1Cv-0008H8-8C
 for kexec@lists.infradead.org; Thu, 24 Dec 2015 08:25:11 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH RFC 00/11] makedumpfile: parallel processing
Date: Thu, 24 Dec 2015 08:20:42 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E10859@BPXM01GP.gisp.nec.co.jp>
References: <1655994487.2838319.1450923648068.JavaMail.zimbra@redhat.com>
 <20151224.122228.361489324.d.hatayama@jp.fujitsu.com>
 <975287896.2848917.1450927897172.JavaMail.zimbra@redhat.com>
 <20151224.125008.280556010.d.hatayama@jp.fujitsu.com>
 <1583977244.2871945.1450936958456.JavaMail.zimbra@redhat.com>
In-Reply-To: <1583977244.2871945.1450936958456.JavaMail.zimbra@redhat.com>
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
To: "HATAYAMA Daisuke (d.hatayama@jp.fujitsu.com)" <d.hatayama@jp.fujitsu.com>, Chao Fan <cfan@redhat.com>
Cc: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> >> >> >> Could you provide the information of your cpu ?
>> >> >> >> I will do some further investigation later.
>> >> >> >>
>> >> >> >
>> >> >> > OK, of course, here is the information of cpu:
>> >> >> >
>> >> >> > # lscpu
>> >> >> > Architecture:          x86_64
>> >> >> > CPU op-mode(s):        32-bit, 64-bit
>> >> >> > Byte Order:            Little Endian
>> >> >> > CPU(s):                48
>> >> >> > On-line CPU(s) list:   0-47
>> >> >> > Thread(s) per core:    1
>> >> >> > Core(s) per socket:    6
>> >> >> > Socket(s):             8
>> >> >> > NUMA node(s):          8
>> >> >> > Vendor ID:             AuthenticAMD
>> >> >> > CPU family:            16
>> >> >> > Model:                 8
>> >> >> > Model name:            Six-Core AMD Opteron(tm) Processor 8439 SE
>> >> >> > Stepping:              0
>> >> >> > CPU MHz:               2793.040
>> >> >> > BogoMIPS:              5586.22
>> >> >> > Virtualization:        AMD-V
>> >> >> > L1d cache:             64K
>> >> >> > L1i cache:             64K
>> >> >> > L2 cache:              512K
>> >> >> > L3 cache:              5118K
>> >> >> > NUMA node0 CPU(s):     0,8,16,24,32,40
>> >> >> > NUMA node1 CPU(s):     1,9,17,25,33,41
>> >> >> > NUMA node2 CPU(s):     2,10,18,26,34,42
>> >> >> > NUMA node3 CPU(s):     3,11,19,27,35,43
>> >> >> > NUMA node4 CPU(s):     4,12,20,28,36,44
>> >> >> > NUMA node5 CPU(s):     5,13,21,29,37,45
>> >> >> > NUMA node6 CPU(s):     6,14,22,30,38,46
>> >> >> > NUMA node7 CPU(s):     7,15,23,31,39,47
>> >> >>
>> >> >> This CPU assignment on NUMA nodes looks interesting. Is it possible
>> >> >> that this affects performance of makedumpfile? This is just a guess.
>> >> >>
>> >> >> Could you check whether the performance gets imporoved if you run each
>> >> >> thread on the same NUMA node? For example:
>> >> >>
>> >> >>   # taskset -c 0,8,16,24 makedumpfile --num-threads 4 -c -d 0 vmcore
>> >> >>   vmcore-cd0
>> >> >>
>> >> > Hi HATAYAMA,
>> >> >
>> >> > I think your guess is right, but maybe your command has a little
>> >> > problem.
>> >> >
>> >> > From my test, the NUMA did affect the performance, but not too much.
>> >> > The average time of cpus in the same NUMA node:
>> >> > # taskset -c 0,8,16,24,32 makedumpfile --num-threads 4 -c -d 0 vmcore
>> >> > vmcore-cd0
>> >> > is 314s
>> >> > The average time of cpus in different NUMA node:
>> >> > # taskset -c 2,3,5,6,7 makedumpfile --num-threads 4 -c -d 0 vmcore
>> >> > vmcore-cd0
>> >> > is 354s
>> >> >
>> >>
>> >> Hmm, according to some previous discussion, what we should see here is
>> >> whether it affects performance of makedumpfile with --num-threads 1
>> >> and -d 31. So you should need to compare:
>> >>
>> >>     # taskset 0,8 makedumpfile --num-threads 1 -c -d 31 vmcore vmcore-d31
>> >>
>> >> with:
>> >>
>> >>     # taskset 0 makedumpfile -c -d 0 vmcore vmcore-d31
>>
>> I removed -c option wrongly. What I wanted to write is:
>>
>>     # taskset -c 0,8 makedumpfile --num-threads 1 -d 31 vmcore vmcore-d31
>>
>> and:
>>
>>     # taskset -c 0 makedumpfile -d 31 vmcore vmcore-d31
>>
>> just in case...

Why did you remove -c option from makedumpfile ?
We are discussing the performance with compression.
I think the below is correct:

       # taskset -c 0,8 makedumpfile --num-threads 1 [-c|-l|-p] -d 31 vmcore vmcore-d31

and:

       # taskset -c 0 makedumpfile [-c|-l|-p] -d 31 vmcore vmcore-d31


Thanks,
Atsushi Kumagai

>Hi HATAYAMA,
>
>the average time of
># taskset -c 0,8 makedumpfile --num-threads 1 -d 31 vmcore vmcore-d31
>is 33s.
>the average time of
># taskset -c 0 makedumpfile -d 31 vmcore vmcore-d31
>is 18s.
>
>My test steps:
>1. change /etc/kdump/conf with
>"core_collector makedumpfile -l --message-level 1 -d 31"
>2. make a crash
>3. cd into the directory of the vmcore made by kdump
>4. in the directory of vmcore do
># taskset -c 0,8 makedumpfile --num-threads 1 -d 31 vmcore vmcore-d31
>or
># taskset -c 0 makedumpfile -d 31 vmcore vmcore-d31
>
>if there are there any problems, please tell me.
>
>Thanks,
>Chao Fan
>
>> >>
>> >> Also, I'm assuming that you've done these benchmark on kdump 1st
>> >> kernel, not kdump 2nd kernel. Is this correct?
>> >>
>> > Hi HATAYAMA,
>> >
>> > I test in the first kernel, not in the kdump second kernel.
>> >
>>
>> I see.
>>
>> --
>> Thanks.
>> HATAYAMA, Daisuke
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
