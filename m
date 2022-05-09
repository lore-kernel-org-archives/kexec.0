From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 09 May 2022 12:55:21 +0200
Subject: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <20220509041305.15056-2-kernelfans@gmail.com>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com>
Message-ID: <87ee13rn52.ffs@tglx>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
> The following code chunk repeats in both
> migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
>
> 	if (!cpu_online(primary_cpu))
> 		primary_cpu = cpumask_first(cpu_online_mask);
>
> This is due to a breakage like the following:

I don't see what's broken here.

> kernel_kexec()
>    migrate_to_reboot_cpu();
>    cpu_hotplug_enable();
>                         -----------> comes a cpu_down(this_cpu) on other cpu
>    machine_shutdown();
>      smp_shutdown_nonboot_cpus(); // re-check "if (!cpu_online(primary_cpu))" to protect against the former breakin
>
> Although the kexec-reboot task can get through a cpu_down() on its cpu,
> this code looks a little confusing.

Confusing != broken.

> +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */

This comment makes no sense.

>  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
>  {
>  	unsigned int cpu;
>  	int error;
>  
> +	/*
> +	 * Block other cpu hotplug event, so primary_cpu is always online if
> +	 * it is not touched by us
> +	 */
>  	cpu_maps_update_begin();
> -
>  	/*
> -	 * Make certain the cpu I'm about to reboot on is online.
> -	 *
> -	 * This is inline to what migrate_to_reboot_cpu() already do.
> +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> +	 * no further code needs to use CPU hotplug (which is true in
> +	 * the reboot case). However, the kexec path depends on using
> +	 * CPU hotplug again; so re-enable it here.

You want to reduce confusion, but in reality this is even more confusing
than before.

>  	 */
> -	if (!cpu_online(primary_cpu))
> -		primary_cpu = cpumask_first(cpu_online_mask);
> +	__cpu_hotplug_enable();

How is this decrement solving anything? At the end of this function, the
counter is incremented again. So what's the point of this exercise?

>  	for_each_online_cpu(cpu) {
>  		if (cpu == primary_cpu)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..db4fa6b174e3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
> -
>  		/*
> -		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> -		 * no further code needs to use CPU hotplug (which is true in
> -		 * the reboot case). However, the kexec path depends on using
> -		 * CPU hotplug again; so re-enable it here.
> +		 * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> +		 * relies on the cpu teardown to achieve reboot, it needs to
> +		 * re-enable CPU hotplug there.

What does that for arch/powerpc/kernel/kexec_machine64.c now?

Nothing, as far as I can tell. Which means you basically reverted
011e4b02f1da ("powerpc, kexec: Fix "Processor X is stuck" issue during
kexec from ST mode") unless I'm completely confused.

>  		 */
> -		cpu_hotplug_enable();

This is tinkering at best. Can we please sit down and rethink this whole
machinery instead of applying random duct tape to it?

Thanks,

        tglx

