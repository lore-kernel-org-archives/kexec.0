From: Baoquan He <bhe@redhat.com>
Date: Fri, 11 Feb 2022 18:51:21 +0800
Subject: [PATCH v20 3/5] arm64: kdump: reimplement crashkernel=X
In-Reply-To: <6ac0c60c-78bc-9789-9f5c-659fb5fa3e9a@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-4-thunder.leizhen@huawei.com>
 <YgY6yvX7PEeZpdTr@MiWiFi-R3L-srv>
 <6ac0c60c-78bc-9789-9f5c-659fb5fa3e9a@huawei.com>
Message-ID: <YgY/qQUkBF0eZ9zc@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/11/22 at 06:41pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/2/11 18:30, Baoquan He wrote:
> > On 01/24/22 at 04:47pm, Zhen Lei wrote:
> >> From: Chen Zhou <chenzhou10@huawei.com>
> > ......
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 6c653a2c7cff052..a5d43feac0d7d96 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -71,6 +71,30 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>  #define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> >>  #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> >>  
> >> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> >> +{
> >> +	unsigned long long low_base;
> >> +
> >> +	/* passed with crashkernel=0,low ? */
> >> +	if (!low_size)
> >> +		return 0;
> >> +
> >> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> >> +	if (!low_base) {
> >> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	pr_info("crashkernel low memory reserved: 0x%llx - 0x%llx (%lld MB)\n",
> >> +		low_base, low_base + low_size, low_size >> 20);
> >> +
> >> +	crashk_low_res.start = low_base;
> >> +	crashk_low_res.end   = low_base + low_size - 1;
> >> +	insert_resource(&iomem_resource, &crashk_low_res);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  /*
> >>   * reserve_crashkernel() - reserves memory for crash kernel
> >>   *
> >> @@ -81,29 +105,62 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>  static void __init reserve_crashkernel(void)
> >>  {
> >>  	unsigned long long crash_base, crash_size;
> >> +	unsigned long long crash_low_size = SZ_256M;
> >>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> >>  	int ret;
> >> +	bool fixed_base;
> >> +	char *cmdline = boot_command_line;
> >>  
> >> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >> +	/* crashkernel=X[@offset] */
> >> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> >>  				&crash_size, &crash_base);
> >> -	/* no crashkernel= or invalid value specified */
> >> -	if (ret || !crash_size)
> >> -		return;
> >> +	if (ret || !crash_size) {
> >> +		unsigned long long low_size;
> >>  
> >> +		/* crashkernel=X,high */
> >> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> >> +		if (ret || !crash_size)
> >> +			return;
> >> +
> >> +		/* crashkernel=X,low */
> >> +		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
> >> +		if (!ret)
> >> +			crash_low_size = low_size;
> > 
> > Here, the error case is not checked and handled. But it still gets
> > expeced result which is the default SZ_256M. Is this designed on
> > purpose?
> 
> Yes, we can specify only "crashkernel=X,high".
> 
> This is mentioned in Documentation/admin-guide/kernel-parameters.txt
> 
>         crashkernel=size[KMG],low
>                         [KNL, X86-64] range under 4G. When crashkernel=X,high
>                         is passed, kernel could allocate physical memory region
>                         above 4G, that cause second kernel crash on system
>                         that require some amount of low memory, e.g. swiotlb
>                         requires at least 64M+32K low memory, also enough extra
>                         low memory is needed to make sure DMA buffers for 32-bit
>                         devices won't run out. Kernel would try to allocate at     <---------
>                         least 256M below 4G automatically.                         <---------

Yeah, that is expected becasue no crahskernel=,low is a right usage. The
'ret' is 0 in the case. If I gave below string, it works too.
"crashkernel=256M,high crashkernel=aaabbadfadfd,low"

> 
> > 
> >> +
> >> +		crash_max = CRASH_ADDR_HIGH_MAX;
> >> +	}
> >> +
> >> +	fixed_base = !!crash_base;
> >>  	crash_size = PAGE_ALIGN(crash_size);
> >>  
> >>  	/* User specifies base address explicitly. */
> >>  	if (crash_base)
> >>  		crash_max = crash_base + crash_size;
> >>  
> >> +retry:
> >>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>  					       crash_base, crash_max);
> >>  	if (!crash_base) {
> >> +		/*
> >> +		 * Attempt to fully allocate low memory failed, fall back
> >> +		 * to high memory, the minimum required low memory will be
> >> +		 * reserved later.
> >> +		 */
> >> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> >> +			crash_max = CRASH_ADDR_HIGH_MAX;
> >> +			goto retry;
> >> +		}
> >> +
> >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >>  			crash_size);
> >>  		return;
> >>  	}
> >>  
> >> +	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
> >> +		memblock_phys_free(crash_base, crash_size);
> >> +		return;
> >> +	}
> >> +
> >>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> >>  		crash_base, crash_base + crash_size, crash_size >> 20);
> >>  
> >> @@ -112,6 +169,9 @@ static void __init reserve_crashkernel(void)
> >>  	 * map. Inform kmemleak so that it won't try to access it.
> >>  	 */
> >>  	kmemleak_ignore_phys(crash_base);
> >> +	if (crashk_low_res.end)
> >> +		kmemleak_ignore_phys(crashk_low_res.start);
> >> +
> >>  	crashk_res.start = crash_base;
> >>  	crashk_res.end = crash_base + crash_size - 1;
> >>  	insert_resource(&iomem_resource, &crashk_res);
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 


