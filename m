Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qhf2F-0004X6-Rb
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 09:50:17 +0000
Date: Fri, 15 Jul 2011 18:35:41 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading
	module debuginfo.
Message-Id: <20110715183541.e9f5e604.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On my machine (RHEL5 x86_64), I cannot compile makedumpfile with this patch.
I guess that it is due to old elfutils of my machine, and I am trying this
problem by newer elfutils.

I'd like to get some hints, so can you tell me your environment ?
RHEL6 x86_64 ?


Thanks
Ken'ichi Ohmichi

On Wed, 18 May 2011 01:31:01 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> So far makedumpfile implementation does not have to deal with module
> debuginfo files. In order to support filtering of kernel module data,
> it needs to read dwarf information from module debuginfo files. The linux
> kernel module debuginfo are of ET_REL type and requires relocation to be
> applied in order to get the dwarf information.
> 
> This patch uses dwfl_* API's to make the code relocation-aware while
> loading module debuginfo files. It also uses dwfl_* API to search module
> debuginfo files installed under default debuginfo path.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Prerna Saxena <prerna@linux.vnet.ibm.com>
> ---
> 
>  makedumpfile.c |  261 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  makedumpfile.h |    7 ++
>  2 files changed, 216 insertions(+), 52 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index f136eba..2274b18 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1372,6 +1372,146 @@ get_elf_info(void)
>  	return TRUE;
>  }
>  
> +static int
> +process_module (Dwfl_Module *dwflmod,
> +		void **userdata __attribute__ ((unused)),
> +		const char *name __attribute__ ((unused)),
> +		Dwarf_Addr base __attribute__ ((unused)),
> +		void *arg)
> +{
> +	const char *fname, *mod_name, *debugfile;
> +	Dwarf_Addr dwbias;
> +
> +	/* get a debug context descriptor.*/
> +	dwarf_info.dwarfd = dwfl_module_getdwarf (dwflmod, &dwbias);
> +	dwarf_info.elfd = dwarf_getelf(dwarf_info.dwarfd);
> +
> +	mod_name = dwfl_module_info(dwflmod, NULL, NULL, NULL, NULL, NULL,
> +							&fname, &debugfile);
> +
> +	if (!strcmp(dwarf_info.module_name, mod_name) &&
> +		!dwarf_info.name_debuginfo && debugfile) {
> +		/*
> +		 * Store the debuginfo filename. Next time we will
> +		 * open debuginfo file direclty instead of searching
> +		 * for it again.
> +		 */
> +		dwarf_info.name_debuginfo = strdup(debugfile);
> +	}
> +
> +	return DWARF_CB_OK;
> +}
> +
> +static int
> +dwfl_report_module_p(const char *modname, const char *filename)
> +{
> +	if (filename && !strcmp(modname, dwarf_info.module_name))
> +		return 1;
> +	return 0;
> +}
> +
> +static void
> +clean_dwfl_info(void)
> +{
> +	if (dwarf_info.dwfl)
> +		dwfl_end(dwarf_info.dwfl);
> +
> +	dwarf_info.dwfl = NULL;
> +	dwarf_info.dwarfd = NULL;
> +	dwarf_info.elfd = NULL;
> +}
> +
> +/*
> + * Intitialize the dwarf info.
> + * Linux kernel module debuginfo are of ET_REL (relocatable) type. The old
> + * implementation of get_debug_info() function that reads the debuginfo was
> + * not relocation-aware and hence could not read the dwarf info properly
> + * from module debuginfo.
> + *
> + * This function uses dwfl API's to apply relocation before reading the
> + * dwarf information from module debuginfo.
> + * On success, this function sets the dwarf_info.elfd and dwarf_info.dwarfd
> + * after applying relocation to module debuginfo.
> + */
> +static int
> +init_dwarf_info(void)
> +{
> +	Dwfl *dwfl = NULL;
> +	int dwfl_fd = -1;
> +	static char *debuginfo_path = DEFAULT_DEBUGINFO_PATH;
> +	static const Dwfl_Callbacks callbacks = {
> +		.section_address = dwfl_offline_section_address,
> +		.find_debuginfo = dwfl_standard_find_debuginfo,
> +		.debuginfo_path = &debuginfo_path,
> +	};
> +
> +	dwarf_info.elfd = NULL;
> +	dwarf_info.dwarfd = NULL;
> +
> +	if ((dwfl = dwfl_begin(&callbacks)) == NULL) {
> +		ERRMSG("Can't create a handle for a new dwfl session.\n");
> +		return FALSE;
> +	}
> +
> +	if (dwarf_info.name_debuginfo) {
> +		/* We have absolute path for debuginfo file, use it directly
> +		 * instead of searching it through
> +		 * dwfl_linux_kernel_report_offline() call.
> +		 *
> +		 * Open the debuginfo file if it is not already open.
> +		 */
> +		if (dwarf_info.fd_debuginfo < 0)
> +			dwarf_info.fd_debuginfo =
> +				open(dwarf_info.name_debuginfo, O_RDONLY);
> +
> +		dwfl_fd = dup(dwarf_info.fd_debuginfo);
> +		if (dwfl_fd < 0) {
> +			ERRMSG("Failed to get a duplicate handle for"
> +				" debuginfo.\n");
> +			goto err_out;
> +		}
> +	}
> +	if (dwarf_info.fd_debuginfo > 0) {
> +		if (dwfl_report_offline(dwfl, dwarf_info.module_name,
> +				dwarf_info.name_debuginfo, dwfl_fd) == NULL) {
> +			ERRMSG("Failed reading %s: %s\n",
> +				dwarf_info.name_debuginfo, dwfl_errmsg (-1));
> +			/* dwfl_fd is consumed on success, not on failure */
> +			close(dwfl_fd);
> +			goto err_out;
> +		}
> +	}
> +	else if (dwfl_linux_kernel_report_offline(dwfl,
> +						info->system_utsname.release,
> +						&dwfl_report_module_p)) {
> +		ERRMSG("Can't get Module debuginfo for module '%s'\n",
> +					dwarf_info.module_name);
> +		goto err_out;
> +	}
> +	dwfl_report_end(dwfl, NULL, NULL);
> +
> +	dwfl_getmodules(dwfl, &process_module, NULL, 0);
> +
> +	if (dwarf_info.elfd == NULL) {
> +		ERRMSG("Can't get first elf header of %s.\n",
> +		    dwarf_info.name_debuginfo);
> +		goto err_out;
> +	}
> +
> +	if (dwarf_info.dwarfd == NULL) {
> +		ERRMSG("Can't get debug context descriptor for %s.\n",
> +		    dwarf_info.name_debuginfo);
> +		goto err_out;
> +	}
> +	dwarf_info.dwfl = dwfl;
> +	return TRUE;
> +err_out:
> +	if (dwfl)
> +		dwfl_end(dwfl);
> +
> +	return FALSE;
> +}
> +
>  unsigned long long
>  get_symbol_addr(char *symname)
>  {
> @@ -1383,18 +1523,12 @@ get_symbol_addr(char *symname)
>  	Elf_Data *data = NULL;
>  	Elf_Scn *scn = NULL;
>  	char *sym_name = NULL;
> -	const off_t failed = (off_t)-1;
>  
> -	if (lseek(dwarf_info.fd_debuginfo, 0, SEEK_SET) == failed) {
> -		ERRMSG("Can't seek the kernel file(%s). %s\n",
> -		    dwarf_info.name_debuginfo, strerror(errno));
> -		return NOT_FOUND_SYMBOL;
> -	}
> -	if (!(elfd = elf_begin(dwarf_info.fd_debuginfo, ELF_C_READ, NULL))) {
> -		ERRMSG("Can't get first elf header of %s.\n",
> -		    dwarf_info.name_debuginfo);
> -		return NOT_FOUND_SYMBOL;
> -	}
> +	if (!init_dwarf_info())
> +		return 0;
> +
> +	elfd = dwarf_info.elfd;
> +
>  	while ((scn = elf_nextscn(elfd, scn)) != NULL) {
>  		if (gelf_getshdr(scn, &shdr) == NULL) {
>  			ERRMSG("Can't get section header.\n");
> @@ -1431,8 +1565,7 @@ get_symbol_addr(char *symname)
>  		}
>  	}
>  out:
> -	if (elfd != NULL)
> -		elf_end(elfd);
> +	clean_dwfl_info();
>  
>  	return symbol;
>  }
> @@ -1449,18 +1582,12 @@ get_next_symbol_addr(char *symname)
>  	Elf_Data *data = NULL;
>  	Elf_Scn *scn = NULL;
>  	char *sym_name = NULL;
> -	const off_t failed = (off_t)-1;
>  
> -	if (lseek(dwarf_info.fd_debuginfo, 0, SEEK_SET) == failed) {
> -		ERRMSG("Can't seek the kernel file(%s). %s\n",
> -		    dwarf_info.name_debuginfo, strerror(errno));
> -		return NOT_FOUND_SYMBOL;
> -	}
> -	if (!(elfd = elf_begin(dwarf_info.fd_debuginfo, ELF_C_READ, NULL))) {
> -		ERRMSG("Can't get first elf header of %s.\n",
> -		    dwarf_info.name_debuginfo);
> -		return NOT_FOUND_SYMBOL;
> -	}
> +	if (!init_dwarf_info())
> +		return 0;
> +
> +	elfd = dwarf_info.elfd;
> +
>  	while ((scn = elf_nextscn(elfd, scn)) != NULL) {
>  		if (gelf_getshdr(scn, &shdr) == NULL) {
>  			ERRMSG("Can't get section header.\n");
> @@ -1522,8 +1649,7 @@ get_next_symbol_addr(char *symname)
>  		}
>  	}
>  out:
> -	if (elfd != NULL)
> -		elf_end(elfd);
> +	clean_dwfl_info();
>  
>  	return next_symbol;
>  }
> @@ -2034,24 +2160,15 @@ get_debug_info(void)
>  	Elf_Scn *scn = NULL;
>  	GElf_Shdr scnhdr_mem, *scnhdr = NULL;
>  	Dwarf_Die cu_die;
> -	const off_t failed = (off_t)-1;
>  
>  	int ret = FALSE;
>  
> -	if (lseek(dwarf_info.fd_debuginfo, 0, SEEK_SET) == failed) {
> -		ERRMSG("Can't seek the kernel file(%s). %s\n",
> -		    dwarf_info.name_debuginfo, strerror(errno));
> -		return FALSE;
> -	}
> -	if (!(elfd = elf_begin(dwarf_info.fd_debuginfo, ELF_C_READ_MMAP, NULL))) {
> -		ERRMSG("Can't get first elf header of %s.\n",
> -		    dwarf_info.name_debuginfo);
> +	if (!init_dwarf_info())
>  		return FALSE;
> -	}
> -	if (!(dwarfd = dwarf_begin_elf(elfd, DWARF_C_READ, NULL))) {
> -		ERRMSG("Can't create a handle for a new debug session.\n");
> -		goto out;
> -	}
> +
> +	elfd = dwarf_info.elfd;
> +	dwarfd = dwarf_info.dwarfd;
> +
>  	if (elf_getshstrndx(elfd, &shstrndx) < 0) {
>  		ERRMSG("Can't get the section index of the string table.\n");
>  		goto out;
> @@ -2088,10 +2205,7 @@ get_debug_info(void)
>  	}
>  	ret = TRUE;
>  out:
> -	if (dwarfd != NULL)
> -		dwarf_end(dwarfd);
> -	if (elfd != NULL)
> -		elf_end(elfd);
> +	clean_dwfl_info();
>  
>  	return ret;
>  }
> @@ -2448,14 +2562,58 @@ get_mem_type(void)
>  	return ret;
>  }
>  
> +/*
> + * Set the dwarf_info with kernel/module debuginfo file information.
> + */
> +int
> +set_dwarf_debuginfo(char *mod_name, char *name_debuginfo, int fd_debuginfo)
> +{
> +	if (!mod_name)
> +		return FALSE;
> +	if (dwarf_info.module_name && !strcmp(dwarf_info.module_name, mod_name))
> +		return TRUE;
> +
> +	/* Switching to different module.
> +	 *
> +	 * Close the file descriptor if previous module is != kernel and
> +	 * xen-syms. The reason is, vmlinux file will always be supplied
> +	 * by user and code to open/close kernel debuginfo file already
> +	 * in place. The module debuginfo files are opened only if '--config'
> +	 * option is used. This helps not to break the existing functionlity
> +	 * if called without '--config' option.
> +	 */
> +
> +	if (dwarf_info.module_name
> +			&& strcmp(dwarf_info.module_name, "vmlinux")
> +			&& strcmp(dwarf_info.module_name, "xen-syms")) {
> +		if (dwarf_info.fd_debuginfo > 0)
> +			close(dwarf_info.fd_debuginfo);
> +		if (dwarf_info.name_debuginfo)
> +			free(dwarf_info.name_debuginfo);
> +	}
> +	dwarf_info.fd_debuginfo = fd_debuginfo;
> +	dwarf_info.name_debuginfo = name_debuginfo;
> +	dwarf_info.module_name = mod_name;
> +
> +	if (!strcmp(dwarf_info.module_name, "vmlinux") ||
> +		!strcmp(dwarf_info.module_name, "xen-syms"))
> +		return TRUE;
> +
> +	/* check to see whether module debuginfo is available */
> +	if (!init_dwarf_info())
> +		return FALSE;
> +	else
> +		clean_dwfl_info();
> +	return TRUE;
> +}
> +
>  int
>  generate_vmcoreinfo(void)
>  {
>  	if (!set_page_size(sysconf(_SC_PAGE_SIZE)))
>  		return FALSE;
>  
> -	dwarf_info.fd_debuginfo   = info->fd_vmlinux;
> -	dwarf_info.name_debuginfo = info->name_vmlinux;
> +	set_dwarf_debuginfo("vmlinux", info->name_vmlinux, info->fd_vmlinux);
>  
>  	if (!get_symbol_info())
>  		return FALSE;
> @@ -3888,8 +4046,8 @@ initial(void)
>  	 * Get the debug information for analysis from the kernel file
>  	 */
>  	} else if (info->name_vmlinux) {
> -		dwarf_info.fd_debuginfo   = info->fd_vmlinux;
> -		dwarf_info.name_debuginfo = info->name_vmlinux;
> +		set_dwarf_debuginfo("vmlinux", info->name_vmlinux,
> +						info->fd_vmlinux);
>  
>  		if (!get_symbol_info())
>  			return FALSE;
> @@ -6552,8 +6710,7 @@ generate_vmcoreinfo_xen(void)
>  		ERRMSG("Can't get the size of page.\n");
>  		return FALSE;
>  	}
> -	dwarf_info.fd_debuginfo   = info->fd_xen_syms;
> -	dwarf_info.name_debuginfo = info->name_xen_syms;
> +	set_dwarf_debuginfo("xen-syms", info->name_xen_syms, info->fd_xen_syms);
>  
>  	if (!get_symbol_info_xen())
>  		return FALSE;
> @@ -6820,8 +6977,8 @@ initial_xen(void)
>  	 * Get the debug information for analysis from the xen-syms file
>  	 */
>  	} else if (info->name_xen_syms) {
> -		dwarf_info.fd_debuginfo   = info->fd_xen_syms;
> -		dwarf_info.name_debuginfo = info->name_xen_syms;
> +		set_dwarf_debuginfo("xen-syms", info->name_xen_syms,
> +							info->fd_xen_syms);
>  
>  		if (!get_symbol_info_xen())
>  			return FALSE;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index e037f12..3fda754 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -27,6 +27,7 @@
>  #include <sys/wait.h>
>  #include <zlib.h>
>  #include <elfutils/libdw.h>
> +#include <elfutils/libdwfl.h>
>  #include <libelf.h>
>  #include <dwarf.h>
>  #include <byteswap.h>
> @@ -1177,6 +1178,8 @@ extern struct srcfile_table	srcfile_table;
>  /*
>   * Debugging information
>   */
> +#define DEFAULT_DEBUGINFO_PATH	"/usr/lib/debug"
> +
>  enum {
>  	DWARF_INFO_GET_STRUCT_SIZE,
>  	DWARF_INFO_GET_MEMBER_OFFSET,
> @@ -1194,10 +1197,14 @@ struct dwarf_info {
>  	unsigned int	cmd;		/* IN */
>  	int	fd_debuginfo;		/* IN */
>  	char	*name_debuginfo;	/* IN */
> +	char	*module_name;		/* IN */
>  	char	*struct_name;		/* IN */
>  	char	*symbol_name;		/* IN */
>  	char	*member_name;		/* IN */
>  	char	*enum_name;		/* IN */
> +	Elf	*elfd;			/* OUT */
> +	Dwarf	*dwarfd;		/* OUT */
> +	Dwfl	*dwfl;			/* OUT */
>  	long	struct_size;		/* OUT */
>  	long	member_offset;		/* OUT */
>  	long	array_length;		/* OUT */
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
