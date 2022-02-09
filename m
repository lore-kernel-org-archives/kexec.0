From: Baoquan He <bhe@redhat.com>
Date: Wed, 9 Feb 2022 16:44:10 +0800
Subject: [PATCHv2] kexec: disable cpu hotplug until the rebooting cpu is
 stable
In-Reply-To: <YgNt4slCVxHRex8z@piliu.users.ipa.redhat.com>
References: <20220127090215.32000-1-kernelfans@gmail.com>
 <20220127094144.GC13508@MiWiFi-R3L-srv>
 <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
 <YgI5AFoL4b/5MJEp@MiWiFi-R3L-srv>
 <YgNt4slCVxHRex8z@piliu.users.ipa.redhat.com>
Message-ID: <YgN+2gAoeyp05MV7@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/09/22 at 03:31pm, Pingfan Liu wrote:
> On Tue, Feb 08, 2022 at 05:33:52PM +0800, Baoquan He wrote:
> > On 01/28/22 at 03:41pm, Pingfan Liu wrote:
> > > On Thu, Jan 27, 2022 at 05:41:44PM +0800, Baoquan He wrote:
> > > Hi Baoquan,
> > > 
> > > Thanks for reviewing, please see comment inlined
> > > > Hi Pingfan,
> > > > 
> > > > On 01/27/22 at 05:02pm, Pingfan Liu wrote:
> > > > > The following identical code piece appears in both
> > > > > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> > > > > 
> > > > > 	if (!cpu_online(primary_cpu))
> > > > > 		primary_cpu = cpumask_first(cpu_online_mask);
> > > > > 
> > > > > This is due to a breakage like the following:
> > > > >    migrate_to_reboot_cpu();
> > > > >    cpu_hotplug_enable();
> > > > >                           --> comes a cpu_down(this_cpu) on other cpu
> > > > >    machine_shutdown();
> > > > > 
> > > > > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > > > > this code looks a little confusing.
> > > > > 
> > > > > Make things straight forward by keeping cpu hotplug disabled until
> > > > > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > > > > breakage is squashed out and the rebooting cpu can keep unchanged.
> > > > 
> > > > If I didn't go through code wrongly, you may miss the x86 case.
> > > > Several ARCHes do call smp_shutdown_nonboot_cpus() in machine_shutdown()
> > > > in kexec reboot code path, while x86 doesn't. If I am right, you may
> > > > need reconsider if this patch is needed or need be adjustd.
> > > > 
> > > Citing the code piece in kernel_kexec()
> > > 
> > >                 migrate_to_reboot_cpu();
> > > 
> > >                 /*
> > >                  * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > >                  * no further code needs to use CPU hotplug (which is true in
> > >                  * the reboot case). However, the kexec path depends on using
> > >                  * CPU hotplug again; so re-enable it here.
> > >                  */
> > >                 cpu_hotplug_enable();
> > >                 pr_notice("Starting new kernel\n");
> > >                 machine_shutdown();
> > > 
> > > So maybe it can be considered in such way: "cpu_hotplug_enable()" is not
> > > needed by x86 and ppc, so this patch removes it, while re-displace it in
> > > a more appropriate place for arm64/riscv ...
> > 
> > OK, so the thing is:
> > 
> > ==
> > In the current code of kexec, we disable cpu hotplug and check reboot cpu
> > validity in migrate_to_reboot_cpu(), then enable cpu hotplug. Then in
> > machine_shutdown()->smp_shutdown_nonboot_cpus(), check the reboot cpu and
> > disable cpu hotplug again.
>   ^^^
> No, there is no any new call to cpu_hotplug_disable() after
> migrate_to_reboot_cpu(). smp_shutdown_nonboot_cpus() just leaves
> cpu_hotplug_disabled==0 as it is.

Hmm, there's 'cpu_hotplug_disabled++;' at the end of
smp_shutdown_nonboot_cpus(). It's disabling cpu hotplug again, I think.

> > 
> > In this patch, it disables cpu hotplug in migrate_to_reboot_cpu() and
> > keep it till entering into smp_shutdown_nonboot_cpus() to shutdown all
> > other cpu with hotplug mechanism, then disable it again. With this
>                                          ^^^
> Here is enable, i.e. smp_shutdown_nonboot_cpus() makes
> cpu_hotplug_disabled switch from 1 to 0, so the following fn can work

Right, you keep the cpu hotplug disabled till in
smp_shutdown_nonboot_cpus(), then enable it to shut down all other cpus.

> ||	static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
> ||	{
> ||		if (cpu_hotplug_disabled)
> ||			return -EBUSY;
> ||		return _cpu_down(cpu, 0, target);
> ||	}
> 
> > change, it won't need to double check the reboot cpu validity. 
> > 
> > This change only affect ARCHes relying on hotplug to shutdown cpu before
> > kexec reboot, e.g arm64, risc-v. Other ARCH like x86 is not affected.
> 
> Yes.
> > ==
> > 
> > Do I got it right?
> > 
> Here, neither the original code nor this patch has another
> cpu_hotplug_disable(), the only change is the shift of cpu_hotplug_enable() to an onwards place.
> 
> And I think you should get my idea except this.
> 
> Thanks,
> 
> 	Pingfan
> 


