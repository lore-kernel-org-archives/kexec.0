Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KiPRb-0003Lm-MN
	for kexec@lists.infradead.org; Wed, 24 Sep 2008 08:09:56 +0000
Message-ID: <48D9F52E.7060605@mxs.nes.nec.co.jp>
Date: Wed, 24 Sep 2008 17:07:10 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>	<48D72B2B.3000406@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>
	<48D9EDDC.1070600@mxs.nes.nec.co.jp>
In-Reply-To: <48D9EDDC.1070600@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1544382612=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============1544382612==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Kevin,

Ken'ichi Ohmichi wrote:
>> My config file is attached. Kernel is 2.6.20 + Ubuntu patches.
>> It was built from http://packages.ubuntu.com/feisty/linux-source-2.6.20
>>
>> Since it might be easy to see the parts I have changed from the defaults,
>> the diff between my config and the Ubuntu "generic" config is below.
> 
> Thank you for your .config file.
> 
> I could reproduce this problem. I created the patch, and it was merged
> into DEVEL tree. Could you get the DEVEL package by the following command
> and test it ?
> 
> cvs -z3 -d:pserver:anonymous@makedumpfile.cvs.sourceforge.net:/cvsroot/makedumpfile co -r DEVEL -P makedumpfile
> 
> If you cannot download it, please try the attached patch for makedumpfile-1.2.9.

Sorry for forgetting one notice.

If you use a vmcoreinfo file by '-i' option, please re-create a vmcoreinfo
file again by a new makedumpfile which applied this patch.
If using an old vmcoreinfo file, makedumpfile cannot run correctly because
the vmcoreinfo file does not contain necessary information (symbol vmlist,
offset vm_struct.addr).


Thanks
Ken'ichi Ohmichi

