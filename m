Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFD4C-0007vP-GB
 for kexec@lists.infradead.org; Fri, 30 Aug 2013 01:00:01 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 9DDF63EE0AE
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:59:36 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 910FA45DEB7
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:59:36 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7BAEE45DEB2
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:59:36 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 703A3E08003
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:59:36 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id F2DC41DB803B
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:59:35 +0900 (JST)
Message-ID: <521FEE6C.6090700@jp.fujitsu.com>
Date: Fri, 30 Aug 2013 09:59:24 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
References: <E1VEnuJ-0000K6-Lo@eag09.americas.sgi.com>
In-Reply-To: <E1VEnuJ-0000K6-Lo@eag09.americas.sgi.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

(2013/08/29 7:08), Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> - get_mm_sparsemem(): reduce the number of entries in the mem_map[] by
>    recording only those sections which actually exist in memory

I have missed this point. How much does this change speed up?

In general, if you want to say your patch improves performance, it's better to
demonstrate it in a measurable way such as benchmark.

> - shorten the executions of __exclude_unnecessary_pages() by passing it only
>    the pfn's of the current cyclic area
> 

I did try to similar kind of effort some months ago locally to figure out where
to improve cyclic-mode. In case of me, I noticed possibility of unnecessary processing
being performed out side the area of current cycle from the sanity check below:

int
set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
{
        int byte, bit;

        if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
                return FALSE;
<cut>

However, I didn't get distinguishable difference at that time. I ran the program
relatively ordinary class of system with some gigabyte memory so I might not got
distinguishable improvement.

Anyway, I thought it was permissible at that time and I didn't continue that work more.

But these days I have a machine with huge physical memory holes and on that system
this improvement sounds work well. So I much want to try to benchmark this direction
of your improvement patch set.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
