Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqHma-00016b-9Y
 for kexec@lists.infradead.org; Tue, 21 Mar 2017 11:16:57 +0000
Received: by mail-io0-x22d.google.com with SMTP id z13so46451590iof.2
 for <kexec@lists.infradead.org>; Tue, 21 Mar 2017 04:16:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170315095941.25119-3-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-3-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 21 Mar 2017 11:16:34 +0000
Message-ID: <CAKv+Gu9mJxOci7sW5iJFWaSmQz4N3SJkh+qwcFZ3ZmUpVywZQg@mail.gmail.com>
Subject: Re: [PATCH v33 05/14] arm64: mm: allow for unmapping part of kernel
 mapping
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 15 March 2017 at 09:59, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> create_pgd_mapping() is enhanced here so that it will accept
> PAGE_KERNEL_INVALID protection attribute and unmap a given range of memory.
>
> The feature will be used in a later kdump patch to implement the protection
> against possible corruption of crash dump kernel memory which is to be set
> aside from ther other memory on primary kernel.
>
> Note that, in this implementation, it assumes that all the range of memory
> to be processed is mapped in page-level since the only current user is
> kdump where page mappings are also required.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Couldn't we use unmap_kernel_range() for this?

> ---
>  arch/arm64/include/asm/pgtable-prot.h |  1 +
>  arch/arm64/mm/mmu.c                   | 17 +++++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 2142c7726e76..945d84cd5df7 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -54,6 +54,7 @@
>  #define PAGE_KERNEL_ROX                __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
>  #define PAGE_KERNEL_EXEC       __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
>  #define PAGE_KERNEL_EXEC_CONT  __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
> +#define PAGE_KERNEL_INVALID    __pgprot(0)
>
>  #define PAGE_HYP               __pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
>  #define PAGE_HYP_EXEC          __pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d28dbcf596b6..cb359a3927ef 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -128,7 +128,10 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>         do {
>                 pte_t old_pte = *pte;
>
> -               set_pte(pte, pfn_pte(pfn, prot));
> +               if (pgprot_val(prot))
> +                       set_pte(pte, pfn_pte(pfn, prot));
> +               else
> +                       pte_clear(null, null, pte);
>                 pfn++;
>
>                 /*
> @@ -309,12 +312,14 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>         __create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, false);
>  }
>
> -void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> -                              unsigned long virt, phys_addr_t size,
> -                              pgprot_t prot, bool page_mappings_only)
> +/*
> + * Note that PAGE_KERNEL_INVALID should be used with page_mappings_only
> + * true for now.
> + */
> +void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> +                       unsigned long virt, phys_addr_t size,
> +                       pgprot_t prot, bool page_mappings_only)
>  {
> -       BUG_ON(mm == &init_mm);
> -
>         __create_pgd_mapping(mm->pgd, phys, virt, size, prot,
>                              pgd_pgtable_alloc, page_mappings_only);
>  }
> --
> 2.11.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
