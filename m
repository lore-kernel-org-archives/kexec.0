Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TfPXg-00014v-C1
 for kexec@lists.infradead.org; Mon, 03 Dec 2012 06:30:14 +0000
Date: Mon, 3 Dec 2012 15:28:15 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCHv3 5/9] Initialize phys_start during early Xen setup
Message-Id: <20121203152815.2a6dd036120210030a0eefbb@mxc.nes.nec.co.jp>
In-Reply-To: <20121128145658.d1d4dd1f386462cba4417ae7@mxc.nes.nec.co.jp>
References: <201208241742.24409.ptesarik@suse.cz>
 <20121128145658.d1d4dd1f386462cba4417ae7@mxc.nes.nec.co.jp>
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

On Wed, 28 Nov 2012 14:56:58 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello Petr,
> 
> On Fri, 24 Aug 2012 17:42:24 +0200
> Petr Tesarik <ptesarik@suse.cz> wrote:
> 
> > With early Xen setup, we can move the initialization of xen_phys_start
> > to the setup routine. This is cleaner, as we can get rid of ifdef'ed
> > arch-specific code in makedumpfile.c (which should IMO stay generic).
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> > 
> > ---
> >  arch/x86.c     |    9 +++++++++
> >  arch/x86_64.c  |    9 +++++++++
> >  makedumpfile.c |   16 ----------------
> >  3 files changed, 18 insertions(+), 16 deletions(-)
> > 
> > --- a/arch/x86.c
> > +++ b/arch/x86.c
> > @@ -296,6 +296,15 @@ int get_xen_basic_info_x86(void)
> >  	unsigned long frame_table_vaddr;
> >  	unsigned long xen_end;
> >  
> > +	if (!info->xen_phys_start) {
> > +		if (info->xen_crash_info_v < 2) {
> > +			ERRMSG("Can't get Xen physical start address.\n"
> > +			       "Please use the --xen_phys_start option.");
> > +			return FALSE;
> > +		}
> > +		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
> > +	}
> > +
> 
> I tested for the vmcore which doesn't include xen_phys_start, then the 
> error message below showed:
> 
>   $ makedumpfile_v1.5.1 -E -X --xen-syms xen-syms-2.6.18-92.el5.debug vmcore dumpfile.EX
>   get_xen_basic_info_x86: Can't get Xen physical start address.
>   Please use the --xen_phys_start option.
>   makedumpfile Failed.
>   $
> 
> So, should I understand this result as reasonable error handling ?
> 
> The reason why I have this question is because the same vmcore can be
> filtered out with makedumpfile-1.5.0 or before like below:
> 
>   $ makedumpfile_v1.5.0 -E -X --xen-syms xen-syms-2.6.18-92.el5.debug vmcore dumpfile.EX
>   Switched running mode from cyclic to non-cyclic,
>   because the cyclic mode doesn't support Xen.
>   Copying data                       : [100 %]
> 
>   The dumpfile is saved to dumpfile.EX.
> 
>   makedumpfile Completed.
>   $
> 
> I have checked with grep, it seems that xen_phys_start is used for
> x86_64 only. So, is the valid check really necessary for x86 ?

I don't know much about Xen, but I think this is just regression.
And I want to release v1.5.1 in this week, so I will fix this regression
with the patch below:

diff --git a/arch/x86.c b/arch/x86.c
index 7de0495..ef29e3c 100644
--- a/arch/x86.c
+++ b/arch/x86.c
@@ -294,15 +294,6 @@ kvtop_xen_x86(unsigned long kvaddr)

 int get_xen_basic_info_x86(void)
 {
-       if (!info->xen_phys_start) {
-               if (info->xen_crash_info_v < 2) {
-                       ERRMSG("Can't get Xen physical start address.\n"
-                              "Please use the --xen_phys_start option.");
-                       return FALSE;
-               }
-               info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
-       }
-
        if (SYMBOL(pgd_l2) == NOT_FOUND_SYMBOL &&
            SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
                ERRMSG("Can't get pgd.\n");


Please let me know if you have any objections.

Thanks
Atsushi Kumagai


> Thanks
> Atsushi Kumagai
> 
> >  	if (SYMBOL(pgd_l2) == NOT_FOUND_SYMBOL &&
> >  	    SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
> >  		ERRMSG("Can't get pgd.\n");
> > --- a/arch/x86_64.c
> > +++ b/arch/x86_64.c
> > @@ -361,6 +361,15 @@ int get_xen_basic_info_x86_64(void)
> >  	unsigned long frame_table_vaddr;
> >  	unsigned long xen_end;
> >  
> > + 	if (!info->xen_phys_start) {
> > +		if (info->xen_crash_info_v < 2) {
> > +			ERRMSG("Can't get Xen physical start address.\n"
> > +			       "Please use the --xen_phys_start option.");
> > +			return FALSE;
> > +		}
> > +		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
> > +	}
> > +
> >  	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL) {
> >  		ERRMSG("Can't get pml4.\n");
> >  		return FALSE;
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -5365,20 +5365,6 @@ init_xen_crash_info(void)
> >  }
> >  
> >  int
> > -get_xen_phys_start(void)
> > -{
> > -	if (info->xen_phys_start)
> > -		return TRUE;
> > -
> > -#if defined(__x86__) || defined(__x86_64__)
> > -	if (info->xen_crash_info_v >= 2)
> > -		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
> > -#endif
> > -
> > -	return TRUE;
> > -}
> > -
> > -int
> >  get_xen_info(void)
> >  {
> >  	unsigned long domain;
> > @@ -5877,8 +5863,6 @@ initial_xen(void)
> >  		if (!read_vmcoreinfo_from_vmcore(offset, size, TRUE))
> >  			return FALSE;
> >  	}
> > -	if (!get_xen_phys_start())
> > -		return FALSE;
> >  	if (!get_xen_info())
> >  		return FALSE;
> >  
> > 
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
