Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 15 Dec 2015 17:29:54 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v12 11/16] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20151215172953.GD353@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <bc962621bd537244b54fc35627a456ab40bc6d26.1448403503.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc962621bd537244b54fc35627a456ab40bc6d26.1448403503.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

On Tue, Nov 24, 2015 at 10:25:34PM +0000, Geoff Levand wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> On primary kernel, the memory region used by crash dump kernel must be
> specified by "crashkernel=" boot parameter. reserve_crashkernel()
> will allocate and reserve the region for later use.
> 
> User space tools will be able to find the region marked as "Crash kernel"
> in /proc/iomem.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/kernel/setup.c |  7 +++++-
>  arch/arm64/mm/init.c      | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 8119479..f9fffc9 100644
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
> @@ -221,6 +220,12 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  	}
> +
> +#ifdef CONFIG_KEXEC
> +	/* User space tools will find "Crash kernel" region in /proc/iomem. */
> +	if (crashk_res.end)
> +		insert_resource(&iomem_resource, &crashk_res);
> +#endif

Why can't this bit be moved into reserved_crashkernel, at the end?

>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 17bf39a..24f0a1c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -34,6 +34,7 @@
>  #include <linux/dma-contiguous.h>
>  #include <linux/efi.h>
>  #include <linux/swiotlb.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/fixmap.h>
>  #include <asm/memory.h>
> @@ -66,6 +67,55 @@ static int __init early_initrd(char *p)
>  early_param("initrd", early_initrd);
>  #endif
>  
> +#ifdef CONFIG_KEXEC
> +/*
> + * reserve_crashkernel() - reserves memory for crash kernel
> + *
> + * This function reserves memory area given in "crashkernel=" kernel command
> + * line parameter. The memory reserved is used by dump capture kernel when
> + * primary kernel is crashing.
> + */
> +static void __init reserve_crashkernel(void)
> +{
> +	unsigned long long crash_size = 0, crash_base = 0;
> +	int ret;
> +
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +				&crash_size, &crash_base);
> +	if (ret)
> +		return;

What's the point in ret?

> +
> +	if (crash_base == 0) {
> +		crash_base = memblock_alloc(crash_size, 1 << 21);

What is this magic number? How about SZ_2M and a comment mentioning the
arm64 boot protocol?

> +		if (crash_base == 0) {
> +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> +				crash_size);
> +			return;
> +		}
> +	} else {
> +		/* User specifies base address explicitly. */
> +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> +			memblock_is_region_reserved(crash_base, crash_size)) {
> +			pr_warn("crashkernel has wrong address or size\n");
> +			return;
> +		}
> +
> +		if (crash_base & ((1 << 21) - 1)) {

IS_ALIGNED

> +			pr_warn("crashkernel base address is not 2MB aligned\n");
> +			return;
> +		}
> +
> +		memblock_reserve(crash_base, crash_size);
> +	}
> +
> +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> +		crash_size >> 20, crash_base >> 20);
> +
> +	crashk_res.start = crash_base;
> +	crashk_res.end = crash_base + crash_size - 1;
> +}

#else

static void __init reserve_crashkernel(void) {};

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
