Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SFgYc-0006E4-Ap
 for kexec@lists.infradead.org; Thu, 05 Apr 2012 06:52:36 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 22D023EE0C0
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 15:52:28 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 09EEF45DE55
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 15:52:28 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E59C145DE53
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 15:52:27 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D1C07E08001
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 15:52:27 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 842481DB8045
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 15:52:27 +0900 (JST)
Date: Thu, 05 Apr 2012 15:52:11 +0900 (   )
Message-Id: <20120405.155211.347142878.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120402164651.6c2b1ae7.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120329132533.GM18218@redhat.com>
 <20120330.095143.347147805.d.hatayama@jp.fujitsu.com>
 <20120402164651.6c2b1ae7.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Date: Mon, 2 Apr 2012 16:46:51 +0900

> On Fri, 30 Mar 2012 09:51:43 +0900 (   )
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

>> For performance impact, I don't know that exactly. But I guess
>> iterating filtering processing is most significant. I don't know exact
>> data structure for each kind of memory, but if there's the ones
>> needing linear order to look up the data for a given page frame
>> number, there would be necessary to add some special handling not to
>> reduce performance.

> 
> Thank you for your idea.
> 
> I think this is an important issue and I have no idea except iterating
> filtering processes for each memory range.
> 
> But as you said, we should consider the issue related to performance.
> For example, makedumpfile must parse free_list repeatedly to distinguish
> whether each pfn is a free page or not, because each range may be inside
> the same zone. It will be overhead.
> 

Hello Kumagai-san,

I looked into contents of free_list and confirmed that even buddies
with the same order are not ordered linearly. The below is the output
of makedumpfile I customized so it outputs buddy data.

# ./makedumpfile --message-level 32 -c -d 31 /media/127.0.0.1-2012-04-04-20:31:58/vmcore vmcore-cd31
NR_ZONE: 0
order: 10 migrate_type: 2 pfn: 3072
order: 10 migrate_type: 2 pfn: 2048
order: 10 migrate_type: 2 pfn: 1024
order: 9 migrate_type: 3 pfn: 512
order: 8 migrate_type: 0 pfn: 256
order: 6 migrate_type: 0 pfn: 64
order: 5 migrate_type: 0 pfn: 32
order: 4 migrate_type: 0 pfn: 128
order: 4 migrate_type: 0 pfn: 16
order: 2 migrate_type: 0 pfn: 144
order: 1 migrate_type: 0 pfn: 148
NR_ZONE: 1
order: 10 migrate_type: 2 pfn: 226304
order: 10 migrate_type: 2 pfn: 225280
order: 10 migrate_type: 2 pfn: 486400
order: 10 migrate_type: 2 pfn: 485376
order: 10 migrate_type: 2 pfn: 484352
order: 10 migrate_type: 2 pfn: 483328
order: 10 migrate_type: 2 pfn: 482304
order: 10 migrate_type: 2 pfn: 481280
<snip>

We cannot choose the way of simply walking free_list in the increasing
order w.r.t. pfn for a given range of memory, suspend the walking and
save the data for the next walking...

So, it's necessary to create a table for access in constant time. But
for that, the table needs to be created on the memory. On the 2nd
kernel, we cannot assume any backing store in general: consider scp
for example.

I think basic idea would be several efforts for small memory
programming, like:

  * Create part of bitmap corresponding to range of memory currently
    being processed only, and table creation processing is repeated
    each time range of memory is started.
    => difficult to avoid looking up a whole part of free_list every
    time, but this is only idea I come up with that makes it always
    possible that consumed memory is stably constant.

  * Have table in memory mapping form rather than bitmap, switch back
    to bitmap if the size gets larger than the bitmap's
    => bad performance on very fragmented case, and constructing
    memory mapping requires O(n^2) so would cost high if doing it
    multiple times.

  * Compress part of bitmap except for the one currently being
    processed
    => bad performance when compression doesn't work well
       bad performance when compression is done too many times

But before that, I want to also consider possibility of increasing
reserved memory for the 2nd kernel.

On the discussion of 512MB reservation regression last month, Vivek
explained that 512MB is current maximam value and enough for at most
6TB system.

  https://lkml.org/lkml/2012/3/13/372

But on such machine, where makedumpfile perforamce is affected, there
seems to be a room to reserve more 512MB memory. Also Yinghai said
following Vivek, system memory size will still grow in next years.

Note:
  * 1 bit in bitmap represents 1 page frame. On x86, 1 byte is for
    32kB memory. 1TB memory requres 32MB. Dump includes two bitmaps so
    64MB is needed in total.
  * Bad performance is free pages only. Cache, cache private, user and
    zero pages are processed per range of memory in good performance.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
