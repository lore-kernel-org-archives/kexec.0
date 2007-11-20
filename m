Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1IuIIM-0007mK-RS
	for kexec@lists.infradead.org; Mon, 19 Nov 2007 20:53:05 -0500
Subject: Re: [PATCH 3/3 -mm] kexec based hibernation -v6: kexec
	hibernate/resume
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <200711191922.44008.rjw@sisk.pl>
References: <1195455769.10291.26.camel@caritas-dev.intel.com>
	<200711191922.44008.rjw@sisk.pl>
Date: Tue, 20 Nov 2007 09:56:48 +0800
Message-Id: <1195523808.11955.27.camel@caritas-dev.intel.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Mon, 2007-11-19 at 19:22 +0100, Rafael J. Wysocki wrote:
> > +#ifdef CONFIG_KEXEC
> > +static void kexec_hibernate_power_down(void)
> > +{
> > +	switch (hibernation_mode) {
> > +	case HIBERNATION_TEST:
> > +	case HIBERNATION_TESTPROC:
> > +		break;
> > +	case HIBERNATION_REBOOT:
> > +		machine_restart(NULL);
> > +		break;
> > +	case HIBERNATION_PLATFORM:
> > +		if (!hibernation_ops)
> > +			break;
> > +		hibernation_ops->enter();
> 
> hibernation_platform_enter() should be used here (as of the current mainline).

The power_down will be called with interrupt disabled, device suspended,
non-boot CPU disabled. But the latest hibernate_platform_enter calls the
device_suspend, disable_nonboot_cpus etc function. So, I use
hibernation_ops->enter() directly instead of
hibernation_platform_enter().

> > +		/* We should never get here */
> > +		while (1);
> > +		break;
> > +	case HIBERNATION_SHUTDOWN:
> > +		machine_power_off();
> > +		break;
> > +	}
> > +	machine_halt();
> > +	/*
> > +	 * Valid image is on the disk, if we continue we risk serious data
> > +	 * corruption after resume.
> > +	 */
> > +	printk(KERN_CRIT "Please power me down manually\n");
> > +	while (1);
> > +}
> 
> Hm, what's the difference between the above function and power_down(),
> actually?

Same as above.

> > +
> > +int kexec_hibernate(struct kimage *image)
> > +{
> > +	int error;
> > +	int platform_mode = (hibernation_mode == HIBERNATION_PLATFORM);
> > +	unsigned long cmd_ret;
> > +
> > +	mutex_lock(&pm_mutex);
> > +
> > +	pm_prepare_console();
> > +	suspend_console();
> > +
> > +	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
> > +	if (error)
> > +		goto Resume_console;
> > +
> > +	error = platform_start(platform_mode);
> > +	if (error)
> > +		goto Resume_console;
> > +
> > +	error = device_suspend(PMSG_FREEZE);
> > +	if (error)
> > +		goto Resume_console;
> > +
> > +	error = platform_pre_snapshot(platform_mode);
> > +	if (error)
> > +		goto Resume_devices;
> > +
> > +	error = disable_nonboot_cpus();
> > +	if (error)
> > +		goto Resume_devices;
> 
> I wonder if it's viable to merge the above with hibernate() and
> hibernation_snapshot() somehow, to avoid code duplication?

Yes. Most code are duplicated. But there is one advantage not to merge
them: power_down can called with IRQ disabled to make it possible to
eliminate the freezer.

I think it is possible to merge the two implementation. I will try to do
it.

> Apart from the above, there's some new debug code to be added to disk.c
> in 2.6.25.  It's in the ACPI test tree right now and you can get it as
> individual patches from:
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24-rc2/patches/
> (patches 10-12).
> 
> Please base your changes on top of that.

OK, I will do it.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
