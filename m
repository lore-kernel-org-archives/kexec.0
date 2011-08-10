Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QqzUu-0005dW-Dq
	for kexec@lists.infradead.org; Wed, 10 Aug 2011 03:30:26 +0000
Date: Wed, 10 Aug 2011 11:30:37 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading
	module debuginfo.
Message-Id: <20110810113037.c6af1d57.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110809174230.GA31038@in.ibm.com>
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110725171156.e4965f9f.oomichi@mxs.nes.nec.co.jp>
	<4E2FABA8.5000401@linux.vnet.ibm.com>
	<20110728181146.d91ee265.oomichi@mxs.nes.nec.co.jp>
	<4E313C17.7050609@linux.vnet.ibm.com>
	<20110729162104.5d611eb9.oomichi@mxs.nes.nec.co.jp>
	<20110809174230.GA31038@in.ibm.com>
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
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Tue, 9 Aug 2011 23:12:30 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > > > 
> > > > If adding the searching method to the blow position and removing the code
> > > > from init_dwarf_info(), I guess it makes the code simple.
> > > > 
> > > > @ process_config_file()
> > > >  9402                         if (!set_dwarf_debuginfo(config->module_name,
> > > >  9403                                                                 NULL, -1)) {
> > > >  9404                                 ERRMSG("Skipping to next Module section\n");
> > > >  9405                                 skip_section = 1;
> > > >  9406                                 free_config(config);
> > > >  9407                                 continue;
> > > >  9408                         }
> > > >  9409                         << HERE >> 
> > > 
> > > This may not be the correct place to call search method. We may end up
> > > calling search method multiple times for same kernel module. I think
> > > moving the search method inside set_dwarf_debuginfo() routine at below
> > > position is a better place:
> > > 
> > > @set_dwarf_debuginfo()
> > > 	......
> > > 	......
> > > 	if (!strcmp(dwarf_info.module_name, "vmlinux") ||
> > >                 !strcmp(dwarf_info.module_name, "xen-syms"))
> > >                 return TRUE;
> > > +	 << HERE >>
> > > -        /* check to see whether module debuginfo is available */
> > > -        if (!init_dwarf_info())
> > > -                return FALSE;
> > > -        else
> > > -                clean_dwfl_info();
> > > 	 return TRUE;
> > > }
> > > 
> > > And then we can remove search routine from init_dwarf_info(). What do
> > > you think?
> > 
> > I think the above change will be good, thanks in advance.
> 
> Please find the inline patch below that separates the search method from
> init_dwarf_info() function. Please review it and let know your comments.

Thank you for the patch.
I think this patch is good, and the patch has been magerd into
filter-out-devel branch.


Thanks
Ken'ichi Ohmichi

