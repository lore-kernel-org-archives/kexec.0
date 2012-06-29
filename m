Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkRYI-0004JB-4d
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 03:07:23 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 855423EE081
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 12:07:15 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6F5F145DE55
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 12:07:15 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5A74645DE54
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 12:07:15 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4B8C31DB8053
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 12:07:15 +0900 (JST)
Received: from m022.s.css.fujitsu.com (m022.s.css.fujitsu.com [10.0.81.62])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id F14091DB804F
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 12:07:14 +0900 (JST)
Date: Fri, 29 Jun 2012 12:07:05 +0900 (JST)
Message-Id: <20120629.120705.209862899.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH 00/10] Support free page filtering looking up
 mem_map array
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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
Cc: kexec@lists.infradead.org

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 00/10] Support free page filtering looking up mem_map array
Date: Fri, 29 Jun 2012 02:37:57 +0900

> This new free page filtering needs the following values.
> 
>   - OFFSET(page._mapcount)
>   - OFFSET(page.private)
>   - SIZE(pageflags)
>   - NUMBER(PG_buddy)
>   - NUMBER(PG_slab)
>   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
> 
> Unfortunately, OFFSET(_mapcount) and OFFSET(private) fields of page
> structure cannot be obtained from VMLINUX using the exiting library in
> makedumpfile since two members are anonymous components of union
> types. We need a new interface for them.
> 
> To try to use this patch set, it's handy to pass manually editted
> VMCOREINFO file via -i option.
> 

Concretely, I added the following values in VMCOREINFO generated with
-g option or using strings command directly to vmcore.

 * 3.1.0-7.fc16.x86_64

NUMBER(PG_slab)=7
SIZE(pageflags)=4
OFFSET(page._mapcount)=24
OFFSET(page.private)=48
NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-128

 * 2.6.38
SIZE(pageflags)=4
OFFSET(page._mapcount)=12
OFFSET(page.private)=16
NUMBER(PG_slab)=7
NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-2

 * 2.6.32
NUMBER(PG_slab)=7
NUMBER(PG_buddy)=19
OFFSET(page._mapcount)=12
OFFSET(page.private)=16
SIZE(pageflags)=4

 * 2.6.18
NUMBER(PG_slab)=7
NUMBER(PG_buddy)=19
OFFSET(page._mapcount)=12
OFFSET(page.private)=16

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
