From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 11 Jan 2022 09:29:30 -0800 (PST)
Subject: [PATCH v2 2/5] riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE)
 instead of #ifdef
In-Reply-To: <20211206160514.2000-3-jszhang@kernel.org>
Message-ID: <mhng-ef554c87-32d1-443f-805d-3f74b88cd1f0@palmer-ri-x1c9>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, 06 Dec 2021 08:05:11 PST (-0800), jszhang at kernel.org wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> and increase compile coverage.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/init.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a15640eeb334..84879a5ce818 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -748,7 +748,6 @@ static inline void setup_vm_final(void)
>  }
>  #endif /* CONFIG_MMU */
>
> -#ifdef CONFIG_KEXEC_CORE
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -765,6 +764,8 @@ static void __init reserve_crashkernel(void)
>
>  	int ret = 0;
>
> +	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> +		return;
>  	/*
>  	 * Don't reserve a region for a crash kernel on a crash kernel
>  	 * since it doesn't make much sense and we have limited memory
> @@ -805,7 +806,6 @@ static void __init reserve_crashkernel(void)
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
>  }
> -#endif /* CONFIG_KEXEC_CORE */
>
>  void __init paging_init(void)
>  {
> @@ -819,9 +819,7 @@ void __init misc_mem_init(void)
>  	arch_numa_init();
>  	sparse_init();
>  	zone_sizes_init();
> -#ifdef CONFIG_KEXEC_CORE
>  	reserve_crashkernel();
> -#endif
>  	memblock_dump_all();
>  }

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

LMK if you wanted me to take this through the RISC-V tree, otherwise I'm 
going to assume all these are going in together.

Thanks!