> -------------------------------
> [PATCH] Add vtop_x86 support.
> 
> On x86 machine, the existing makedumpfile translates a virtual address
> only by referring PT_LOAD header of /proc/vmcore. This feature is not
> enough for x86 machine, because some kernel data is located in vmalloc
> area. Then, this patch adds the translating feature for vmalloc address.
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> ---
> diff -puN backup/makedumpfile-1.2.9/makedumpfile.c makedumpfile/makedumpfile.c
> --- backup/makedumpfile-1.2.9/makedumpfile.c	2008-09-04 16:31:58.000000000 +0900
> +++ makedumpfile/makedumpfile.c	2008-09-24 14:56:02.000000000 +0900
> @@ -1803,6 +1803,7 @@ get_symbol_info(void)
>  	SYMBOL_INIT(_stext, "_stext");
>  	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
>  	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
> +	SYMBOL_INIT(vmlist, "vmlist");
>  	SYMBOL_INIT(phys_base, "phys_base");
>  	SYMBOL_INIT(node_online_map, "node_online_map");
>  	SYMBOL_INIT(node_states, "node_states");
> @@ -1910,6 +1911,8 @@ get_structure_info(void)
>  	OFFSET_INIT(node_memblk_s.size, "node_memblk_s", "size");
>  	OFFSET_INIT(node_memblk_s.nid, "node_memblk_s", "nid");
>  
> +	OFFSET_INIT(vm_struct.addr, "vm_struct", "addr");
> +
>  	ENUM_NUMBER_INIT(NR_FREE_PAGES, "NR_FREE_PAGES");
>  	ENUM_NUMBER_INIT(N_ONLINE, "N_ONLINE");
>  
> @@ -2095,6 +2098,7 @@ generate_vmcoreinfo(void)
>  	WRITE_SYMBOL("_stext", _stext);
>  	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>  	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
> +	WRITE_SYMBOL("vmlist", vmlist);
>  	WRITE_SYMBOL("phys_base", phys_base);
>  	WRITE_SYMBOL("node_online_map", node_online_map);
>  	WRITE_SYMBOL("node_states", node_states);
> @@ -2142,6 +2146,7 @@ generate_vmcoreinfo(void)
>  	WRITE_MEMBER_OFFSET("node_memblk_s.start_paddr", node_memblk_s.start_paddr);
>  	WRITE_MEMBER_OFFSET("node_memblk_s.size", node_memblk_s.size);
>  	WRITE_MEMBER_OFFSET("node_memblk_s.nid", node_memblk_s.nid);
> +	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
>  
>  	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
>  		WRITE_ARRAY_LENGTH("node_data", node_data);
> @@ -2339,6 +2344,7 @@ read_vmcoreinfo(void)
>  	READ_SYMBOL("_stext", _stext);
>  	READ_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>  	READ_SYMBOL("init_level4_pgt", init_level4_pgt);
> +	READ_SYMBOL("vmlist", vmlist);
>  	READ_SYMBOL("phys_base", phys_base);
>  	READ_SYMBOL("node_online_map", node_online_map);
>  	READ_SYMBOL("node_states", node_states);
> @@ -2379,6 +2385,7 @@ read_vmcoreinfo(void)
>  	READ_MEMBER_OFFSET("node_memblk_s.start_paddr", node_memblk_s.start_paddr);
>  	READ_MEMBER_OFFSET("node_memblk_s.size", node_memblk_s.size);
>  	READ_MEMBER_OFFSET("node_memblk_s.nid", node_memblk_s.nid);
> +	READ_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
>  
>  	READ_ARRAY_LENGTH("node_data", node_data);
>  	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
> diff -puN backup/makedumpfile-1.2.9/makedumpfile.h makedumpfile/makedumpfile.h
> --- backup/makedumpfile-1.2.9/makedumpfile.h	2008-09-04 16:31:58.000000000 +0900
> +++ makedumpfile/makedumpfile.h	2008-09-24 15:59:13.000000000 +0900
> @@ -498,6 +498,24 @@ do { \
>  #define _SECTION_SIZE_BITS_PAE	(30)
>  #define _MAX_PHYSMEM_BITS	(32)
>  #define _MAX_PHYSMEM_BITS_PAE	(36)
> +
> +#define PGDIR_SHIFT_3LEVEL	(30)
> +#define PTRS_PER_PTE_3LEVEL	(512)
> +#define PTRS_PER_PGD_3LEVEL	(4)
> +#define PMD_SHIFT		(21)  /* only used by PAE translators */
> +#define PTRS_PER_PMD		(512) /* only used by PAE translators */
> +#define PTE_SHIFT		(12)  /* only used by PAE translators */
> +#define PTRS_PER_PTE		(512) /* only used by PAE translators */
> +
> +#define pgd_index_PAE(address)  (((address) >> PGDIR_SHIFT_3LEVEL) & (PTRS_PER_PGD_3LEVEL - 1))
> +#define pmd_index(address)  (((address) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
> +#define pte_index(address)  (((address) >> PTE_SHIFT) & (PTRS_PER_PTE - 1))
> +
> +#define _PAGE_PRESENT		(0x001)
> +#define _PAGE_PSE		(0x080)
> +
> +#define ENTRY_MASK		(~0x8000000000000fffULL)
> +
>  #endif /* x86 */
>  
>  #ifdef __x86_64__
> @@ -611,10 +629,11 @@ do { \
>   */
>  #ifdef __x86__
>  int get_machdep_info_x86(void);
> +unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
>  #define get_phys_base()		TRUE
>  #define get_machdep_info()	get_machdep_info_x86()
>  #define get_versiondep_info()	TRUE
> -#define vaddr_to_paddr(X)	vaddr_to_paddr_general(X)
> +#define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
>  #endif /* x86 */
>  
>  #ifdef __x86_64__
> @@ -840,6 +859,7 @@ struct symbol_table {
>  	unsigned long long 	_stext;
>  	unsigned long long 	swapper_pg_dir;
>  	unsigned long long 	init_level4_pgt;
> +	unsigned long long 	vmlist;
>  	unsigned long long 	phys_base;
>  	unsigned long long 	node_online_map;
>  	unsigned long long 	node_states;
> @@ -919,6 +939,9 @@ struct offset_table {
>  		long	size;
>  		long	nid;
>  	} node_memblk_s;
> +	struct vm_struct {
> +		long	addr;
> +	} vm_struct;
>  
>  	/*
>  	 * for Xen extraction
> @@ -1051,19 +1074,6 @@ struct domain_list {
>  #define is_direct(x) \
>  	((x) >= DIRECTMAP_VIRT_START && (x) < DIRECTMAP_VIRT_END)
>  
> -#define PGDIR_SHIFT_3LEVEL   (30)
> -#define PTRS_PER_PTE_3LEVEL  (512)
> -#define PTRS_PER_PGD_3LEVEL  (4)
> -#define PMD_SHIFT            (21)    /* only used by PAE translators */
> -#define PTRS_PER_PMD         (512)   /* only used by PAE translators */
> -#define PTE_SHIFT            (12)    /* only used by PAE translators */
> -#define PTRS_PER_PTE         (512)   /* only used by PAE translators */
> -
> -#define _PAGE_PRESENT   0x001
> -#define _PAGE_PSE       0x080
> -
> -#define ENTRY_MASK	(~0x8000000000000fffULL)
> -
>  unsigned long long kvtop_xen_x86(unsigned long kvaddr);
>  #define kvtop_xen(X)	kvtop_xen_x86(X)
>  
> diff -puN backup/makedumpfile-1.2.9/x86.c makedumpfile/x86.c
> --- backup/makedumpfile-1.2.9/x86.c	2008-09-04 16:31:58.000000000 +0900
> +++ makedumpfile/x86.c	2008-09-24 16:06:25.000000000 +0900
> @@ -20,6 +20,8 @@
>  int
>  get_machdep_info_x86(void)
>  {
> +	unsigned long vmlist, vmalloc_start;
> +
>  	/* PAE */
>  	if ((vt.mem_flags & MEMORY_X86_PAE)
>  	    || ((SYMBOL(pkmap_count) != NOT_FOUND_SYMBOL)
> @@ -28,6 +30,7 @@ get_machdep_info_x86(void)
>  	      == 512)) {
>  		DEBUG_MSG("\n");
>  		DEBUG_MSG("PAE          : ON\n");
> +		vt.mem_flags |= MEMORY_X86_PAE;
>  		info->section_size_bits = _SECTION_SIZE_BITS_PAE;
>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_PAE;
>  	} else {
> @@ -38,9 +41,123 @@ get_machdep_info_x86(void)
>  	}
>  	info->page_offset = __PAGE_OFFSET;
>  
> +	if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
> +		ERRMSG("Can't get the symbol of _stext.\n");
> +		return FALSE;
> +	}
> +	info->kernel_start = SYMBOL(_stext) & ~KVBASE_MASK;
> +	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
> +
> +	/*
> +	 * For the compatibility, makedumpfile should run without the symbol
> +	 * vmlist and the offset of vm_struct.addr if they are not necessary.
> +	 */
> +	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> +	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> +		return TRUE;
> +	}
> +	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
> +		ERRMSG("Can't get vmlist.\n");
> +		return FALSE;
> +	}
> +	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
> +	    sizeof(vmalloc_start))) {
> +		ERRMSG("Can't get vmalloc_start.\n");
> +		return FALSE;
> +	}
> +	info->vmalloc_start = vmalloc_start;
> +	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
> +
>  	return TRUE;
>  }
>  
> +unsigned long long
> +vtop_x86_PAE(unsigned long vaddr)
> +{
> +	unsigned long long page_dir, pgd_pte, pmd_paddr, pmd_pte;
> +	unsigned long long pte_paddr, pte;
> +
> +	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
> +		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
> +		return NOT_PADDR;
> +	}
> +
> +	page_dir  = SYMBOL(swapper_pg_dir);
> +	page_dir += pgd_index_PAE(vaddr) * sizeof(unsigned long long);
> +	if (!readmem(VADDR, page_dir, &pgd_pte, sizeof(pgd_pte))) {
> +		ERRMSG("Can't get pgd_pte (page_dir:%llx).\n", page_dir);
> +		return NOT_PADDR;
> +	}
> +	if (!(pgd_pte & _PAGE_PRESENT))
> +		return NOT_PADDR;
> +
> +	if (info->vaddr_for_vtop == vaddr)
> +		MSG("  PGD : %16llx => %16llx\n", page_dir, pgd_pte);
> +
> +	pmd_paddr  = pgd_pte & ENTRY_MASK;
> +	pmd_paddr += pmd_index(vaddr) * sizeof(unsigned long long);
> +	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof(pmd_pte))) {
> +		ERRMSG("Can't get pmd_pte (pmd_paddr:%llx).\n", pmd_paddr);
> +		return NOT_PADDR;
> +	}
> +	if (!(pmd_pte & _PAGE_PRESENT))
> +		return NOT_PADDR;
> +
> +	if (info->vaddr_for_vtop == vaddr)
> +		MSG("  PMD : %16llx => %16llx\n", pmd_paddr, pmd_pte);
> +
> +	if (pmd_pte & _PAGE_PSE)
> +		return (pmd_pte & ENTRY_MASK) + (vaddr & ((1UL << PMD_SHIFT) - 1));
> +
> +	pte_paddr  = pmd_pte & ENTRY_MASK;
> +	pte_paddr += pte_index(vaddr) * sizeof(unsigned long long);
> +	if (!readmem(PADDR, pte_paddr, &pte, sizeof(pte)))
> +		return NOT_PADDR;
> +
> +	if (!(pte & _PAGE_PRESENT))
> +		return NOT_PADDR;
> +
> +	if (info->vaddr_for_vtop == vaddr)
> +		MSG("  PTE : %16llx => %16llx\n", pte_paddr, pte);
> +
> +	return (pte & ENTRY_MASK) + (vaddr & ((1UL << PTE_SHIFT) - 1));
> +}
> +
> +int
> +is_vmalloc_addr_x86(unsigned long vaddr)
> +{
> +	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
> +}
> +
> +unsigned long long
> +vaddr_to_paddr_x86(unsigned long vaddr)
> +{
> +	unsigned long long paddr;
> +
> +	if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
> +		return paddr;
> +
> +	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> +	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> +		ERRMSG("Can't get necessary information for vmalloc translation.\n");
> +		return NOT_PADDR;
> +	}
> +	if (!is_vmalloc_addr_x86(vaddr))
> +		return (vaddr - info->kernel_start);
> +
> +	if (vt.mem_flags & MEMORY_X86_PAE) {
> +		paddr = vtop_x86_PAE(vaddr);
> +	} else {
> +		/*
> +		 * TODO: Support vmalloc translation of not-PAE kernel.
> +		 */
> +		ERRMSG("This makedumpfile does not support vmalloc ");
> +		ERRMSG("translation of not-PAE kernel.\n");
> +		return NOT_PADDR;
> +	}
> +	return paddr;
> +}
> +
>  /*
>   * for Xen extraction
>   */
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec





--===============1544382612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1544382612==--
