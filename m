Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFaUW-0005O4-K3
 for kexec@lists.infradead.org; Mon, 07 May 2018 07:23:43 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH 1/4] arch/x86_64: Cleanup the address translation of the
 4-level page tables
Date: Mon, 7 May 2018 07:19:45 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE011A75A8@BPXM01GP.gisp.nec.co.jp>
References: <20180302054841.22195-1-bhe@redhat.com>
 <20180302054841.22195-2-bhe@redhat.com>
In-Reply-To: <20180302054841.22195-2-bhe@redhat.com>
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


> +#define PUD_SIZE		(1UL << PUD_SHIFT)
> +#define PUD_MASK		(~(PUD_SHIFT - 1))
                        Is this (~(PUD_SIZE - 1)) ?
If so, I will correct this.

> +#define PMD_SIZE		(1UL << PMD_SHIFT)
> +#define PMD_MASK		(~(PMD_SIZE - 1))


Thanks
Tachibana


> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Baoquan He
> Sent: Friday, March 02, 2018 2:49 PM
> To: kexec@lists.infradead.org
> Cc: douly.fnst@cn.fujitsu.com; indou.takao@jp.fujitsu.com; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>;
> Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>
> Subject: [PATCH 1/4] arch/x86_64: Cleanup the address translation of the 4-level page tables
> 
> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
> 
> Due to the changing of 4-level page tables implementation in kernel, makedumpfile
> left behind some of the redundant macros. this make the translation not clear and
> hard to expand the code to support 5-level page tables.
> 
> Remove the PML4* and PGDIR_* and unify the macro to get the index of PGD.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  arch/x86_64.c  | 59 +++++++++++++++++++++++++++++++++++-----------------------
>  makedumpfile.h | 21 +++++++++------------
>  2 files changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index 1f24415..cbe45c2 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -257,7 +257,7 @@ get_versiondep_info_x86_64(void)
>  unsigned long long
>  __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  {
> -	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
> +	unsigned long page_dir, pgd, pud_paddr, pud_pte, pmd_paddr, pmd_pte;
>  	unsigned long pte_paddr, pte;
> 
>  	/*
> @@ -269,43 +269,43 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  		if (page_dir == NOT_PADDR)
>  			return NOT_PADDR;
>  	}
> -	page_dir += pml4_index(vaddr) * sizeof(unsigned long);
> -	if (!readmem(PADDR, page_dir, &pml4, sizeof pml4)) {
> -		ERRMSG("Can't get pml4 (page_dir:%lx).\n", page_dir);
> +	page_dir += pgd_index(vaddr) * sizeof(unsigned long);
> +	if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> +		ERRMSG("Can't get pgd (page_dir:%lx).\n", page_dir);
>  		return NOT_PADDR;
>  	}
>  	if (info->vaddr_for_vtop == vaddr)
> -		MSG("  PGD : %16lx => %16lx\n", page_dir, pml4);
> +		MSG("  PGD : %16lx => %16lx\n", page_dir, pgd);
> 
> -	if (!(pml4 & _PAGE_PRESENT)) {
> -		ERRMSG("Can't get a valid pml4.\n");
> +	if (!(pgd & _PAGE_PRESENT)) {
> +		ERRMSG("Can't get a valid pgd.\n");
>  		return NOT_PADDR;
>  	}
> 
>  	/*
>  	 * Get PUD.
>  	 */
> -	pgd_paddr  = pml4 & ENTRY_MASK;
> -	pgd_paddr += pgd_index(vaddr) * sizeof(unsigned long);
> -	if (!readmem(PADDR, pgd_paddr, &pgd_pte, sizeof pgd_pte)) {
> -		ERRMSG("Can't get pgd_pte (pgd_paddr:%lx).\n", pgd_paddr);
> +	pud_paddr  = pgd & ENTRY_MASK;
> +	pud_paddr += pud_index(vaddr) * sizeof(unsigned long);
> +	if (!readmem(PADDR, pud_paddr, &pud_pte, sizeof pud_pte)) {
> +		ERRMSG("Can't get pud_pte (pud_paddr:%lx).\n", pud_paddr);
>  		return NOT_PADDR;
>  	}
>  	if (info->vaddr_for_vtop == vaddr)
> -		MSG("  PUD : %16lx => %16lx\n", pgd_paddr, pgd_pte);
> +		MSG("  PUD : %16lx => %16lx\n", pud_paddr, pud_pte);
> 
> -	if (!(pgd_pte & _PAGE_PRESENT)) {
> -		ERRMSG("Can't get a valid pgd_pte.\n");
> +	if (!(pud_pte & _PAGE_PRESENT)) {
> +		ERRMSG("Can't get a valid pud_pte.\n");
>  		return NOT_PADDR;
>  	}
> -	if (pgd_pte & _PAGE_PSE)	/* 1GB pages */
> -		return (pgd_pte & ENTRY_MASK & PGDIR_MASK) +
> -			(vaddr & ~PGDIR_MASK);
> +	if (pud_pte & _PAGE_PSE)	/* 1GB pages */
> +		return (pud_pte & ENTRY_MASK & PUD_MASK) +
> +			(vaddr & ~PUD_MASK);
> 
>  	/*
>  	 * Get PMD.
>  	 */
> -	pmd_paddr  = pgd_pte & ENTRY_MASK;
> +	pmd_paddr  = pud_pte & ENTRY_MASK;
>  	pmd_paddr += pmd_index(vaddr) * sizeof(unsigned long);
>  	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
>  		ERRMSG("Can't get pmd_pte (pmd_paddr:%lx).\n", pmd_paddr);
> @@ -391,15 +391,22 @@ kvtop_xen_x86_64(unsigned long kvaddr)
> 
>  	if ((dirp = kvtop_xen_x86_64(SYMBOL(pgd_l4))) == NOT_PADDR)
>  		return NOT_PADDR;
> -	dirp += pml4_index(kvaddr) * sizeof(unsigned long long);
> +
> +	/*
> +	 * Get PGD.
> +	 */
> +	dirp += pgd_index(kvaddr) * sizeof(unsigned long long);
>  	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
>  		return NOT_PADDR;
> 
>  	if (!(entry & _PAGE_PRESENT))
>  		return NOT_PADDR;
> 
> +	/*
> +	 * Get PUD.
> +	 */
>  	dirp = entry & ENTRY_MASK;
> -	dirp += pgd_index(kvaddr) * sizeof(unsigned long long);
> +	dirp += pud_index(kvaddr) * sizeof(unsigned long long);
>  	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
>  		return NOT_PADDR;
> 
> @@ -407,9 +414,12 @@ kvtop_xen_x86_64(unsigned long kvaddr)
>  		return NOT_PADDR;
> 
>  	if (entry & _PAGE_PSE)		/* 1GB pages */
> -		return (entry & ENTRY_MASK & PGDIR_MASK) +
> -			(kvaddr & ~PGDIR_MASK);
> +		return (entry & ENTRY_MASK & PUD_MASK) +
> +			(kvaddr & ~PUD_MASK);
> 
> +	/*
> +	 * Get PMD.
> +	 */
>  	dirp = entry & ENTRY_MASK;
>  	dirp += pmd_index(kvaddr) * sizeof(unsigned long long);
>  	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
> @@ -422,6 +432,9 @@ kvtop_xen_x86_64(unsigned long kvaddr)
>  		return (entry & ENTRY_MASK & PMD_MASK) +
>  			(kvaddr & ~PMD_MASK);
> 
> +	/*
> +	 * Get PTE.
> +	 */
>  	dirp = entry & ENTRY_MASK;
>  	dirp += pte_index(kvaddr) * sizeof(unsigned long long);
>  	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
> @@ -596,7 +609,7 @@ find_vmemmap_x86_64()
>  	 * for max_paddr >> 12 page structures
>  	 */
>  	high_pfn = max_paddr >> 12;
> -	pgd_index = pgd4_index(vaddr_base);
> +	pgd_index = pgd_index(vaddr_base);
>  	pgd_addr = vaddr_to_paddr(init_level4_pgt); /* address of pgd */
>  	pgd_addr += pgd_index * sizeof(unsigned long);
>  	page_structs_per_pud = (PTRS_PER_PUD * PTRS_PER_PMD * info->page_size) /
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 01eece2..088dfc3 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -602,25 +602,22 @@ unsigned long get_kvbase_arm64(void);
>  /*
>   * 4 Levels paging
>   */
> -#define PML4_SHIFT		(39)
> -#define PTRS_PER_PML4		(512)
> -#define PGDIR_SHIFT		(30)
> -#define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
> -#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
> -#define PTRS_PER_PGD		(512)
>  #define PGD_SHIFT		(39)
>  #define PUD_SHIFT		(30)
>  #define PMD_SHIFT		(21)
> -#define PMD_SIZE		(1UL << PMD_SHIFT)
> -#define PMD_MASK		(~(PMD_SIZE - 1))
> +#define PTE_SHIFT		(12)
> +
> +#define PTRS_PER_PGD		(512)
>  #define PTRS_PER_PUD		(512)
>  #define PTRS_PER_PMD		(512)
>  #define PTRS_PER_PTE		(512)
> -#define PTE_SHIFT		(12)
> 
> -#define pml4_index(address) (((address) >> PML4_SHIFT) & (PTRS_PER_PML4 - 1))
> -#define pgd_index(address)  (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> -#define pgd4_index(address) (((address) >> PGD_SHIFT) & (PTRS_PER_PGD - 1))
> +#define PUD_SIZE		(1UL << PUD_SHIFT)
> +#define PUD_MASK		(~(PUD_SHIFT - 1))
> +#define PMD_SIZE		(1UL << PMD_SHIFT)
> +#define PMD_MASK		(~(PMD_SIZE - 1))
> +
> +#define pgd_index(address)  (((address) >> PGD_SHIFT) & (PTRS_PER_PGD - 1))
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
