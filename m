Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SUoTE-0002Ut-2B
 for kexec@lists.infradead.org; Thu, 17 May 2012 00:21:33 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 713453EE0B5
 for <kexec@lists.infradead.org>; Thu, 17 May 2012 09:21:24 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 56BFE45DE7A
 for <kexec@lists.infradead.org>; Thu, 17 May 2012 09:21:24 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3CA1E45DE75
 for <kexec@lists.infradead.org>; Thu, 17 May 2012 09:21:24 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2C4BC1DB8041
 for <kexec@lists.infradead.org>; Thu, 17 May 2012 09:21:24 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D452C1DB8038
 for <kexec@lists.infradead.org>; Thu, 17 May 2012 09:21:23 +0900 (JST)
Date: Thu, 17 May 2012 09:21:06 +0900 (JST)
Message-Id: <20120517.092106.347153627.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120516170230.c2dd1ccd.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120427164649.9932a33f.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120514.144428.71088479.d.hatayama@jp.fujitsu.com>
 <20120516170230.c2dd1ccd.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Date: Wed, 16 May 2012 17:02:30 +0900

> On Mon, 14 May 2012 14:44:28 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

>> Anyway, I think it better to add _mapcount information to VMCOREINFO
>> on upstream as soon as possible.
> 
> I think it's better way to use _mapcount. 
> But we don't certainly decide to use _mapcount and even if we decide to use it,
> we still have problems to use it.
> For example, the upstream kernel(v3.4-rc7) has _mapcount in union, we need
> a information to judge whether the found data is _mapcount or not. 
> So, more investigation is needed and I think it's too early to send the request
> to upstream kernel.

A quick look into the other part of the union---inuse, objects,
froze---to which _mapcount belongs, they appears to be used in SLUB
allocator. The page with PG_slab appears to use the other part to
_mapcount. This means that to decide whether to use _mapcount, it's
necessary to first investigate how SLUB allocator works.

> 
> I plan to finish working to reduce memory consumption by the end of June, 
> and I will continue to discuss performance issues.
> Therefore, the request will be delayed until July or August.
> 

I'll wait for your patch on memory consumption and feedback to
it. I'll also look into possibility of filtering free memory in
constant space on recent kernels.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
