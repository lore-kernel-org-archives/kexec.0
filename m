Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfhwY-0003bB-VD
 for kexec@lists.infradead.org; Fri, 24 May 2013 02:41:23 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D40FE3EE0BB
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:41:00 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C57D045DE59
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:41:00 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id AD5C845DE56
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:41:00 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A01361DB804D
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:41:00 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 565191DB803A
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:41:00 +0900 (JST)
Message-ID: <519ED32F.6090005@jp.fujitsu.com>
Date: Fri, 24 May 2013 11:40:47 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Petr Tesarik's hugepage filtering
References: <E1UcggB-0005gy-4i@eag09.americas.sgi.com>
 <20130524101121.58d765fdfd5800dee0f1b951@mxc.nes.nec.co.jp>
 <519ECF57.1080600@jp.fujitsu.com>
In-Reply-To: <519ECF57.1080600@jp.fujitsu.com>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, cpw@sgi.com

(2013/05/24 11:24), HATAYAMA Daisuke wrote:
> (2013/05/24 10:11), Atsushi Kumagai wrote:
>> On Wed, 15 May 2013 13:43:59 -0500
>> Cliff Wickman <cpw@sgi.com> wrote:

> Also, hugetlbfs pages are "user data". They should get filtered when user data dump level
> is specified. So how about:
>
>        Dump  |  zero   without  with     user    free   hugetlbfs
>        Level |  page   private  private  data    page   page
>       -------+-----------------------------------------------------
>           0  |
>           1  |   X
>           2  |           X
>           4  |           X        X
>           8  |                            X              X
>          16  |                                    X
>          32  |                                           X
>          63  |   X       X        X       X       X      X
>
> On dump level 8, hugetlbfs pages also get filtered.

Thinking further, it might be unlikely that we want user data but don't want hugetlbfs pages
on crash dump case. If so, I think Petr's implementation seems also OK. It seems no problem
to postpone introducing new dump level after someone who wants to filter hugetlbfs pages only,
actually occurs.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
