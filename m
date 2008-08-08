Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRSfY-0006ha-6p
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 14:10:16 +0000
Date: Fri, 8 Aug 2008 10:09:38 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -v2 3/8] kexec jump: check code size in control page
Message-ID: <20080808140938.GE3840@redhat.com>
References: <1218178356.22039.76.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218178356.22039.76.camel@caritas-dev.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Fri, Aug 08, 2008 at 02:52:36PM +0800, Huang Ying wrote:
> Kexec/Kexec-jump require code size in control page is less than
> PAGE_SIZE/2. This patch add link-time checking for this.
> 
> ASSERT() of ld link script is used as the link-time checking
> mechanism.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  arch/x86/kernel/machine_kexec_32.c     |    2 +-
>  arch/x86/kernel/relocate_kernel_32.S   |   10 +++++++---
>  arch/x86/kernel/vmlinux_32.lds.S       |    2 ++
>  arch/x86/kernel/vmlinux_check_32.lds.S |    7 +++++++
>  include/asm-x86/kexec.h                |    4 ++++
>  5 files changed, 21 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -138,7 +138,7 @@ void machine_kexec(struct kimage *image)
>  	}
>  
>  	control_page = page_address(image->control_code_page);
> -	memcpy(control_page, relocate_kernel, PAGE_SIZE/2);
> +	memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
>  
>  	relocate_kernel_ptr = control_page;
>  	page_list[PA_CONTROL_PAGE] = __pa(control_page);
> --- a/arch/x86/kernel/relocate_kernel_32.S
> +++ b/arch/x86/kernel/relocate_kernel_32.S
> @@ -20,10 +20,11 @@
>  #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
>  #define PAE_PGD_ATTR (_PAGE_PRESENT)
>  
> -/* control_page + PAGE_SIZE/2 ~ control_page + PAGE_SIZE * 3/4 are
> - * used to save some data for jumping back
> +/* control_page + KEXEC_CONTROL_CODE_MAX_SIZE
> + * ~ control_page + PAGE_SIZE * 3/4 are used to save some data for
> + * jumping back
>   */

Hi Huang,

Above comment is not very clear. Can you please elaborate it. I thought
that PAGE_SIZE/2 is used for control code and rest half is shared between
kjump data and stack. What is PAGE_SIZE *3/4?


> -#define DATA(offset)		(PAGE_SIZE/2+(offset))
> +#define DATA(offset)		(KEXEC_CONTROL_CODE_MAX_SIZE+(offset))
>  
>  /* Minimal CPU state */
>  #define ESP			DATA(0x0)
> @@ -376,3 +377,6 @@ swap_pages:
>  	popl	%ebx
>  	popl	%ebp
>  	ret
> +
> +	.globl kexec_control_code_size
> +.set kexec_control_code_size, . - relocate_kernel
> --- a/include/asm-x86/kexec.h
> +++ b/include/asm-x86/kexec.h
> @@ -41,6 +41,10 @@
>  # define PAGES_NR		17
>  #endif
>  
> +#ifdef CONFIG_X86_32
> +# define KEXEC_CONTROL_CODE_MAX_SIZE	2048
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/string.h>
> --- a/arch/x86/kernel/vmlinux_32.lds.S
> +++ b/arch/x86/kernel/vmlinux_32.lds.S
> @@ -209,3 +209,5 @@ SECTIONS
>  
>    DWARF_DEBUG
>  }
> +
> +#include "vmlinux_check_32.lds.S"
> --- /dev/null
> +++ b/arch/x86/kernel/vmlinux_check_32.lds.S
> @@ -0,0 +1,7 @@
> +/*
> + * Link time checks
> + */
> +
> +#include <asm/kexec.h>
> +
> +ASSERT(kexec_control_code_size <= KEXEC_CONTROL_CODE_MAX_SIZE, "kexec control code size is too big")

Will it make sense to move it into vmlinux_32.lds.S itself? Creating a separate
file for a single check seems superfluous.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
