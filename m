Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 1 Feb 2017 15:07:00 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v31 02/12] arm64: limit memory regions based on DT
 property, usable-memory-range
Message-ID: <20170201150700.GD4756@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170201124630.6016-1-takahiro.akashi@linaro.org>
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
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Feb 01, 2017 at 09:46:21PM +0900, AKASHI Takahiro wrote:
> +static int __init early_init_dt_scan_usablemem(unsigned long node,
> +		const char *uname, int depth, void *data)
> +{
> +	struct memblock_region *usablemem = (struct memblock_region *)data;

Nit: unnecessary cast.

> +	const __be32 *reg;
> +	int len;
> +
> +	usablemem->size = 0;

Could we please lift this assignment/initialisation into the caller...

> +
> +	if (depth != 1 || strcmp(uname, "chosen") != 0)
> +		return 0;
> +
> +	reg = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> +	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +		return 1;
> +
> +	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +
> +	return 1;
> +}
> +
> +static void __init fdt_enforce_memory_region(void)
> +{
> +	struct memblock_region reg;

... e.g. have:

	struct memblock_region reg = {
		.size = 0,
	};

That saves us from making unnecessary assignments to the size field, and
makes it clear that reg.size has definitely been initialised, regardless
of what of_scan_flat_dt() happens to do.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +
> +	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
> +
> +	if (reg.size)
> +		memblock_cap_memory_range(reg.base, reg.size);
> +}
> +
>  void __init arm64_memblock_init(void)
>  {
>  	const s64 linear_region_size = -(s64)PAGE_OFFSET;
>  
> +	/* Handle linux,usable-memory-range property */
> +	fdt_enforce_memory_region();
> +
>  	/*
>  	 * Ensure that the linear region takes up exactly half of the kernel
>  	 * virtual address space. This way, we can distinguish a linear address
> -- 
> 2.11.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
