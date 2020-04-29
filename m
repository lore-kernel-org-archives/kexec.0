Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 03/18] arm64: trans_pgd: make trans_pgd_map_page generic
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-4-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <c857d4aa-e8ec-81f6-bdea-dff6513c52dc@arm.com>
Date: Wed, 29 Apr 2020 18:01:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-4-pasha.tatashin@soleen.com>
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> kexec is going to use a different allocator, so make

> trans_pgd_map_page to accept allocator as an argument, and also
> kexec is going to use a different map protection, so also pass
> it via argument.

This trans_pgd_map_page() used to be create_single_mapping() It creates page tables that
map one page: the relocation code.

Why do you need a different pgprot? Surely PAGE_KERNEL_EXEC is exactly what you want.


> diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> index 23153c13d1ce..ad5194ad178d 100644
> --- a/arch/arm64/include/asm/trans_pgd.h
> +++ b/arch/arm64/include/asm/trans_pgd.h
> @@ -12,10 +12,24 @@
>  #include <linux/types.h>
>  #include <asm/pgtable-types.h>
>  
> +/*
> + * trans_alloc_page
> + *	- Allocator that should return exactly one zeroed page, if this
> + *	 allocator fails, trans_pgd returns -ENOMEM error.

trans_pgd is what you pass in to trans_pgd_map_page() or trans_pgd_create_copy().
Do you mean what those functions return?


> + *
> + * trans_alloc_arg
> + *	- Passed to trans_alloc_page as an argument
> + */

> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 3d6f0fd73591..607bb1fbc349 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -195,6 +200,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  				 unsigned long dst_addr,
>  				 phys_addr_t *phys_dst_addr)
>  {
> +	struct trans_pgd_info trans_info = {
> +		.trans_alloc_page	= hibernate_page_alloc,
> +		.trans_alloc_arg	= (void *)GFP_ATOMIC,
> +	};

As you need another copy of this in the next patch, is it worth declaring this globally
and making it const?


> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index d20e48520cef..275a79935d7e 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -180,8 +185,18 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
>  	return rc;
>  }
>  
> -int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
> -		       pgprot_t pgprot)
> +/*
> + * Add map entry to trans_pgd for a base-size page at PTE level.
> + * info:	contains allocator and its argument
> + * trans_pgd:	page table in which new map is added.
> + * page:	page to be mapped.

> + * dst_addr:	new VA address for the pages

~s/pages/page/

This thing only maps one page.


> + * pgprot:	protection for the page.
> + *
> + * Returns 0 on success, and -ENOMEM on failure.
> + */
> +int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> +		       void *page, unsigned long dst_addr, pgprot_t pgprot)
>  {
>  	pgd_t *pgdp;
>  	pud_t *pudp;



Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
