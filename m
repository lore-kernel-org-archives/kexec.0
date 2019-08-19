Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 19 Aug 2019 16:58:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 03/14] arm64, hibernate: add trans_table public
 functions
Message-ID: <20190819155824.GE9927@lakrids.cambridge.arm.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190817024629.26611-4-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, james.morse@arm.com, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Aug 16, 2019 at 10:46:18PM -0400, Pavel Tatashin wrote:
> trans_table_create_copy() and trans_table_map_page() are going to be
> the basis for public interface of new subsystem that handles page
> tables for cases which are between kernels: kexec, and hibernate.

While the architecture uses the term 'translation table', in the kernel
we generally use 'pgdir' or 'pgd' to refer to the tables, so please keep
to that naming scheme.

For example, in arch/arm64/mm/mmu.c we have a somewhat analagous
function called create_pgd_mapping() -- could we use that here, to crate
the mapping?

Thanks,
Mark.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/hibernate.c | 96 ++++++++++++++++++++++-------------
>  1 file changed, 61 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 96b6f8da7e49..449d69b5651c 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)
>  }
>  EXPORT_SYMBOL(arch_hibernation_header_restore);
>  
> -/*
> - * Copies length bytes, starting at src_start into an new page,
> - * perform cache maintentance, then maps it at the specified address low
> - * address as executable.
> - *
> - * This is used by hibernate to copy the code it needs to execute when
> - * overwriting the kernel text. This function generates a new set of page
> - * tables, which it loads into ttbr0.
> - *
> - * Length is provided as we probably only want 4K of data, even on a 64K
> - * page system.
> - */
> -static int create_safe_exec_page(void *src_start, size_t length,
> -				 unsigned long dst_addr,
> -				 phys_addr_t *phys_dst_addr)
> +int trans_table_map_page(pgd_t *trans_table, void *page,
> +			 unsigned long dst_addr,
> +			 pgprot_t pgprot)
>  {
> -	void *page = (void *)get_safe_page(GFP_ATOMIC);
> -	pgd_t *trans_table;
>  	pgd_t *pgdp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep;
>  
> -	if (!page)
> -		return -ENOMEM;
> -
> -	memcpy((void *)page, src_start, length);
> -	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> -
> -	trans_table = (void *)get_safe_page(GFP_ATOMIC);
> -	if (!trans_table)
> -		return -ENOMEM;
> -
>  	pgdp = pgd_offset_raw(trans_table, dst_addr);
>  	if (pgd_none(READ_ONCE(*pgdp))) {
>  		pudp = (void *)get_safe_page(GFP_ATOMIC);
> @@ -242,6 +218,44 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	ptep = pte_offset_kernel(pmdp, dst_addr);
>  	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
>  
> +	return 0;
> +}
> +
> +/*
> + * Copies length bytes, starting at src_start into an new page,
> + * perform cache maintentance, then maps it at the specified address low
> + * address as executable.
> + *
> + * This is used by hibernate to copy the code it needs to execute when
> + * overwriting the kernel text. This function generates a new set of page
> + * tables, which it loads into ttbr0.
> + *
> + * Length is provided as we probably only want 4K of data, even on a 64K
> + * page system.
> + */
> +static int create_safe_exec_page(void *src_start, size_t length,
> +				 unsigned long dst_addr,
> +				 phys_addr_t *phys_dst_addr)
> +{
> +	void *page = (void *)get_safe_page(GFP_ATOMIC);
> +	pgd_t *trans_table;
> +	int rc;
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	memcpy(page, src_start, length);
> +	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> +
> +	trans_table = (void *)get_safe_page(GFP_ATOMIC);
> +	if (!trans_table)
> +		return -ENOMEM;
> +
> +	rc = trans_table_map_page(trans_table, page, dst_addr,
> +				  PAGE_KERNEL_EXEC);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * Load our new page tables. A strict BBM approach requires that we
>  	 * ensure that TLBs are free of any entries that may overlap with the
> @@ -259,7 +273,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);
>  	isb();
>  
> -	*phys_dst_addr = virt_to_phys((void *)page);
> +	*phys_dst_addr = virt_to_phys(page);
>  
>  	return 0;
>  }
> @@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
>  	return 0;
>  }
>  
> +int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
> +			    unsigned long end)
> +{
> +	int rc;
> +	pgd_t *trans_table = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +
> +	if (!trans_table) {
> +		pr_err("Failed to allocate memory for temporary page tables.\n");
> +		return -ENOMEM;
> +	}
> +
> +	rc = copy_page_tables(trans_table, start, end);
> +	if (!rc)
> +		*dst_pgdp = trans_table;
> +
> +	return rc;
> +}
> +
>  /*
>   * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
>   *
> @@ -483,13 +515,7 @@ int swsusp_arch_resume(void)
>  	 * Create a second copy of just the linear map, and use this when
>  	 * restoring.
>  	 */
> -	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
> -	if (!tmp_pg_dir) {
> -		pr_err("Failed to allocate memory for temporary page tables.\n");
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, 0);
> +	rc = trans_table_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
>  	if (rc)
>  		goto out;
>  
> -- 
> 2.22.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
