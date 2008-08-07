Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR5hI-0007QT-Jo
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 13:38:32 +0000
Date: Thu, 7 Aug 2008 09:38:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 6/6] kexec jump: fix for ftrace
Message-ID: <20080807133805.GD27783@redhat.com>
References: <1218099937.5164.37.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218099937.5164.37.camel@caritas-dev.intel.com>
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

On Thu, Aug 07, 2008 at 05:05:37PM +0800, Huang Ying wrote:
> Restore ftrace after jumping back from kexeced kernel.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  arch/x86/kernel/machine_kexec_32.c |   19 +++++++++++++++++++
>  kernel/kexec.c                     |    2 --
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/numa.h>
>  #include <linux/ftrace.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -117,6 +118,7 @@ void machine_kexec(struct kimage *image)
>  {
>  	unsigned long page_list[PAGES_NR];
>  	void *control_page;
> +	int save_ftrace_enabled;
>  	asmlinkage unsigned long
>  		(*relocate_kernel_ptr)(unsigned long indirection_page,
>  				       unsigned long control_page,
> @@ -124,7 +126,15 @@ void machine_kexec(struct kimage *image)
>  				       unsigned int has_pae,
>  				       unsigned int preserve_context);
>  
> +#ifdef CONFIG_KEXEC_JUMP
> +	if (kexec_image->preserve_context)
> +		save_processor_state();
> +#endif
> +
> +#ifdef CONFIG_FTRACE
> +	save_ftrace_enabled = ftrace_enabled;
>  	tracer_disable();
> +#endif
>  
>  	/* Interrupts aren't acceptable while we reboot */
>  	raw_local_irq_disable();
> @@ -182,6 +192,15 @@ void machine_kexec(struct kimage *image)
>  					   (unsigned long)page_list,
>  					   image->start, cpu_has_pae,
>  					   image->preserve_context);
> +
> +#ifdef CONFIG_KEXEC_JUMP
> +	if (kexec_image->preserve_context)
> +		restore_processor_state();
> +#endif
> +
> +#ifdef CONFIG_FTRACE
> +	ftrace_enabled = save_ftrace_enabled;
> +#endif
>  }
>  

Hi Huang,

What kind of problem we run into if we don't disable the ftracer?

I think there are too many #ifdefs now and probably we can at least
get rid if #ifdef CONFIG_FTRACE thing.

I think ftracer needs to export the function to enable the tracer
back (tracer_enable()) so that we don't directly play with ftrace_enabled
variable. tracer_enable() can be do {} while{0} in case of CONFIG_FTRACE=n
so that we can get rid of #ifdefs here.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
