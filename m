Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYCBL-0004K5-Nf
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 08:49:23 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 68B833EE081
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:49:13 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 33C0145DE51
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:49:13 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1606145DE4D
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:49:13 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EF71F1DB802F
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:49:12 +0900 (JST)
Received: from g01jpexchyt10.g01.fujitsu.local
 (g01jpexchyt10.g01.fujitsu.local [10.128.194.49])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A06831DB8037
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 17:49:12 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 10/10] Print warning about cyclic buffer overrun if it
 can happen
Date: Tue, 13 Nov 2012 08:49:11 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AB00854@G01JPEXMBYT03>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121108094900.30421.54675.stgit@localhost6.localdomain6>
 <20121113165600.09afdc35534c6fbf3905b289@mxc.nes.nec.co.jp>
In-Reply-To: <20121113165600.09afdc35534c6fbf3905b289@mxc.nes.nec.co.jp>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> Sent: Tuesday, November 13, 2012 4:56 PM
> To: Hatayama, Daisuke/畑山 大輔
> Cc: kexec@lists.infradead.org
> Subject: Re: [PATCH 10/10] Print warning about cyclic buffer overrun if
> it can happen
> 
> Hello HATAYAMA-san,
> 
> On Thu, 08 Nov 2012 18:49:00 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> > Clearling bits on cyclic buffer can overrun the cyclic buffer
> > according to some combination of MAX_ORDER and cyclic buffer size.
> >
> > This patch warns this possibility but continues processing.
> >
> > Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> > ---
> 
> Thank you for pointing it out.
> 
> v1.5.1-rc will calculate the cyclic buffer size automatically and this
> issue can happen even if MAX_ORDER is 11, so this patch is useful.
> 
> I'll try to resolve this issue essentially in v1.5.2.
> 

Instead of the check, how about the following?

  info->bufsize_cyclic = round(info->bufsize_cyclic,
                               roundup(max_order_nr_pages,
                                       BITPERBYTE));

This chooses the largest buffer size from the sizes smaller than
info->bufsize_cyclic fitting into max_order size.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
