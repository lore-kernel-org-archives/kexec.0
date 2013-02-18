Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U7Kyz-0005LC-Ak
 for kexec@lists.infradead.org; Mon, 18 Feb 2013 07:17:51 +0000
Date: Mon, 18 Feb 2013 16:11:44 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile-1.5.2: Secret data scrubbing with eppic language.
Message-Id: <20130218161144.7b961a9026c8d0efa487c637@mxc.nes.nec.co.jp>
In-Reply-To: <5121CB85.6040306@redhat.com>
References: <20130214110716.7b2b9f9b0eba662caefc9410@mxc.nes.nec.co.jp>
 <511F597A.2030900@redhat.com> <51204EE1.8040406@redhat.com>
 <20130218131431.9a1a5bcf811767788cd0e38f@mxc.nes.nec.co.jp>
 <5121CB85.6040306@redhat.com>
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
To: dyoung@redhat.com
Cc: kexec@lists.infradead.org, bhe@redhat.com

Hello Dave,

On Mon, 18 Feb 2013 14:34:45 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 02/18/2013 12:14 PM, Atsushi Kumagai wrote:
> > Hello Dave,
> > 
> > On Sat, 16 Feb 2013 18:03:38 +0800
> > Dave Young <dyoung@redhat.com> wrote:
> > 
> >> On 02/14/2013 10:07 AM, Atsushi Kumagai wrote:
> >>> Hello,
> >>>
> >>> makedumpfile version 1.5.2 is released.
> >>> Your comments/patches are welcome.
> >>
> >> Hi,
> >> ppc64 build fails with "undefined reference to readpage_sadump".
> >>
> > 
> > Thanks for reporting this issue.
> > 
> > readpage_sadump() was introduced as modification of readpmem_sadump
> > to use caching feature, but the dummy implementation of it wasn't
> > renamed.
> > 
> > I'll fix this issue with the patch below, so could you test it in your
> > environment ?
> 
> Hi, Atsushi
> 
> It works for me, thanks.
> 
> Tested-by: Dave Young <dyoung@redhat.com>

Thanks for your quick response.
I'll release a fixed version soon.


Thanks
Atsushi Kumagai

> 
> > 
> > 
> > Thanks
> > Atsushi Kumagai
> > -----------------------------------------------------------------
> > 
> > [PATCH] Fix dummy implementation for readpage_sadump.
> > 
> > readpage_sadump() was introduced as modification of readpmem_sadump,
> > but the dummy implementation of it wasn't renamed.
> > 
> > Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> > 
> > diff --git a/sadump_info.h b/sadump_info.h
> > index 766f35d..c0175dd 100644
> > --- a/sadump_info.h
> > +++ b/sadump_info.h
> > @@ -97,8 +97,8 @@ static inline unsigned long long sadump_get_max_mapnr(void)
> >         return 0;
> >  }
> > 
> > -static inline int readpmem_sadump(unsigned long long paddr,
> > -                                 void *bufptr, size_t size)
> > +static inline int
> > +readpage_sadump(unsigned long long paddr, void *bufptr)
> >  {
> >         return FALSE;
> >  }
> > 
> > 
> >> Below patch fixes this, but feel free to fix it without the #if in other way.
> >>
> >> diff -uprN makedumpfile/makedumpfile.c makedumpfile.new/makedumpfile.c
> >> --- makedumpfile/makedumpfile.c	2013-02-16 17:58:58.158576503 +0800
> >> +++ makedumpfile.new/makedumpfile.c	2013-02-16 17:59:19.775577017 +0800
> >> @@ -412,9 +412,11 @@ readmem(int type_addr, unsigned long lon
> >>  		if (info->flag_refiltering) {
> >>  			if (!readpage_kdump_compressed(pgaddr, pgbuf))
> >>  				goto error;
> >> +#if defined(__x86__) || defined(__x86_64__)
> >>  		} else if (info->flag_sadump) {
> >>  			if (!readpage_sadump(pgaddr, pgbuf))
> >>  				goto error;
> >> +#endif
> >>  		} else {
> >>  			if (!readpage_elf(pgaddr, pgbuf))
> >>  				goto error;
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> 
> -- 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
