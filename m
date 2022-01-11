From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Tue, 11 Jan 2022 09:04:02 -0600
Subject: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
In-Reply-To: <20211228132612.1860-3-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
Message-ID: <097d4a87-1981-7848-6553-079d63cf6410@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Use parse_crashkernel_high_low() to bring the parsing of
> "crashkernel=X,high" and the parsing of "crashkernel=Y,low" together, they
> are strongly dependent, make code logic clear and more readable.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>
> ---
>   arch/x86/kernel/setup.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6a190c7f4d71b05..93d78aae1937db3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -416,18 +416,16 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   # define CRASH_ADDR_HIGH_MAX	SZ_64T
>   #endif
>   
> -static int __init reserve_crashkernel_low(void)
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
>   {
>   #ifdef CONFIG_X86_64
> -	unsigned long long base, low_base = 0, low_size = 0;
> +	unsigned long long low_base = 0;
>   	unsigned long low_mem_limit;
> -	int ret;
>   
>   	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
>   
> -	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
> -	if (ret) {
> +	/* crashkernel=Y,low is not specified */
> +	if ((long)low_size < 0) {
>   		/*
>   		 * two parts from kernel/dma/swiotlb.c:
>   		 * -swiotlb size: user-specified with swiotlb= or default.
> @@ -465,7 +463,7 @@ static int __init reserve_crashkernel_low(void)
>   
>   static void __init reserve_crashkernel(void)
>   {
> -	unsigned long long crash_size, crash_base, total_mem;
> +	unsigned long long crash_size, crash_base, total_mem, low_size;
>   	bool high = false;
>   	int ret;
>   
> @@ -474,10 +472,9 @@ static void __init reserve_crashkernel(void)
>   	/* crashkernel=XM */
>   	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
>   	if (ret != 0 || crash_size <= 0) {
> -		/* crashkernel=X,high */
> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> -					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> +		/* crashkernel=X,high and possible crashkernel=Y,low */
> +		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
> +		if (ret)
>   			return;
>   		high = true;
>   	}
> @@ -520,7 +517,7 @@ static void __init reserve_crashkernel(void)
>   		}
>   	}
>   
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> +	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low(low_size)) {
>   		memblock_phys_free(crash_base, crash_size);
>   		return;
>   	}


