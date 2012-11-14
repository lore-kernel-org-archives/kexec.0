Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYU02-0000zm-Uz
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 03:50:52 +0000
Date: Wed, 14 Nov 2012 12:47:42 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 10/10] Print warning about cyclic buffer overrun if it
 can happen
Message-Id: <20121114124742.9c695ad11fa29e56c57413e9@mxc.nes.nec.co.jp>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AB00854@G01JPEXMBYT03>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121108094900.30421.54675.stgit@localhost6.localdomain6>
 <20121113165600.09afdc35534c6fbf3905b289@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB00854@G01JPEXMBYT03>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Tue, 13 Nov 2012 08:49:11 +0000
"Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:

> > -----Original Message-----
> > From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> > Sent: Tuesday, November 13, 2012 4:56 PM
> > To: Hatayama, Daisuke
> > Cc: kexec@lists.infradead.org
> > Subject: Re: [PATCH 10/10] Print warning about cyclic buffer overrun if
> > it can happen
> > 
> > Hello HATAYAMA-san,
> > 
> > On Thu, 08 Nov 2012 18:49:00 +0900
> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> > 
> > > Clearling bits on cyclic buffer can overrun the cyclic buffer
> > > according to some combination of MAX_ORDER and cyclic buffer size.
> > >
> > > This patch warns this possibility but continues processing.
> > >
> > > Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> > > ---
> > 
> > Thank you for pointing it out.
> > 
> > v1.5.1-rc will calculate the cyclic buffer size automatically and this
> > issue can happen even if MAX_ORDER is 11, so this patch is useful.
> > 
> > I'll try to resolve this issue essentially in v1.5.2.
> > 
> 
> Instead of the check, how about the following?
> 
>   info->bufsize_cyclic = round(info->bufsize_cyclic,
>                                roundup(max_order_nr_pages,
>                                        BITPERBYTE));
> 
> This chooses the largest buffer size from the sizes smaller than
> info->bufsize_cyclic fitting into max_order size.

It looks good, please change this patch as the above in v2.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
