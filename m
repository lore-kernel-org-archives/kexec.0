Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1UA8sX-0007By-VA
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 00:58:47 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6DD223EE0BC
 for <kexec@lists.infradead.org>; Tue, 26 Feb 2013 09:58:37 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5700A45DE4F
 for <kexec@lists.infradead.org>; Tue, 26 Feb 2013 09:58:37 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 35F6745DE4E
 for <kexec@lists.infradead.org>; Tue, 26 Feb 2013 09:58:37 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 298B01DB8037
 for <kexec@lists.infradead.org>; Tue, 26 Feb 2013 09:58:37 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id D6B561DB802F
 for <kexec@lists.infradead.org>; Tue, 26 Feb 2013 09:58:36 +0900 (JST)
Date: Tue, 26 Feb 2013 09:58:14 +0900 (JST)
Message-Id: <20130226.095814.331287795.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kexec,x86: code optimization and adjustment for
 add_memmap and delete_memmap
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <512B5B51.2060209@cn.fujitsu.com>
References: <512B5B51.2060209@cn.fujitsu.com>
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
To: zhangyanfei@cn.fujitsu.com
Cc: horms@verge.net.au, kexec@lists.infradead.org

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Subject: [PATCH] kexec,x86: code optimization and adjustment for add_memmap and delete_memmap
Date: Mon, 25 Feb 2013 20:38:41 +0800

> The code in the two functions seems a little messy, So I modify
> some of them, trying to make the logic more clearly.
> 
> For example,
> code before:
> 
>          for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
>                  mstart = memmap_p[i].start;
>                  mend = memmap_p[i].end;
>                  if (mstart == 0 && mend == 0)
>                          break;
> 
> for we already have nr_entries for this memmap_p array, so we needn't
> have a check in every loop to see if we have go through the whole array.
> code after:
> 
>          for (i = 0; i < nr_entries; i++) {
>  		mstart = memmap_p[i].start;
>  		mend = memmap_p[i].end;
> 

Then, but even if doing so, times of the loop is unchanged after your
fix. The loop doesn't always look up a whole part of memmap_p; it
looks up until it reaches the end of elements with 0 in their members.
Also, CRASH_MAX_MEMMAP_NR is 17 on i386. Is it problematic in
performance?

Rather, it seems problematic to me how length of memmap_p is handled
here. It is initialized first here:

        /* Memory regions which panic kernel can safely use to boot into */
        sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
        memmap_p = xmalloc(sz);
        memset(memmaSp_p, 0, sz);

and then it is passed to add_memmap,

        add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);

and there the passed memmap_p is assumed to have length of
CRASH_MAX_MEMMAP_NR that is defined as (KEXEC_MAX_SEGMENTS + 1)
according to the condition of the for loop above. (The
(KEXEC_MAX_SEGMENTS + 1) in the allocation should also be
CRASH_MAX_MEMMAP_NR for clarification?)

The ideas I have for cleaning up here, are for example:

- introduce specific for-each statement to iterate memmap_p just like:

  for_each_memmap(memmap_p, start, end) {
    ...
  }

  or

- use struct memory_ranges instead of struct memory_range and pass it
  to add_memmap; the former has size member in addition to ranges
  member, and then in add_memmap:

  for (i = 0; i < ranges.size; i++) {
    mstart = ranges.ranges[i].start;
    mend = ranges.ranges[i].end;
  }

The former hides actual length of memmap_p from users because they
don't need to care about it, while the latter makes length of memmap_p
explicitly handled even in add_memmp.

But sorry, this idea comes from some minuts look on the code around.

Also, you should have divided the patch into two: nr_entires part and
the others.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
