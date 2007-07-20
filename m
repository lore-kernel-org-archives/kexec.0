Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IC0GA-0006Ke-Cw
	for kexec@lists.infradead.org; Fri, 20 Jul 2007 17:43:39 -0400
Date: Fri, 20 Jul 2007 14:43:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] Debug handling of early spurious interrupts
Message-Id: <20070720144302.2785e961.akpm@linux-foundation.org>
In-Reply-To: <1184898043.28418.3.camel@sebastian.kern.oss.ntt.co.jp>
References: <1184666997.5271.5.camel@sebastian.kern.oss.ntt.co.jp>
	<20070718154659.c8b5ffea.akpm@linux-foundation.org>
	<1184896459.27369.36.camel@sebastian.kern.oss.ntt.co.jp>
	<1184896944.27369.50.camel@sebastian.kern.oss.ntt.co.jp>
	<1184898043.28418.3.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, 20 Jul 2007 11:20:43 +0900
Fernando Luis V__zquez Cao <fernando@oss.ntt.co.jp> wrote:

> With the advent of kdump it is possible that device drivers receive
> interrupts generated in the context of a previous kernel. Ideally
> quiescing the underlying devices should suffice but not all drivers do
> this, either because it is not possible or because they did not
> contemplate this case. Thus drivers ought to be able to handle
> interrupts coming in as soon as the interrupt handler is registered.
> 
> Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
> ---
> 
> diff -urNp linux-2.6.22-orig/kernel/irq/manage.c linux-2.6.22-pendirq/kernel/irq/manage.c
> --- linux-2.6.22-orig/kernel/irq/manage.c	2007-07-19 18:18:53.000000000 +0900
> +++ linux-2.6.22-pendirq/kernel/irq/manage.c	2007-07-19 19:43:41.000000000 +0900
> @@ -533,21 +533,32 @@ int request_irq(unsigned int irq, irq_ha
>  
>  	select_smp_affinity(irq);
>  
> -	if (irqflags & IRQF_SHARED) {
> -		/*
> -		 * It's a shared IRQ -- the driver ought to be prepared for it
> -		 * to happen immediately, so let's make sure....
> -		 * We do this before actually registering it, to make sure that
> -		 * a 'real' IRQ doesn't run in parallel with our fake
> -		 */
> -		if (irqflags & IRQF_DISABLED) {
> -			unsigned long flags;
> +	/*
> +	 * With the advent of kdump it possible that device drivers receive
> +	 * interrupts generated in the context of a previous kernel. Ideally
> +	 * quiescing the underlying devices should suffice but not all drivers
> +	 * do this, either because it is not possible or because they did not
> +	 * contemplate this case. Thus drivers ought to be able to handle
> +	 * interrupts coming in as soon as the interrupt handler is registered.
> +	 *
> +	 * Besides, if it is a shared IRQ the driver ought to be prepared for
> +	 * it to happen immediately too.
> +	 *
> +	 * We do this before actually registering it, to make sure that
> +	 * a 'real' IRQ doesn't run in parallel with our fake.
> +	 */
> +	if (irqflags & IRQF_DISABLED) {
> +		unsigned long flags;
>  
> -			local_irq_save(flags);
> -			handler(irq, dev_id);
> -			local_irq_restore(flags);
> -		} else
> -			handler(irq, dev_id);
> +		local_irq_save(flags);
> +		retval = handler(irq, dev_id);
> +		local_irq_restore(flags);
> +	} else
> +		retval = handler(irq, dev_id);
> +	if (retval == IRQ_HANDLED) {
> +		printk(KERN_WARNING
> +		       "%s (IRQ %d) handled a spurious interrupt\n",
> +		       devname, irq);
>  	}
>  

This change means that we'll run the irq handler at request_irq()-time even
for non-shared interrupts.

This is a bit of a worry.  See, shared-interrupt handlers are required to
be able to cope with being called when their device isn't interrupting. 
But nobody ever said that non-shared interrupt handlers need to be able to
cope with that.

Hence these non-shared handlers are within their rights to emit warning
printks, go BUG or accuse the operator of having busted hardware.

So bad things might happen because of this change.  And if they do, they
will take a loooong time to be discovered, because non-shared interrupt
handlers tend to dwell in crufty old drivers which not many people use.

So I'm wondering if it would be more prudent to only do all this for shared
handlers?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
