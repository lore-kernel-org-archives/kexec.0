Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x233.google.com ([2607:f8b0:400e:c03::233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFALP-0002Ba-4Q
 for kexec@lists.infradead.org; Tue, 21 Jun 2016 01:19:13 +0000
Received: by mail-pa0-x233.google.com with SMTP id b13so653856pat.0
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 18:18:50 -0700 (PDT)
Date: Tue, 21 Jun 2016 10:23:42 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v19 06/13] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20160621012337.GV20774@linaro.org>
References: <cover.1466120418.git.geoff@infradead.org>
 <d0486ff8419e38844ecb524d0ac86ea81a6ec67d.1466120418.git.geoff@infradead.org>
 <576814AF.5060307@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <576814AF.5060307@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 20, 2016 at 05:07:11PM +0100, James Morse wrote:
> Hi,
> 
> On 17/06/16 00:48, Geoff Levand wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > On the startup of primary kernel, the memory region used by crash dump
> > kernel must be specified by "crashkernel=" kernel parameter.
> > reserve_crashkernel() will allocate and reserve the region for later use.
> > 
> > User space tools, like kexec-tools, will be able to find that region marked
> > as "Crash kernel" in /proc/iomem.
> 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index d45f862..45f1319 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/dma-contiguous.h>
> >  #include <linux/efi.h>
> >  #include <linux/swiotlb.h>
> > +#include <linux/kexec.h>
> >  
> >  #include <asm/boot.h>
> >  #include <asm/fixmap.h>
> > @@ -76,6 +77,65 @@ static int __init early_initrd(char *p)
> >  early_param("initrd", early_initrd);
> >  #endif
> >  
> > +#ifdef CONFIG_KEXEC_CORE
> > +/*
> > + * reserve_crashkernel() - reserves memory for crash kernel
> > + *
> > + * This function reserves memory area given in "crashkernel=" kernel command
> > + * line parameter. The memory reserved is used by dump capture kernel when
> > + * primary kernel is crashing.
> > + */
> > +static void __init reserve_crashkernel(void)
> > +{
> > +	unsigned long long crash_size = 0, crash_base = 0;
> > +	int ret;
> > +
> > +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > +				&crash_size, &crash_base);
> > +	/* no crashkernel= or invalid value specified */
> > +	if (!crash_size)
> > +		return;
> 
> Should we check ret too?

I thought that it was almost OK, but there is the only erroneous case,
"crashkernel=SIZE@". Will fix it.

> 
> > +
> > +	if (crash_base == 0) {
> > +		/* Current arm64 boot protocol requires 2MB alignment */
> > +		crash_base = memblock_find_in_range(0,
> > +				MEMBLOCK_ALLOC_ACCESSIBLE, crash_size, SZ_2M);
> > +		if (crash_base == 0) {
> > +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> > +				crash_size);
> > +			return;
> > +		}
> > +		memblock_reserve(crash_base, crash_size);
> 
> What if memblock_reserve() fails?

I don't think it fails because the region has been allocated
by memblock_find_in_range() just before.
> 
> > +
> > +	} else {
> > +		/* User specifies base address explicitly. */
> > +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> > +			memblock_is_region_reserved(crash_base, crash_size)) {
> > +			pr_warn("crashkernel has wrong address or size\n");
> > +			return;
> > +		}
> > +
> > +		if (IS_ALIGNED(crash_base, SZ_2M)) {
> 
> !IS_ALIGNED()...

Oops, will fix it.

> 
> > +			pr_warn("crashkernel base address is not 2MB aligned\n");
> > +			return;
> > +		}
> > +
> > +		memblock_reserve(crash_base, crash_size);
> 
> What if memblock_reserve() fails?

The region has been checked with memblock_is_region_reserved().

> 
> > +	}
> > +
> > +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > +		crash_size >> 20, crash_base >> 20);
> > +
> > +	crashk_res.start = crash_base;
> > +	crashk_res.end = crash_base + crash_size - 1;
> > +}
> > +#else
> > +static void __init reserve_crashkernel(void)
> > +{
> > +	;
> > +}
> > +#endif /* CONFIG_KEXEC_CORE */
> > +
> >  /*
> >   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
> >   * currently assumes that for memory starting above 4G, 32-bit devices will
> > @@ -291,6 +351,8 @@ void __init arm64_memblock_init(void)
> >  	}
> >  #endif
> >  
> > +	reserve_crashkernel();
> > +
> >  	early_init_fdt_scan_reserved_mem();
> >  
> >  	/* 4GB maximum for 32-bit only capable devices */
> > 
> 
> 
> With those,
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
