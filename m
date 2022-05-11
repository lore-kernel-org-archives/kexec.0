From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 11 May 2022 17:09:40 +0800
Subject: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <87y1z9pzac.ffs@tglx>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com> <87ee13rn52.ffs@tglx>
 <YnneUeRJ42SRM/M+@piliu.users.ipa.redhat.com> <87y1z9pzac.ffs@tglx>
Message-ID: <Ynt9VHkNYEzsSRnF@piliu.users.ipa.redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, May 10, 2022 at 10:28:11AM +0200, Thomas Gleixner wrote:
> On Tue, May 10 2022 at 11:38, Pingfan Liu wrote:
> > On Mon, May 09, 2022 at 12:55:21PM +0200, Thomas Gleixner wrote:
> >> On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
> >> > The following code chunk repeats in both
> >> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> >> > This is due to a breakage like the following:
> >> 
> >> I don't see what's broken here.
> >> 
> >
> > No, no broken. Could it be better to replace 'breakage' with
> > 'breakin'?
> 
> There is no break-in. There is a phase where CPU hotplug is reenabled,
> which might be avoided.
> 

OK, I will rephrase like this.

> >> > +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
> >> 
> >> This comment makes no sense.
> >> 
> >
> > Since migrate_to_reboot_cpu() disables cpu hotplug, so the selected
> > valid online cpu -- primary_cpu keeps unchange.
> 
> So what is that parameter for then? If migrate_to_reboot_cpu() ensured
> that the current task is on the reboot CPU then this parameter is
> useless, no?
> 

Yes, it is useless after this patch. I will post V4 to kill it.

> >> >  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> >> >  {
> >> >  	unsigned int cpu;
> >> >  	int error;
> >> >  
> >> > +	/*
> >> > +	 * Block other cpu hotplug event, so primary_cpu is always online if
> >> > +	 * it is not touched by us
> >> > +	 */
> >> >  	cpu_maps_update_begin();
> >> > -
> >> >  	/*
> >> > -	 * Make certain the cpu I'm about to reboot on is online.
> >> > -	 *
> >> > -	 * This is inline to what migrate_to_reboot_cpu() already do.
> >> > +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> >> > +	 * no further code needs to use CPU hotplug (which is true in
> >> > +	 * the reboot case). However, the kexec path depends on using
> >> > +	 * CPU hotplug again; so re-enable it here.
> >> 
> >> You want to reduce confusion, but in reality this is even more confusing
> >> than before.
> >> 
> >
> > This __cpu_hotplug_enable() can be considered to defer from kernel_kexec() to
> > arch-dependent code chunk (here), which is a more proper point.
> >
> > Could it make things better by rephrasing the words as the following?
> >    migrate_to_reboot_cpu() disables CPU hotplug to prevent the selected
> >    reboot cpu from disappearing. But arches need cpu_down to hot remove
> >    cpus except rebooting-cpu, so re-enabling cpu hotplug again.
> 
> Can you please use proper words. arches is not a word and it's closer to
> the plural of arch, than to the word architecture. This is not twitter.
> 

OK, I will correct it.

> And no, the architectures do not need cpu_down() at all. This very
> function smp_shutdown_nonboot_cpus() invokes cpu_down_maps_locked() to
> shut down the non boot CPUs. That fails when cpu_hotplug_disabled != 0.
> 

Yes. I will pay attention to the accuracy of the description.

> >> >  	 */
> >> > -	if (!cpu_online(primary_cpu))
> >> > -		primary_cpu = cpumask_first(cpu_online_mask);
> >> > +	__cpu_hotplug_enable();
> >> 
> >> How is this decrement solving anything? At the end of this function, the
> >> counter is incremented again. So what's the point of this exercise?
> >> 
> > This decrement enables the cpu hot-removing.  Since
> > smp_shutdown_nonboot_cpus()->cpu_down_maps_locked(), if
> > cpu_hotplug_disabled, it returns -EBUSY.
> 
> Correct, so why can't you spell that out in concise words in the first
> place right at that comment which reenables hotplug?
> 

OK, thanks for the suggestion.

> >> What does that for arch/powerpc/kernel/kexec_machine64.c now?
> >> 
> >> Nothing, as far as I can tell. Which means you basically reverted
> >> 011e4b02f1da ("powerpc, kexec: Fix "Processor X is stuck" issue during
> >> kexec from ST mode") unless I'm completely confused.
> >> 
> >
> > Oops. Forget about powerpc. Considering the cpu hotplug is an
> > arch-dependent feature in machine_shutdown(), as x86 does not need it.
> 
> It's not a feature, it's a architecture specific requirement. x86 is
> irrelevant here because this is a powerpc requirement.
> 

Yes.

> >> This is tinkering at best. Can we please sit down and rethink this whole
> >> machinery instead of applying random duct tape to it?
> >> 
> > I try to make code look consistent.
> 
> Emphasis on try. So far the attempt failed and resulted in a regression.
> 

I will fix the powerpc issue and post V4 after a test.


Thanks for your precious time.

Best Regards,

	Pingfan


