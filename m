Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 24 Feb 2021 16:04:08 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v14 08/11] arm64: kdump: reimplement crashkernel=X
Message-ID: <20210224160408.GC28965@arm.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-9-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210130071025.65258-9-chenzhou10@huawei.com>
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, rppt@kernel.org, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Sat, Jan 30, 2021 at 03:10:22PM +0800, Chen Zhou wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 
> To solve these issues, change the behavior of crashkernel=X and
> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
> in DMA zone, and fall back to high allocation if it fails.
> We can also use "crashkernel=X,high" to select a region above DMA zone,
> which also tries to allocate at least 256M in DMA zone automatically.
> "crashkernel=Y,low" can be used to allocate specified size low memory.
> 
> Another minor change, there may be two regions reserved for crash
> dump kernel, in order to distinct from the high region and make no
> effect to the use of existing kexec-tools, rename the low region as
> "Crash kernel (low)".

I think we discussed this but I don't remember the conclusion. Is this
only renamed conditionally so that we don't break current kexec-tools?

IOW, assuming that the full crashkernel region is reserved below 4GB,
does the "(low)" suffix still appear or it's only if a high region is
additionally reserved?

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 3f6ecae0bc68..f0caed0cb5e1 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -96,6 +96,10 @@ static inline void crash_prepare_suspend(void) {}
>  static inline void crash_post_resume(void) {}
>  #endif
>  
> +#ifdef CONFIG_KEXEC_CORE
> +extern void __init reserve_crashkernel(void);
> +#endif

Why not have this in some generic header?

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index c18aacde8bb0..69c592c546de 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -238,7 +238,18 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		/*
> +		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
> +		 * region in /proc/iomem.
> +		 * In order to distinct from the high region and make no effect
> +		 * to the use of existing kexec-tools, rename the low region as
> +		 * "Crash kernel (low)".
> +		 */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +				crashk_low_res.end <= res->end) {
> +			crashk_low_res.name = "Crash kernel (low)";
> +			request_resource(res, &crashk_low_res);
> +		}
>  		if (crashk_res.end && crashk_res.start >= res->start &&
>  		    crashk_res.end <= res->end)
>  			request_resource(res, &crashk_res);

My reading of the new generic reserve_crashkernel() is that
crashk_low_res will only be populated if crask_res is above 4GB. If
that's correct, I'm fine with the renaming here since current systems
would not get a renamed low reservation (as long as they don't change
the kernel cmdline).

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 912f64f505f7..d20f5c444ebf 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -35,6 +35,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/kasan.h>
>  #include <asm/kernel-pgtable.h>
> +#include <asm/kexec.h>
>  #include <asm/memory.h>
>  #include <asm/numa.h>
>  #include <asm/sections.h>
> @@ -61,66 +62,11 @@ EXPORT_SYMBOL(memstart_addr);
>   */
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  
> -#ifdef CONFIG_KEXEC_CORE
> -/*
> - * reserve_crashkernel() - reserves memory for crash kernel
> - *
> - * This function reserves memory area given in "crashkernel=" kernel command
> - * line parameter. The memory reserved is used by dump capture kernel when
> - * primary kernel is crashing.
> - */
> +#ifndef CONFIG_KEXEC_CORE
>  static void __init reserve_crashkernel(void)
>  {
[...]
>  }
> +#endif

Can we not have the dummy reserve_crashkernel() in the generic code as
well and avoid the #ifndef here?

>  #ifdef CONFIG_CRASH_DUMP
>  static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
> @@ -446,6 +392,14 @@ void __init bootmem_init(void)
>  	 * reserved, so do it here.
>  	 */
>  	reserve_crashkernel();
> +#ifdef CONFIG_KEXEC_CORE
> +	/*
> +	 * The low region is intended to be used for crash dump kernel devices,
> +	 * just mark the low region as "nomap" simply.
> +	 */
> +	if (crashk_low_res.end)
> +		memblock_mark_nomap(crashk_low_res.start, resource_size(&crashk_low_res));
> +#endif

Do we do something similar for crashk_res?

Also, I can see we call crash_exclude_mem_range() only for crashk_res.
Do we need to do this for crashk_low_res as well?

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
