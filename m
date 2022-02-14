From: Baoquan He <bhe@redhat.com>
Date: Mon, 14 Feb 2022 11:52:43 +0800
Subject: [PATCH v20 3/5] arm64: kdump: reimplement crashkernel=X
In-Reply-To: <20220124084708.683-4-thunder.leizhen@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-4-thunder.leizhen@huawei.com>
Message-ID: <YgnSCxlr1O2ZZ1sO@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/24/22 at 04:47pm, Zhen Lei wrote:
......
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6c653a2c7cff052..a5d43feac0d7d96 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -71,6 +71,30 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  #define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
>  
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +	unsigned long long low_base;
> +
> +	/* passed with crashkernel=0,low ? */
> +	if (!low_size)
> +		return 0;
> +
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	if (!low_base) {
> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("crashkernel low memory reserved: 0x%llx - 0x%llx (%lld MB)\n",
> +		low_base, low_base + low_size, low_size >> 20);
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +	insert_resource(&iomem_resource, &crashk_low_res);
> +
> +	return 0;
> +}
> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel

My another concern is the crashkernel=,low handling. In this patch, the
code related to low memory is obscure. Wondering if we should make them
explicit with a little redundant but very clear code flows. Saying this
because the code must be very clear to you and reviewers, it may be
harder for later code reader or anyone interested to understand.

1) crashkernel=X,high
2) crashkernel=X,high crashkernel=Y,low
3) crashkernel=X,high crashkernel=0,low
4) crashkernel=X,high crashkernel='messy code',low
5) crashkernel=X //fall back to high memory, low memory is required then.

It could be me thinking about it too much. I made changes to your patch
with a tuning, not sure if it's OK to you. Otherwise, this patchset
works very well for all above test cases, it's ripe to be merged for
wider testing.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a5d43feac0d7..671862c56d7d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -94,7 +94,8 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	return 0;
 }
-
+/*Words explaining why it's 256M*/
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE SZ_256M
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -105,10 +106,10 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
-	unsigned long long crash_low_size = SZ_256M;
+	unsigned long long crash_low_size;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	int ret;
-	bool fixed_base;
+	bool fixed_base, high;
 	char *cmdline = boot_command_line;
 
 	/* crashkernel=X[@offset] */
@@ -126,7 +127,10 @@ static void __init reserve_crashkernel(void)
 		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
 		if (!ret)
 			crash_low_size = low_size;
+		else
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 
+		high = true;
 		crash_max = CRASH_ADDR_HIGH_MAX;
 	}
 
@@ -134,7 +138,7 @@ static void __init reserve_crashkernel(void)
 	crash_size = PAGE_ALIGN(crash_size);
 
 	/* User specifies base address explicitly. */
-	if (crash_base)
+	if (fixed_base)
 		crash_max = crash_base + crash_size;
 
 retry:
@@ -156,7 +160,10 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
+	if (crash_base >= SZ_4G && !high) 
+		crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+
+	if (reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
 	}

>   *
> @@ -81,29 +105,62 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
> +	unsigned long long crash_low_size = SZ_256M;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	int ret;
> +	bool fixed_base;
> +	char *cmdline = boot_command_line;
>  
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +	/* crashkernel=X[@offset] */
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> +	if (ret || !crash_size) {
> +		unsigned long long low_size;
>  
> +		/* crashkernel=X,high */
> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +
> +		/* crashkernel=X,low */
> +		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
> +		if (!ret)
> +			crash_low_size = low_size;
> +
> +		crash_max = CRASH_ADDR_HIGH_MAX;
> +	}
> +
> +	fixed_base = !!crash_base;
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	/* User specifies base address explicitly. */
>  	if (crash_base)
>  		crash_max = crash_base + crash_size;
>  
> +retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);
>  	if (!crash_base) {
> +		/*
> +		 * Attempt to fully allocate low memory failed, fall back
> +		 * to high memory, the minimum required low memory will be
> +		 * reserved later.
> +		 */
> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +			crash_max = CRASH_ADDR_HIGH_MAX;
> +			goto retry;
> +		}
> +
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
>  	}
>  
> +	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
> +		memblock_phys_free(crash_base, crash_size);
> +		return;
> +	}
> +
>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>  		crash_base, crash_base + crash_size, crash_size >> 20);
>  
> @@ -112,6 +169,9 @@ static void __init reserve_crashkernel(void)
>  	 * map. Inform kmemleak so that it won't try to access it.
>  	 */
>  	kmemleak_ignore_phys(crash_base);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
> +
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
>  	insert_resource(&iomem_resource, &crashk_res);
> -- 
> 2.25.1
> 


