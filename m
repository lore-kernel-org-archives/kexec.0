Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QmhXz-0004VT-5Y
	for kexec@lists.infradead.org; Fri, 29 Jul 2011 07:31:52 +0000
Date: Fri, 29 Jul 2011 16:21:04 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading
	module debuginfo.
Message-Id: <20110729162104.5d611eb9.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E313C17.7050609@linux.vnet.ibm.com>
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110725171156.e4965f9f.oomichi@mxs.nes.nec.co.jp>
	<4E2FABA8.5000401@linux.vnet.ibm.com>
	<20110728181146.d91ee265.oomichi@mxs.nes.nec.co.jp>
	<4E313C17.7050609@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Thu, 28 Jul 2011 16:08:15 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > 
> > If adding the searching method to the blow position and removing the code
> > from init_dwarf_info(), I guess it makes the code simple.
> > 
> > @ process_config_file()
> >  9402                         if (!set_dwarf_debuginfo(config->module_name,
> >  9403                                                                 NULL, -1)) {
> >  9404                                 ERRMSG("Skipping to next Module section\n");
> >  9405                                 skip_section = 1;
> >  9406                                 free_config(config);
> >  9407                                 continue;
> >  9408                         }
> >  9409                         << HERE >> 
> 
> This may not be the correct place to call search method. We may end up
> calling search method multiple times for same kernel module. I think
> moving the search method inside set_dwarf_debuginfo() routine at below
> position is a better place:
> 
> @set_dwarf_debuginfo()
> 	......
> 	......
> 	if (!strcmp(dwarf_info.module_name, "vmlinux") ||
>                 !strcmp(dwarf_info.module_name, "xen-syms"))
>                 return TRUE;
> +	 << HERE >>
> -        /* check to see whether module debuginfo is available */
> -        if (!init_dwarf_info())
> -                return FALSE;
> -        else
> -                clean_dwfl_info();
> 	 return TRUE;
> }
> 
> And then we can remove search routine from init_dwarf_info(). What do
> you think?

I think the above change will be good, thanks in advance.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
