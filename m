From: Baoquan He <bhe@redhat.com>
Date: Tue, 8 Feb 2022 17:33:52 +0800
Subject: [PATCHv2] kexec: disable cpu hotplug until the rebooting cpu is
 stable
In-Reply-To: <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
References: <20220127090215.32000-1-kernelfans@gmail.com>
 <20220127094144.GC13508@MiWiFi-R3L-srv>
 <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
Message-ID: <YgI5AFoL4b/5MJEp@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/28/22 at 03:41pm, Pingfan Liu wrote:
> On Thu, Jan 27, 2022 at 05:41:44PM +0800, Baoquan He wrote:
> Hi Baoquan,
> 
> Thanks for reviewing, please see comment inlined
> > Hi Pingfan,
> > 
> > On 01/27/22 at 05:02pm, Pingfan Liu wrote:
> > > The following identical code piece appears in both
> > > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> > > 
> > > 	if (!cpu_online(primary_cpu))
> > > 		primary_cpu = cpumask_first(cpu_online_mask);
> > > 
> > > This is due to a breakage like the following:
> > >    migrate_to_reboot_cpu();
> > >    cpu_hotplug_enable();
> > >                           --> comes a cpu_down(this_cpu) on other cpu
> > >    machine_shutdown();
> > > 
> > > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > > this code looks a little confusing.
> > > 
> > > Make things straight forward by keeping cpu hotplug disabled until
> > > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > > breakage is squashed out and the rebooting cpu can keep unchanged.
> > 
> > If I didn't go through code wrongly, you may miss the x86 case.
> > Several ARCHes do call smp_shutdown_nonboot_cpus() in machine_shutdown()
> > in kexec reboot code path, while x86 doesn't. If I am right, you may
> > need reconsider if this patch is needed or need be adjustd.
> > 
> Citing the code piece in kernel_kexec()
> 
>                 migrate_to_reboot_cpu();
> 
>                 /*
>                  * migrate_to_reboot_cpu() disables CPU hotplug assuming that
>                  * no further code needs to use CPU hotplug (which is true in
>                  * the reboot case). However, the kexec path depends on using
>                  * CPU hotplug again; so re-enable it here.
>                  */
>                 cpu_hotplug_enable();
>                 pr_notice("Starting new kernel\n");
>                 machine_shutdown();
> 
> So maybe it can be considered in such way: "cpu_hotplug_enable()" is not
> needed by x86 and ppc, so this patch removes it, while re-displace it in
> a more appropriate place for arm64/riscv ...

OK, so the thing is:

==
In the current code of kexec, we disable cpu hotplug and check reboot cpu
validity in migrate_to_reboot_cpu(), then enable cpu hotplug. Then in
machine_shutdown()->smp_shutdown_nonboot_cpus(), check the reboot cpu and
disable cpu hotplug again.

In this patch, it disables cpu hotplug in migrate_to_reboot_cpu() and
keep it till entering into smp_shutdown_nonboot_cpus() to shutdown all
other cpu with hotplug mechanism, then disable it again. With this
change, it won't need to double check the reboot cpu validity. 

This change only affect ARCHes relying on hotplug to shutdown cpu before
kexec reboot, e.g arm64, risc-v. Other ARCH like x86 is not affected.
==

Do I got it right?


