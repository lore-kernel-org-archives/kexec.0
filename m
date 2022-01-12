From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 12 Jan 2022 08:45:15 -0600
Subject: [PATCH v19 11/13] arm64: kdump: reimplement crashkernel=X
In-Reply-To: <20211228132612.1860-12-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-12-thunder.leizhen@huawei.com>
Message-ID: <e48ac849-cc3d-3c0b-e159-7408af61eece@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/28/21 7:26AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
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
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   arch/arm64/kernel/machine_kexec.c      |  5 +++-
>   arch/arm64/kernel/machine_kexec_file.c | 12 ++++++--
>   arch/arm64/kernel/setup.c              | 13 +++++++-
>   arch/arm64/mm/init.c                   | 41 ++++++++++----------------
>   4 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 6fb31c117ebe08c..6665bf31f6b6a19 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -327,7 +327,10 @@ bool crash_is_nosave(unsigned long pfn)
>   
>   	/* in reserved memory? */
>   	addr = __pfn_to_phys(pfn);
> -	if ((addr < crashk_res.start) || (crashk_res.end < addr))
> +	if (((addr < crashk_res.start) || (crashk_res.end < addr)) && !crashk_low_res.end)
> +		return false;
> +
> +	if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
>   		return false;
>   
>   	if (!kexec_crash_image)
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 59c648d51848886..889951291cc0f9c 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -65,10 +65,18 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>   
>   	/* Exclude crashkernel region */
>   	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
> +
> +	if (crashk_low_res.end) {
> +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		if (ret)
> +			goto out;
> +	}
>   
> -	if (!ret)
> -		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>   
> +out:
>   	kfree(cmem);
>   	return ret;
>   }
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index be5f85b0a24de69..4bb2e55366be64d 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -248,7 +248,18 @@ static void __init request_standard_resources(void)
>   		    kernel_data.end <= res->end)
>   			request_resource(res, &kernel_data);
>   #ifdef CONFIG_KEXEC_CORE
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
>   		if (crashk_res.end && crashk_res.start >= res->start &&
>   		    crashk_res.end <= res->end)
>   			request_resource(res, &crashk_res);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index be4595dc7459115..91b8038a1529068 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -74,41 +74,32 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>    */
>   static void __init reserve_crashkernel(void)
>   {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_size, crash_base, total_mem, low_size;

low_size needs to be initialized to -1.

If parse_crashkernel() succeeds, then an uninitialized low_size will be 
passed to reserve_crashkernel_mem().

> +	bool high = false;
>   	int ret;
>   
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> -
> -	crash_size = PAGE_ALIGN(crash_size);
> -
> -	/* User specifies base address explicitly. */
> -	if (crash_base)
> -		crash_max = crash_base + crash_size;
> +	total_mem = memblock_phys_mem_size();
>   
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> -	if (!crash_base) {
> -		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -			crash_size);
> -		return;
> +	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> +	if (ret != 0 || crash_size <= 0) {
> +		/* crashkernel=X,high and possible crashkernel=Y,low */
> +		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
> +		if (ret)
> +			return;
> +		high = true;
>   	}
>   
> -	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> -		crash_base, crash_base + crash_size, crash_size >> 20);
> +	ret = reserve_crashkernel_mem(total_mem, crash_size, crash_base, low_size, high);
> +	if (ret)
> +		return;
>   
>   	/*
>   	 * The crashkernel memory will be removed from the kernel linear
>   	 * map. Inform kmemleak so that it won't try to access it.
>   	 */
> -	kmemleak_ignore_phys(crash_base);
> -	crashk_res.start = crash_base;
> -	crashk_res.end = crash_base + crash_size - 1;
> +	kmemleak_ignore_phys(crashk_res.start);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
>   }
>   #else
>   static void __init reserve_crashkernel(void)


