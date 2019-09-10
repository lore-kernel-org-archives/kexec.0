Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v4 10/17] arm64: trans_pgd: make trans_pgd_map_page generic
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-11-pasha.tatashin@soleen.com>
From: Matthias Brugger <mbrugger@suse.com>
Message-ID: <60975350-87f8-56b3-437d-d9ee26ac3bd3@suse.com>
Date: Tue, 10 Sep 2019 10:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190909181221.309510-11-pasha.tatashin@soleen.com>
Content-Language: en-US
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com

Bikeshedding alarm, please see below.

On 09/09/2019 20:12, Pavel Tatashin wrote:
> kexec is going to use a different allocator, so make
> trans_pgd_map_page to accept allocator as an argument, and also
> kexec is going to use a different map protection, so also pass
> it via argument.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/trans_pgd.h | 24 ++++++++++++++++++++++--
>  arch/arm64/kernel/hibernate.c      | 12 +++++++++++-
>  arch/arm64/mm/trans_pgd.c          | 17 +++++++++++------
>  3 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> index c7b5402b7d87..53f67ec84cdc 100644
> --- a/arch/arm64/include/asm/trans_pgd.h
> +++ b/arch/arm64/include/asm/trans_pgd.h
> @@ -11,10 +11,30 @@
>  #include <linux/bits.h>
>  #include <asm/pgtable-types.h>
>  
> +/*
> + * trans_alloc_page
> + *	- Allocator that should return exactly one zeroed page, if this
> + *	 allocator fails, trans_pgd returns -ENOMEM error.
> + *
> + * trans_alloc_arg
> + *	- Passed to trans_alloc_page as an argument
> + */
> +
> +struct trans_pgd_info {
> +	void * (*trans_alloc_page)(void *arg);
> +	void *trans_alloc_arg;
> +};
> +
>  int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
>  			  unsigned long end);
>  
> -int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
> -		       pgprot_t pgprot);
> +/*
> + * Add map entry to trans_pgd for a base-size page at PTE level.
> + * page:	page to be mapped.
> + * dst_addr:	new VA address for the pages
> + * pgprot:	protection for the page.

For consistency please describe all function parameters. From my experience
function parameter description is normally done in the C-file that implements
the logic. Don't ask me why.

> + */
> +int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> +		       void *page, unsigned long dst_addr, pgprot_t pgprot);
>  
>  #endif /* _ASM_TRANS_TABLE_H */
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 94ede33bd777..9b75b680ab70 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -179,6 +179,12 @@ int arch_hibernation_header_restore(void *addr)
>  }
>  EXPORT_SYMBOL(arch_hibernation_header_restore);
>  
> +static void *
> +hibernate_page_alloc(void *arg)

AFAICS no new line needed here.

> +{
> +	return (void *)get_safe_page((gfp_t)(unsigned long)arg);
> +}
> +
>  /*
>   * Copies length bytes, starting at src_start into an new page,
>   * perform cache maintenance, then maps it at the specified address low
> @@ -195,6 +201,10 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  				 unsigned long dst_addr,
>  				 phys_addr_t *phys_dst_addr)
>  {
> +	struct trans_pgd_info trans_info = {
> +		.trans_alloc_page	= hibernate_page_alloc,
> +		.trans_alloc_arg	= (void *)GFP_ATOMIC,
> +	};

New line between end of struct and other variables.

With these changes:
Reviewed-by: Matthias Brugger <mbrugger@suse.com>

>  	void *page = (void *)get_safe_page(GFP_ATOMIC);
>  	pgd_t *trans_pgd;
>  	int rc;
> @@ -209,7 +219,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	if (!trans_pgd)
>  		return -ENOMEM;
>  
> -	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
> +	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
>  				PAGE_KERNEL_EXEC);
>  	if (rc)
>  		return rc;
> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index 5ac712b92439..7521d558a0b9 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -25,6 +25,11 @@
>  #include <linux/mm.h>
>  #include <linux/mmzone.h>
>  
> +static void *trans_alloc(struct trans_pgd_info *info)
> +{
> +	return info->trans_alloc_page(info->trans_alloc_arg);
> +}
> +
>  static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
>  {
>  	pte_t pte = READ_ONCE(*src_ptep);
> @@ -180,8 +185,8 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
>  	return rc;
>  }
>  
> -int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
> -		       pgprot_t pgprot)
> +int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> +		       void *page, unsigned long dst_addr, pgprot_t pgprot)
>  {
>  	pgd_t *pgdp;
>  	pud_t *pudp;
> @@ -190,7 +195,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
>  
>  	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
>  	if (pgd_none(READ_ONCE(*pgdp))) {
> -		pudp = (void *)get_safe_page(GFP_ATOMIC);
> +		pudp = trans_alloc(info);
>  		if (!pudp)
>  			return -ENOMEM;
>  		pgd_populate(&init_mm, pgdp, pudp);
> @@ -198,7 +203,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
>  
>  	pudp = pud_offset(pgdp, dst_addr);
>  	if (pud_none(READ_ONCE(*pudp))) {
> -		pmdp = (void *)get_safe_page(GFP_ATOMIC);
> +		pmdp = trans_alloc(info);
>  		if (!pmdp)
>  			return -ENOMEM;
>  		pud_populate(&init_mm, pudp, pmdp);
> @@ -206,14 +211,14 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
>  
>  	pmdp = pmd_offset(pudp, dst_addr);
>  	if (pmd_none(READ_ONCE(*pmdp))) {
> -		ptep = (void *)get_safe_page(GFP_ATOMIC);
> +		ptep = trans_alloc(info);
>  		if (!ptep)
>  			return -ENOMEM;
>  		pmd_populate_kernel(&init_mm, pmdp, ptep);
>  	}
>  
>  	ptep = pte_offset_kernel(pmdp, dst_addr);
> -	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
> +	set_pte(ptep, pfn_pte(virt_to_pfn(page), pgprot));
>  
>  	return 0;
>  }
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
