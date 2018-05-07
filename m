Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFaXS-0007Dj-3l
 for kexec@lists.infradead.org; Mon, 07 May 2018 07:26:28 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH 4/4] arch/x86_64: Add 5-level paging support
Date: Mon, 7 May 2018 07:22:24 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE011A760E@BPXM01GP.gisp.nec.co.jp>
References: <20180302054841.22195-1-bhe@redhat.com>
 <20180302054841.22195-5-bhe@redhat.com>
In-Reply-To: <20180302054841.22195-5-bhe@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: "douly.fnst@cn.fujitsu.com" <douly.fnst@cn.fujitsu.com>, "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Keiichi Nakamura <kei-nakamura@vt.jp.nec.com>

Hi Baoquan,

Sorry for the late reply.

The patch looks good.


Thanks
Tachibana

> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Baoquan He
> Sent: Friday, March 02, 2018 2:49 PM
> To: kexec@lists.infradead.org
> Cc: douly.fnst@cn.fujitsu.com; indou.takao@jp.fujitsu.com; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>;
> Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>
> Subject: [PATCH 4/4] arch/x86_64: Add 5-level paging support
> 
> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
> 
> Now, kernel can use 5-level page tables in x86_64 system.
> 
> Add the 5-level paging support for makedumpfile.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  arch/x86_64.c  | 76 ++++++++++++++++++++++++++++++++++++++++++----------------
>  makedumpfile.h | 17 +++++++++++++
>  2 files changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index e88ee0b..b242f36 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -112,6 +112,8 @@ get_page_offset_x86_64(void)
> 
>  	if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
>  		info->page_offset = __PAGE_OFFSET_ORIG;
> +	} else if(check_5level_paging()) {
> +		info->page_offset = __PAGE_OFFSET_5LEVEL;
>  	} else {
>  		info->page_offset = __PAGE_OFFSET_2_6_27;
>  	}
> @@ -243,6 +245,8 @@ get_versiondep_info_x86_64(void)
>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
>  	else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
> +	else if(check_5level_paging())
> +		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
>  	else
>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
> 
> @@ -252,6 +256,9 @@ get_versiondep_info_x86_64(void)
>  	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
>  		info->vmemmap_start = VMEMMAP_START_ORIG;
>  		info->vmemmap_end   = VMEMMAP_END_ORIG;
> +	} else if(check_5level_paging()) {
> +		info->vmemmap_start = VMEMMAP_START_5LEVEL;
> +		info->vmemmap_end   = VMEMMAP_END_5LEVEL;
>  	} else {
>  		info->vmemmap_start = VMEMMAP_START_2_6_31;
>  		info->vmemmap_end   = VMEMMAP_END_2_6_31;
> @@ -268,6 +275,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  {
>  	unsigned long page_dir, pgd, pud_paddr, pud_pte, pmd_paddr, pmd_pte;
>  	unsigned long pte_paddr, pte;
> +	unsigned long p4d_paddr, p4d_pte;
> 
>  	/*
>  	 * Get PGD.
> @@ -278,23 +286,56 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  		if (page_dir == NOT_PADDR)
>  			return NOT_PADDR;
>  	}
> -	page_dir += pgd_index(vaddr) * sizeof(unsigned long);
> -	if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> -		ERRMSG("Can't get pgd (page_dir:%lx).\n", page_dir);
> -		return NOT_PADDR;
> -	}
> -	if (info->vaddr_for_vtop == vaddr)
> -		MSG("  PGD : %16lx => %16lx\n", page_dir, pgd);
> 
> -	if (!(pgd & _PAGE_PRESENT)) {
> -		ERRMSG("Can't get a valid pgd.\n");
> -		return NOT_PADDR;
> +	if (check_5level_paging()) {
> +		page_dir += pgd5_index(vaddr) * sizeof(unsigned long);
> +		if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> +			ERRMSG("Can't get pgd (page_dir:%lx).\n", page_dir);
> +			return NOT_PADDR;
> +		}
> +		if (info->vaddr_for_vtop == vaddr)
> +			MSG("  PGD : %16lx => %16lx\n", page_dir, pgd);
> +
> +		if (!(pgd & _PAGE_PRESENT)) {
> +			ERRMSG("Can't get a valid pgd.\n");
> +			return NOT_PADDR;
> +		}
> +		/*
> +		 * Get P4D.
> +		 */
> +		p4d_paddr  = pgd & ENTRY_MASK;
> +		p4d_paddr += p4d_index(vaddr) * sizeof(unsigned long);
> +		if (!readmem(PADDR, p4d_paddr, &p4d_pte, sizeof p4d_pte)) {
> +			ERRMSG("Can't get p4d_pte (p4d_paddr:%lx).\n", p4d_paddr);
> +			return NOT_PADDR;
> +		}
> +		if (info->vaddr_for_vtop == vaddr)
> +			MSG("  P4D : %16lx => %16lx\n", p4d_paddr, p4d_pte);
> +
> +		if (!(p4d_pte & _PAGE_PRESENT)) {
> +			ERRMSG("Can't get a valid p4d_pte.\n");
> +			return NOT_PADDR;
> +		}
> +		pud_paddr  = p4d_pte & ENTRY_MASK;
> +	}else {
> +		page_dir += pgd_index(vaddr) * sizeof(unsigned long);
> +		if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> +			ERRMSG("Can't get pgd (page_dir:%lx).\n", page_dir);
> +			return NOT_PADDR;
> +		}
> +		if (info->vaddr_for_vtop == vaddr)
> +			MSG("  PGD : %16lx => %16lx\n", page_dir, pgd);
> +
> +		if (!(pgd & _PAGE_PRESENT)) {
> +			ERRMSG("Can't get a valid pgd.\n");
> +			return NOT_PADDR;
> +		}
> +		pud_paddr  = pgd & ENTRY_MASK;
>  	}
> 
>  	/*
>  	 * Get PUD.
>  	 */
> -	pud_paddr  = pgd & ENTRY_MASK;
>  	pud_paddr += pud_index(vaddr) * sizeof(unsigned long);
>  	if (!readmem(PADDR, pud_paddr, &pud_pte, sizeof pud_pte)) {
>  		ERRMSG("Can't get pud_pte (pud_paddr:%lx).\n", pud_paddr);
> @@ -361,12 +402,7 @@ vtop4_x86_64(unsigned long vaddr)
>  	else if (SYMBOL(init_top_pgt) != NOT_FOUND_SYMBOL)
>  		init_level4_pgt = SYMBOL(init_top_pgt);
>  	else {
> -		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
> -		return NOT_PADDR;
> -	}
> -
> -	if (SYMBOL(level4_kernel_pgt) != NOT_FOUND_SYMBOL) {
> -		ERRMSG("Kernel is built with 5-level page tables\n");
> +		ERRMSG("Can't get the symbol of init_level4_pgt/init_top_pgt.\n");
>  		return NOT_PADDR;
>  	}
> 
> @@ -605,10 +641,6 @@ find_vmemmap_x86_64()
>  		return FAILED;
>  	}
> 
> -	if (SYMBOL(level4_kernel_pgt) != NOT_FOUND_SYMBOL) {
> -		ERRMSG("kernel is configured for 5-level page tables\n");
> -		return FAILED;
> -	}
>  	pagestructsize = size_table.page;
>  	hugepagesize = PTRS_PER_PMD * info->page_size;
>  	vaddr_base = info->vmemmap_start;
> @@ -630,12 +662,14 @@ find_vmemmap_x86_64()
>  	/* outer loop is for pud entries in the pgd */
>  	for (pgdindex = 0, pgdp = (unsigned long *)pgd_addr; pgdindex < num_puds;
>  								pgdindex++, pgdp++) {
> +
>  		/* read the pgd one word at a time, into pud_addr */
>  		if (!readmem(PADDR, (unsigned long long)pgdp, (void *)&pud_addr,
>  								sizeof(unsigned long))) {
>  			ERRMSG("Can't get pgd entry for slot %d.\n", pgd_index);
>  			return FAILED;
>  		}
> +
>  		/* mask the pgd entry for the address of the pud page */
>  		pud_addr &= PMASK;
>  		if (pud_addr == 0)
> diff --git a/makedumpfile.h b/makedumpfile.h
> index a0d1c13..d26c30b 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -581,16 +581,21 @@ unsigned long get_kvbase_arm64(void);
>  #ifdef __x86_64__
>  #define __PAGE_OFFSET_ORIG	(0xffff810000000000) /* 2.6.26, or former */
>  #define __PAGE_OFFSET_2_6_27	(0xffff880000000000) /* 2.6.27, or later  */
> +#define __PAGE_OFFSET_5LEVEL	(0xff10000000000000) /* 5-level page table */
> 
>  #define VMALLOC_START_ORIG	(0xffffc20000000000) /* 2.6.30, or former */
>  #define VMALLOC_START_2_6_31	(0xffffc90000000000) /* 2.6.31, or later  */
> +#define VMALLOC_START_5LEVEL	(0xffa0000000000000) /* 5-level page table */
>  #define VMALLOC_END_ORIG	(0xffffe1ffffffffff) /* 2.6.30, or former */
>  #define VMALLOC_END_2_6_31	(0xffffe8ffffffffff) /* 2.6.31, or later  */
> +#define VMALLOC_END_5LEVEL	(0xffd1ffffffffffff) /* 5-level page table */
> 
>  #define VMEMMAP_START_ORIG	(0xffffe20000000000) /* 2.6.30, or former */
>  #define VMEMMAP_START_2_6_31	(0xffffea0000000000) /* 2.6.31, or later  */
> +#define VMEMMAP_START_5LEVEL	(0xffd4000000000000) /* 5-level page table */
>  #define VMEMMAP_END_ORIG	(0xffffe2ffffffffff) /* 2.6.30, or former */
>  #define VMEMMAP_END_2_6_31	(0xffffeaffffffffff) /* 2.6.31, or later  */
> +#define VMEMMAP_END_5LEVEL	(0xffd5ffffffffffff) /* 5-level page table */
> 
>  #define __START_KERNEL_map	(0xffffffff80000000)
>  #define KVBASE			PAGE_OFFSET
> @@ -598,6 +603,7 @@ unsigned long get_kvbase_arm64(void);
>  #define _MAX_PHYSMEM_BITS_ORIG		(40)
>  #define _MAX_PHYSMEM_BITS_2_6_26	(44)
>  #define _MAX_PHYSMEM_BITS_2_6_31	(46)
> +#define _MAX_PHYSMEM_BITS_5LEVEL	(52)
> 
>  /*
>   * 4 Levels paging
> @@ -617,7 +623,18 @@ unsigned long get_kvbase_arm64(void);
>  #define PMD_SIZE		(1UL << PMD_SHIFT)
>  #define PMD_MASK		(~(PMD_SIZE - 1))
> 
> +/*
> + * 5 Levels paging
> + */
> +#define PGD_SHIFT_5LEVEL	(48)
> +#define P4D_SHIFT		(39)
> +
> +#define PTRS_PER_PGD_5LEVEL	(512)
> +#define PTRS_PER_P4D		(512)
> +
> +#define pgd5_index(address)  (((address) >> PGD_SHIFT_5LEVEL) & (PTRS_PER_PGD_5LEVEL - 1))
>  #define pgd_index(address)  (((address) >> PGD_SHIFT) & (PTRS_PER_PGD - 1))
> +#define p4d_index(address)  (((address) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
>  #define pud_index(address)  (((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
>  #define pmd_index(address)  (((address) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>  #define pte_index(address)  (((address) >> PTE_SHIFT) & (PTRS_PER_PTE - 1))
> --
> 2.13.6
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
