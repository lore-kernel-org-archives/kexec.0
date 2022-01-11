From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Tue, 11 Jan 2022 09:06:00 -0600
Subject: [PATCH v19 05/13] x86/setup: Add and use CRASH_BASE_ALIGN
In-Reply-To: <20211228132612.1860-6-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-6-thunder.leizhen@huawei.com>
Message-ID: <36952970-6ce3-e17e-7997-3fa7e8f6307a@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Add macro CRASH_BASE_ALIGN to indicate the alignment for crash kernel
> fixed region, in preparation for making partial implementation of
> reserve_crashkernel[_low]() generic.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   arch/x86/kernel/setup.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 93d78aae1937db3..cb7f237a2ae0dfa 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -392,9 +392,12 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   
>   #ifdef CONFIG_KEXEC_CORE
>   
> -/* 16M alignment for crash kernel regions */
> +/* alignment for crash kernel dynamic regions */
>   #define CRASH_ALIGN		SZ_16M
>   
> +/* alignment for crash kernel fixed region */
> +#define CRASH_BASE_ALIGN	SZ_1M
> +
>   /*
>    * Keep the crash kernel below this limit.
>    *
> @@ -509,7 +512,7 @@ static void __init reserve_crashkernel(void)
>   	} else {
>   		unsigned long long start;
>   
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> +		start = memblock_phys_alloc_range(crash_size, CRASH_BASE_ALIGN, crash_base,
>   						  crash_base + crash_size);
>   		if (start != crash_base) {
>   			pr_info("crashkernel reservation failed - memory is in use.\n");


