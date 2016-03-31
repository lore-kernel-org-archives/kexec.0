Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1alXRf-0001mM-7K
 for kexec@lists.infradead.org; Thu, 31 Mar 2016 07:55:12 +0000
Received: by mail-pf0-x233.google.com with SMTP id x3so63673501pfb.1
 for <kexec@lists.infradead.org>; Thu, 31 Mar 2016 00:54:50 -0700 (PDT)
Date: Thu, 31 Mar 2016 16:57:00 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
Message-ID: <20160331075659.GD2267@linaro.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
 <56EC440F.4050406@arm.com> <56EFF738.1040308@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56EFF738.1040308@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org

On Mon, Mar 21, 2016 at 01:29:28PM +0000, James Morse wrote:
> Hi!
> 
> On 18/03/16 18:08, James Morse wrote:
> > On 14/03/16 17:48, Geoff Levand wrote:
> >> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>
> >> Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
> >> and save registers' status in per-cpu ELF notes before starting crash
> >> dump kernel. See kernel_kexec().
> >> Even if not all secondary cpus have shut down, we do kdump anyway.
> >>
> >> As we don't have to make non-boot(crashed) cpus offline (to preserve
> >> correct status of cpus at crash dump) before shutting down, this patch
> >> also adds a variant of smp_send_stop().
> 
> >> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> >> index b1adc51..76402c6cd 100644
> >> --- a/arch/arm64/kernel/smp.c
> >> +++ b/arch/arm64/kernel/smp.c
> >> @@ -701,6 +705,28 @@ static void ipi_cpu_stop(unsigned int cpu)
> >>  		cpu_relax();
> >>  }
> >>  
> >> +static atomic_t waiting_for_crash_ipi;
> >> +
> >> +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> >> +{
> >> +	crash_save_cpu(regs, cpu);
> >> +
> >> +	raw_spin_lock(&stop_lock);
> >> +	pr_debug("CPU%u: stopping\n", cpu);
> >> +	raw_spin_unlock(&stop_lock);
> >> +
> >> +	atomic_dec(&waiting_for_crash_ipi);
> >> +
> >> +	local_irq_disable();
> >> +
> >> +	if (cpu_ops[cpu]->cpu_die)
> >> +		cpu_ops[cpu]->cpu_die(cpu);
> >> +
> >> +	/* just in case */
> >> +	while (1)
> >> +		wfi();
> 
> Having thought about this some more: I don't think spinning like this is safe.
> We need to spin with the MMU turned off, otherwise this core will pollute the
> kdump kernel with TLB entries from the old page tables.

I think that wfi() will never wake up since local interrupts are disabled
here. So how can it pollute the kdump kernel?

> Suzuki added code to
> catch this happening with cpu hotplug (grep CPU_STUCK_IN_KERNEL in
> arm64/for-next/core), but that won't help here. If 'CPU_STUCK_IN_KERNEL' was set
> by a core, I don't think we can kexec/kdump for this reason.

I will need to look into Suzuki's code.

> Something like cpu_die() for spin-table is needed, naively I think it should
> turn the MMU off, and jump back into the secondary_holding_pen, but the core
> would still be stuck in the kernel, and the memory addresses associated with
> secondary_holding_pen can't be re-used. (which is fine for kdump, but not kexec)

Please note that the code is exercised only in kdump case
through machine_crash_shutdown().

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
