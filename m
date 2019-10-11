Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v6 08/17] arm64: hibernate: add trans_pgd public functions
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-9-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <2ea69969-154d-fa55-767d-43ea8971dd0e@arm.com>
Date: Fri, 11 Oct 2019 19:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191004185234.31471-9-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 04/10/2019 19:52, Pavel Tatashin wrote:
> trans_pgd_create_copy() and trans_pgd_map_page() are going to be
> the basis for new shared code that handles page tables for cases
> which are between kernels: kexec, and hibernate.
> 
> Note: Eventually, get_safe_page() will be moved into a function pointer
> passed via argument, but for now keep it as is.


> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index ce60bceed357..ded9034b9d39 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c

> @@ -242,6 +218,44 @@ static int create_safe_exec_page(void *src_start, size_t length,

> +/*
> + * Copies length bytes, starting at src_start into an new page,
> + * perform cache maintenance, then maps it at the specified address low
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
> +	pgd_t *trans_pgd;
> +	int rc;
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	memcpy(page, src_start, length);
> +	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> +
> +	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
> +	if (!trans_pgd)
> +		return -ENOMEM;
> +
> +	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
> +				PAGE_KERNEL_EXEC);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * Load our new page tables. A strict BBM approach requires that we
>  	 * ensure that TLBs are free of any entries that may overlap with the

(I suspect you are going to to duplicate this in the kexec code. Kexec has the same
pattern: instructions that have to be copied to do the relocation of the rest of memory)


> @@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,

> +int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> +			  unsigned long end)
> +{
> +	int rc;
> +	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +
> +	if (!trans_pgd) {
> +		pr_err("Failed to allocate memory for temporary page tables.\n");
> +		return -ENOMEM;
> +	}
> +
> +	rc = copy_page_tables(trans_pgd, start, end);
> +	if (!rc)
> +		*dst_pgdp = trans_pgd;

*dst_pgdp was already allocated in swsusp_arch_resume().


> +
> +	return rc;
> +}
> +
>  /*
>   * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
>   *
> @@ -488,7 +520,7 @@ int swsusp_arch_resume(void)
>  		pr_err("Failed to allocate memory for temporary page tables.\n");
>  		return -ENOMEM;
>  	}

If the allocation moves into 'trans_pgd_create_copy()', please move the code just above
here (cut off by the diff) that allocates it in swsusp_arch_resume().

Its actually okay to leak memory like this, hibernate's allocator acts as a memory pool.
It either gets freed if we fail to resume, or vanishes when the resumed kernel takes over.

Reviewed-by: James Morse <james.morse@arm.com>


> -	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, PAGE_END);
> +	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, PAGE_END);
>  	if (rc)
>  		return rc;


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
