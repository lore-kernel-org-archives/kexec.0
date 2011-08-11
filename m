Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QrTnQ-0004vl-Gv
	for kexec@lists.infradead.org; Thu, 11 Aug 2011 11:51:33 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p7BBpP3d017780
	for <kexec@lists.infradead.org>; Thu, 11 Aug 2011 17:21:25 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7BBpPOM3825872
	for <kexec@lists.infradead.org>; Thu, 11 Aug 2011 17:21:25 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7BBpP5E026370
	for <kexec@lists.infradead.org>; Thu, 11 Aug 2011 17:21:25 +0530
Date: Thu, 11 Aug 2011 17:21:24 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/8] makedumpfile: Read and process filter commands
	from config file.
Message-ID: <20110811115124.GA2817@in.ibm.com>
References: <20110517200407.12740.95780.stgit@mars.in.ibm.com>
	<20110811110716.7aec3c9e.oomichi@mxs.nes.nec.co.jp>
	<20110811141751.7927b2bb.oomichi@mxs.nes.nec.co.jp>
	<20110811172900.ad5c50b6.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110811172900.ad5c50b6.oomichi@mxs.nes.nec.co.jp>
Reply-To: mahesh@linux.vnet.ibm.com
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

On 2011-08-11 17:29:00 Thu, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Thu, 11 Aug 2011 14:17:51 +0900
> "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:
> > > 
> > > BTW makedumpfile.c has become a large file which is bigger than 10KLine,
> > > and I will separate it to some files for the maintenance.
> > 
> > To shrink makedumpfile.c file, I made a prototype patch.
> > (commit 40f5724152047a12e4ac9db51d9f9e00e7a79ebe of filter-out-devel branch)
> > And I'd like to see your opinion.
> > 
> > You added sym_in_module() call into get_symbol_addr() to look for module
> > symbol. And I will move the call to resolve_config_entry() because I guess
> > sym_in_module() is used only for resolve_config_entry():
> > 
> > @@ -8448,13 +7326,21 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
> >                                                 char *base_struct_name)
> >  {
> >         char buf[BUFSIZE + 1];
> > +       unsigned long long symbol;
> > 
> >         if (ce->flag & SYMBOL_ENTRY) {
> >                 /* find the symbol info */
> >                 if (!ce->name)
> >                         return FALSE;
> > 
> > -               ce->sym_addr = get_symbol_addr(ce->name);
> > +               /*
> > +                * If we are looking for module symbol then traverse through
> > +                * mod_st.modules for symbol lookup
> > +                */
> > +               if (sym_in_module(ce->name, &symbol))
> > +                       ce->sym_addr = symbol;
> > +               else
> > +                       ce->sym_addr = get_symbol_addr(ce->name);
> >                 if (!ce->sym_addr) {
> >                         ERRMSG("Config error at %d: Can't find symbol '%s'.\n",
> >                                                         ce->line, ce->name);
> > ---
> 
> Sorry, the above mail is not clear.
> My question is,
> 	Do you think this change is right ?

My intention was to hide it under get_symbol_addr(). But yes, since it's
only used by resolve_config_entry() we can safely move it there.

Thanks,
-Mahesh.

-- 
Mahesh J Salgaonkar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
