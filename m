Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6YMw-0004Ib-Co
 for kexec@lists.infradead.org; Wed, 29 Aug 2012 02:51:05 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 095F73EE0C7
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 11:50:56 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E529B45DE4E
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 11:50:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CEC2F45DD78
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 11:50:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C0EE91DB802C
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 11:50:55 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7DA421DB803A
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 11:50:55 +0900 (JST)
Date: Wed, 29 Aug 2012 11:50:31 +0900 (JST)
Message-Id: <20120829.115031.346071170.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
References: <20120810143655.GA5416@redhat.com>
 <20120814.205532.509440957.d.hatayama@jp.fujitsu.com>
 <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
Date: Wed, 15 Aug 2012 15:27:10 +0900

> Hello HATAYAMA-san,
> 
> On Tue, 14 Aug 2012 20:55:32 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: Vivek Goyal <vgoyal@redhat.com>
>> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
>> Date: Fri, 10 Aug 2012 10:36:55 -0400
>> 
>> > On Fri, Aug 10, 2012 at 05:39:38PM +0900, HATAYAMA Daisuke wrote:
>> > 
>> > [..]
>> >> 
>> >> I finished benchmarking filtering time and demonstrate the result.
>> >> But I failed to collect amount of memory consumption by my mistake. If
>> >> they are necessary, I'll again try to collect them. But we have 9 days
>> >> vacation starting tommorow, so I'll do that after the vacation.
>> >> 
> 
> Thank you for your help.
> Could you continue to measure amount of memory consumption ?
> 

Hello Kumagai-san, here is the benchmark result for the amount of
actual memory consumption when there are multiple child processes
using --split option.

I measured the data in the following way:

  * for buffer size, 1MB, 2MB, 4MB, 8MB and 16MB are chosen.

  * for the number of splitted dumpfiles, 2, 4, 8 and 16 are chosen.

  * I collected RSS, SHA(RED) and PRI(VATE) memory for each process
    from /proc/self/smaps; RSS is the value of the column "Rss:", SHA
    is the value of the column "Shared_Clean" plus the value of the
    column "Shared_Dirty" and PRI is the value of the column
    "Private_Clean" plus the value of the clumn "Private_Dirty".

    Note that RSS is the amount of memory actually mapped on physical
    memory, and RSS = SHA + PRI always holds.

    Note also that the reason of collecting SHA is the fact that
    makedumpfile --split is implemented using fork and child processes
    shares the same parent's memory by COW.

    Notice that I write only one child process data below because each
    result is exactly the same and also purely due to space issue;
    there's no room to put all childs' data here.

  * In the following table, I'm using [BEGIN] => [END] notation, such
    as 3.16 => 0.57. This indicates at what point the data is
    measured.

    For the parent process, the left-hand side, [BEGIN] part, is
    before waitpid() in writeout_multiple_dumpfiles(), while the
    right-hand side, [END] part, after waitpid().

    For child process, the left-hand side, [BEGIN] part, is the
    beginning of write_kdump_pages_and_bitmap_cyclic(), while the
    right-hand side, [END] part, the end of
    write_kdump_pages_and_bitmap_cyclic().


buffer size 1MB

      split     parent         child
------------------------------------------
RSS          3.42 => 3.42   2.98 => 3.27
SHA     2    3.16 => 0.57   2.85 => 0.89
PRI          0.25 => 2.84   0.13 => 2.38
------------------------------------------
RSS          3.42 => 3.42   2.98 => 3.27
SHA     4    3.18 => 0.57   2.85 => 0.89
PRI          0.24 => 2.84   0.13 => 2.38
------------------------------------------
RSS          3.42 => 3.42   2.98 => 3.27
SHA     8    3.18 => 0.57   2.85 => 0.89
PRI          0.23 => 2.84   0.13 => 2.37
------------------------------------------
RSS          3.41 => 3.41   2.98 => 3.26
SHA    16    3.18 => 0.57   2.84 => 0.89
PRI          0.23 => 2.84   0.13 => 2.37


buffer size 2MB

      split     parent         child
------------------------------------------
RSS          5.42 => 5.42   4.98 => 5.27
SHA     2    5.17 => 0.57   4.85 => 0.89
PRI          0.25 => 4.84   0.13 => 4.37
------------------------------------------
RSS          5.42 => 5.42   4.98 => 5.27
SHA     4    5.17 => 0.57   4.85 => 0.89
PRI          0.25 => 4.84   0.13 => 4.37
------------------------------------------
RSS          5.41 => 5.41   4.98 => 5.26
SHA     8    5.18 => 0.57   4.84 => 0.89
PRI          0.23 => 4.84   0.13 => 4.37
------------------------------------------
RSS          5.42 => 5.42   4.98 => 5.27
SHA    16    5.19 => 0.57   4.85 => 0.89
PRI          0.23 => 4.84   0.13 => 4.37


buffer size 4MB

      split     parent         child
------------------------------------------
RSS          9.42 => 9.42   8.98 => 9.27
SHA     2    9.18 => 0.57   8.85 => 0.89
PRI          0.24 => 8.84   0.13 => 8.38
------------------------------------------
RSS          9.41 => 9.41   8.98 => 9.26
SHA     4    9.18 => 0.57   8.84 => 0.89
PRI          0.24 => 8.84   0.13 => 8.37
------------------------------------------
RSS          9.41 => 9.41   8.98 => 9.26
SHA     8    9.18 => 0.57   8.84 => 0.89
PRI          0.24 => 8.84   0.13 => 8.37
------------------------------------------
RSS          9.42 => 9.42   8.98 => 9.27
SHA    16    9.18 => 0.57   8.85 => 0.89
PRI          0.23 => 8.84   0.13 => 8.38


buffer size 8MB

      split      parent          child
---------------------------------------------
RSS          17.41 => 17.41  16.98 => 17.26
SHA     2    17.17 =>  0.57  16.84 =>  0.89
PRI           0.25 => 16.84   0.13 => 16.37
---------------------------------------------
RSS          17.41 => 17.41   16.98 => 17.27
SHA     4    17.18 =>  0.57   16.84 =>  0.89
PRI           0.24 => 16.84    0.13 => 16.38
---------------------------------------------
RSS          17.42 => 17.42   16.98 => 17.27
SHA     8    17.17 =>  0.57   16.85 =>  0.89
PRI           0.25 => 16.84    0.13 => 16.37
---------------------------------------------
RSS          17.42 => 17.42  16.98 => 17.27
SHA    16    17.18 =>  0.57  16.85 =>  0.89
PRI           0.23 => 16.84   0.13 => 16.38


buffer size 16MB

      split      parent           child
---------------------------------------------
RSS          33.41 => 33.41  32.98 => 33.27
SHA     2    33.16 =>  0.57  32.84 =>  0.89
PRI           0.25 => 32.84   0.13 => 32.38
---------------------------------------------
RSS          33.42 => 33.42   32.98 => 33.27
SHA     4    33.18 =>  0.57   32.85 =>  0.89
PRI           0.24 => 32.84    0.13 => 32.38
---------------------------------------------
RSS          33.42 => 33.42   32.98 => 33.27
SHA     8    33.18 =>  0.57   32.85 =>  0.89
PRI           0.23 => 32.84    0.13 => 32.37
---------------------------------------------
RSS          33.41 => 33.41  32.98 => 33.26
SHA    16    33.18 =>  0.57  32.84 =>  0.89
PRI           0.24 => 32.84   0.13 => 32.37


Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
