Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqho6-0006S7-F9
 for kexec@lists.infradead.org; Mon, 04 Feb 2019 17:13:20 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v3] Remove the memory encryption mask to obtain the true
 physical address
Date: Mon, 4 Feb 2019 17:12:02 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03567B03@BPXM09GP.gisp.nec.co.jp>
References: <20190130024853.28586-1-lijiang@redhat.com>
In-Reply-To: <20190130024853.28586-1-lijiang@redhat.com>
Content-Language: en-US
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
To: Lianbo Jiang <lijiang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "anderson@redhat.com" <anderson@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>

> [PATCH v3] Remove the memory encryption mask to obtain the true physical address

I forgot to comment on the subject and the commit log..
I'll change this to

  x86_64: Add support for AMD Secure Memory Encryption

On 1/29/2019 9:48 PM, Lianbo Jiang wrote:
> For AMD machine with SME feature, if SME is enabled in the first
> kernel, the crashed kernel's page table(pgd/pud/pmd/pte) contains
> the memory encryption mask, so makedumpfile needs to remove the
> memory encryption mask to obtain the true physical address.

I added a few official words from some documents:
---
On AMD machine with Secure Memory Encryption (SME) feature, if SME is
enabled, page tables contain a specific attribute bit (C-bit) in their
entries to indicate whether a page is encrypted or unencrypted.

So get NUMBER(sme_mask) from vmcoreinfo, which stores the value of
the C-bit position, and drop it to obtain the true physical address.
---

If these are OK, I'll modify them when merging, so you don't need
to repost.

And, I'm thinking to merge this after the kernel patch gets merged
into the mainline.

Thanks for your work.
Kazu

> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> Changes since v1:
> 1. Merge them into a patch.
> 2. The sme_mask is not an enum number, remove it.
> 3. Sanity check whether the sme_mask is in vmcoreinfo.
> 4. Deal with the huge pages case.
> 5. Cover the 5-level path.
> 
> Changes since v2:
> 1. Change the sme_me_mask to entry_mask.
> 2. No need to remove the mask when makedumpfile prints out the
>    value of the entry.
> 3. Remove the sme mask from the pte at the end of the __vtop4_x86_64().
> 4. Also need to remove the sme mask from page table entry in
>    find_vmemmap_x86_64()
> 
>  arch/x86_64.c  | 30 +++++++++++++++++++-----------
>  makedumpfile.c |  4 ++++
>  makedumpfile.h |  1 +
>  3 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index 537fb78..9977466 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -291,6 +291,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  	unsigned long page_dir, pgd, pud_paddr, pud_pte, pmd_paddr, pmd_pte;
>  	unsigned long pte_paddr, pte;
>  	unsigned long p4d_paddr, p4d_pte;
> +	unsigned long entry_mask = ENTRY_MASK;
> 
>  	/*
>  	 * Get PGD.
> @@ -302,6 +303,9 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  			return NOT_PADDR;
>  	}
> 
> +	if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
> +		entry_mask &= ~(NUMBER(sme_mask));
> +
>  	if (check_5level_paging()) {
>  		page_dir += pgd5_index(vaddr) * sizeof(unsigned long);
>  		if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> @@ -318,7 +322,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  		/*
>  		 * Get P4D.
>  		 */
> -		p4d_paddr  = pgd & ENTRY_MASK;
> +		p4d_paddr  = pgd & entry_mask;
>  		p4d_paddr += p4d_index(vaddr) * sizeof(unsigned long);
>  		if (!readmem(PADDR, p4d_paddr, &p4d_pte, sizeof p4d_pte)) {
>  			ERRMSG("Can't get p4d_pte (p4d_paddr:%lx).\n", p4d_paddr);
> @@ -331,7 +335,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  			ERRMSG("Can't get a valid p4d_pte.\n");
>  			return NOT_PADDR;
>  		}
> -		pud_paddr  = p4d_pte & ENTRY_MASK;
> +		pud_paddr  = p4d_pte & entry_mask;
>  	}else {
>  		page_dir += pgd_index(vaddr) * sizeof(unsigned long);
>  		if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> @@ -345,7 +349,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  			ERRMSG("Can't get a valid pgd.\n");
>  			return NOT_PADDR;
>  		}
> -		pud_paddr  = pgd & ENTRY_MASK;
> +		pud_paddr  = pgd & entry_mask;
>  	}
> 
>  	/*
> @@ -364,13 +368,13 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  		return NOT_PADDR;
>  	}
>  	if (pud_pte & _PAGE_PSE)	/* 1GB pages */
> -		return (pud_pte & ENTRY_MASK & PUD_MASK) +
> +		return (pud_pte & entry_mask & PUD_MASK) +
>  			(vaddr & ~PUD_MASK);
> 
>  	/*
>  	 * Get PMD.
>  	 */
> -	pmd_paddr  = pud_pte & ENTRY_MASK;
> +	pmd_paddr  = pud_pte & entry_mask;
>  	pmd_paddr += pmd_index(vaddr) * sizeof(unsigned long);
>  	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
>  		ERRMSG("Can't get pmd_pte (pmd_paddr:%lx).\n", pmd_paddr);
> @@ -384,13 +388,13 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  		return NOT_PADDR;
>  	}
>  	if (pmd_pte & _PAGE_PSE)	/* 2MB pages */
> -		return (pmd_pte & ENTRY_MASK & PMD_MASK) +
> +		return (pmd_pte & entry_mask & PMD_MASK) +
>  			(vaddr & ~PMD_MASK);
> 
>  	/*
>  	 * Get PTE.
>  	 */
> -	pte_paddr  = pmd_pte & ENTRY_MASK;
> +	pte_paddr  = pmd_pte & entry_mask;
>  	pte_paddr += pte_index(vaddr) * sizeof(unsigned long);
>  	if (!readmem(PADDR, pte_paddr, &pte, sizeof pte)) {
>  		ERRMSG("Can't get pte (pte_paddr:%lx).\n", pte_paddr);
> @@ -403,7 +407,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  		ERRMSG("Can't get a valid pte.\n");
>  		return NOT_PADDR;
>  	}
> -	return (pte & ENTRY_MASK) + PAGEOFFSET(vaddr);
> +	return (pte & entry_mask) + PAGEOFFSET(vaddr);
>  }
> 
>  unsigned long long
> @@ -636,6 +640,7 @@ find_vmemmap_x86_64()
>  	unsigned long pmd, tpfn;
>  	unsigned long pvaddr = 0;
>  	unsigned long data_addr = 0, last_data_addr = 0, start_data_addr = 0;
> +	unsigned long pmask = PMASK;
>  	/*
>  	 * data_addr is the paddr of the page holding the page structs.
>  	 * We keep lists of contiguous pages and the pfn's that their
> @@ -656,6 +661,9 @@ find_vmemmap_x86_64()
>  		return FAILED;
>  	}
> 
> +	if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
> +		pmask &= ~(NUMBER(sme_mask));
> +
>  	pagestructsize = size_table.page;
>  	hugepagesize = PTRS_PER_PMD * info->page_size;
>  	vaddr_base = info->vmemmap_start;
> @@ -686,7 +694,7 @@ find_vmemmap_x86_64()
>  		}
> 
>  		/* mask the pgd entry for the address of the pud page */
> -		pud_addr &= PMASK;
> +		pud_addr &= pmask;
>  		if (pud_addr == 0)
>  			  continue;
>  		/* read the entire pud page */
> @@ -699,7 +707,7 @@ find_vmemmap_x86_64()
>  		/* pudp points to an entry in the pud page */
>  		for (pudp = (unsigned long *)pud_page, pudindex = 0;
>  					pudindex < PTRS_PER_PUD; pudindex++, pudp++) {
> -			pmd_addr = *pudp & PMASK;
> +			pmd_addr = *pudp & pmask;
>  			/* read the entire pmd page */
>  			if (pmd_addr == 0)
>  				continue;
> @@ -741,7 +749,7 @@ find_vmemmap_x86_64()
>  				 * - we discontiguous page is a string of valids
>  				 */
>  				if (pmd) {
> -					data_addr = (pmd & PMASK);
> +					data_addr = (pmd & pmask);
>  					if (start_range) {
>  						/* first-time kludge */
>  						start_data_addr = data_addr;
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 8923538..2237eb8 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -977,6 +977,8 @@ next_page:
>  	read_size = MIN(info->page_size - PAGEOFFSET(paddr), size);
> 
>  	pgaddr = PAGEBASE(paddr);
> +	if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
> +		pgaddr = pgaddr & ~(NUMBER(sme_mask));
>  	pgbuf = cache_search(pgaddr, read_size);
>  	if (!pgbuf) {
>  		++cache_miss;
> @@ -2276,6 +2278,7 @@ write_vmcoreinfo_data(void)
>  	WRITE_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
>  	WRITE_NUMBER("N_ONLINE", N_ONLINE);
>  	WRITE_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);
> +	WRITE_NUMBER("sme_mask", sme_mask);
> 
>  	WRITE_NUMBER("PG_lru", PG_lru);
>  	WRITE_NUMBER("PG_private", PG_private);
> @@ -2672,6 +2675,7 @@ read_vmcoreinfo(void)
>  	READ_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
>  	READ_NUMBER("N_ONLINE", N_ONLINE);
>  	READ_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);
> +	READ_NUMBER("sme_mask", sme_mask);
> 
>  	READ_NUMBER("PG_lru", PG_lru);
>  	READ_NUMBER("PG_private", PG_private);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 73813ed..e97b2e7 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1912,6 +1912,7 @@ struct number_table {
>  	long	NR_FREE_PAGES;
>  	long	N_ONLINE;
>  	long	pgtable_l5_enabled;
> +	long	sme_mask;
> 
>  	/*
>   	* Page flags
> --
> 2.17.1
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
