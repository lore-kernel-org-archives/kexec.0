Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QlxJb-0001Lp-Cv
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 06:09:57 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p6R63MsF019810
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 16:03:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6R69AbP807082
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 16:09:10 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6R69lKT030632
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 16:09:48 +1000
Message-ID: <4E2FABA8.5000401@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 11:39:44 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading module
	debuginfo.
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110725171156.e4965f9f.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110725171156.e4965f9f.oomichi@mxs.nes.nec.co.jp>
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

Hi Ken'ichi,

On 07/25/2011 01:41 PM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> This patch is almost good, and there are some cleanup points.
> 
> On Wed, 18 May 2011 01:31:01 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> +
>> +static void
>> +clean_dwfl_info(void)
>> +{
>> +	if (dwarf_info.dwfl)
>> +		dwfl_end(dwarf_info.dwfl);
>> +
>> +	dwarf_info.dwfl = NULL;
>> +	dwarf_info.dwarfd = NULL;
>> +	dwarf_info.elfd = NULL;
>> +}
>> +
>> +/*
>> + * Intitialize the dwarf info.
>>
>> + * Linux kernel module debuginfo are of ET_REL (relocatable) type. The old
>> + * implementation of get_debug_info() function that reads the debuginfo was
>> + * not relocation-aware and hence could not read the dwarf info properly
>> + * from module debuginfo.
> 
> "The old implementaion .." is useful for my review, but it is not necessary
> after merging this patch.
> 
> 
>> + *
>> + * This function uses dwfl API's to apply relocation before reading the
>> + * dwarf information from module debuginfo.
>> + * On success, this function sets the dwarf_info.elfd and dwarf_info.dwarfd
>> + * after applying relocation to module debuginfo.
>> + */
>> +static int
>> +init_dwarf_info(void)
> 
> Is the searching method of debuginfo file only for kernel module ?
> Or also for vmlinux ?

Yes, the searching method is only for module debuginfo. For vmlinux we
set the dwarf_info.name_debuginfo before call to init_dwarf_info() and
we never call search routine dwfl_linux_kernel_report_offline() for
vmlinux. The routine dwfl_report_offline() applies the relocation on
specified debuginfo module. In case vmlinux it basically does nothing.

> 
> I feel this function is a little complex, and I'd like to make it simple.
> If only for kernel module, we can do it by separating the searching method
> from this function and calling it in case of kernel module.

The init_dwarf_info() function gets called everytime when
get_debug_info() is called. The get_debug_info() is called multiple
times for same debuginfo file. This function tries to avoid the repeated
search for same debuginfo, hence the function is little complex.
	- In case of kernel module the very first invocation of
init_dwarf_info() would call dwfl_linux_kernel_report_offline() which
will iterate over the available kernel modules and process the debuginfo
only for the module for which we are interested in.
	- We set the dwarf_info.name_debuginfo with the debuginfo file name
found during the first invocation.
	- The second invocation of init_dwarf_info() for same kernel module,
will find dwarf_info.name_debuginfo is already set and will avoid the
debuginfo search. In this case it will just apply relocation using
routine dwfl_report_offline().

This function does not have any special handling code for vmlinux. The
function is independent of whether it is called for vmlinux or kernel
module. In case of vmlinux this function has absolutely no side effects.

> 
> 
>> +{
>> +	Dwfl *dwfl = NULL;
>> +	int dwfl_fd = -1;
>> +	static char *debuginfo_path = DEFAULT_DEBUGINFO_PATH;
>> +	static const Dwfl_Callbacks callbacks = {
>> +		.section_address = dwfl_offline_section_address,
>> +		.find_debuginfo = dwfl_standard_find_debuginfo,
>> +		.debuginfo_path = &debuginfo_path,
>> +	};
>> +
>> +	dwarf_info.elfd = NULL;
>> +	dwarf_info.dwarfd = NULL;
>> +
>> +	if ((dwfl = dwfl_begin(&callbacks)) == NULL) {
>> +		ERRMSG("Can't create a handle for a new dwfl session.\n");
>> +		return FALSE;
>> +	}
>> +
>> +	if (dwarf_info.name_debuginfo) {
>> +		/* We have absolute path for debuginfo file, use it directly
>> +		 * instead of searching it through
>> +		 * dwfl_linux_kernel_report_offline() call.
>> +		 *
>> +		 * Open the debuginfo file if it is not already open.
>> +		 */
>> +		if (dwarf_info.fd_debuginfo < 0)
>> +			dwarf_info.fd_debuginfo =
>> +				open(dwarf_info.name_debuginfo, O_RDONLY);
>> +
>> +		dwfl_fd = dup(dwarf_info.fd_debuginfo);
>> +		if (dwfl_fd < 0) {
>> +			ERRMSG("Failed to get a duplicate handle for"
>> +				" debuginfo.\n");
>> +			goto err_out;
>> +		}
>> +	}
>> +	if (dwarf_info.fd_debuginfo > 0) {
> 
> Better to change the above to
> 	if (dwfl_fd > 0) {
> 
> because dwfl_fd is used in the follwoing and dwarf_info.fd_debuginfo is not.

Agree.

> 
> 
>> @@ -1383,18 +1523,12 @@ get_symbol_addr(char *symname)
>>  	Elf_Data *data = NULL;
>>  	Elf_Scn *scn = NULL;
>>  	char *sym_name = NULL;
>> -	const off_t failed = (off_t)-1;
>>  
>> -	if (lseek(dwarf_info.fd_debuginfo, 0, SEEK_SET) == failed) {
>> -		ERRMSG("Can't seek the kernel file(%s). %s\n",
>> -		    dwarf_info.name_debuginfo, strerror(errno));
>> -		return NOT_FOUND_SYMBOL;
>> -	}
>> -	if (!(elfd = elf_begin(dwarf_info.fd_debuginfo, ELF_C_READ, NULL))) {
>> -		ERRMSG("Can't get first elf header of %s.\n",
>> -		    dwarf_info.name_debuginfo);
>> -		return NOT_FOUND_SYMBOL;
>> -	}
>> +	if (!init_dwarf_info())
>> +		return 0;
> 
> Better to change the above to
> +		return NOT_FOUND_SYMBOL;
> 

Agree.

> 
>> @@ -1449,18 +1582,12 @@ get_next_symbol_addr(char *symname)
>>  	Elf_Data *data = NULL;
>>  	Elf_Scn *scn = NULL;
>>  	char *sym_name = NULL;
>> -	const off_t failed = (off_t)-1;
>>  
>> -	if (lseek(dwarf_info.fd_debuginfo, 0, SEEK_SET) == failed) {
>> -		ERRMSG("Can't seek the kernel file(%s). %s\n",
>> -		    dwarf_info.name_debuginfo, strerror(errno));
>> -		return NOT_FOUND_SYMBOL;
>> -	}
>> -	if (!(elfd = elf_begin(dwarf_info.fd_debuginfo, ELF_C_READ, NULL))) {
>> -		ERRMSG("Can't get first elf header of %s.\n",
>> -		    dwarf_info.name_debuginfo);
>> -		return NOT_FOUND_SYMBOL;
>> -	}
>> +	if (!init_dwarf_info())
>> +		return 0;
> 
> ditto.

Agree.

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
