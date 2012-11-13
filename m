Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYCIW-0007Sg-1C
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 08:56:45 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8D6363EE0B6
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:56:39 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 75A3E45DE4D
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:56:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5D5BF45DD74
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:56:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4EAFE1DB803A
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:56:39 +0900 (JST)
Received: from g01jpexchyt02.g01.fujitsu.local
 (g01jpexchyt02.g01.fujitsu.local [10.128.194.41])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D42B61DB8038
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:56:38 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 00/10] Support free page filtering looking up mem_map array
Date: Tue, 13 Nov 2012 08:56:37 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AB008A2@G01JPEXMBYT03>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121113165608.b561e597fefb6bc3f2bbd5de@mxc.nes.nec.co.jp>
In-Reply-To: <20121113165608.b561e597fefb6bc3f2bbd5de@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> Sent: Tuesday, November 13, 2012 4:56 PM
[...]
> >   - OFFSET(page._mapcount)
> >   - OFFSET(page.private)
> >   - SIZE(pageflags)
> >   - NUMBER(PG_buddy)
> >   - NUMBER(PG_slab)
> >   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
> 
> And I will post the patch to add the values above to the upstream kernel,
> so there is no problem on the future kernel.
> 
> However, according to my tests, current makedumpfile can't get some of the
> values above from VMLINUX and can't exclude free pages with the mem_map
> array logic.
> For example, page_is_buddy_v1() will be selected for kernel-3.4 with
> setup_page_is_buddy() due to not founding NUMBER(PG_buddy) and
> SIZE(pageflags),
> it's miss selection.
> 
> Therefore, I propose to change the policy for excluding free page as below
> in order to take care of current kernels:
> 
>   1. If VMCORE (or specified VMCOREINFO) includes the values above,
>      using the mem_map array logic.
> 
>   2. In other cases, using the current logic which uses free_list even if
>      running on cyclic mode.
> 
> Of course, page_is_buddy_v1() and page_is_buddy_v2() should be retain
> because there is valuable for the user who can prepare VMCOREINFO.
> 

You are corrent. I'll repost the patch set soon. Rc1 or beta, which is better?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
