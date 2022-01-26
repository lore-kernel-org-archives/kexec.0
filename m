From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Wed, 26 Jan 2022 09:17:37 -0600
Subject: [PATCH v20 2/5] arm64: kdump: introduce some macros for crash
 kernel reservation
In-Reply-To: <20220124084708.683-3-thunder.leizhen@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-3-thunder.leizhen@huawei.com>
Message-ID: <35d28434-25d7-5aca-e810-2b4639dd5810@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 1/24/22 2:47 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> upper bound of high crash memory, use macros instead.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>


Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   arch/arm64/mm/init.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 90f276d46b93bc6..6c653a2c7cff052 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -65,6 +65,12 @@ EXPORT_SYMBOL(memstart_addr);
>   phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   
>   #ifdef CONFIG_KEXEC_CORE
> +/* Current arm64 boot protocol requires 2MB alignment */
> +#define CRASH_ALIGN		SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> +
>   /*
>    * reserve_crashkernel() - reserves memory for crash kernel
>    *
> @@ -75,7 +81,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   static void __init reserve_crashkernel(void)
>   {
>   	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = arm64_dma_phys_limit;
> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>   	int ret;
>   
>   	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -90,8 +96,7 @@ static void __init reserve_crashkernel(void)
>   	if (crash_base)
>   		crash_max = crash_base + crash_size;
>   
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>   					       crash_base, crash_max);
>   	if (!crash_base) {
>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",


