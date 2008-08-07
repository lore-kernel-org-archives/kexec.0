Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1j4-0007cJ-5G
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:24:06 +0000
Date: Thu, 7 Aug 2008 11:24:05 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 6/6] kexec jump: fix for ftrace
Message-ID: <20080807092405.GF372@atrey.karlin.mff.cuni.cz>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

> Restore ftrace after jumping back from kexeced kernel.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  arch/x86/kernel/machine_kexec_32.c |   19 +++++++++++++++++++
>  kernel/kexec.c                     |    2 --
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
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

The patch does way more than its changelog says...
									Pavel


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
>  void arch_crash_save_vmcoreinfo(void)
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1469,7 +1469,6 @@ int kernel_kexec(void)
>  		error = device_power_down(PMSG_FREEZE);
>  		if (error)
>  			goto Enable_irqs;
> -		save_processor_state();
>  	} else
>  #endif
>  	{
> @@ -1482,7 +1481,6 @@ int kernel_kexec(void)
>  
>  #ifdef CONFIG_KEXEC_JUMP
>  	if (kexec_image->preserve_context) {
> -		restore_processor_state();
>  		device_power_up(PMSG_RESTORE);
>   Enable_irqs:
>  		local_irq_enable();
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
