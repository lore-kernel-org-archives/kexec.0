Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USG43-0001gm-Ts
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 00:17:32 +0000
Date: Wed, 17 Apr 2013 09:17:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec, i386, bzImage: Remove unnecessary symbol value get
Message-ID: <20130417001726.GC21434@verge.net.au>
References: <516D5DF6.8060906@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516D5DF6.8060906@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Apr 16, 2013 at 10:19:34PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> We needn't get the initial values for every regs in regs32
> from symbol entry32_regs for we will manually initialize them
> one by one next:
> 
>         /*  
>          * Initialize the 32bit start information.
>          */
>         regs32.eax = 0; /* unused */
>         regs32.ebx = 0; /* 0 == boot not AP processor start */
>         regs32.ecx = 0; /* unused */
>         regs32.edx = 0; /* unused */
>         regs32.esi = setup_base; /* kernel parameters */
>         regs32.edi = 0; /* unused */
>         regs32.esp = elf_rel_get_addr(&info->rhdr, "stack_end"); /* stack, unused */
>         regs32.ebp = 0; /* unused */
>         regs32.eip = kernel32_load_addr; /* kernel entry point */
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, nice clean-up.

I have applied this patch.

> ---
>  kexec/arch/i386/kexec-bzImage.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
> index 39452a4..6a34279 100644
> --- a/kexec/arch/i386/kexec-bzImage.c
> +++ b/kexec/arch/i386/kexec-bzImage.c
> @@ -310,9 +310,8 @@ int do_bzImage_load(struct kexec_info *info,
>  	if (real_mode_entry)
>  		elf_rel_get_symbol(&info->rhdr, "entry16_regs",
>  					 &regs16, sizeof(regs16));
> -	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
> -	/*
>  
> +	/*
>  	 * Initialize the 32bit start information.
>  	 */
>  	regs32.eax = 0; /* unused */
> -- 
> 1.7.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
