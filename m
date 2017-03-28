Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1csno2-0005dl-Bq
 for kexec@lists.infradead.org; Tue, 28 Mar 2017 09:52:52 +0000
Received: by mail-it0-x233.google.com with SMTP id y18so12425637itc.1
 for <kexec@lists.infradead.org>; Tue, 28 Mar 2017 02:52:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328065130.16019-2-takahiro.akashi@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 28 Mar 2017 10:52:29 +0100
Message-ID: <CAKv+Gu9ut2gRx-Vbo=Vn0GEJM9icivUXnapHgBV+dC8Qm0JwUA@mail.gmail.com>
Subject: Re: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
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
Cc: Mark Rutland <mark.rutland@arm.com>, Pratyush Anand <panand@redhat.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Sameer Goel <sgoel@codeaurora.org>, Dave Young <dyoung@redhat.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28 March 2017 at 07:51, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> "crashkernel=" kernel parameter specifies the size (and optionally
> the start address) of the system ram to be used by crash dump kernel.
> reserve_crashkernel() will allocate and reserve that memory at boot time
> of primary kernel.
>
> The memory range will be exposed to userspace as a resource named
> "Crash kernel" in /proc/iomem.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/setup.c |  7 ++++-
>  arch/arm64/mm/init.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 42274bda0ccb..28855ec1be95 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -31,7 +31,6 @@
>  #include <linux/screen_info.h>
>  #include <linux/init.h>
>  #include <linux/kexec.h>
> -#include <linux/crash_dump.h>
>  #include <linux/root_dev.h>
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
> @@ -226,6 +225,12 @@ static void __init request_standard_resources(void)
>                 if (kernel_data.start >= res->start &&
>                     kernel_data.end <= res->end)
>                         request_resource(res, &kernel_data);
> +#ifdef CONFIG_KEXEC_CORE
> +               /* Userspace will find "Crash kernel" region in /proc/iomem. */
> +               if (crashk_res.end && crashk_res.start >= res->start &&
> +                   crashk_res.end <= res->end)
> +                       request_resource(res, &crashk_res);
> +#endif
>         }
>  }
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 290794b1a0f1..09d19207362d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -30,6 +30,7 @@
>  #include <linux/gfp.h>
>  #include <linux/memblock.h>
>  #include <linux/sort.h>
> +#include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dma-contiguous.h>
> @@ -37,6 +38,7 @@
>  #include <linux/swiotlb.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
> +#include <linux/kexec.h>
>
>  #include <asm/boot.h>
>  #include <asm/fixmap.h>
> @@ -77,6 +79,67 @@ static int __init early_initrd(char *p)
>  early_param("initrd", early_initrd);
>  #endif
>
> +#ifdef CONFIG_KEXEC_CORE
> +/*
> + * reserve_crashkernel() - reserves memory for crash kernel
> + *
> + * This function reserves memory area given in "crashkernel=" kernel command
> + * line parameter. The memory reserved is used by dump capture kernel when
> + * primary kernel is crashing.
> + */
> +static void __init reserve_crashkernel(void)
> +{
> +       unsigned long long crash_base, crash_size;
> +       int ret;
> +
> +       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +                               &crash_size, &crash_base);
> +       /* no crashkernel= or invalid value specified */
> +       if (ret || !crash_size)
> +               return;
> +
> +       crash_size = PAGE_ALIGN(crash_size);
> +
> +       if (crash_base == 0) {
> +               /* Current arm64 boot protocol requires 2MB alignment */
> +               crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> +                               crash_size, SZ_2M);
> +               if (crash_base == 0) {
> +                       pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> +                               crash_size);
> +                       return;
> +               }
> +       } else {
> +               /* User specifies base address explicitly. */
> +               if (!memblock_is_region_memory(crash_base, crash_size)) {
> +                       pr_warn("cannot reserve crashkernel: region is not memory\n");
> +                       return;
> +               }
> +
> +               if (memblock_is_region_reserved(crash_base, crash_size)) {
> +                       pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
> +                       return;
> +               }
> +
> +               if (!IS_ALIGNED(crash_base, SZ_2M)) {
> +                       pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
> +                       return;
> +               }
> +       }
> +       memblock_reserve(crash_base, crash_size);
> +
> +       pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> +               crash_base, crash_base + crash_size, crash_size >> 20);
> +
> +       crashk_res.start = crash_base;
> +       crashk_res.end = crash_base + crash_size - 1;
> +}
> +#else
> +static void __init reserve_crashkernel(void)
> +{
> +}
> +#endif /* CONFIG_KEXEC_CORE */
> +
>  /*
>   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
>   * currently assumes that for memory starting above 4G, 32-bit devices will
> @@ -332,6 +395,9 @@ void __init arm64_memblock_init(void)
>                 arm64_dma_phys_limit = max_zone_dma_phys();
>         else
>                 arm64_dma_phys_limit = PHYS_MASK + 1;
> +
> +       reserve_crashkernel();
> +
>         dma_contiguous_reserve(arm64_dma_phys_limit);
>
>         memblock_allow_resize();
> --
> 2.11.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
