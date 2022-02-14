From: Pingfan Liu <kernelfans@gmail.com>
Date: Mon, 14 Feb 2022 10:38:22 +0800
Subject: [PATCHv2] kexec: disable cpu hotplug until the rebooting cpu is
 stable
In-Reply-To: <20220127090215.32000-1-kernelfans@gmail.com>
References: <20220127090215.32000-1-kernelfans@gmail.com>
Message-ID: <CAFgQCTsVyH5mctKeYpBJY3GvmODDMq3xmqT+z0C0pOZNjjPXxw@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Gently ping, maintainers, could you share your opinions?


Thanks

On Thu, Jan 27, 2022 at 5:02 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> The following identical code piece appears in both
> migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
>
>         if (!cpu_online(primary_cpu))
>                 primary_cpu = cpumask_first(cpu_online_mask);
>
> This is due to a breakage like the following:
>    migrate_to_reboot_cpu();
>    cpu_hotplug_enable();
>                           --> comes a cpu_down(this_cpu) on other cpu
>    machine_shutdown();
>
> Although the kexec-reboot task can get through a cpu_down() on its cpu,
> this code looks a little confusing.
>
> Make things straight forward by keeping cpu hotplug disabled until
> smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> breakage is squashed out and the rebooting cpu can keep unchanged.
>
> Note: this patch only affects the kexec-reboot on arches, which rely on
> cpu hotplug mechanism.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: Baokun Li <libaokun1@huawei.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: kexec at lists.infradead.org
> To: linux-kernel at vger.kernel.org
> ---
> v1 -> v2:
>  improve commit log
>
>  kernel/cpu.c        | 16 ++++++++++------
>  kernel/kexec_core.c | 10 ++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c92147f0812..87bdf21de950 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1240,20 +1240,24 @@ int remove_cpu(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(remove_cpu);
>
> +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
>  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
>  {
>         unsigned int cpu;
>         int error;
>
> +       /*
> +        * Block other cpu hotplug event, so primary_cpu is always online if
> +        * it is not touched by us
> +        */
>         cpu_maps_update_begin();
> -
>         /*
> -        * Make certain the cpu I'm about to reboot on is online.
> -        *
> -        * This is inline to what migrate_to_reboot_cpu() already do.
> +        * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> +        * no further code needs to use CPU hotplug (which is true in
> +        * the reboot case). However, the kexec path depends on using
> +        * CPU hotplug again; so re-enable it here.
>          */
> -       if (!cpu_online(primary_cpu))
> -               primary_cpu = cpumask_first(cpu_online_mask);
> +       __cpu_hotplug_enable();
>
>         for_each_online_cpu(cpu) {
>                 if (cpu == primary_cpu)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..db4fa6b174e3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
>                 kexec_in_progress = true;
>                 kernel_restart_prepare("kexec reboot");
>                 migrate_to_reboot_cpu();
> -
>                 /*
> -                * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> -                * no further code needs to use CPU hotplug (which is true in
> -                * the reboot case). However, the kexec path depends on using
> -                * CPU hotplug again; so re-enable it here.
> +                * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> +                * relies on the cpu teardown to achieve reboot, it needs to
> +                * re-enable CPU hotplug there.
>                  */
> -               cpu_hotplug_enable();
> +
>                 pr_notice("Starting new kernel\n");
>                 machine_shutdown();
>         }
> --
> 2.31.1
>

