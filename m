Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 27 Jul 2020 18:30:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v10 4/5] arm64: kdump: fix kdump broken with ZONE_DMA
 reintroduced
Message-ID: <20200727173014.GL13938@gaia>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-5-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200703035816.31289-5-chenzhou10@huawei.com>
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
Cc: horms@verge.net.au, John.P.donnelly@oracle.com, xiexiuqi@huawei.com, arnd@arndb.de, bhe@redhat.com, corbet@lwn.net, dyoung@redhat.com, bhsharma@redhat.com, guohanjun@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, tglx@linutronix.de, will@kernel.org, nsaenzjulienne@suse.de

On Fri, Jul 03, 2020 at 11:58:15AM +0800, Chen Zhou wrote:
> commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> broken the arm64 kdump. If the memory reserved for crash dump kernel
> falled in ZONE_DMA32, the devices in crash dump kernel need to use
> ZONE_DMA will alloc fail.
> 
> This patch addressed the above issue based on "reserving crashkernel
> above 4G". Originally, we reserve low memory below 4G, and now just need
> to adjust memory limit to arm64_dma_phys_limit in reserve_crashkernel_low
> if ZONE_DMA is enabled. That is, if there are devices need to use ZONE_DMA
> in crash dump kernel, it is a good choice to use parameters
> "crashkernel=X crashkernel=Y,low".
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  kernel/crash_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a7580d291c37..e8ecbbc761a3 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -320,6 +320,7 @@ int __init reserve_crashkernel_low(void)
>  	unsigned long long base, low_base = 0, low_size = 0;
>  	unsigned long total_low_mem;
>  	int ret;
> +	phys_addr_t crash_max = 1ULL << 32;
>  
>  	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
>  
> @@ -352,7 +353,11 @@ int __init reserve_crashkernel_low(void)
>  			return 0;
>  	}
>  
> -	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> +#ifdef CONFIG_ARM64
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		crash_max = arm64_dma_phys_limit;
> +#endif
> +	low_base = memblock_find_in_range(0, crash_max, low_size, CRASH_ALIGN);
>  	if (!low_base) {
>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>  		       (unsigned long)(low_size >> 20));

Given the number of #ifdefs we end up with in this function, I think
it's better to simply copy to the code to arch/arm64 and tailor it
accordingly.

Anyway, there are two series solving slightly different issues with
kdump reservations:

1. This series which relaxes the crashkernel= allocation to go anywhere
   in the accessible space while having a dedicated crashkernel=X,low
   option for ZONE_DMA.

2. Bhupesh's series [1] forcing crashkernel=X allocations only from
   ZONE_DMA.

For RPi4 support, we limited ZONE_DMA allocations to the 1st GB.
Existing crashkernel= uses may no longer work, depending on where the
allocation falls. Option (2) above is a quick fix assuming that the
crashkernel reservation is small enough. What's a typical crashkernel
option here? That series is probably more prone to reservation failures.

Option (1), i.e. this series, doesn't solve the problem raised by
Bhupesh unless one uses the crashkernel=X,low argument. It can actually
make it worse even for ZONE_DMA32 since the allocation can go above 4G
(assuming that we change the ZONE_DMA configuration to only limit it to
1GB on RPi4).

I'm more inclined to keep the crashkernel= behaviour to ZONE_DMA
allocations. If this is too small for typical kdump, we can look into
expanding ZONE_DMA to 4G on non-RPi4 hardware (we had patches on the
list). In addition, if Chen thinks allocations above 4G are still needed
or if RPi4 needs a sufficiently large crashkernel=, I'd rather have a
",high" option to explicitly require such access.

[1] http://lists.infradead.org/pipermail/kexec/2020-July/020777.html

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
