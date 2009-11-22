Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NCC0J-0004q2-4O
	for kexec@lists.infradead.org; Sun, 22 Nov 2009 12:57:32 +0000
References: <86802c440911220226g21cc42bbmdc3ebe21d0f61943@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 22 Nov 2009 04:56:54 -0800
In-Reply-To: <86802c440911220226g21cc42bbmdc3ebe21d0f61943@mail.gmail.com>
	(Yinghai Lu's message of "Sun\, 22 Nov 2009 02\:26\:03 -0800")
Message-ID: <m18wdypvjd.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: crash kernel reserve with reserve_early
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Yinghai Lu <yhlu.kernel@gmail.com> writes:

> [PATCH] x86: crash kernel reserve with reserve_early
>
> use find_e820_area/reserve_early instead.
> will get next good one automatically with alignment

Semantically this is broken, as you are now ignoring a passed in
base address if one is supplied.  What problem are you trying to fix?

Eric

>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/kernel/setup.c |   60 ++++++++++--------------------------------------
>  1 file changed, 13 insertions(+), 47 deletions(-)
>
> Index: linux-2.6/arch/x86/kernel/setup.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/setup.c
> +++ linux-2.6/arch/x86/kernel/setup.c
> @@ -488,42 +488,11 @@ static void __init reserve_early_setup_d
>  
>  #ifdef CONFIG_KEXEC
>  
> -/**
> - * Reserve @size bytes of crashkernel memory at any suitable offset.
> - *
> - * @size: Size of the crashkernel memory to reserve.
> - * Returns the base address on success, and -1ULL on failure.
> - */
> -static
> -unsigned long long __init find_and_reserve_crashkernel(unsigned long long size)
> -{
> -	const unsigned long long alignment = 16<<20; 	/* 16M */
> -	unsigned long long start = 0LL;
> -
> -	while (1) {
> -		int ret;
> -
> -		start = find_e820_area(start, ULONG_MAX, size, alignment);
> -		if (start == -1ULL)
> -			return start;
> -
> -		/* try to reserve it */
> -		ret = reserve_bootmem_generic(start, size, BOOTMEM_EXCLUSIVE);
> -		if (ret >= 0)
> -			return start;
> -
> -		start += alignment;
> -	}
> -}
> -
>  static inline unsigned long long get_total_mem(void)
>  {
>  	unsigned long long total;
>  
> -	total = max_low_pfn - min_low_pfn;
> -#ifdef CONFIG_HIGHMEM
> -	total += highend_pfn - highstart_pfn;
> -#endif
> +	total = max_pfn - min_low_pfn;
>  
>  	return total << PAGE_SHIFT;
>  }
> @@ -532,6 +501,8 @@ static void __init reserve_crashkernel(v
>  {
>  	unsigned long long total_mem;
>  	unsigned long long crash_size, crash_base;
> +	const unsigned long long alignment = 16<<20;	/* 16M */
> +	unsigned long long start;
>  	int ret;
>  
>  	total_mem = get_total_mem();
> @@ -543,21 +514,16 @@ static void __init reserve_crashkernel(v
>  
>  	/* 0 means: find the address automatically */
>  	if (crash_base <= 0) {
> -		crash_base = find_and_reserve_crashkernel(crash_size);
> -		if (crash_base == -1ULL) {
> -			pr_info("crashkernel reservation failed. "
> -				"No suitable area found.\n");
> -			return;
> -		}
> +		start = alignment;
>  	} else {
> -		ret = reserve_bootmem_generic(crash_base, crash_size,
> -					BOOTMEM_EXCLUSIVE);
> -		if (ret < 0) {
> -			pr_info("crashkernel reservation failed - "
> -				"memory is in use\n");
> -			return;
> -		}
> +		start = crash_base;
> +	}
> +	crash_base = find_e820_area(start, ULONG_MAX, crash_size, alignment);
> +	if (crash_base == -1ULL) {
> +		pr_info("crashkernel reservation failed - No suitable area found.\n");
> +		return;
>  	}
> +	reserve_early(crash_base, crash_base + crash_size, "CRASH KERNEL");
>  
>  	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
>  			"for crashkernel (System RAM: %ldMB)\n",
> @@ -935,6 +901,8 @@ void __init setup_arch(char **cmdline_p)
>  
>  	reserve_initrd();
>  
> +	reserve_crashkernel();
> +
>  	vsmp_init();
>  
>  	io_delay_init();
> @@ -965,8 +933,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	initmem_init(0, max_pfn, acpi, k8);
>  
> -	reserve_crashkernel();
> -
>  #ifdef CONFIG_X86_64
>  	/*
>  	 * dma32_reserve_bootmem() allocates bootmem which may conflict

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
