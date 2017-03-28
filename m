Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1csnkN-0002mZ-O4
 for kexec@lists.infradead.org; Tue, 28 Mar 2017 09:49:07 +0000
Received: by mail-it0-x22f.google.com with SMTP id 190so12333977itm.0
 for <kexec@lists.infradead.org>; Tue, 28 Mar 2017 02:48:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328065033.15966-2-takahiro.akashi@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065033.15966-2-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 28 Mar 2017 10:48:42 +0100
Message-ID: <CAKv+Gu-3tEu8LYv-jzn3G+LNcBff6fzPLF38nszx_botgD6_NA@mail.gmail.com>
Subject: Re: [PATCH v34 02/14] memblock: add memblock_cap_memory_range()
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
Cc: Mark Rutland <mark.rutland@arm.com>, Pratyush Anand <panand@redhat.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, James Morse <james.morse@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Sameer Goel <sgoel@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28 March 2017 at 07:50, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> Add memblock_cap_memory_range() which will remove all the memblock regions
> except the memory range specified in the arguments. In addition, rework is
> done on memblock_mem_limit_remove_map() to re-implement it using
> memblock_cap_memory_range().
>
> This function, like memblock_mem_limit_remove_map(), will not remove
> memblocks with MEMMAP_NOMAP attribute as they may be mapped and accessed
> later as "device memory."
> See the commit a571d4eb55d8 ("mm/memblock.c: add new infrastructure to
> address the mem limit issue").
>
> This function is used, in a succeeding patch in the series of arm64 kdump
> suuport, to limit the range of usable memory, or System RAM, on crash dump
> kernel.
> (Please note that "mem=" parameter is of little use for this purpose.)
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Dennis Chen <dennis.chen@arm.com>
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 44 +++++++++++++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index e82daffcfc44..4ce24a376262 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -336,6 +336,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> +void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
>  void memblock_mem_limit_remove_map(phys_addr_t limit);
>  bool memblock_is_memory(phys_addr_t addr);
>  int memblock_is_map_memory(phys_addr_t addr);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 2f4ca8104ea4..b049c9b2dba8 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1543,11 +1543,37 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
>                               (phys_addr_t)ULLONG_MAX);
>  }
>
> +void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
> +{
> +       int start_rgn, end_rgn;
> +       int i, ret;
> +
> +       if (!size)
> +               return;
> +
> +       ret = memblock_isolate_range(&memblock.memory, base, size,
> +                                               &start_rgn, &end_rgn);
> +       if (ret)
> +               return;
> +
> +       /* remove all the MAP regions */
> +       for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
> +               if (!memblock_is_nomap(&memblock.memory.regions[i]))
> +                       memblock_remove_region(&memblock.memory, i);
> +
> +       for (i = start_rgn - 1; i >= 0; i--)
> +               if (!memblock_is_nomap(&memblock.memory.regions[i]))
> +                       memblock_remove_region(&memblock.memory, i);
> +
> +       /* truncate the reserved regions */
> +       memblock_remove_range(&memblock.reserved, 0, base);
> +       memblock_remove_range(&memblock.reserved,
> +                       base + size, (phys_addr_t)ULLONG_MAX);
> +}
> +
>  void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>  {
> -       struct memblock_type *type = &memblock.memory;
>         phys_addr_t max_addr;
> -       int i, ret, start_rgn, end_rgn;
>
>         if (!limit)
>                 return;
> @@ -1558,19 +1584,7 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>         if (max_addr == (phys_addr_t)ULLONG_MAX)
>                 return;
>
> -       ret = memblock_isolate_range(type, max_addr, (phys_addr_t)ULLONG_MAX,
> -                               &start_rgn, &end_rgn);
> -       if (ret)
> -               return;
> -
> -       /* remove all the MAP regions above the limit */
> -       for (i = end_rgn - 1; i >= start_rgn; i--) {
> -               if (!memblock_is_nomap(&type->regions[i]))
> -                       memblock_remove_region(type, i);
> -       }
> -       /* truncate the reserved regions */
> -       memblock_remove_range(&memblock.reserved, max_addr,
> -                             (phys_addr_t)ULLONG_MAX);
> +       memblock_cap_memory_range(0, max_addr);
>  }
>
>  static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
> --
> 2.11.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
