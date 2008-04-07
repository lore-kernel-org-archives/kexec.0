Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jig57-0007WD-So
	for kexec@lists.infradead.org; Mon, 07 Apr 2008 01:23:34 +0000
Date: Mon, 07 Apr 2008 10:23:21 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: [PATCH 4/4] extract vmcoreinfo from /proc/vmcore for Xen
In-Reply-To: <47F5E51D.7010204@mxs.nes.nec.co.jp>
References: <20080404072106.DE06.ODA@valinux.co.jp>
	<47F5E51D.7010204@mxs.nes.nec.co.jp>
Message-Id: <20080407102237.BD25.ODA@valinux.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org

Hi Ken'ichi,

I agree with you.

Thanks.
Itsuro Oda

On Fri, 04 Apr 2008 17:21:49 +0900
"Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> 
> Hi ODA-san,
> 
> Itsuro ODA wrote:
> > Hi,
> > 
> > I like the Plan2 since it is simple.
> 
> Thank you for the comment.
> 
> I considered about it well, and think that a new option '-X' is
> good for excluding all the user domain pages. I will merge your
> patch with this option.
> 
> I think it is better that the dump_level is used for excluding
> only linux's pages. If the dump_level for linux is added after
> the one for xen, the dump_level probably becomes strange like
> the following:
> 
>        |               linux              | Xen | linux
>        +----------------------------------+-----+-------
>  Dump  | zero  cache  cache    user  free |     | some
>  Level | page  page   private  data  page | Xen | page
> -------+----------------------------------+-----+-------
>     1  |  X
>     2  |        X
>     4  |        X      X
>     8  |                        X
>    16  |                              X
>    32  |                                     X
>    64  |                                           X
> 
> Sorry, I should have considered about it before posting the last mail.
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
