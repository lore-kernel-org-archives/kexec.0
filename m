Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x230.google.com ([2607:f8b0:400e:c03::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1alWqx-0006tF-4R
 for kexec@lists.infradead.org; Thu, 31 Mar 2016 07:17:16 +0000
Received: by mail-pa0-x230.google.com with SMTP id tt10so60065451pab.3
 for <kexec@lists.infradead.org>; Thu, 31 Mar 2016 00:16:54 -0700 (PDT)
Date: Thu, 31 Mar 2016 16:19:03 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v15 15/20] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20160331071903.GB2267@linaro.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <1083d7e4a6285c39d2955fb99dc9fa4c345d00fa.1457977403.git.geoff@infradead.org>
 <56EC441E.2040606@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56EC441E.2040606@arm.com>
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

On Fri, Mar 18, 2016 at 06:08:30PM +0000, James Morse wrote:
> Hi!
> 
> On 14/03/16 17:48, Geoff Levand wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > On the startup of primary kernel, the memory region used by crash dump
> > kernel must be specified by "crashkernel=" kernel parameter.
> > reserve_crashkernel() will allocate and reserve the region for later use.
> > 
> > User space tools, like kexec-tools, will be able to find that region marked
> > as "Crash kernel" in /proc/iomem.
> 
> [NB: Re-ordered diff hunks ]
> 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 7802f21..4edf181 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -171,6 +229,8 @@ void __init arm64_memblock_init(void)
> >  		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
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
> This is 'nit' territory, but if you were to make this:
> >	if (IS_ENABLED(CONFIG_KEXEC_CORE))
> >		reserve_crashkernel();
> 
> then the #ifdefs around reserve_crashkernel() can go, and the compiler will work
> out that this static function can be optimised out. It also means the
> compiler performs its checks, even if CONFIG_KEXEC_CORE isn't selected. The same
> trick can be applied in patch 18 (around reserve_elfcorehdr()).

It will also make the code more understandable.

Thanks,
-Takahiro AKASHI

> > @@ -66,6 +67,63 @@ static int __init early_initrd(char *p)
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
> > +	if (ret)
> > +		return;
> > +
> > +	if (crash_base == 0) {
> > +		crash_base = memblock_find_in_range(0,
> > +				MEMBLOCK_ALLOC_ACCESSIBLE, crash_size, 1 << 21);
> > +		if (crash_base == 0) {
> > +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> > +				crash_size);
> > +			return;
> > +		}
> > +		memblock_reserve(crash_base, crash_size);
> > +
> > +	} else {
> > +		/* User specifies base address explicitly. */
> > +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> > +			memblock_is_region_reserved(crash_base, crash_size)) {
> > +			pr_warn("crashkernel has wrong address or size\n");
> > +			return;
> > +		}
> > +
> > +		if (crash_base & ((1 << 21) - 1)) {
> > +			pr_warn("crashkernel base address is not 2MB aligned\n");
> > +			return;
> > +		}
> > +
> > +		memblock_reserve(crash_base, crash_size);
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
> 
> 
> Thanks,
> 
> James
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
