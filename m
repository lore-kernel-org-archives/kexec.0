From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 10 May 2022 11:38:57 +0800
Subject: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <87ee13rn52.ffs@tglx>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com> <87ee13rn52.ffs@tglx>
Message-ID: <YnneUeRJ42SRM/M+@piliu.users.ipa.redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, May 09, 2022 at 12:55:21PM +0200, Thomas Gleixner wrote:
> On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
> > The following code chunk repeats in both
> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> >
> > 	if (!cpu_online(primary_cpu))
> > 		primary_cpu = cpumask_first(cpu_online_mask);
> >
> > This is due to a breakage like the following:
> 
> I don't see what's broken here.
> 

No, no broken. Could it be better to replace 'breakage' with 'breakin'?

> > kernel_kexec()
> >    migrate_to_reboot_cpu();
> >    cpu_hotplug_enable();
> >                         -----------> comes a cpu_down(this_cpu) on other cpu
> >    machine_shutdown();
> >      smp_shutdown_nonboot_cpus(); // re-check "if (!cpu_online(primary_cpu))" to protect against the former breakin
> >
> > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > this code looks a little confusing.
> 
> Confusing != broken.
> 

Yes. And it only recurs confusing.

> > +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
> 
> This comment makes no sense.
> 

Since migrate_to_reboot_cpu() disables cpu hotplug, so the selected
valid online cpu -- primary_cpu keeps unchange.

> >  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> >  {
> >  	unsigned int cpu;
> >  	int error;
> >  
> > +	/*
> > +	 * Block other cpu hotplug event, so primary_cpu is always online if
> > +	 * it is not touched by us
> > +	 */
> >  	cpu_maps_update_begin();
> > -
> >  	/*
> > -	 * Make certain the cpu I'm about to reboot on is online.
> > -	 *
> > -	 * This is inline to what migrate_to_reboot_cpu() already do.
> > +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > +	 * no further code needs to use CPU hotplug (which is true in
> > +	 * the reboot case). However, the kexec path depends on using
> > +	 * CPU hotplug again; so re-enable it here.
> 
> You want to reduce confusion, but in reality this is even more confusing
> than before.
> 

This __cpu_hotplug_enable() can be considered to defer from kernel_kexec() to
arch-dependent code chunk (here), which is a more proper point.

Could it make things better by rephrasing the words as the following?
   migrate_to_reboot_cpu() disables CPU hotplug to prevent the selected
   reboot cpu from disappearing. But arches need cpu_down to hot remove
   cpus except rebooting-cpu, so re-enabling cpu hotplug again.

> >  	 */
> > -	if (!cpu_online(primary_cpu))
> > -		primary_cpu = cpumask_first(cpu_online_mask);
> > +	__cpu_hotplug_enable();
> 
> How is this decrement solving anything? At the end of this function, the
> counter is incremented again. So what's the point of this exercise?
> 

This decrement enables the cpu hot-removing.  Since
smp_shutdown_nonboot_cpus()->cpu_down_maps_locked(), if
cpu_hotplug_disabled, it returns -EBUSY. 

On the other hand, at the end of this function, cpu_hotplug_disabled++,
which aims to prevent any new coming cpu, since machine_kexec() assumes
to execute on the only rebooting-cpu, any dangling cpu has unexpected
result.

> >  	for_each_online_cpu(cpu) {
> >  		if (cpu == primary_cpu)
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 68480f731192..db4fa6b174e3 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
> >  		kexec_in_progress = true;
> >  		kernel_restart_prepare("kexec reboot");
> >  		migrate_to_reboot_cpu();
> > -
> >  		/*
> > -		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > -		 * no further code needs to use CPU hotplug (which is true in
> > -		 * the reboot case). However, the kexec path depends on using
> > -		 * CPU hotplug again; so re-enable it here.
> > +		 * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> > +		 * relies on the cpu teardown to achieve reboot, it needs to
> > +		 * re-enable CPU hotplug there.
> 
> What does that for arch/powerpc/kernel/kexec_machine64.c now?
> 
> Nothing, as far as I can tell. Which means you basically reverted
> 011e4b02f1da ("powerpc, kexec: Fix "Processor X is stuck" issue during
> kexec from ST mode") unless I'm completely confused.
> 

Oops. Forget about powerpc. Considering the cpu hotplug is an
arch-dependent feature in machine_shutdown(), as x86 does not need it.

What about supplying an cpu hotplug enable in the powerpc machine_kexec implement.

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 6cc7793b8420..8ccf22197f08 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -224,6 +224,7 @@ static void wake_offline_cpus(void)

 static void kexec_prepare_cpus(void)
 {
+       cpu_hotplug_enable();
        wake_offline_cpus();
        smp_call_function(kexec_smp_down, NULL, /* wait */0);
        local_irq_disable();


> >  		 */
> > -		cpu_hotplug_enable();
> 
> This is tinkering at best. Can we please sit down and rethink this whole
> machinery instead of applying random duct tape to it?
> 

I try to make code look consistent. As in the current source tree.
There are three sequential sites trying to resolve the valid rebooting cpu:

1.
void migrate_to_reboot_cpu(void)
{
	/* The boot cpu is always logical cpu 0 */
	int cpu = reboot_cpu;

	cpu_hotplug_disable();

	/* Make certain the cpu I'm about to reboot on is online */
	if (!cpu_online(cpu))
		cpu = cpumask_first(cpu_online_mask);
...
}

2. In each arches machine_shutdown(), the input param primary_cpu for
smp_shutdown_nonboot_cpus() looks a little arbitrary.

$git grep smp_shutdown_nonboot_cpus -- arch | grep -v \*
arch/arm/kernel/reboot.c:94:    smp_shutdown_nonboot_cpus(reboot_cpu);
arch/arm64/kernel/process.c:89: smp_shutdown_nonboot_cpus(reboot_cpu);
arch/ia64/kernel/process.c:578: smp_shutdown_nonboot_cpus(reboot_cpu);
arch/riscv/kernel/machine_kexec.c:135:  smp_shutdown_nonboot_cpus(smp_processor_id());

3. finally
smp_shutdown_nonboot_cpus(primary_cpu)
{
...
	if (!cpu_online(primary_cpu))
		primary_cpu = cpumask_first(cpu_online_mask);
...
}


With this series, the 3rd can be removed, and the 2nd can be unified to
smp_processor_id().


Thanks,

	Pingfan

