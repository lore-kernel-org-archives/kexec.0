Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YcR3f-0004yC-0E
 for kexec@lists.infradead.org; Mon, 30 Mar 2015 04:12:16 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 0/6] WIP: avoid two pass filtering by using bitmap file.
Date: Mon, 30 Mar 2015 04:08:29 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D9CAB2@BPXM01GP.gisp.nec.co.jp>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "cpw@sgi.com" <cpw@sgi.com>

Hello,

This series is still under developing, but the basic process can work
so I measured the performance about filtering and report it here.
The patches include some cleanup but the main purpose is to make sure
whether avoiding two pass filtering is worth even using bitmap file as
I wrote the thread below:

http://lists.infradead.org/pipermail/kexec/2014-December/013100.html
> By the way, the non-cyclic is faster than the cyclic mode in your
> environments ? Certainly the non-cyclic mode can avoid two-pass
> filtering but it needs disk i/o to read and write the bitmap file
> instead. I'm concerned that the disadvantage of the non-cyclic mode
> defeats the advantage of it.

-------------------------------------------------------------------------
Environment:
  CPU: Intel(R) Xeon(R) CPU E7- 8870  @ 2.40GHz
  Memory: 1TiB
  Kernel: 3.19.0
  makedumpfile: v1.5.8 + this patch series

How to measure:

Sum up the total time of [Checking for memory holes  ] as "1st bitmap(s)",
[Excluding unnecessary pages] as "2nd bitmap(s)" for each case below:

   A: 1-cycle filtering by using bitmap file.
   B: N-cycle filtering with small memory space. It needs two-pass filtering.
   C: 1-cycle filtering with enough memory space.

Command:

   A: makedumpfile --message-level=31 --work-dir=/mnt/root  -d31 /proc/vmcore /dev/null -f
   B: makedumpfile --message-level=31 --cyclic-buffer=1000  -d31 /proc/vmcore /dev/null -f
   C: makedumpfile --message-level=31 --cyclic-buffer=40000 -d31 /proc/vmcore /dev/null -f

Result:

   case		1st bitmap(s)	2nd bitmap(s)    Total(s)
------------------------------------------------------------
    A              4.753            11.42         16.17
    B              0.01617          20.82         20.83
    C              0.01211          10.10         10.11

and B as N-cycle case has to do two pass filtering, the breakdown
of the result is here:

    case        1st bitmap(s)   2nd bitmap(s)    Total(s)
------------------------------------------------------------
    B-1st          0.005563         10.43         10.43
    B-2nd          0.01061          10.39         10.40
    B-total        0.01617          20.82         20.83

Discussion:
- It goes without saying that C is the best. There is no meaning to
  use bitmap file if memory space is enough.

- Comparing A and B, the advantage of avoiding two pass filtering is
  more than the disadvantage of using bitmap file.


The benefits of avoiding two pass filtering by using bitmap file looks
small, but at least there is no degradation. So I'll continue my work
as code cleanup.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
