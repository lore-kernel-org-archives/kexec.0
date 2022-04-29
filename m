From: Michael Kelley (LINUX) <mikelley@microsoft.com>
Date: Fri, 29 Apr 2022 16:26:02 +0000
Subject: [PATCH 02/30] ARM: kexec: Disable IRQs/FIQs also on crash CPUs
 shutdown path
In-Reply-To: <20220427224924.592546-3-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-3-gpiccoli@igalia.com>
Message-ID: <PH0PR21MB3025F5AADF3CCEF714585912D7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Wednesday, April 27, 2022 3:49 PM
> 
> Currently the regular CPU shutdown path for ARM disables IRQs/FIQs
> in the secondary CPUs - smp_send_stop() calls ipi_cpu_stop(), which
> is responsible for that. This makes sense, since we're turning off
> such CPUs, putting them in an endless busy-wait loop.
> 
> Problem is that there is an alternative path for disabling CPUs,
> in the form of function crash_smp_send_stop(), used for kexec/panic
> paths. This functions relies in a SMP call that also triggers a

s/functions relies in/function relies on/

> busy-wait loop [at machine_crash_nonpanic_core()], but *without*
> disabling interrupts. This might lead to odd scenarios, like early
> interrupts in the boot of kexec'd kernel or even interrupts in
> other CPUs while the main one still works in the panic path and
> assumes all secondary CPUs are (really!) off.
> 
> This patch mimics the ipi_cpu_stop() interrupt disable mechanism
> in the crash CPU shutdown path, hence disabling IRQs/FIQs in all
> secondary CPUs in the kexec/panic path as well.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  arch/arm/kernel/machine_kexec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index f567032a09c0..ef788ee00519 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -86,6 +86,9 @@ void machine_crash_nonpanic_core(void *unused)
>  	set_cpu_online(smp_processor_id(), false);
>  	atomic_dec(&waiting_for_crash_ipi);
> 
> +	local_fiq_disable();
> +	local_irq_disable();
> +
>  	while (1) {
>  		cpu_relax();
>  		wfe();
> --
> 2.36.0


