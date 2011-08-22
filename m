Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvUVU-0006xB-2K
	for kexec@lists.infradead.org; Mon, 22 Aug 2011 13:25:37 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
	(dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
	id S1590089Ab1HVNZZ (ORCPT <rfc822;kexec@lists.infradead.org>);
	Mon, 22 Aug 2011 15:25:25 +0200
Date: Mon, 22 Aug 2011 15:25:25 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: Re: [PATCH 1/4] xen: Take into account Xen control interface changes
	since Xen Ver. 4.1
Message-ID: <20110822132525.GB27902@router-fw-old.local.net-space.pl>
References: <20110821135139.GB17323@router-fw-old.local.net-space.pl>
	<201108212356.50589.konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201108212356.50589.konrad.wilk@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, ian.campbell@citrix.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, vgoyal@redhat.com, Daniel Kiper <dkiper@net-space.pl>

On Sun, Aug 21, 2011 at 11:56:50PM -0400, Konrad Rzeszutek Wilk wrote:
> > xc_interface_open() receive three arguments instead of void and returns
> > pointer to xc_interface type instead of int since Xen Ver. 4.1. Take into
> > account that and allow kexec-tools compilation with all versions of Xen.
> >
> > Signed-off-by: Daniel Kiper <dkiper@net-space.pl>
> > ---
> >  kexec/crashdump-xen.c |   15 ++++++++++++++-
> >  1 files changed, 14 insertions(+), 1 deletions(-)
> >
> > diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
> > index b347764..9dfabf8 100644
> > --- a/kexec/crashdump-xen.c
> > +++ b/kexec/crashdump-xen.c
> > @@ -126,19 +126,32 @@ unsigned long xen_architecture(struct crash_elf_info
> *elf_info)
> >  {
> >  	unsigned long machine = elf_info->machine;
> >  #ifdef HAVE_LIBXENCTRL
> > -	int xc, rc;
> > +	int rc;
> >  	xen_capabilities_info_t capabilities;
> > +#ifdef XENCTRL_HAS_XC_INTERFACE
> > +	xc_interface *xc;
> > +#else
> > +	int xc;
> > +#endif
>
> Where is the #endif for HAVE_LIBXENCTRL?

At the end of this function. It is not included in this patch.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
