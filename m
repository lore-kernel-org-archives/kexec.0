Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gArFp-0000FE-78
 for kexec@lists.infradead.org; Fri, 12 Oct 2018 06:49:00 +0000
Date: Fri, 12 Oct 2018 14:48:39 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Use VMCOREINTO inside '/proc/kcore' if available
Message-ID: <20181012064839.GA1731@192.168.1.5>
References: <1538916769-3499-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1538916769-3499-1-git-send-email-bhsharma@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: ptesarik@suse.cz, dyoung@redhat.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org, k-hagio@ab.jp.nec.com

Hi Bhupesh,

On 10/07/18 at 06:22pm, Bhupesh Sharma wrote:
> Commit 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 (arm64: Get
> 'info->page_offset' from PT_LOAD segments to support KASLR boot cases)
> added a method to determine 'info->page_offset' from PT_LOAD segments
> for arm64 platforms.
> 
> In this commit we hardcoded the NOT_PADDR_ARM64 macro as
> 0x0000000010a80000UL which was a valid value on qualcomm-amberwing
> boards.
> 
> However, I was testing this change on several other arm64 boards
> like apm-mustang, huawei-taishan and hp-moonshot and saw that
> this value can vary on the basic of the "Kernel code" memory
> range placement.

So arm64 has defined NOT_PADDR_ARM64 as an invalid physical address, if
it's not right on several machines, I am wondering why you don't
investigate and make clear what's happening in arm64 kernel, and why
it's different in different boards. We might need to root cause the
reason firstly, then check if it can't be fixed in kernel side, then we
may have to change in makedumpfile.

Thanks
Baoquan

