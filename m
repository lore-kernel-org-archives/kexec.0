Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3 12/17] arm64, trans_pgd: complete generalization of
 trans_pgds
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-13-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <d4a5bb7b-21c0-9f39-ad96-3fa43684c6c6@arm.com>
Date: Fri, 6 Sep 2019 16:23:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-13-pasha.tatashin@soleen.com>
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
> Make the last private functions in page table copy path generlized for use
> outside of hibernate.
> 
> Switch to use the provided allocator, flags, and source page table. Also,
> unify all copy function implementations to reduce the possibility of bugs.

By changing it? No one has reported any problems. We're more likely to break it making
unnecessary changes.

Why is this necessary?


> All page table levels are implemented symmetrically.


> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index efd42509d069..ccd9900f8edb 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -27,139 +27,157 @@ static void *trans_alloc(struct trans_pgd_info *info)

> -static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
> +static int copy_pte(struct trans_pgd_info *info, pte_t *dst_ptep,
> +		    pte_t *src_ptep, unsigned long start, unsigned long end)
>  {
> -	pte_t pte = READ_ONCE(*src_ptep);
> -
> -	if (pte_valid(pte)) {
> -		/*
> -		 * Resume will overwrite areas that may be marked
> -		 * read only (code, rodata). Clear the RDONLY bit from
> -		 * the temporary mappings we use during restore.
> -		 */
> -		set_pte(dst_ptep, pte_mkwrite(pte));
> -	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
> -		/*
> -		 * debug_pagealloc will removed the PTE_VALID bit if
> -		 * the page isn't in use by the resume kernel. It may have
> -		 * been in use by the original kernel, in which case we need
> -		 * to put it back in our copy to do the restore.
> -		 *
> -		 * Before marking this entry valid, check the pfn should
> -		 * be mapped.
> -		 */
> -		BUG_ON(!pfn_valid(pte_pfn(pte)));
> -
> -		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite(pte)));
> -	}
> -}

> -static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
> -		    unsigned long end)
> -{
> -	pte_t *src_ptep;
> -	pte_t *dst_ptep;
>  	unsigned long addr = start;
> +	int i = pte_index(addr);
>  
> -	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
> -	if (!dst_ptep)
> -		return -ENOMEM;
> -	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
> -	dst_ptep = pte_offset_kernel(dst_pmdp, start);
> -
> -	src_ptep = pte_offset_kernel(src_pmdp, start);
>  	do {
> -		_copy_pte(dst_ptep, src_ptep, addr);
> -	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr != end);
> +		pte_t src_pte = READ_ONCE(src_ptep[i]);
> +
> +		if (pte_none(src_pte))
> +			continue;

> +		if (info->trans_flags & TRANS_MKWRITE)
> +			src_pte = pte_mkwrite(src_pte);

This should be unconditional. The purpose of this thing is to create a set of page tables
you can use to overwrite all of memory. Why would you want to keep the RDONLY flag for
normal memory?


> +		if (info->trans_flags & TRANS_MKVALID)
> +			src_pte = pte_mkpresent(src_pte);
> +		if (info->trans_flags & TRANS_CHECKPFN) {
> +			if (!pfn_valid(pte_pfn(src_pte)))
> +				return -ENXIO;
> +		}

This lets you skip the pfn_valid() check if you want to create bogus mappings. This should
not be conditional.
This removes the BUG_ON(), which is there to make sure we stop if we find page-table
corruption.

Please keep the shape of _copy_pte() as it is. Putting a different mapping in the copied
tables is risky, the code that does it should all be in one place, along with the
justification of why its doing this. Anything else is harder to debug when it goes wrong.


> +		set_pte(&dst_ptep[i], src_pte);
> +	} while (addr += PAGE_SIZE, i++, addr != end && i < PTRS_PER_PTE);

Incrementing pte/pud/pmg/pgd pointers is a common pattern in the kernel's page table
walkers. Why do we need to change this to index it like an array?

This needs to look like walk_page_range() as the eventual aim is to remove it, and use the
core-code page table walker.

(at the time it was merged the core-code page table walker removed block mappings it
didn't like, which didn't go well.)

This is a backwards step as it makes any attempt to remove this arch-specific walker harder.


>  
>  	return 0;
>  }



Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
