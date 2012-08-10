Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzklC-0007O1-MX
 for kexec@lists.infradead.org; Fri, 10 Aug 2012 08:40:01 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 90F863EE0AE
 for <kexec@lists.infradead.org>; Fri, 10 Aug 2012 17:39:50 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 76A5545DD78
 for <kexec@lists.infradead.org>; Fri, 10 Aug 2012 17:39:50 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 54FEC45DD74
 for <kexec@lists.infradead.org>; Fri, 10 Aug 2012 17:39:50 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 47AD41DB802C
 for <kexec@lists.infradead.org>; Fri, 10 Aug 2012 17:39:50 +0900 (JST)
Received: from m022.s.css.fujitsu.com (m022.s.css.fujitsu.com [10.0.81.62])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id F0A111DB803A
 for <kexec@lists.infradead.org>; Fri, 10 Aug 2012 17:39:49 +0900 (JST)
Date: Fri, 10 Aug 2012 17:39:38 +0900 (JST)
Message-Id: <20120810.173938.37160718.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120807.163120.106259238.d.hatayama@jp.fujitsu.com>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120806204731.GJ25559@redhat.com>
 <20120807.163120.106259238.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
Date: Tue, 7 Aug 2012 16:31:20 +0900

> From: Vivek Goyal <vgoyal@redhat.com>
> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
> Date: Mon, 6 Aug 2012 16:47:31 -0400
> 
>> On Fri, Jun 29, 2012 at 11:13:20AM +0900, Atsushi Kumagai wrote:
>>> Hello,
>>> 
>>> I improved prototype of cyclic processing as version 2.
>>> If there is no objection to basic idea, I want to consider the things
>>> related to performance as next step. (Concretely, buffer size and the patch set
>>> HATAYAMA-san sent a short time ago.) 
>> 
>> Hi Atsushi San,
>> 
>> Just checking that what's the state of these patches now. Are they ready
>> to be included in makedumpfile?
>> 
>> I would love to see new makedumpfile where memory usage does not grow
>> by physical memory present in the system. (Assuming computig overhead
>> of cycles is bearable).
>> 
>> Thanks
>> Vivek
>> 
> 
> Hello Vivek,
> 
> I'm just now benchmarking cycle processing on our machine. Please wait
> for a while.
> 
> Thanks.
> HATAYAMA, Daisuke
> 

I finished benchmarking filtering time and demonstrate the result.
But I failed to collect amount of memory consumption by my mistake. If
they are necessary, I'll again try to collect them. But we have 9 days
vacation starting tommorow, so I'll do that after the vacation.

The machine spec I used is as follows:

  Memory: 2TB
  CPU: Intel(R) Xeon(R) CPU E7- 8870  @ 2.40GHz
       (8 sockets, 10 cores, 2 threads)

In the first step, I chosed buffer size 10KB and it took about 3h 45m
57s. So, next I changed the buffer size to 512KB and measured up to
8MB.

The result is as follows:

| buffer size | time       |
|-------------+------------|
| 8 MB        | 48.32 sec  |
| 4 MB        | 55.76 sec  |
| 2 MB        | 69.91 sec  |
| 1 MB        | 98.25 sec  |
| 512 KB      | 154.42 sec |

BTW, the existing free_list logic took about 48 sec for the same
vmcore as below.

STEP [Excluding free pages       ] : 49.846321 seconds
STEP [Excluding unnecessary pages] : 6.339228 seconds
STEP [Excluding free pages       ] : 48.595884 seconds
STEP [Excluding unnecessary pages] : 6.530479 seconds
STEP [Excluding free pages       ] : 48.598879 seconds
STEP [Excluding unnecessary pages] : 6.527133 seconds
STEP [Excluding free pages       ] : 48.602401 seconds
STEP [Excluding unnecessary pages] : 6.502681 seconds
STEP [Excluding free pages       ] : 48.602010 seconds
STEP [Excluding unnecessary pages] : 6.469853 seconds
STEP [Excluding free pages       ] : 48.601637 seconds
STEP [Excluding unnecessary pages] : 6.431381 seconds
STEP [Excluding free pages       ] : 48.601195 seconds
STEP [Excluding unnecessary pages] : 6.416676 seconds
STEP [Excluding free pages       ] : 48.602221 seconds
STEP [Excluding unnecessary pages] : 6.387611 seconds
STEP [Excluding free pages       ] : 48.589972 seconds
STEP [Excluding unnecessary pages] : 0.816955 seconds

Original pages  : 0x0000000040049690
  Excluded pages   : 0x000000001f3c1564
    Pages filled with zero  : 0x0000000000000000
    Cache pages             : 0x000000000000467d
    Cache pages + private   : 0x000000000000103c
    User process data pages : 0x00000000000015d6
    Free pages              : 0x000000001f3ba8d5
  Remaining pages  : 0x0000000020c8812c
  (The number of pages is reduced to 51%.)
Memory Hole     : 0xffffffffe0036970
--------------------------------------------------
Total pages     : 0x0000000020080000

There are other log files. I can directly email them if necessary; the
reason why I didn't attach the log files in this mail is that sending
the mail with attachment to this ML requires authentication and it
would take some time.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
