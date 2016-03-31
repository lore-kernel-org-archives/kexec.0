Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1alXHb-0004CQ-0E
 for kexec@lists.infradead.org; Thu, 31 Mar 2016 07:44:48 +0000
Received: by mail-pf0-x236.google.com with SMTP id 4so63551396pfd.0
 for <kexec@lists.infradead.org>; Thu, 31 Mar 2016 00:44:26 -0700 (PDT)
Date: Thu, 31 Mar 2016 16:46:35 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
Message-ID: <20160331074635.GC2267@linaro.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
 <56EC440F.4050406@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56EC440F.4050406@arm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 18, 2016 at 06:08:15PM +0000, James Morse wrote:
> Hi!
> 
> On 14/03/16 17:48, Geoff Levand wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
> > and save registers' status in per-cpu ELF notes before starting crash
> > dump kernel. See kernel_kexec().
> > Even if not all secondary cpus have shut down, we do kdump anyway.
> > 
> > As we don't have to make non-boot(crashed) cpus offline (to preserve
> > correct status of cpus at crash dump) before shutting down, this patch
> > also adds a variant of smp_send_stop().
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index b1adc51..76402c6cd 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -701,6 +705,28 @@ static void ipi_cpu_stop(unsigned int cpu)
> >  		cpu_relax();
> >  }
> >  
> > +static atomic_t waiting_for_crash_ipi;
> > +
> > +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> > +{
> > +	crash_save_cpu(regs, cpu);
> > +
> > +	raw_spin_lock(&stop_lock);
> > +	pr_debug("CPU%u: stopping\n", cpu);
> > +	raw_spin_unlock(&stop_lock);
> > +
> > +	atomic_dec(&waiting_for_crash_ipi);
> > +
> > +	local_irq_disable();
> 
> Aren't irqs already disabled here? - or is this a 'just make sure'....

Well, it also exists in ipi_cpu_stop() ...

> > +
> > +	if (cpu_ops[cpu]->cpu_die)
> > +		cpu_ops[cpu]->cpu_die(cpu);
> > +
> > +	/* just in case */
> > +	while (1)
> > +		wfi();
> > +}
> > +
> >  /*
> >   * Main handler for inter-processor interrupts
> >   */
> > @@ -731,6 +757,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
> >  		irq_exit();
> >  		break;
> >  
> > +	case IPI_CPU_CRASH_STOP:
> > +		irq_enter();
> > +		ipi_cpu_crash_stop(cpu, regs);
> > +		irq_exit();
> 
> This made me jump: irq_exit() may end up in the __do_softirq() (with irqs turned
> back on!) ... but these lines are impossible to reach. Maybe get the compiler to
> enforce this with an unreachable() instead?

I'm not sure how effective unreachable() is here, but OK I will add it.

Thanks,
-Takahiro AKASHI

> > +		break;
> > +
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> >  	case IPI_TIMER:
> >  		irq_enter();
> > @@ -791,6 +823,30 @@ void smp_send_stop(void)
> >  		pr_warning("SMP: failed to stop secondary CPUs\n");
> >  }
> >  
> > +void smp_send_crash_stop(void)
> > +{
> > +	cpumask_t mask;
> > +	unsigned long timeout;
> > +
> > +	if (num_online_cpus() == 1)
> > +		return;
> > +
> > +	cpumask_copy(&mask, cpu_online_mask);
> > +	cpumask_clear_cpu(smp_processor_id(), &mask);
> > +
> > +	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> > +
> > +	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
> > +
> > +	/* Wait up to one second for other CPUs to stop */
> > +	timeout = USEC_PER_SEC;
> > +	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
> > +		udelay(1);
> > +
> > +	if (atomic_read(&waiting_for_crash_ipi) > 0)
> > +		pr_warn("SMP: failed to stop secondary CPUs\n");
> > +}
> > +
> >  /*
> >   * not supported here
> >   */
> > 
> 
> 
> Thanks,
> 
> James
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
