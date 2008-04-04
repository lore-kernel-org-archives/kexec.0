Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JhhBJ-0003nq-A3
	for kexec@lists.infradead.org; Fri, 04 Apr 2008 08:21:53 +0000
Message-Id: <47F5E51D.7010204@mxs.nes.nec.co.jp>
Date: Fri, 04 Apr 2008 17:21:49 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] extract vmcoreinfo from /proc/vmcore for Xen
References: <20080331132027.DDD3.ODA@valinux.co.jp>	<47F49C8A.1020906@mxs.nes.nec.co.jp>
	<20080404072106.DE06.ODA@valinux.co.jp>
In-Reply-To: <20080404072106.DE06.ODA@valinux.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0778673296=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Itsuro ODA <oda@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org

--===============0778673296==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi ODA-san,

Itsuro ODA wrote:
> Hi,
> 
> I like the Plan2 since it is simple.

Thank you for the comment.

I considered about it well, and think that a new option '-X' is
good for excluding all the user domain pages. I will merge your
patch with this option.

I think it is better that the dump_level is used for excluding
only linux's pages. If the dump_level for linux is added after
the one for xen, the dump_level probably becomes strange like
the following:

       |               linux              | Xen | linux
       +----------------------------------+-----+-------
 Dump  | zero  cache  cache    user  free |     | some
 Level | page  page   private  data  page | Xen | page
-------+----------------------------------+-----+-------
    1  |  X
    2  |        X
    4  |        X      X
    8  |                        X
   16  |                              X
   32  |                                     X
   64  |                                           X

Sorry, I should have considered about it before posting the last mail.


Thanks
Ken'ichi Ohmichi



--===============0778673296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0778673296==--
