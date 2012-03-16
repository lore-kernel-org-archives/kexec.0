Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S8OkA-0002bD-77
 for kexec@lists.infradead.org; Fri, 16 Mar 2012 04:26:23 +0000
Date: Fri, 16 Mar 2012 13:26:13 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 resend] kdump x86: fix total mem size calculation for
 reservation
Message-ID: <20120316042612.GB29238@verge.net.au>
References: <20120316030216.GA5123@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120316030216.GA5123@localhost.localdomain>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux@arm.linux.org.uk, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, vgoyal@redhat.com

On Fri, Mar 16, 2012 at 11:02:16AM +0800, Dave Young wrote:
> crashkernel reservation need know the total memory size. Current get_total_mem
> simply use max_pfn - min_low_pfn. It is wrong because it will including
> memory holes in the middle.
> 
> Especially for kvm guest with memory > 0xe0000000, there's below in qemu code:
> qemu split memory as below:
>     if (ram_size >= 0xe0000000 ) {
>         above_4g_mem_size = ram_size - 0xe0000000;
>         below_4g_mem_size = 0xe0000000;
>     } else {
>         below_4g_mem_size = ram_size;
>     }
> So for 4G mem guest, seabios will insert a 512M usable region beyond of 4G.
> Thus in above case max_pfn - min_low_pfn will be more than original memsize.
> 
> Fixing this issue by using memblock_phys_mem_size() to get the total memsize.
> 
> [v1 -> v2]: refresh the patch based on latest linus tree
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@verge.net.au>


Andrew, can you pick this up?
It has been floating around without objections for a week now.

> ---
>  arch/x86/kernel/setup.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> --- linux-2.6.orig/arch/x86/kernel/setup.c	2012-03-04 03:46:35.000000000 +0800
> +++ linux-2.6/arch/x86/kernel/setup.c	2012-03-10 12:44:58.133300788 +0800
> @@ -509,15 +509,6 @@ static void __init memblock_x86_reserve_
>  
>  #ifdef CONFIG_KEXEC
>  
> -static inline unsigned long long get_total_mem(void)
> -{
> -	unsigned long long total;
> -
> -	total = max_pfn - min_low_pfn;
> -
> -	return total << PAGE_SHIFT;
> -}
> -
>  /*
>   * Keep the crash kernel below this limit.  On 32 bits earlier kernels
>   * would limit the kernel to the low 512 MiB due to mapping restrictions.
> @@ -536,7 +527,7 @@ static void __init reserve_crashkernel(v
>  	unsigned long long crash_size, crash_base;
>  	int ret;
>  
> -	total_mem = get_total_mem();
> +	total_mem = memblock_phys_mem_size();
>  
>  	ret = parse_crashkernel(boot_command_line, total_mem,
>  			&crash_size, &crash_base);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
