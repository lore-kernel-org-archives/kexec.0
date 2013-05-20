Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UeP20-00065n-Tq
 for kexec@lists.infradead.org; Mon, 20 May 2013 12:17:38 +0000
Date: Mon, 20 May 2013 07:17:12 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH] makedumpfile: warn on vmlinux without dwarf
Message-ID: <20130520121712.GA25963@sgi.com>
References: <E1UcggB-0005hQ-Gr@eag09.americas.sgi.com>
 <20130520112044.0c660d8586141b938800d0d6@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130520112044.0c660d8586141b938800d0d6@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Mon, May 20, 2013 at 11:20:44AM +0900, Atsushi Kumagai wrote:
> On Wed, 15 May 2013 13:43:59 -0500
> Cliff Wickman <cpw@sgi.com> wrote:
> 
> > From: Cliff Wickman <cpw@sgi.com>
> > 
> > If the vmlinux does not have dwarf information makedumpfile fails in
> > a rather obscure way, with a flood of redundant errors,
> > 
> > Make it fail with more of a hint of what is wrong.
> > 
> > Signed-off-by: Cliff Wickman <cpw@sgi.com>
> > ---
> >  dwarf_info.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > Index: makedumpfile.mmap/dwarf_info.c
> > ===================================================================
> > --- makedumpfile.mmap.orig/dwarf_info.c
> > +++ makedumpfile.mmap/dwarf_info.c
> > @@ -139,6 +139,10 @@ process_module (Dwfl_Module *dwflmod,
> >  
> >  	/* get a debug context descriptor.*/
> >  	dwarf_info.dwarfd = dwfl_module_getdwarf (dwflmod, &dwbias);
> > +	if (dwarf_info.dwarfd == NULL) {
> > +		fprintf(stderr, "makedumpfile: dwfl_module_getdwarf error\n");
> > +		exit(1);
> > +	}
> 
> I agree to insert this message here, but don't agree to abort without
> any error handling.
> I think the code below seems better:
> 
>  	if (dwarf_info.dwarfd == NULL) {
>  		ERRMSG("dwfl_module_getdwarf error.\n");
>  		return DWARF_CB_ABORT;
>  	}

Agreed.  An error code is good.

-Cliff
> 
> 
> Thanks
> Atsushi Kumagai
> 
> >  	dwarf_info.elfd = dwarf_getelf(dwarf_info.dwarfd);
> >  
> >  	mod_name = dwfl_module_info(dwflmod, NULL, NULL, NULL, NULL, NULL,
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
