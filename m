Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3ydL-0000GT-8O
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 05:40:01 +0000
Subject: Re: [Makedumpfile PATCH 1/2] makedumpfile: add runtime kaslr offset
 if it exists
References: <cover.1493272570.git.panand@redhat.com>
 <11497aba9c2a9f6441bb7ee874e9cba70b02c7f1.1493272570.git.panand@redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <5902D5E0.809@redhat.com>
Date: Fri, 28 Apr 2017 13:40:48 +0800
MIME-Version: 1.0
In-Reply-To: <11497aba9c2a9f6441bb7ee874e9cba70b02c7f1.1493272570.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>, ats-kumagai@wm.jp.nec.com
Cc: keescook@chromium.org, bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, yinghai@kernel.org, mingo@kernel.org

On 04/27/2017 at 02:15 PM, Pratyush Anand wrote:
> If we have to erase a symbol from vmcore whose address is not present in
> vmcoreinfo, then we need to pass vmlinux as well to get the symbol
> address.
> When kaslr is enabled, virtual address of all the kernel symbols are
> randomized with an offset. vmlinux  always has a static address, but all
> the arch specific calculation are based on run time kernel address. So
> we need to find a way to translate symbol address from vmlinux to kernel
> run time address.
>
> without this patch:
>     # makedumpfile --split  -d 5 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
>
>     readpage_kdump_compressed: pfn(f97ea) is excluded from vmcore.
>     readmem: type_addr: 1, addr:f97eaff8, size:8
>     vtop4_x86_64: Can't get pml4 (page_dir:f97eaff8).
>     readmem: Can't convert a virtual address(ffffffff819f1284) to physical address.
>     readmem: type_addr: 0, addr:ffffffff819f1284, size:390
>     check_release: Can't get the address of system_utsname.
>
> After this patch check_release() is ok, and also we are able to erase
> symbol from vmcore.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  arch/x86_64.c  | 23 +++++++++++++++++++++++
>  erase_info.c   |  1 +
>  makedumpfile.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  makedumpfile.h | 15 +++++++++++++++
>  4 files changed, 83 insertions(+)
>
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index e978a36f8878..ab5aae8f1b26 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -33,6 +33,29 @@ get_xen_p2m_mfn(void)
>  	return NOT_FOUND_LONG_VALUE;
>  }
>  
> +unsigned long
> +get_kaslr_offset_x86_64(unsigned long vaddr)
> +{
> +	unsigned long sym_vmcoreinfo, sym_vmlinux;
> +
> +	if (!info->kaslr_offset) {
> +		sym_vmlinux = get_symbol_addr("_stext");
> +		if (sym_vmlinux == NOT_FOUND_SYMBOL)
> +			return 0;
> +		sym_vmcoreinfo = read_vmcoreinfo_symbol(STR_SYMBOL("_stext"));
> +		info->kaslr_offset = sym_vmcoreinfo - sym_vmlinux;
> +	}
> +	if (vaddr >= __START_KERNEL_map &&
> +			vaddr < __START_KERNEL_map + info->kaslr_offset)
> +		return info->kaslr_offset;
> +	else
> +		/*
> +		 * TODO: we need to check if it is vmalloc/vmmemmap/module
> +		 * address, we will have different offset
> +		 */
> +		return 0;
> +}
> +
>  static int
>  get_page_offset_x86_64(void)
>  {
> diff --git a/erase_info.c b/erase_info.c
> index f2ba9149e93e..60abfa1a1adf 100644
> --- a/erase_info.c
> +++ b/erase_info.c
> @@ -1088,6 +1088,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_vaddr,
>  							ce->line, ce->name);
>  			return FALSE;
>  		}
> +		ce->sym_addr += get_kaslr_offset(ce->sym_addr);
>  		ce->type_name = get_symbol_type_name(ce->name,
>  					DWARF_INFO_GET_SYMBOL_TYPE,
>  					&ce->size, &ce->type_flag);
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 301772a8820c..7e78641917d7 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3782,6 +3782,46 @@ free_for_parallel()
>  }
>  
>  int
> +find_kaslr_offsets()
> +{
> +	off_t offset;
> +	unsigned long size;
> +	int ret = FALSE;
> +
> +	get_vmcoreinfo(&offset, &size);
> +
> +	if (!(info->name_vmcoreinfo = strdup(FILENAME_VMCOREINFO))) {
> +		MSG("Can't duplicate strings(%s).\n", FILENAME_VMCOREINFO);
> +		return FALSE;
> +	}
> +	if (!copy_vmcoreinfo(offset, size))
> +		goto out;
> +
> +	if (!open_vmcoreinfo("r"))
> +		goto out;
> +
> +	unlink(info->name_vmcoreinfo);
> +
> +	/*
> +	 * This arch specific function should update info->kaslr_offset. If
> +	 * kaslr is not enabled then offset will be set to 0. arch specific
> +	 * function might need to read from vmcoreinfo, therefore we have
> +	 * called this function between open_vmcoreinfo() and
> +	 * close_vmcoreinfo()
> +	 */
> +	get_kaslr_offset(SYMBOL(_stext));

Looks like acquiring "KERNELOFFSET" in read_vmcoreinfo() should be enough here.

We can get kaslr offset directly from the vmcoreinfo because the compressed dumpfile
contains vmcoreinfo as well in case of flag_refiltering, also x86_64 kernel has exported
"vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());"

Regards,
Xunlei

> +
> +	close_vmcoreinfo();
> +
> +	ret = TRUE;
> +out:
> +	free(info->name_vmcoreinfo);
> +	info->name_vmcoreinfo = NULL;
> +
> +	return ret;
> +}
> +
> +int
>  initial(void)
>  {
>  	off_t offset;
> @@ -3833,6 +3873,9 @@ initial(void)
>  		set_dwarf_debuginfo("vmlinux", NULL,
>  					info->name_vmlinux, info->fd_vmlinux);
>  
> +		if (has_vmcoreinfo() && !find_kaslr_offsets())
> +			return FALSE;
> +
>  		if (!get_symbol_info())
>  			return FALSE;
>  
> @@ -11031,6 +11074,7 @@ main(int argc, char *argv[])
>  	info->fd_memory = -1;
>  	info->fd_dumpfile = -1;
>  	info->fd_bitmap = -1;
> +	info->kaslr_offset = 0;
>  	initialize_tables();
>  
>  	/*
> diff --git a/makedumpfile.h b/makedumpfile.h
> index e32e567018f6..0d358be8caac 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -253,10 +253,14 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
>  #define SYMBOL_INIT(symbol, str_symbol) \
>  do { \
>  	SYMBOL(symbol) = get_symbol_addr(str_symbol); \
> +	if (SYMBOL(symbol) != NOT_FOUND_SYMBOL) \
> +		SYMBOL(symbol) += info->kaslr_offset; \
>  } while (0)
>  #define SYMBOL_INIT_NEXT(symbol, str_symbol) \
>  do { \
>  	SYMBOL(symbol) = get_next_symbol_addr(str_symbol); \
> +	if (SYMBOL(symbol) != NOT_FOUND_SYMBOL) \
> +		SYMBOL(symbol) += info->kaslr_offset; \
>  } while (0)
>  #define WRITE_SYMBOL(str_symbol, symbol) \
>  do { \
> @@ -838,6 +842,7 @@ int get_xen_info_arm64(void);
>  #define get_phys_base()		get_phys_base_arm64()
>  #define get_machdep_info()	get_machdep_info_arm64()
>  #define get_versiondep_info()	get_versiondep_info_arm64()
> +#define get_kaslr_offset(X)	FALSE
>  #define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
>  #define get_xen_info_arch(X) get_xen_info_arm64(X)
>  #define is_phys_addr(X)		stub_true_ul(X)
> @@ -851,6 +856,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
>  #define get_phys_base()		get_phys_base_arm()
>  #define get_machdep_info()	get_machdep_info_arm()
>  #define get_versiondep_info()	stub_true()
> +#define get_kaslr_offset(X)	FALSE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
>  #define is_phys_addr(X)		stub_true_ul(X)
>  #endif /* arm */
> @@ -863,11 +869,13 @@ unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
>  #define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_x86()
>  #define get_versiondep_info()	get_versiondep_info_x86()
> +#define get_kaslr_offset(X)	FALSE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
>  #define is_phys_addr(X)		stub_true_ul(X)
>  #endif /* x86 */
>  
>  #ifdef __x86_64__
> +unsigned long get_kaslr_offset_x86_64(unsigned long vaddr);
>  int get_phys_base_x86_64(void);
>  int get_machdep_info_x86_64(void);
>  int get_versiondep_info_x86_64(void);
> @@ -876,6 +884,7 @@ unsigned long long vtop4_x86_64(unsigned long vaddr);
>  #define get_phys_base()		get_phys_base_x86_64()
>  #define get_machdep_info()	get_machdep_info_x86_64()
>  #define get_versiondep_info()	get_versiondep_info_x86_64()
> +#define get_kaslr_offset(X)	get_kaslr_offset_x86_64(X)
>  #define vaddr_to_paddr(X)	vtop4_x86_64(X)
>  #define is_phys_addr(X)		stub_true_ul(X)
>  #endif /* x86_64 */
> @@ -888,6 +897,7 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
>  #define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_ppc64()
>  #define get_versiondep_info()	get_versiondep_info_ppc64()
> +#define get_kaslr_offset(X)	FALSE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
>  #define is_phys_addr(X)		stub_true_ul(X)
>  #endif          /* powerpc64 */
> @@ -899,6 +909,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
>  #define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_ppc()
>  #define get_versiondep_info()	stub_true()
> +#define get_kaslr_offset(X)	FALSE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
>  #define is_phys_addr(X)		stub_true_ul(X)
>  #endif          /* powerpc32 */
> @@ -911,6 +922,7 @@ int is_iomem_phys_addr_s390x(unsigned long addr);
>  #define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_s390x()
>  #define get_versiondep_info()	stub_true()
> +#define get_kaslr_offset(X)	FALSE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
>  #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
>  #endif          /* s390x */
> @@ -923,6 +935,7 @@ unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
>  #define get_machdep_info()	get_machdep_info_ia64()
>  #define get_phys_base()		get_phys_base_ia64()
>  #define get_versiondep_info()	stub_true()
> +#define get_kaslr_offset(X)	FALSE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
>  #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
>  #define is_phys_addr(X)		stub_true_ul(X)
> @@ -1152,6 +1165,7 @@ struct DumpInfo {
>  	int		vmemmap_psize;
>  	int		vmemmap_cnt;
>  	struct ppc64_vmemmap	*vmemmap_list;
> +	unsigned long	kaslr_offset;
>  
>  	/*
>  	 * page table info for ppc64
> @@ -1803,6 +1817,7 @@ struct memory_range {
>  struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
>  int crash_reserved_mem_nr;
>  
> +unsigned long read_vmcoreinfo_symbol(char *str_symbol);
>  int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);
>  int get_str_osrelease_from_vmlinux(void);
>  int read_vmcoreinfo_xen(void);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
