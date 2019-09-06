Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 06/17] arm64, hibernate: add trans_pgd public functions
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-7-pasha.tatashin@soleen.com>
Message-ID: <bcc3f71f-97d2-dff4-c55a-4798c6e2bede@arm.com>
Date: Fri, 6 Sep 2019 16:18:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-7-pasha.tatashin@soleen.com>
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

On 21/08/2019 19:31, Pavel Tatashin wrote:
> trans_pgd_create_copy() and trans_pgd_map_page() are going to be
> the basis for public interface of new subsystem that handles page

Please don't call this a subsystem. 'sound' and 'mm' are subsystems, this is just some
shared code.

> tables for cases which are between kernels: kexec, and hibernate.

Even though you've baked the get_safe_page() calls into trans_pgd_map_page()?


> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 750ecc7f2cbe..2e29d620b56c 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)

> +int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
> +		       unsigned long dst_addr,
> +		       pgprot_t pgprot)

If this thing is going to be exposed, its name should reflect that its creating a set of
page tables, to map a single page.

A function called 'map_page' with this prototype should 'obviously' map @page at @dst_addr
in @trans_pgd using the provided @pgprot... but it doesn't.

This is what 'create' was doing in the old name, if that wasn't obvious, its because
naming things is hard!
| trans_create_single_page_mapping()?

(might be too verbose)

I think this bites you in patch 8, where you 'generalise' this.


>  {
> -	void *page = (void *)get_safe_page(GFP_ATOMIC);
> -	pgd_t *trans_pgd;
>  	pgd_t *pgdp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep;
>  
> -	if (!page)
> -		return -ENOMEM;
> -
> -	memcpy(page, src_start, length);
> -	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> -
> -	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
> -	if (!trans_pgd)
> -		return -ENOMEM;
> -
>  	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
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

Could you fix the spelling of maintenance as git thinks you've moved it?


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


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