> makedumpfile: Move debuginfo search to set_dwarf_debuginfo() routine.
> 
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Move the debuginfo search logic out of init_dwarf_info() function to make
> this function more simpler. Now we call search method in set_dwarf_debuginfo
> when switch to different module section.
> 
> This patch also fixes a BUG where dwarf_info.module_name becomes a stale
> pointer after free_config() invocation. This patch now uses strdup() to get
> duplicate string and assigns it to dwarf_info.module_name.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  makedumpfile.c |  126 ++++++++++++++++++++++++++++++++++++++------------------
>  1 files changed, 86 insertions(+), 40 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 35cbed9..fe8e8b0 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1186,7 +1186,60 @@ clean_dwfl_info(void)
>  }
>  
>  /*
> - * Intitialize the dwarf info.
> + * Search module debuginfo.
> + * This function searches for module debuginfo in default debuginfo path for
> + * a given module in dwarf_info.module_name.
> + *
> + * On success, dwarf_info.name_debuginfo is set to absolute path of
> + * module debuginfo.
> + */
> +static int
> +search_module_debuginfo(void)
> +{
> +	Dwfl *dwfl = NULL;
> +	static char *debuginfo_path = DEFAULT_DEBUGINFO_PATH;
> +	static const Dwfl_Callbacks callbacks = {
> +		.section_address = dwfl_offline_section_address,
> +		.find_debuginfo = dwfl_standard_find_debuginfo,
> +		.debuginfo_path = &debuginfo_path,
> +	};
> +
> +	/*
> +	 * Check if We already have debuginfo file name with us. If yes,
> +	 * then we don't need to proceed with search method.
> +	 */
> +	if (dwarf_info.name_debuginfo)
> +		return TRUE;
> +
> +	if ((dwfl = dwfl_begin(&callbacks)) == NULL) {
> +		ERRMSG("Can't create a handle for a new dwfl session.\n");
> +		return FALSE;
> +	}
> +
> +	/* Search for module debuginfo file. */
> +	if (dwfl_linux_kernel_report_offline(dwfl,
> +						info->system_utsname.release,
> +						&dwfl_report_module_p)) {
> +		ERRMSG("Can't get Module debuginfo for module '%s'\n",
> +					dwarf_info.module_name);
> +		dwfl_end(dwfl);
> +		return FALSE;
> +	}
> +	dwfl_report_end(dwfl, NULL, NULL);
> +	dwfl_getmodules(dwfl, &process_module, NULL, 0);
> +
> +	dwfl_end(dwfl);
> +	clean_dwfl_info();
> +
> +	/* Return success if module debuginfo is found. */
> +	if (dwarf_info.name_debuginfo)
> +		return TRUE;
> +
> +	return FALSE;
> +}
> +
> +/*
> + * Initialize the dwarf info.
>   * Linux kernel module debuginfo are of ET_REL (relocatable) type.
>   * This function uses dwfl API's to apply relocation before reading the
>   * dwarf information from module debuginfo.
> @@ -1198,51 +1251,45 @@ init_dwarf_info(void)
>  {
>  	Dwfl *dwfl = NULL;
>  	int dwfl_fd = -1;
> -	static char *debuginfo_path = DEFAULT_DEBUGINFO_PATH;
>  	static const Dwfl_Callbacks callbacks = {
>  		.section_address = dwfl_offline_section_address,
> -		.find_debuginfo = dwfl_standard_find_debuginfo,
> -		.debuginfo_path = &debuginfo_path,
>  	};
>  
>  	dwarf_info.elfd = NULL;
>  	dwarf_info.dwarfd = NULL;
>  
> +	 /*
> +	  * We already know the absolute path of debuginfo file. Fail if we
> +	  * still don't have one. Ideally we should never be in this situation.
> +	  */
> +	if (!dwarf_info.name_debuginfo) {
> +		ERRMSG("Can't find absolute path to debuginfo file.\n");
> +		return FALSE;
> +	}
> +
>  	if ((dwfl = dwfl_begin(&callbacks)) == NULL) {
>  		ERRMSG("Can't create a handle for a new dwfl session.\n");
>  		return FALSE;
>  	}
>  
> -	if (dwarf_info.name_debuginfo) {
> -		/* We have absolute path for debuginfo file, use it directly
> -		 * instead of searching it through
> -		 * dwfl_linux_kernel_report_offline() call.
> -		 *
> -		 * Open the debuginfo file if it is not already open.
> -		 */
> -		if (dwarf_info.fd_debuginfo < 0)
> -			dwarf_info.fd_debuginfo =
> -				open(dwarf_info.name_debuginfo, O_RDONLY);
> -
> -		dwfl_fd = dup(dwarf_info.fd_debuginfo);
> -		if (dwfl_fd < 0) {
> -			ERRMSG("Failed to get a duplicate handle for"
> -				" debuginfo.\n");
> -			goto err_out;
> -		}
> -		if (dwfl_report_offline(dwfl, dwarf_info.module_name,
> -				dwarf_info.name_debuginfo, dwfl_fd) == NULL) {
> -			ERRMSG("Failed reading %s: %s\n",
> -				dwarf_info.name_debuginfo, dwfl_errmsg (-1));
> -			/* dwfl_fd is consumed on success, not on failure */
> -			close(dwfl_fd);
> -			goto err_out;
> -		}
> -	} else if (dwfl_linux_kernel_report_offline(dwfl,
> -						info->system_utsname.release,
> -						&dwfl_report_module_p)) {
> -		ERRMSG("Can't get Module debuginfo for module '%s'\n",
> -					dwarf_info.module_name);
> +	/* Open the debuginfo file if it is not already open.  */
> +	if (dwarf_info.fd_debuginfo < 0)
> +		dwarf_info.fd_debuginfo =
> +			open(dwarf_info.name_debuginfo, O_RDONLY);
> +
> +	dwfl_fd = dup(dwarf_info.fd_debuginfo);
> +	if (dwfl_fd < 0) {
> +		ERRMSG("Failed to get a duplicate handle for"
> +			" debuginfo.\n");
> +		goto err_out;
> +	}
> +	/* Apply relocations. */
> +	if (dwfl_report_offline(dwfl, dwarf_info.module_name,
> +			dwarf_info.name_debuginfo, dwfl_fd) == NULL) {
> +		ERRMSG("Failed reading %s: %s\n",
> +			dwarf_info.name_debuginfo, dwfl_errmsg (-1));
> +		/* dwfl_fd is consumed on success, not on failure */
> +		close(dwfl_fd);
>  		goto err_out;
>  	}
>  	dwfl_report_end(dwfl, NULL, NULL);
> @@ -2522,20 +2569,19 @@ set_dwarf_debuginfo(char *mod_name, char *name_debuginfo, int fd_debuginfo)
>  		if (dwarf_info.name_debuginfo)
>  			free(dwarf_info.name_debuginfo);
>  	}
> +	if (dwarf_info.module_name)
> +		free(dwarf_info.module_name);
> +
>  	dwarf_info.fd_debuginfo = fd_debuginfo;
>  	dwarf_info.name_debuginfo = name_debuginfo;
> -	dwarf_info.module_name = mod_name;
> +	dwarf_info.module_name = strdup(mod_name);
>  
>  	if (!strcmp(dwarf_info.module_name, "vmlinux") ||
>  		!strcmp(dwarf_info.module_name, "xen-syms"))
>  		return TRUE;
>  
>  	/* check to see whether module debuginfo is available */
> -	if (!init_dwarf_info())
> -		return FALSE;
> -	else
> -		clean_dwfl_info();
> -	return TRUE;
> +	return search_module_debuginfo();
>  }
>  
>  int
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
