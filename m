Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from djurbala-pt.tunnel.tserv2.fmt.ipv6.he.net
	([2001:470:1f01:ffff::eb] helo=gate.crashing.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L3M0i-0001o1-Ub
	for kexec@lists.infradead.org; Fri, 21 Nov 2008 02:44:45 +0000
Subject: Re: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC
	on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200811201823.25263.arnd@arndb.de>
References: <200811191450.59361.arnd@arndb.de>
	<1227166240.7185.207.camel@pasglop> <200811201823.25263.arnd@arndb.de>
Date: Fri, 21 Nov 2008 13:44:10 +1100
Message-Id: <1227235450.7185.214.camel@pasglop>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kexec@lists.infradead.org, cbe-oss-dev@ozlabs.org, Max Krasnyansky <maxk@qualcomm.com>

On Thu, 2008-11-20 at 18:23 +0100, Arnd Bergmann wrote:
> Kexec/kdump currently fails on the IBM QS2x blades when the kexec happens
> on a CPU other than the initial boot CPU.  It turns out that this is the
> result of mpic_init trying to set affinity of each interrupt vector to the
> current boot CPU.
> 
> As far as I can tell,  the same problem is likely to exist on any
> secondary MPIC, because they have to deliver interrupts to the first
> output all the time. There are two potential solutions for this: either
> not set up affinity at all for secondary MPICs, or assume that a single
> CPU output is connected to the upstream interrupt controller and hardcode
> affinity to that per architecture.
> 
> This patch implements the second approach, defaulting to the first output.
> An architecture that has a secondary MPIC connected upstream using a
> different output needs to set the mpic default_dest to the correct
> value before calling mpic_init.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
>  include/asm/mpic.h |    3 +++
>  sysdev/mpic.c      |    9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> On Thursday 20 November 2008, Benjamin Herrenschmidt wrote:
> 
> > I would rather, for non primary, set it to a cpu provided as
> > either a new argument or an mpic struct member initially set to 1 with
> > an accessor to change it if necessary. 
> 
> How about this one?
> 
> > Or should we define a flag to have it read it at init time from the chip ?
> 
> I don't understand. This is init time, where we write it to the chip,
> what do you mean with reading from it? If I understand you correctly,
> we can't trust that value to start with.

Oh just that for powermac for example, I know I'm resetting the thing,
so can't rely on init values, and on some BML embedded boxes too, while
on things like cell I don't off hand know what the right CPU number is
to hit the right C3PO interrupt, so I'm better off reading what SLOF
did :-)

But if you think on Cell we can just hard wire in the platform code,
then I'm ok.

Cheers,
Ben.

> 	Arnd <><
> 
> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
> index fe566a3..543d51c 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -295,6 +295,9 @@ struct mpic
>  	/* Protected sources */
>  	unsigned long		*protected;
>  
> +	/* destination for non-primary MPICs */
> +	int			default_dest;
> +
>  #ifdef CONFIG_MPIC_WEIRD
>  	/* Pointer to HW info array */
>  	u32			*hw_set;
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8e3478c..cf154c9 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1220,6 +1220,7 @@ void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
>  void __init mpic_init(struct mpic *mpic)
>  {
>  	int i;
> +	int cpu;
>  
>  	BUG_ON(mpic->num_sources == 0);
>  
> @@ -1262,6 +1263,11 @@ void __init mpic_init(struct mpic *mpic)
>  
>  	mpic_pasemi_msi_init(mpic);
>  
> +	if (mpic->flags & MPIC_PRIMARY)
> +		cpu = hard_smp_processor_id();
> +	else
> +		cpu = mpic->default_dest;
> +
>  	for (i = 0; i < mpic->num_sources; i++) {
>  		/* start with vector = source number, and masked */
>  		u32 vecpri = MPIC_VECPRI_MASK | i |
> @@ -1272,8 +1278,7 @@ void __init mpic_init(struct mpic *mpic)
>  			continue;
>  		/* init hw */
>  		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
> -		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
> -			       1 << hard_smp_processor_id());
> +		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
>  	}
>  	
>  	/* Init spurious vector */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
