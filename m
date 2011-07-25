Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QlGVk-0002WG-3V
	for kexec@lists.infradead.org; Mon, 25 Jul 2011 08:27:37 +0000
Date: Mon, 25 Jul 2011 17:11:56 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading
	module debuginfo.
Message-Id: <20110725171156.e4965f9f.oomichi@mxs.nes.nec.co.jp>
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

This patch is almost good, and there are some cleanup points.

On Wed, 18 May 2011 01:31:01 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
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
>
> + * Linux kernel module debuginfo are of ET_REL (relocatable) type. The old
> + * implementation of get_debug_info() function that reads the debuginfo was
> + * not relocation-aware and hence could not read the dwarf info properly
> + * from module debuginfo.

"The old implementaion .." is useful for my review, but it is not necessary
after merging this patch.


> + *
> + * This function uses dwfl API's to apply relocation before reading the
> + * dwarf information from module debuginfo.
> + * On success, this function sets the dwarf_info.elfd and dwarf_info.dwarfd
> + * after applying relocation to module debuginfo.
> + */
> +static int
> +init_dwarf_info(void)

Is the searching method of debuginfo file only for kernel module ?
Or also for vmlinux ?

I feel this function is a little complex, and I'd like to make it simple.
If only for kernel module, we can do it by separating the searching method
from this function and calling it in case of kernel module.


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

Better to change the above to
	if (dwfl_fd > 0) {

because dwfl_fd is used in the follwoing and dwarf_info.fd_debuginfo is not.


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

Better to change the above to
+		return NOT_FOUND_SYMBOL;


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

ditto.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
