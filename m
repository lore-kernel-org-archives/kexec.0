Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYe97-0007dk-Dd
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 04:46:03 -0400
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <m1y7f0k6p4.fsf@ebiederm.dsl.xmission.com>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<m1y7f0k6p4.fsf@ebiederm.dsl.xmission.com>
Date: Fri, 21 Sep 2007 16:42:34 +0800
Message-Id: <1190364154.21818.182.camel@caritas-dev.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thu, 2007-09-20 at 22:01 -0600, Eric W. Biederman wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > Index: linux-2.6.23-rc6/include/linux/kexec.h
> > ===================================================================
> > --- linux-2.6.23-rc6.orig/include/linux/kexec.h 2007-09-20 11:24:25.000000000
> > +0800
> > +++ linux-2.6.23-rc6/include/linux/kexec.h 2007-09-20 11:26:03.000000000 +0800
> > @@ -83,6 +83,7 @@
> >  
> >  	unsigned long start;
> >  	struct page *control_code_page;
> > +	struct page *swap_page;
> >  
> >  	unsigned long nr_segments;
> >  	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
> > @@ -194,4 +195,12 @@
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> >  #endif /* CONFIG_KEXEC */
> > +
> > +#ifdef CONFIG_KEXEC_JUMP
> > +extern int machine_kexec_jump(struct kimage *image);
> > +extern unsigned long kexec_jump_back_entry;
> > +extern int kexec_jump(void);
> > +#else /* !CONFIG_KEXEC_JUMP */
> > +static inline int kexec_jump(void) { return 0; }
> > +#endif /* CONFIG_KEXEC_JUMP */
> >  #endif /* LINUX_KEXEC_H */
> 
> Please the kexec_jump code just be triggered off of a flag in
> struct kimage.  We just need to define an extra flag to sys_kexec_load
> say KEXEC_RETURNS.  Ideally in the long term we would not have to
> do anything except to accept the flag.  Adding a flag makes
> a nice feature test if you want to see if your kernel supports
> the extended version of kexec.
> 
> Until we get the hibernation methods sorted out storing the flag in
> struct kimage and making the methods that we call conditional feels
> like a more maintainable interface.  Especially since we have to
> know at kexec image load time what we are going to do with the
> kexec image.

You mean we use KEXEC_RETURNS when do sys_kexec_load, then use ordinary
reboot command LINUX_REBOOT_CMD_KEXEC, which call kexec_jump conditional
based on KEXEC_RETURNS? This is reasonable. I will change it.

> > +#ifdef CONFIG_KEXEC_JUMP
> > +unsigned long kexec_jump_back_entry;
> > +
> > +int kexec_jump(void)
> > +{
> > +	int error;
> > +
> > +	if (!kexec_image)
> > +		return -EINVAL;
> 
> I understand where you are coming from with this implementation of
> kexec_jump but it looks like this is one of the big parts of this
> patch that have not reached their final form.
> 
> The line above is racy with sys_kexec_load.

Yes. I should use xchg(&kexec_image, NULL) as that of other kexec
related functions.

> > +	pm_prepare_console();
> > +	suspend_console();
> > +	error = device_suspend(PMSG_FREEZE);
> > +	if (error)
> > +		goto Resume_console;
> 
> This as everyone knows needs to be device_shutdown or a better hibernation
> replacement.

Yes.

> > +	error = disable_nonboot_cpus();
> > +	if (error)
> > +		goto Resume_devices;
> 
> Can't we just catch the noboot cpu's in a mutex.
> disable_nonboot_cpus is actually impossible to implement 100% reliably
> with current hardware.  But something smp_call_function so we trap them
> at a specific location and then the equivalent when we come back should
> be simple.  I guess the tricky part is bringing the cpus back up again.
> 
> Using the broken by design version of cpu hotplug really annoys me here.

I think this is not very simple. Given that we may jump back from the
kernel with SMP turned off, or from bootloader directly. But CPU hotplug
is another topic, I think it should be solved in another patch.

> > +	local_irq_disable();
> > +	/* At this point, device_suspend() has been called, but *not*
> > +	 * device_power_down(). We *must* device_power_down() now.
> > +	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
> > +	 * become desynchronized with the actual state of the hardware
> > +	 * at resume time, and evil weirdness ensues.
> > +	 */
> > +	error = device_power_down(PMSG_FREEZE);
> > +	if (error)
> > +		goto Enable_irqs;
> 
> This of course should go away when we have the proper methods.
Yes.
> > +	save_processor_state();
> This line might even be reasonable.
> > +	error = machine_kexec_jump(kexec_image);
> > +	restore_processor_state();
> >
> > +	/* NOTE:  device_power_up() is just a resume() for devices
> > +	 * that suspended with irqs off ... no overall powerup.
> > +	 */
> > +	device_power_up();
> Yep this can go away.
Yes.
> > + Enable_irqs:
> > +	local_irq_enable();
> > +	enable_nonboot_cpus();
> 
> I haven't looked at the cpu start up code yet to see if it
> is generally implementable.  I would think so, but I guess
> we need to be careful with our data structures.
> 
> > + Resume_devices:
> > +	device_resume();
> This of course should change.
Yes.
> > + Resume_console:
> > +	resume_console();
> > +	pm_restore_console();
> 
> Odd.  I'm a little surprised that the console is the last
> thing we restore.  But it does make sense to treat it specially.
> 
> > +	return error;
> > +}
> > +#endif /* CONFIG_KEXEC_JUMP */

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
