Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a8OTm-0000LK-8A
 for kexec@lists.infradead.org; Mon, 14 Dec 2015 08:27:41 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH RFC 00/11] makedumpfile: parallel processing
Date: Mon, 14 Dec 2015 08:26:00 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E0D0DA@BPXM01GP.gisp.nec.co.jp>
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <5575123D.8090506@cn.fujitsu.com>
 <1831406384.24254782.1448959169018.JavaMail.zimbra@redhat.com>
 <565E81A7.4080604@cn.fujitsu.com>
 <20151202072443.GD2899@dhcp-128-65.nay.redhat.com>
 <565E9FFE.20501@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E09F28@BPXM01GP.gisp.nec.co.jp>
 <56610990.2090607@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E0C319@BPXM01GP.gisp.nec.co.jp>
 <566947AF.5010800@cn.fujitsu.com>
In-Reply-To: <566947AF.5010800@cn.fujitsu.com>
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
To: =?utf-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?= <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>>> Think about this, in a huge memory, most of the page will be filtered, and
>>> we have 5 buffers.
>>>
>>> page1       page2      page3     page4     page5      page6       page7 .....
>>> [buffer1]   [2]        [3]       [4]       [5]
>>> unfiltered  filtered   filtered  filtered  filtered   unfiltered  filtered
>>>
>>> Since filtered page will take a buffer, when compressing page1,
>>> page6 can't be compressed at the same time.
>>> That why it will prevent parallel compression.
>>
>> Thanks for your explanation, I understand.
>> This is just an issue of the current implementation, there is no
>> reason to stand this restriction.
>>
>>>> Further, according to Chao's benchmark, there is a big performance
>>>> degradation even if the number of thread is 1. (58s vs 240s)
>>>> The current implementation seems to have some problems, we should
>>>> solve them.
>>>>
>>>
>>> If "-d 31" is specified, on the one hand we can't save time by compressing
>>> parallel, on the other hand we will introduce some extra work by adding
>>> "--num-threads". So it is obvious that it will have a performance degradation.
>>
>> Sure, there must be some overhead due to "some extra work"(e.g. exclusive lock),
>> but "--num-threads=1 is 4 times slower than --num-threads=0" still sounds
>> too slow, the degradation is too big to be called "some extra work".
>>
>> Both --num-threads=0 and --num-threads=1 are serial processing,
>> the above "buffer fairness issue" will not be related to this degradation.
>> What do you think what make this degradation ?
>>
>
>I can't get such result at this moment, so I can't do some further investigation
>right now. I guess it may be caused by the underlying implementation of pthread.
>I reviewed the test result of the patch v2 and found in different machines,
>the results are quite different.

Unluckily, I also can't reproduce such big degradation.
According to the Chao's verification, this issue seems different form
the "too many page fault issue" that we solved.
I have no ideas, but at least I want to confirm whether this issue
is avoidable or not.

>It seems that I can get almost the same result of Chao from "PRIMEQUEST 1800E".
>
>###################################
>- System: PRIMERGY RX300 S6
>- CPU: Intel(R) Xeon(R) CPU x5660
>- memory: 16GB
>###################################
>************ makedumpfile -d 7 ******************
>                 core-data       0       256
>         threads-num
>-l
>         0                       10      144
>         4                       5       110
>         8                       5       111
>         12                      6       111
>
>************ makedumpfile -d 31 ******************
>                 core-data       0       256
>         threads-num
>-l
>         0                       0       0
>         4                       2       2
>         8                       2       3
>         12                      2       3
>
>###################################
>- System: PRIMEQUEST 1800E
>- CPU: Intel(R) Xeon(R) CPU E7540
>- memory: 32GB
>###################################
>************ makedumpfile -d 7 ******************
>                 core-data        0       256
>         threads-num
>-l
>         0                        34      270
>         4                        63      154
>         8                        64      131
>         12                       65      159
>
>************ makedumpfile -d 31 ******************
>                 core-data        0       256
>         threads-num
>-l
>         0                        2       1
>         4                        48      48
>         8                        48      49
>         12                       49      50
>
>>> I'm not so sure if it is a problem that the performance degradation is so big.
>>> But I think if in other cases, it works as expected, this won't be a problem(
>>> or a problem needs to be fixed), for the performance degradation existing
>>> in theory.
>>>
>>> Or the current implementation should be replaced by a new arithmetic.
>>> For example:
>>> We can add an array to record whether the page is filtered or not.
>>> And only the unfiltered page will take the buffer.
>>
>> We should discuss how to implement new mechanism, I'll mention this later.
>>
>>> But I'm not sure if it is worth.
>>> For "-l -d 31" is fast enough, the new arithmetic also can't do much help.
>>
>> Basically the faster, the better. There is no obvious target time.
>> If there is room for improvement, we should do it.
>>
>
>Maybe we can improve the performance of "-c -d 31" in some case.

Yes, the buffer is used for -c, -l and -p, not only for -l.
It would be useful to improve that.

>BTW, we can easily get the theoretical performance by using the "--split".

Are you sure ? You persuaded me in the thread below:

  http://lists.infradead.org/pipermail/kexec/2015-June/013881.html

--num-threads is orthogonal to --split, it's better to use the both
option since they try to solve different bottlenecks.
That's why I decided to merge your multi thread feature.

However, what you said sounds --split is a superset of --num-threads.
You don't need the multi thread feature ?


Thanks,
Atsushi Kumagai
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
