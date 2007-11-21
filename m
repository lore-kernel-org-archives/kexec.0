Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Iuvbt-0003ub-Vw
	for kexec@lists.infradead.org; Wed, 21 Nov 2007 14:51:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3 -mm] kexec based hibernation -v6: kexec
	hibernate/resume
Date: Wed, 21 Nov 2007 21:09:31 +0100
References: <1195455769.10291.26.camel@caritas-dev.intel.com>
	<200711210100.32631.rjw@sisk.pl>
	<1195632306.29280.7.camel@caritas-dev.intel.com>
In-Reply-To: <1195632306.29280.7.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200711212109.32925.rjw@sisk.pl>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Wednesday, 21 of November 2007, Huang, Ying wrote:
> On Wed, 2007-11-21 at 01:00 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, 20 of November 2007, Huang, Ying wrote:
> > > On Tue, 2007-11-20 at 03:24 +0100, Rafael J. Wysocki wrote:
> > > > On Tuesday, 20 of November 2007, Huang, Ying wrote:
> > > > > On Mon, 2007-11-19 at 19:22 +0100, Rafael J. Wysocki wrote:
> > > > > > > +#ifdef CONFIG_KEXEC
> > > > > > > +static void kexec_hibernate_power_down(void)
> > > > > > > +{
> > > > > > > +	switch (hibernation_mode) {
> > > > > > > +	case HIBERNATION_TEST:
> > > > > > > +	case HIBERNATION_TESTPROC:
> > > > > > > +		break;
> > > > > > > +	case HIBERNATION_REBOOT:
> > > > > > > +		machine_restart(NULL);
> > > > > > > +		break;
> > > > > > > +	case HIBERNATION_PLATFORM:
> > > > > > > +		if (!hibernation_ops)
> > > > > > > +			break;
> > > > > > > +		hibernation_ops->enter();
> > > > > > 
> > > > > > hibernation_platform_enter() should be used here (as of the current mainline).
> > > > > 
> > > > > The power_down will be called with interrupt disabled, device suspended,
> > > > > non-boot CPU disabled. But the latest hibernate_platform_enter calls the
> > > > > device_suspend, disable_nonboot_cpus etc function. So, I use
> > > > > hibernation_ops->enter() directly instead of
> > > > > hibernation_platform_enter().
> > > > 
> > > > Hm, you need to call device_power_down(PMSG_SUSPEND) before
> > > > hibernation_ops->enter().
> > > > 
> > > > Also, all of the ACPI global calls need to be carried out before that and the
> > > > devices should be suspended rather than shut down in that case.
> > > > 
> > > > That's why hibernation_platform_enter() has been introduced, BTW.
> > > 
> > > Situation is a little different between u/swsusp and khiberantion.
> > > 
> > > u/swsusp:
> > > 
> > > platform_start();
> > > suspend console();
> > > device_suspend(PMSG_FREEZE);
> > > platform_pre_snapshot();
> > > disable_nonboot_cpus();
> > > local_irq_disable();
> > > device_power_down(PMSG_FREEZE);
> > > /* create snapshot */
> > > device_power_up();
> > > local_irq_enable();
> > > enable_nonboot_cpus();
> > > platform_finish();
> > > device_resume();
> > > resume_console();
> > > /* write the image out */
> > > hibernation_ops->start();
> > > suspend_console();
> > > device_suspend(PMSG_SUSPEND);
> > > hibernation_ops->prepare();
> > > disable_nonboot_cpus();
> > > local_irq_disable();
> > > device_power_down(PMSG_SUSPEND);
> > > hibernation_ops->enter();
> > > 
> > > khibernation:
> > > 
> > > suspend_console();
> > > platform_start();
> > > device_suspend(PMSG_FREEZE);
> > > platform_pre_snapshot();
> > > disable_nonboot_cpus();
> > > local_irq_disable();
> > > device_power_down(PMSG_FREEZE);
> > > /* jump to kexeced (hibernating) kernel */
> > > /* in kexeced kernel */
> > > device_power_up();
> > > local_irq_eanble();
> > > enable_nonboot_cpus();
> > 
> > You should call platform_finish() here, or device_resume() will not work
> > appropriately on some systems.
> > 
> > However, after platform_finish() has been executed, the ACPI firmware will
> > assume that the hibernation has been canceled, so you need to tell it that
> > you'd like to go into the low power state after all.
> > 
> > > device_resume();
> > > resume_console();
> > > /* write the image */
> > 
> > For this reason, you have to call hibernation_ops->start() once again
> > and the other functions like in the swsusp case, in that order.
> > 
> > > suspend_console();
> > > device_suspend(PMSG_FREEZE);
> > > disable_nonboot_cpus();
> > > local_irq_disable();
> > > device_power_down(PMSG_FREEZE);
> > > /* jump to original (hibernated) kernel */
> > 
> > This looks too fragile to my eyes.
> > 
> > Why don't you call hibernation_ops->enter() directly from the "kexeced" kernel?
> 
> I don't know whether there are ACPI global state inside Linux kernel. So
> I restrict all ACPI method calling in original kernel. If the ACPI
> global state in Linux kernel is not a issue, I can call
> hibernation_ops->enter() directly in the "kexeced" kernel.

Well, I can't say to what extent the Linux ACPI tracks the global state.
Still, even if it does, you don't need to jump back to the hibernated kernel
just to power off the system.

Actually, if you really want to include ACPI into the picture, which I'm not
sure is the best idea at this point, you should use all of the appropriate
ACPI hooks in the kexeced kernel and you shouldn't get back to the hibernated
kernel after you've saved the image.

Regards,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
