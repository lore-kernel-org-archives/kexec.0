Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <58D10209.1090406@arm.com>
Date: Tue, 21 Mar 2017 10:35:53 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v33 05/14] arm64: mm: allow for unmapping part of kernel
 mapping
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-3-takahiro.akashi@linaro.org>
In-Reply-To: <20170315095941.25119-3-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 15/03/17 09:59, AKASHI Takahiro wrote:
> create_pgd_mapping() is enhanced here so that it will accept
> PAGE_KERNEL_INVALID protection attribute and unmap a given range of memory.
> 
> The feature will be used in a later kdump patch to implement the protection
> against possible corruption of crash dump kernel memory which is to be set
> aside from ther other memory on primary kernel.

Nit: ther- > the

> Note that, in this implementation, it assumes that all the range of memory
> to be processed is mapped in page-level since the only current user is
> kdump where page mappings are also required.

Using create_pgd_mapping() like this means the mappings will be updated via the
fixmap which is unnecessary as the page tables will be part of mapped memory. In
the worst case this adds an extra tlbi for every 2MB of crash image when we map
or unmap it. I don't think this matters.

This code used to be __init and it is the only user of FIX_PTE, so there won't
be any existing runtime users. The two arch_kexec_unprotect_crashkres() calls in
kexec are both protected by the kexec_mutex, and the call in hibernate happens
after disable_nonboot_cpus(), so these callers can't race with each other.

This looks safe to me.


> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d28dbcf596b6..cb359a3927ef 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -128,7 +128,10 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  	do {
>  		pte_t old_pte = *pte;
>  
> -		set_pte(pte, pfn_pte(pfn, prot));
> +		if (pgprot_val(prot))
> +			set_pte(pte, pfn_pte(pfn, prot));
> +		else
> +			pte_clear(null, null, pte);

Lowercase NULLs? This relies on these values never being used... __set_fixmap()
in the same file passes &init_mm and the address, can we do the same to be
consistent?


>  		pfn++;
>  
>  		/*

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
