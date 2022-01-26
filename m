From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 26 Jan 2022 10:45:12 +0800
Subject: [PATCH] kexec: disable cpu hotplug until the rebooting cpu is
 stable
In-Reply-To: <87wnin3hj5.mognet@arm.com>
References: <20220125033913.15374-1-kernelfans@gmail.com>
 <87wnin3hj5.mognet@arm.com>
Message-ID: <CAFgQCTvbsh5UhefhDgOu8ZdUKww6FQXw-Hxnz5mC4vs0C+WP1w@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Jan 26, 2022 at 12:29 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 25/01/22 11:39, Pingfan Liu wrote:
> > The following identical code piece appears in both
> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> >
> >       if (!cpu_online(primary_cpu))
> >               primary_cpu = cpumask_first(cpu_online_mask);
> >
> > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > this code looks a little confusing.
> >
> > Make things straight forward by keep cpu hotplug disabled until
> > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > rebooting cpu can keep unchanged.
> >
>
> So is this supposed to be a refactor with no change in behaviour? AFAICT it
> actually does change things (and isn't necessarily clearer).
>
Yes, as you have seen, it does change behavior. Before this patch,
there is a breakage:
  migrate_to_reboot_cpu();
  cpu_hotplug_enable();
                                     ----------> technical, here can
comes a cpu_down(this_cpu)
  machine_shutdown();

And this patch squeezes out this breakage.

> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: YueHaibing <yuehaibing@huawei.com>
> > Cc: Baokun Li <libaokun1@huawei.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: kexec at lists.infradead.org
> > To: linux-kernel at vger.kernel.org
> > ---
> >  kernel/cpu.c        | 16 ++++++++++------
> >  kernel/kexec_core.c | 10 ++++------
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 407a2568f35e..bc687d59ca90 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1227,20 +1227,24 @@ int remove_cpu(unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(remove_cpu);
> >
> > +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
> >  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> >  {
> >       unsigned int cpu;
> >       int error;
> >
> > +     /*
> > +      * Block other cpu hotplug event, so primary_cpu is always online if
> > +      * it is not touched by us
> > +      */
> >       cpu_maps_update_begin();
> > -
> >       /*
> > -      * Make certain the cpu I'm about to reboot on is online.
> > -      *
> > -      * This is inline to what migrate_to_reboot_cpu() already do.
> > +      * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > +      * no further code needs to use CPU hotplug (which is true in
> > +      * the reboot case). However, the kexec path depends on using
> > +      * CPU hotplug again; so re-enable it here.
> >        */
> > -     if (!cpu_online(primary_cpu))
> > -             primary_cpu = cpumask_first(cpu_online_mask);
> > +     __cpu_hotplug_enable();
> >
> >       for_each_online_cpu(cpu) {
> >               if (cpu == primary_cpu)
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 68480f731192..db4fa6b174e3 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
> >               kexec_in_progress = true;
> >               kernel_restart_prepare("kexec reboot");
> >               migrate_to_reboot_cpu();
> > -
> >               /*
> > -              * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > -              * no further code needs to use CPU hotplug (which is true in
> > -              * the reboot case). However, the kexec path depends on using
> > -              * CPU hotplug again; so re-enable it here.
> > +              * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> > +              * relies on the cpu teardown to achieve reboot, it needs to
> > +              * re-enable CPU hotplug there.
> >                */
> > -             cpu_hotplug_enable();
> > +
>
> Not all archs map machine_shutdown() to smp_shutdown_nonboot_cpus(), other
> archs will now be missing a cpu_hotplug_enable() prior to a kexec
> machine_shutdown(). That said, AFAICT none of those archs rely on the
> hotplug machinery in machine_shutdown(), so it might be OK, but that's not
> obvious at all.
>
At the first glance, it may be not obvious, but tracing down
cpu_hotplug_enable() to the variable cpu_hotplug_disabled, you can
find out the limited involved functions are all related to
cpu_up/cpu_down.

IOW, if no code path connects with the interface of cpu_up/cpu_down,
then kexec-reboot will not be affected.

And after this patch, it is more clear how to handle the following cases:
arch/arm/kernel/reboot.c:94:    smp_shutdown_nonboot_cpus(reboot_cpu);
arch/arm64/kernel/process.c:88: smp_shutdown_nonboot_cpus(reboot_cpu);
arch/ia64/kernel/process.c:578: smp_shutdown_nonboot_cpus(reboot_cpu);

Thanks,
Pingfan

