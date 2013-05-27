Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgvEV-0004yw-Nc
 for kexec@lists.infradead.org; Mon, 27 May 2013 11:04:58 +0000
Date: Mon, 27 May 2013 19:56:16 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: Petr Tesarik's hugepage filtering
Message-Id: <20130527195616.e150af370837bebda1239161@mxc.nes.nec.co.jp>
In-Reply-To: <519ED32F.6090005@jp.fujitsu.com>
References: <E1UcggB-0005gy-4i@eag09.americas.sgi.com>
 <20130524101121.58d765fdfd5800dee0f1b951@mxc.nes.nec.co.jp>
 <519ECF57.1080600@jp.fujitsu.com> <519ED32F.6090005@jp.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: ptesarik@suse.cz, kexec@lists.infradead.org, cpw@sgi.com

On Fri, 24 May 2013 11:40:47 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> (2013/05/24 11:24), HATAYAMA Daisuke wrote:
> > (2013/05/24 10:11), Atsushi Kumagai wrote:
> >> On Wed, 15 May 2013 13:43:59 -0500
> >> Cliff Wickman <cpw@sgi.com> wrote:
> 
> > Also, hugetlbfs pages are "user data". They should get filtered when user data dump level
> > is specified. So how about:
> >
> >        Dump  |  zero   without  with     user    free   hugetlbfs
> >        Level |  page   private  private  data    page   page
> >       -------+-----------------------------------------------------
> >           0  |
> >           1  |   X
> >           2  |           X
> >           4  |           X        X
> >           8  |                            X              X
> >          16  |                                    X
> >          32  |                                           X
> >          63  |   X       X        X       X       X      X
> >
> > On dump level 8, hugetlbfs pages also get filtered.
> 
> Thinking further, it might be unlikely that we want user data but don't want hugetlbfs pages
> on crash dump case. If so, I think Petr's implementation seems also OK. It seems no problem
> to postpone introducing new dump level after someone who wants to filter hugetlbfs pages only,
> actually occurs.

Even leaving aside the new dump level, I think his implementation needs
to be changed because the assumption that all compound pages are user
data will be broken by introducing "Transparent huge page cache".

  https://lkml.org/lkml/2013/5/11/187

So I'd like to make the condition to estimate page type more restricted
in advance.

As for user data on THP, they should be estimated using isAnon() and
isHugePage() combination like my code image.

But hugetlbfs pages don't meet isAnon(), so they should be estimated
with another logic like kernel's PageHuge().
And they can be filtered out as user data always.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
