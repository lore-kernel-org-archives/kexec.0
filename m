Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KC4RK-0008HE-83
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 03:15:59 +0000
Message-Id: <48645B6C.1070608@mxs.nes.nec.co.jp>
Date: Fri, 27 Jun 2008 12:15:56 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix vmcoreinfo generation on 32bit hosts for 64bit kernels
References: <20080626124731.GA24365@suse.de>
In-Reply-To: <20080626124731.GA24365@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0369054006=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============0369054006==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Thank you for the patch.

Bernhard Walle wrote:
> This bug fixes the generation of vmcoreinfo files on 32bit hosts for ELF64
> files, i.e. 64bit kernels. The concrete problem was PPC64 which is built in a
> 32bit environment at SUSE.

I have one question.
I guess that the fundamental problem is that makedumpfile cannot
use vmcoreinfo which is contained in /proc/vmcore on ppc64, right ?
If yes, could you please test my attached patch for fixing it.

I created the kernel patch for adding the symbol "node_data" to
ppc64's vmcoreinfo, but I cannot tested it because I don't have
any ppc64 machine.


Thanks
Ken'ichi Ohmichi

--- ./arch/powerpc/kernel/machine_kexec.c.orig	2008-06-27 11:26:29.000000000 +0900
+++ ./arch/powerpc/kernel/machine_kexec.c	2008-06-27 11:32:05.000000000 +0900
@@ -116,3 +116,13 @@ int overlaps_crashkernel(unsigned long s
 {
 	return (start + size) > crashk_res.start && start <= crashk_res.end;
 }
+
+
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
+}
+

> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  makedumpfile.c |   37 ++++++++++++++++++-----------------
>  makedumpfile.h |   60 ++++++++++++++++++++++++++++-----------------------------
>  2 files changed, 49 insertions(+), 48 deletions(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -123,7 +123,7 @@ vaddr_to_offset_general(unsigned long lo
>   * It is useful at few calls like get_str_osrelease_from_vmlinux().
>   */
>  off_t
> -vaddr_to_offset_slow(int fd, char *filename, unsigned long vaddr)
> +vaddr_to_offset_slow(int fd, char *filename, unsigned long long vaddr)
>  {
>  	off_t offset = 0;
>  	int i, phnum, num_load, flag_elf64, elf_format;
> @@ -170,6 +170,7 @@ vaddr_to_offset_slow(int fd, char *filen
>  			break;
>  		}
>  	}
> +
>  	return offset;
>  }
>  
> @@ -970,11 +971,11 @@ out:
>  	return ret;
>  }
>  
> -unsigned long
> +unsigned long long
>  get_symbol_addr(char *symname)
>  {
>  	int i;
> -	unsigned long symbol = NOT_FOUND_SYMBOL;
> +	unsigned long long symbol = NOT_FOUND_SYMBOL;
>  	Elf *elfd = NULL;
>  	GElf_Shdr shdr;
>  	GElf_Sym sym;
> @@ -1949,7 +1950,7 @@ int
>  get_str_osrelease_from_vmlinux()
>  {
>  	struct utsname system_utsname;
> -	unsigned long utsname;
> +	unsigned long long utsname;
>  	off_t offset;
>  	const off_t failed = (off_t)-1;
>  
> @@ -1968,7 +1969,7 @@ get_str_osrelease_from_vmlinux()
>  	    dwarf_info.name_debuginfo, utsname);
>  
>  	if (!offset) {
> -		ERRMSG("Can't convert vaddr (%lx) of utsname to an offset.\n",
> +		ERRMSG("Can't convert vaddr (%llx) of utsname to an offset.\n",
>  		    utsname);
>  		return FALSE;
>  	}
> @@ -5684,19 +5685,19 @@ show_data_xen()
>  	 * Show data for debug
>  	 */
>  	MSG("\n");
> -	MSG("SYMBOL(dom_xen): %lx\n", SYMBOL(dom_xen));
> -	MSG("SYMBOL(dom_io): %lx\n", SYMBOL(dom_io));
> -	MSG("SYMBOL(domain_list): %lx\n", SYMBOL(domain_list));
> -	MSG("SYMBOL(xen_heap_start): %lx\n", SYMBOL(xen_heap_start));
> -	MSG("SYMBOL(frame_table): %lx\n", SYMBOL(frame_table));
> -	MSG("SYMBOL(alloc_bitmap): %lx\n", SYMBOL(alloc_bitmap));
> -	MSG("SYMBOL(max_page): %lx\n", SYMBOL(max_page));
> -	MSG("SYMBOL(pgd_l2): %lx\n", SYMBOL(pgd_l2));
> -	MSG("SYMBOL(pgd_l3): %lx\n", SYMBOL(pgd_l3));
> -	MSG("SYMBOL(pgd_l4): %lx\n", SYMBOL(pgd_l4));
> -	MSG("SYMBOL(xenheap_phys_end): %lx\n", SYMBOL(xenheap_phys_end));
> -	MSG("SYMBOL(xen_pstart): %lx\n", SYMBOL(xen_pstart));
> -	MSG("SYMBOL(frametable_pg_dir): %lx\n", SYMBOL(frametable_pg_dir));
> +	MSG("SYMBOL(dom_xen): %llx\n", SYMBOL(dom_xen));
> +	MSG("SYMBOL(dom_io): %llx\n", SYMBOL(dom_io));
> +	MSG("SYMBOL(domain_list): %llx\n", SYMBOL(domain_list));
> +	MSG("SYMBOL(xen_heap_start): %llx\n", SYMBOL(xen_heap_start));
> +	MSG("SYMBOL(frame_table): %llx\n", SYMBOL(frame_table));
> +	MSG("SYMBOL(alloc_bitmap): %llx\n", SYMBOL(alloc_bitmap));
> +	MSG("SYMBOL(max_page): %llx\n", SYMBOL(max_page));
> +	MSG("SYMBOL(pgd_l2): %llx\n", SYMBOL(pgd_l2));
> +	MSG("SYMBOL(pgd_l3): %llx\n", SYMBOL(pgd_l3));
> +	MSG("SYMBOL(pgd_l4): %llx\n", SYMBOL(pgd_l4));
> +	MSG("SYMBOL(xenheap_phys_end): %llx\n", SYMBOL(xenheap_phys_end));
> +	MSG("SYMBOL(xen_pstart): %llx\n", SYMBOL(xen_pstart));
> +	MSG("SYMBOL(frametable_pg_dir): %llx\n", SYMBOL(frametable_pg_dir));
>  
>  	MSG("SIZE(page_info): %ld\n", SIZE(page_info));
>  	MSG("OFFSET(page_info.count_info): %ld\n", OFFSET(page_info.count_info));
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -258,7 +258,7 @@ do { \
>  #define WRITE_SYMBOL(str_symbol, symbol) \
>  do { \
>  	if (SYMBOL(symbol) != NOT_FOUND_SYMBOL) { \
> -		fprintf(info->file_vmcoreinfo, "%s%lx\n", \
> +		fprintf(info->file_vmcoreinfo, "%s%llx\n", \
>  		    STR_SYMBOL(str_symbol), SYMBOL(symbol)); \
>  	} \
>  } while (0)
> @@ -802,39 +802,39 @@ struct vm_table {
>  extern struct vm_table		vt;
>  
>  struct symbol_table {
> -	unsigned long	mem_map;
> -	unsigned long	mem_section;
> -	unsigned long	pkmap_count;
> -	unsigned long	pkmap_count_next;
> -	unsigned long	system_utsname;
> -	unsigned long	init_uts_ns;
> -	unsigned long	_stext;
> -	unsigned long	swapper_pg_dir;
> -	unsigned long	init_level4_pgt;
> -	unsigned long	phys_base;
> -	unsigned long	node_online_map;
> -	unsigned long	node_states;
> -	unsigned long	node_memblk;
> -	unsigned long	node_data;
> -	unsigned long	pgdat_list;
> -	unsigned long	contig_page_data;
> +	unsigned long long	mem_map;
> +	unsigned long long	mem_section;
> +	unsigned long long	pkmap_count;
> +	unsigned long long	pkmap_count_next;
> +	unsigned long long	system_utsname;
> +	unsigned long long	init_uts_ns;
> +	unsigned long long 	_stext;
> +	unsigned long long 	swapper_pg_dir;
> +	unsigned long long 	init_level4_pgt;
> +	unsigned long long 	phys_base;
> +	unsigned long long 	node_online_map;
> +	unsigned long long 	node_states;
> +	unsigned long long 	node_memblk;
> +	unsigned long long 	node_data;
> +	unsigned long long 	pgdat_list;
> +	unsigned long long 	contig_page_data;
>  
>  	/*
>  	 * for Xen extraction
>  	 */
> -	unsigned long	dom_xen;
> -	unsigned long	dom_io;
> -	unsigned long	domain_list;
> -	unsigned long	frame_table;
> -	unsigned long	xen_heap_start;
> -	unsigned long	pgd_l2;
> -	unsigned long	pgd_l3;
> -	unsigned long	pgd_l4;
> -	unsigned long	xenheap_phys_end;
> -	unsigned long	xen_pstart;
> -	unsigned long	frametable_pg_dir;
> -	unsigned long	max_page;
> -	unsigned long	alloc_bitmap;
> +	unsigned long long	dom_xen;
> +	unsigned long long	dom_io;
> +	unsigned long long	domain_list;
> +	unsigned long long	frame_table;
> +	unsigned long long	xen_heap_start;
> +	unsigned long long	pgd_l2;
> +	unsigned long long	pgd_l3;
> +	unsigned long long	pgd_l4;
> +	unsigned long long	xenheap_phys_end;
> +	unsigned long long	xen_pstart;
> +	unsigned long long	frametable_pg_dir;
> +	unsigned long long	max_page;
> +	unsigned long long	alloc_bitmap;
>  };
>  
>  struct size_table {
> 



--===============0369054006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0369054006==--
