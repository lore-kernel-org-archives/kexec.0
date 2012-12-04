Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tfo1R-0008M5-VO
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 08:38:34 +0000
Date: Tue, 4 Dec 2012 17:36:41 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCHv3 5/9] Initialize phys_start during early Xen setup
Message-Id: <20121204173641.135b920e234e3e663a1f0a42@mxc.nes.nec.co.jp>
In-Reply-To: <20121203111004.374e78c4@azariah.suse.cz>
References: <201208241742.24409.ptesarik@suse.cz>
 <20121128145658.d1d4dd1f386462cba4417ae7@mxc.nes.nec.co.jp>
 <20121203152815.2a6dd036120210030a0eefbb@mxc.nes.nec.co.jp>
 <20121203111004.374e78c4@azariah.suse.cz>
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
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org, Norbert.Trapp@ts.fujitsu.com

Hello Petr,

On Mon, 3 Dec 2012 11:10:04 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:
 
> > I don't know much about Xen, but I think this is just regression.
> > And I want to release v1.5.1 in this week, so I will fix this
> > regression with the patch below:
> > 
> > diff --git a/arch/x86.c b/arch/x86.c
> > index 7de0495..ef29e3c 100644
> > --- a/arch/x86.c
> > +++ b/arch/x86.c
> > @@ -294,15 +294,6 @@ kvtop_xen_x86(unsigned long kvaddr)
> > 
> >  int get_xen_basic_info_x86(void)
> >  {
> > -       if (!info->xen_phys_start) {
> > -               if (info->xen_crash_info_v < 2) {
> > -                       ERRMSG("Can't get Xen physical start
> > address.\n"
> > -                              "Please use the --xen_phys_start
> > option.");
> > -                       return FALSE;
> > -               }
> > -               info->xen_phys_start =
> > info->xen_crash_info.v2->xen_phys_start;
> > -       }
> > -
> >         if (SYMBOL(pgd_l2) == NOT_FOUND_SYMBOL &&
> >             SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
> >                 ERRMSG("Can't get pgd.\n");
> > 
> > 
> > Please let me know if you have any objections.
> 
> Hello Atsushi-san,
> 
> I'm sorry for my late reaction. Yes, this piece should be removed.
> While there is a xen_phys_start variable in 32-bit Xen, it is always
> zero, so we shouldn't complain if we can't get it.
> 
> Petr Tesarik

Thank you for your reply.
I will release v1.5.1 with the change above.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
