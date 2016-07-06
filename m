Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1467826137.8880.35.camel@infradead.org>
Subject: Re: [PATCH v21 3/8] arm64: kdump: implement machine_crash_shutdown()
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 06 Jul 2016 10:28:57 -0700
In-Reply-To: <20160706075226.27609-4-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-4-takahiro.akashi@linaro.org>
Mime-Version: 1.0
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com
Cc: kexec@lists.infradead.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -136,6 +136,10 @@ static inline void cpu_panic_kernel(void)
>   */
>  bool cpus_are_stuck_in_kernel(void);
>  
> +#ifdef CONFIG_KEXEC_CORE
> +extern void smp_send_crash_stop(void);
> +#endif

It seems this could be simplified by removing these
conditionals, then move the conditionals that are
around the smp_send_crash_stop definition to inside
that definition.

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 62ff3c0..51e0b73 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -800,6 +803,28 @@ static void ipi_cpu_stop(unsigned int cpu)
>  > 	> 	> cpu_relax();
>  }
>  
> +#ifdef CONFIG_KEXEC_CORE
> +static atomic_t waiting_for_crash_ipi;
> +
> +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> +{
> +> 	> crash_save_cpu(regs, cpu);
> +
> +> 	> atomic_dec(&waiting_for_crash_ipi);
> +
> +> 	> local_irq_disable();
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +> 	> if (cpu_ops[cpu]->cpu_die)
> +> 	> 	> cpu_ops[cpu]->cpu_die(cpu);
> +#endif
> +
> +> 	> /* just in case */
> +> 	> while (1)
> +> 	> 	> wfi();
> +}
> +#endif

 /*
>   * Main handler for inter-processor interrupts
>   */
> @@ -830,6 +855,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  > 	> 	> irq_exit();
>  > 	> 	> break;
>  
> +#ifdef CONFIG_KEXEC_CORE
> +> 	> case IPI_CPU_CRASH_STOP:
> +> 	> 	> irq_enter();
> +> 	> 	> ipi_cpu_crash_stop(cpu, regs);
> +
> +> 	> 	> unreachable();
> +#endif

It seems like you could simplifiy with something like:

	case IPI_CPU_CRASH_STOP:
		if (IS_ENABLED(CONFIG_KEXEC_CORE) {
			irq_enter();
			ipi_cpu_crash_stop(cpu, regs);
			unreachable();
		}

Then move the CONFIG_KEXEC_CORE conditional around
ipi_cpu_crash_stop to just around crash_save_cpu().

 -Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