> To fix the same, this patchset uses a new approach. Since kernel
> version 4.19-rc5 (Commit
> 23c85094fe1895caefdd19ef624ee687ec5f4507 ["proc/kcore: add vmcoreinfo
> note to /proc/kcore"]), '/proc/kcore' contains a new
> PT_NOTE which carries the VMCOREINFO information.
> 
> If the same is available, we can use it for makedumpfile
> 'show_mem_usage()' and other functionality. This is especially useful
> for architectures like arm64 as we can get kernel symbols like
> 'VA_BITS' and 'kimage_voffset' from the '/proc/kcore' itself and use it
> to calculate 'info->page_offset' when we make a call to
> 'get_page_offset()'.
> 
> This VMCOREINFO note provides us a standard interface which can be
> leveraged while debugging live (or primary) kernel with makedumpfile
> (and other user-space tools), especially to derive the machine specific
> details (for e.g. VA_BITS, PHYS_OFFSET and kimage_voffset for arm64
> arch).
> 
> I also verified the makedumpfile functionality in crash kernel with this
> patchset. Here are some details of the tests I ran:
> 
> Testing:
> --------
> 1. Architectures tested:
>    a) arm64 :- huawei-taishan, apm-mustang and qualcomm-amberwing boards.
>    b) x86_64 :- Dell optiplex workstation.
>       (NOTE that x86_64 makedumpfile --mem-usage use-case is currently
>       broken with upstream kernel, but I have debugged the root-cause
>       and will separately send a patch to fix the same).
> 
> 2. Use-cases tested:
>    a) Primary kernel ->
>       [] --mem-usage:
>          # makedumpfile -f --mem-usage /proc/kcore
> 
>       [] filtering use-case:
>          # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
> 
>       [] dumpfile creation:
>          # makedumpfile -d 31 -x vmlinux vmcore dumpfile
> 
>    b) Crash kernel ->
>       [] dumpfile creation:
>          # makedumpfile -l --message-level 31 -d 31 /proc/vmcore dump
> 
> 3. Kernel versions tested:
>    a) Kernel version 4.19-rc5 and above on both arm64 and x86_64.
>    b) Fedora 28 on x86_64.
>    c) Kernel version 4.14 on arm64.
> 
> Fixes: 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 "arm64: Get 'info->page_offset' from PT_LOAD segments to support KASLR boot cases"
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arch/arm64.c   | 114 +++++++++++++++++++++++++++++++++++++++++++--------------
>  makedumpfile.c |  67 ++++++++++++++++++++++++++++++---
>  makedumpfile.h |   2 +-
>  3 files changed, 149 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64.c b/arch/arm64.c
> index 362609668ea2..d695eff628f0 100644
> --- a/arch/arm64.c
> +++ b/arch/arm64.c
> @@ -53,6 +53,7 @@ static unsigned long kimage_voffset;
>  #define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
>  #define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
>  #define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
> +#define __PAGE_OFFSET(x) ((0xffffffffffffffffUL) << (x - 1))
>  
>  #define pgd_val(x)		((x).pgd)
>  #define pud_val(x)		(pgd_val((x).pgd))
> @@ -311,45 +312,104 @@ get_versiondep_info_arm64(void)
>  	unsigned long long virt_start;
>  	ulong _stext;
>  
> -	_stext = get_stext_symbol();
> -	if (!_stext) {
> -		ERRMSG("Can't get the symbol of _stext.\n");
> -		return FALSE;
> -	}
> +	/* Calculate 'VA_BITS'. */
>  
> -	/* Derive va_bits as per arch/arm64/Kconfig */
> -	if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> -		va_bits = 36;
> -	} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> -		va_bits = 39;
> -	} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> -		va_bits = 42;
> -	} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> -		va_bits = 47;
> -	} else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> -		va_bits = 48;
> +	/* Since kernel version 4.19, '/proc/kcore' contains a new
> +	 * PT_NOTE which carries the VMCOREINFO information.
> +	 *
> +	 * If the same is available, use it as it already contains the
> +	 * value of 'VA_BITS' on the machine.
> +	 *
> +	 * Otherwise, we can read the '_stext' symbol and determine the
> +	 * 'VA_BITS' value from the same as well.
> +	 */
> +	if (info->flag_kcore_contains_vmcoreinfo &&
> +	    (NUMBER(VA_BITS) != NOT_FOUND_NUMBER)) {
> +		va_bits = NUMBER(VA_BITS);
>  	} else {
> -		ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> -		return FALSE;
> +		_stext = get_stext_symbol();
> +		if (!_stext) {
> +			ERRMSG("Can't get the symbol of _stext.\n");
> +			return FALSE;
> +		}
> +
> +		/* Derive va_bits as per arch/arm64/Kconfig */
> +		if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> +			va_bits = 36;
> +		} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> +			va_bits = 39;
> +		} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> +			va_bits = 42;
> +		} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> +			va_bits = 47;
> +		} else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> +			va_bits = 48;
> +		} else {
> +			ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> +			return FALSE;
> +		}
> +	}
> +
> +	/* Calculate 'info->page_offset'. */
> +
> +	/* Since kernel version 4.19, '/proc/kcore' contains a new
> +	 * PT_NOTE which carries the VMCOREINFO information.
> +	 *
> +	 * If the same is available, use it as it already contains the
> +	 * value of 'kimage_voffset' on the machine.
> +	 */
> +	if (info->flag_kcore_contains_vmcoreinfo &&
> +	    (NUMBER(kimage_voffset) != NOT_FOUND_NUMBER)) {
> +		kimage_voffset = NUMBER(kimage_voffset);
>  	}
>  
> +	/* First, lets try and calculate the 'info->page_offset' value
> +	 * from PT_LOAD segments, if they are available.
> +	 */
>  	if (get_num_pt_loads()) {
>  		for (i = 0;
>  		    get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
>  		    i++) {
> -			if (virt_start != NOT_KV_ADDR
> -			    && virt_start < __START_KERNEL_map
> -			    && phys_start != NOT_PADDR
> -			    && phys_start != NOT_PADDR_ARM64) {
> -				info->page_offset = virt_start - phys_start;
> -				DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> -						info->page_offset, va_bits);
> -				return TRUE;
> +			/* On systems where we have a valid 'kimage_voffset'
> +			 * available by now, we should give preference to the same
> +			 * while calculating 'info->page_offset'.
> +			 *
> +			 * Otherwise, we can ensure that we consider
> +			 * only those PT_LOAD segments whose 'virt_start'
> +			 * is greater than the PAGE_OFFSET value (as defined
> +			 * in 'arch/arm64/include/asm/memory.h').
> +			 */
> +			if (!kimage_voffset) {
> +				if (virt_start != NOT_KV_ADDR &&
> +				   virt_start > __PAGE_OFFSET(va_bits) &&
> +				   phys_start != NOT_PADDR) {
> +					info->page_offset = virt_start - phys_start;
> +					DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> +							info->page_offset, va_bits);
> +					return TRUE;
> +				}
> +			} else {
> +				if (virt_start != NOT_KV_ADDR &&
> +				   phys_start != NOT_PADDR &&
> +				   (virt_start - phys_start) != kimage_voffset) {
> +					info->page_offset = virt_start - phys_start;
> +					DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> +							info->page_offset, va_bits);
> +					return TRUE;
> +				}
>  			}
>  		}
>  	}
>  
> -	info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> +	/* Fallback to hard-coded value (equal to PAGE_OFFSET macro
> +	 * defined in 'arch/arm64/include/asm/memory.h'), as the last
> +	 * resort.
> +	 *
> +	 * Note that this will not be a valid value on KASLR enabled
> +	 * kernels as the start address of linear range is also
> +	 * randomized for KASLR boot cases.
> +	 */
> +	info->page_offset = __PAGE_OFFSET(va_bits);
>  	DEBUG_MSG("page_offset=%lx, va_bits=%d\n", info->page_offset,
>  			va_bits);
>  
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 3ccdaaeda0c5..59967f95e0d3 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1302,6 +1302,20 @@ error:
>  	return FALSE;
>  }
>  
> +static int
> +check_kcore_contains_vmcoreinfo(int fd, char *name)
> +{
> +	if (!get_elf_info(fd, name))
> +		return FALSE;
> +
> +	if (!has_vmcoreinfo())
> +		return FALSE;
> +
> +	DEBUG_MSG("VMCOREINFO PT_NOTE found in %s\n", name);
> +
> +	return TRUE;
> +}
> +
>  int
>  open_dump_memory(void)
>  {
> @@ -1314,6 +1328,23 @@ open_dump_memory(void)
>  	}
>  	info->fd_memory = fd;
>  
> +	/* Since kernel version 4.19, '/proc/kcore' contains a new
> +	 * PT_NOTE which carries the VMCOREINFO information.
> +	 *
> +	 * If the same is available, use it for makedumpfile
> +	 * show_mem_usage() cases.
> +	 */
> +	if (info->flag_mem_usage &&
> +	    !(strcmp(info->name_memory, "/proc/kcore")) &&
> +	    (info->kernel_version >= KERNEL_VERSION(4, 19, 0))){
> +		status = check_kcore_contains_vmcoreinfo(fd,
> +						info->name_memory);
> +		if (status == TRUE) {
> +			info->flag_kcore_contains_vmcoreinfo = TRUE;
> +			return TRUE;
> +		}
> +	}
> +
>  	status = check_kdump_compressed(info->name_memory);
>  	if (status == TRUE) {
>  		info->flag_refiltering = TRUE;
> @@ -11195,6 +11226,8 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
>  
>  int show_mem_usage(void)
>  {
> +	off_t offset;
> +	unsigned long size;
>  	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
>  	struct cycle cycle = {0};
>  
> @@ -11208,17 +11241,39 @@ int show_mem_usage(void)
>  	if (!open_files_for_creating_dumpfile())
>  		return FALSE;
>  
> -	if (!get_elf_loads(info->fd_memory, info->name_memory))
> -		return FALSE;
> +	/* Since kernel version 4.19, '/proc/kcore' contains a new
> +	 * PT_NOTE which carries the VMCOREINFO information.
> +	 *
> +	 * If the same is available, use it for makedumpfile
> +	 * show_mem_usage(). This is especially useful for architectures
> +	 * like arm64 as we can get symbols like 'VA_BITS' and
> +	 * 'kimage_voffset' before we call get_page_offset().
> +	 */
> +
> +	if (!info->flag_kcore_contains_vmcoreinfo) {
> +		if (!get_elf_loads(info->fd_memory, info->name_memory))
> +			return FALSE;
> +	} else {
> +		if (has_vmcoreinfo()) {
> +			get_vmcoreinfo(&offset, &size);
> +			if (!read_vmcoreinfo_from_vmcore(offset, size, FALSE))
> +				return FALSE;
> +		}
> +	}
>  
>  	if (!get_page_offset())
>  		return FALSE;
>  
> -	if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> -		return FALSE;
> +	/* If flag_kcore_contains_vmcoreinfo is TRUE when we are here,
> +	 * we don't need to read the vmcoreinfo again.
> +	 */
> +	if (!info->flag_kcore_contains_vmcoreinfo)
> +		if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> +			return FALSE;
>  
> -	if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> -		return FALSE;
> +	if (!info->flag_kcore_contains_vmcoreinfo)
> +		if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> +			return FALSE;
>  
>  	if (!initial())
>  		return FALSE;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index d1fcd87e85f5..3ae683774fe5 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -544,7 +544,6 @@ unsigned long get_kvbase_arm64(void);
>  #define KVBASE			get_kvbase_arm64()
>  
>  #define __START_KERNEL_map	(0xffffffff80000000UL)
> -#define NOT_PADDR_ARM64		(0x0000000010a80000UL)
>  
>  #endif /* aarch64 */
>  
> @@ -1307,6 +1306,7 @@ struct DumpInfo {
>  	int		flag_vmemmap;        /* kernel supports vmemmap address space */
>  	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
>  	int		flag_use_count;      /* _refcount is named _count in struct page */
> +	int		flag_kcore_contains_vmcoreinfo;    /* '/proc/kcore' contains a VMCOREINFO PT_NOTE */
>  	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
>  	long		page_size;           /* size of page */
>  	long		page_shift;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
