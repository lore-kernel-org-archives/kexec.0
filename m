Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1STo5T-0008RK-53
 for kexec@lists.infradead.org; Mon, 14 May 2012 05:44:53 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 67A6B3EE0B5
 for <kexec@lists.infradead.org>; Mon, 14 May 2012 14:44:44 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 50E1F45DE56
 for <kexec@lists.infradead.org>; Mon, 14 May 2012 14:44:44 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3C4B245DE54
 for <kexec@lists.infradead.org>; Mon, 14 May 2012 14:44:44 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D7588E08001
 for <kexec@lists.infradead.org>; Mon, 14 May 2012 14:44:43 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 896C01DB8045
 for <kexec@lists.infradead.org>; Mon, 14 May 2012 14:44:43 +0900 (JST)
Date: Mon, 14 May 2012 14:44:28 +0900 (JST)
Message-Id: <20120514.144428.71088479.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120427164649.9932a33f.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120412124040.bad03498.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120412.164714.39159547.d.hatayama@jp.fujitsu.com>
 <20120427164649.9932a33f.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org, vgoyal@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Date: Fri, 27 Apr 2012 16:46:49 +0900

>     - Now, the prototype doesn't support PG_buddy because the value of PG_buddy
>       is different depending on kernel configuration and it isn't stored into 
>       VMCOREINFO. However, I'll extend get_length_of_free_pages() for PG_buddy 
>       when the value of PG_buddy is stored into VMCOREINFO.

Hello Kumagai san,

I'm now investigating how to perform filtering free pages without
kernel debuginfo. For this, I've investigated which of PG_buddy and
_mapcount to use in kernel versions. In the current conclusion, it's
reasonable to do that as shown in the following table.

| kernel version   |  Use PG_buddy? or _mapcount?                             |
|------------------+----------------------------------------------------------|
| 2.6.15 -- 2.6.16 | offsetof(page,_mapcount):=sizeof(ulong)+sizeof(atomic_t) |
| 2.6.17 -- 2.6.26 |        PG_buddy := 19                                    |
| 2.6.27 -- 2.6.36 |        PG_buddy := 18                                    |
| 2.6.37 and later | offsetof(page,_mapcount):= under investigation           |                                           |

In summary: PG_buddy was first introduced at 2.6.17 as 19 to fix some
race bug leading to lru list corruptions, and from 2.6.17 to 2.6.26,
it had been defined using macro preprocessor. At 2.6.27 enum pageflags
was introduced for ease of page flags maintainance and its value
changed to 18. At 2.6.37, it was removed, and it no longer exists in
later kernel versions.

My quick feeling is that solving dependency of PG_buddy is simler than
that of _mapcount from 2.6.17 to 2.6.36.

From 2.6.15 to 2.6.16, PG_buddy has not been introduced so we need to
rely on _mapcount. It's very complex to solve _mapcount dependency in
general on all supported kernel versions, but only on both kernel
versions, definition of struct page begins with the following
layout. I think it's not so much complex to hardcode offset of
_mapcount for these two kernel versions only: that is, sizeof(unsigned
long) + sizeof(atomic_t) which is in fact struct { volatile int
counter } on all platforms.

struct page {
        unsigned long flags;            /* Atomic flags, some possibly
                                         * updated asynchronously */
        atomic_t _count;                /* Usage count, see below. */
        atomic_t _mapcount;             /* Count of ptes mapped in mms,
...

In the period of PG_buddy is defined as enumeration value, PG_buddy
value depends on CONFIG_PAGEFLAGS_EXTENDED. At commit
e20b8cca760ed2a6abcfe37ef56f2306790db648, PG_head and PG_tail were
introduced and they are positioned before PG_buddy if
CONFIG_PAGEFLAGS_EXTENDED is set; then PG_buddy value becomes
19. However, its users are mips, um and xtensa only as:

  $ git grep "CONFIG_PAGEFLAGS_EXTENDED"
  arch/mips/configs/db1300_defconfig:CONFIG_PAGEFLAGS_EXTENDED=y
  arch/um/defconfig:CONFIG_PAGEFLAGS_EXTENDED=y
  arch/xtensa/configs/iss_defconfig:CONFIG_PAGEFLAGS_EXTENDED=y
  arch/xtensa/configs/s6105_defconfig:CONFIG_PAGEFLAGS_EXTENDED=y
  include/linux/page-flags.h:#ifdef CONFIG_PAGEFLAGS_EXTENDED
  include/linux/page-flags.h:#ifdef CONFIG_PAGEFLAGS_EXTENDED
  mm/memory-failure.c:#ifdef CONFIG_PAGEFLAGS_EXTENDED
  mm/page_alloc.c:#ifdef CONFIG_PAGEFLAGS_EXTENDED

and makedumpfile doesn't support any of these platforms now. So we
don't need to consider this case more.

On 2.6.37 and the later kernels, we must use _mapcount. I'm now
looking into how to get offset of _mapcount in each kernel version
without kernel debug information. But page structure has changed
considerably on recent kernels so I guess the way hardcoding them gets
more complicated.

Anyway, I think it better to add _mapcount information to VMCOREINFO
on upstream as soon as possible.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
