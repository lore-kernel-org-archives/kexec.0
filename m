Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6t2f-0008Tq-0i
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 00:55:31 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9722A3EE0BD
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 09:55:22 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D45145DE54
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 09:55:22 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 58ABC45DE58
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 09:55:22 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 489B31DB8040
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 09:55:22 +0900 (JST)
Received: from m021.s.css.fujitsu.com (m021.s.css.fujitsu.com [10.0.81.61])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id ECD701DB8042
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 09:55:21 +0900 (JST)
Date: Thu, 30 Aug 2012 09:55:06 +0900 (JST)
Message-Id: <20120830.095506.265670820.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120829123539.GA12504@redhat.com>
References: <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
 <20120829.115031.346071170.d.hatayama@jp.fujitsu.com>
 <20120829123539.GA12504@redhat.com>
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
To: vgoyal@redhat.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
Date: Wed, 29 Aug 2012 08:35:39 -0400

> On Wed, Aug 29, 2012 at 11:50:31AM +0900, HATAYAMA Daisuke wrote:
>> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
>> Date: Wed, 15 Aug 2012 15:27:10 +0900
>> 
>> > Hello HATAYAMA-san,
>> > 
>> > On Tue, 14 Aug 2012 20:55:32 +0900 (JST)
>> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> > 
>> >> From: Vivek Goyal <vgoyal@redhat.com>
>> >> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
>> >> Date: Fri, 10 Aug 2012 10:36:55 -0400
>> >> 
>> >> > On Fri, Aug 10, 2012 at 05:39:38PM +0900, HATAYAMA Daisuke wrote:
>> >> > 
>> >> > [..]
>> >> >> 
>> >> >> I finished benchmarking filtering time and demonstrate the result.
>> >> >> But I failed to collect amount of memory consumption by my mistake. If
>> >> >> they are necessary, I'll again try to collect them. But we have 9 days
>> >> >> vacation starting tommorow, so I'll do that after the vacation.
>> >> >> 
>> > 
>> > Thank you for your help.
>> > Could you continue to measure amount of memory consumption ?
>> > 
>> 
>> Hello Kumagai-san, here is the benchmark result for the amount of
>> actual memory consumption when there are multiple child processes
>> using --split option.
>> 
> 
> Hi,
> 
> Thanks for testing results. I had few questions.
> 
> - What's the objective of this testing? Are we just trying to figure out
>   memory footprint of makedumpfile in cyclic mode using struct page 
>   filtering and compare with free list filtering?
> 

Basically yes, and in addition to that, I wanted to see when using
--split because then makedumpfile process forks and memory usage
increases.

> - Why are we testing using --split option. How does that help. In kdump
>   kernel we boot only 1 cpu. And if all the dump files are being saved
>   to same disk, it might not give lot of performance boost.
>  
>   Even if does give performance boost, this seems to be orthogonal to 
>   the idea of going using struct page for filtering.  Will single thread
>   dumping not give a good idea about memory footprint?
> 

On this benchmark, I didn't aim at seeing performance gain here, only
seeing memory footprint, so I used only one disk and one cpu to write
without any special configuration.

In cyclic mode, each child process refers to different part of
physical memory, and the bitmaps each process handles are also
different each other; in normal mode, each child process shares the
unique two bitmaps. This bench aims at evaluating amount of memory
footprint for the former case precisely.

> 
> - What's the conclusion of below measurements and numbers.
> 

These are expected results, I think. Please forcus on buffer size and
value of child's PRI. Each child process has two bitmaps and each
bitmap has buffer size length. So, for 1MB buffer size, PRI finally
amounts to 2.38 MB where 2.00 MB is the 2 bitmap part, and for other
buffer sizes, these also hold similarly, and there rest of bitmaps
part is all 0.37 or 0.38 MB.

During the measurement I was temporarily thinking virtual memory usage
profiler, like valgrind massif, might be enough, but now I think this
kind of benchmarking is needed becaues the issue we are now on is the
severe 2nd kernel environment's, requiring to figure out actual memory
usage precisly.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
