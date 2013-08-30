Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFDas-0000Ow-2l
 for kexec@lists.infradead.org; Fri, 30 Aug 2013 01:33:47 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2D0643EE1B1
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:33:24 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 208F345DE59
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:33:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 08C4545DE55
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:33:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id F0D72E08004
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:33:23 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id AAB55E08001
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:33:23 +0900 (JST)
Message-ID: <521FF655.8000909@jp.fujitsu.com>
Date: Fri, 30 Aug 2013 10:33:09 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: A few patches to consider
References: <E1VEnuJ-0000Jl-CC@eag09.americas.sgi.com>
In-Reply-To: <E1VEnuJ-0000Jl-CC@eag09.americas.sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

(2013/08/29 7:08), Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
>
> I am submitting 6 patches that I have found helpful in speeding the dump
> process or clarifying the progress report.
> They are not a series, and should not be interdependent.  But if you
> find any dependencies I apply them in this order:
> [PATCH] makedumpfile: reverse -c and -p if using snappy compression
> [PATCH] makedumpfile: use non-cyclic when possible
> [PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
> [PATCH] makedumpfile: shorten cyclic unnecessary-page scans
> [PATCH] makedumpfile: show needed memory
> [PATCH] makedumpfile: search for a debug vmlinux
>
> The last one (search for a debug vmlinux) is useful in identifying huge
> pages with the PG_head/PG-tail flags.  There was a patch from Petr Tesarik
> that enables that huge page filtering. I don't think you are taking that one
> as-is, but are reworking it. Seems like Hatayama-san was doing that work.

No. If I have good memory, Kumagai-san was investigating how to integrate
huge page filtering into current memory types currently supported by
makedumpfile.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
