From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 26 Apr 2022 15:26:28 +0100
Subject: [PATCH v22 4/9] arm64: kdump: Don't force page-level mappings
 for memory above 4G
In-Reply-To: <20220414115720.1887-5-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-5-thunder.leizhen@huawei.com>
Message-ID: <YmgBFPMbyyOH/52y@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Apr 14, 2022 at 07:57:15PM +0800, Zhen Lei wrote:
> @@ -540,13 +540,31 @@ static void __init map_mem(pgd_t *pgdp)
>  	for_each_mem_range(i, &start, &end) {
>  		if (start >= end)
>  			break;
> +
> +#ifdef CONFIG_KEXEC_CORE
> +		if (eflags && (end >= SZ_4G)) {
> +			/*
> +			 * The memory block cross the 4G boundary.
> +			 * Forcibly use page-level mappings for memory under 4G.
> +			 */
> +			if (start < SZ_4G) {
> +				__map_memblock(pgdp, start, SZ_4G - 1,
> +					       pgprot_tagged(PAGE_KERNEL), flags | eflags);
> +				start  = SZ_4G;
> +			}
> +
> +			/* Page-level mappings is not mandatory for memory above 4G */
> +			eflags = 0;
> +		}
> +#endif

That's a bit tricky if a SoC has all RAM above 4G. IIRC AMD Seattle had
this layout. See max_zone_phys() for how we deal with this, basically
extending ZONE_DMA to the whole range if RAM starts above 4GB. In that
case, crashkernel reservation would fall in the range above 4GB.

BTW, we changed the max_zone_phys() logic with commit 791ab8b2e3db
("arm64: Ignore any DMA offsets in the max_zone_phys() calculation").

-- 
Catalin

