Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1IuJAi-0002yo-H5
	for kexec@lists.infradead.org; Mon, 19 Nov 2007 21:49:15 -0500
Subject: Re: [PATCH 3/3 -mm] kexec based hibernation -v6: kexec
	hibernate/resume
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <200711200324.31180.rjw@sisk.pl>
References: <1195455769.10291.26.camel@caritas-dev.intel.com>
	<200711191922.44008.rjw@sisk.pl>
	<1195523808.11955.27.camel@caritas-dev.intel.com>
	<200711200324.31180.rjw@sisk.pl>
Date: Tue, 20 Nov 2007 10:50:33 +0800
Message-Id: <1195527033.11955.50.camel@caritas-dev.intel.com>
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

On Tue, 2007-11-20 at 03:24 +0100, Rafael J. Wysocki wrote:
> On Tuesday, 20 of November 2007, Huang, Ying wrote:
> > On Mon, 2007-11-19 at 19:22 +0100, Rafael J. Wysocki wrote:
> > > > +#ifdef CONFIG_KEXEC
> > > > +static void kexec_hibernate_power_down(void)
> > > > +{
> > > > +	switch (hibernation_mode) {
> > > > +	case HIBERNATION_TEST:
> > > > +	case HIBERNATION_TESTPROC:
> > > > +		break;
> > > > +	case HIBERNATION_REBOOT:
> > > > +		machine_restart(NULL);
> > > > +		break;
> > > > +	case HIBERNATION_PLATFORM:
> > > > +		if (!hibernation_ops)
> > > > +			break;
> > > > +		hibernation_ops->enter();
> > > 
> > > hibernation_platform_enter() should be used here (as of the current mainline).
> > 
> > The power_down will be called with interrupt disabled, device suspended,
> > non-boot CPU disabled. But the latest hibernate_platform_enter calls the
> > device_suspend, disable_nonboot_cpus etc function. So, I use
> > hibernation_ops->enter() directly instead of
> > hibernation_platform_enter().
> 
> Hm, you need to call device_power_down(PMSG_SUSPEND) before
> hibernation_ops->enter().
> 
> Also, all of the ACPI global calls need to be carried out before that and the
> devices should be suspended rather than shut down in that case.
> 
> That's why hibernation_platform_enter() has been introduced, BTW.

Situation is a little different between u/swsusp and khiberantion.

u/swsusp:

platform_start();
suspend console();
device_suspend(PMSG_FREEZE);
platform_pre_snapshot();
disable_nonboot_cpus();
local_irq_disable();
device_power_down(PMSG_FREEZE);
/* create snapshot */
device_power_up();
local_irq_enable();
enable_nonboot_cpus();
platform_finish();
device_resume();
resume_console();
/* write the image out */
hibernation_ops->start();
suspend_console();
device_suspend(PMSG_SUSPEND);
hibernation_ops->prepare();
disable_nonboot_cpus();
local_irq_disable();
device_power_down(PMSG_SUSPEND);
hibernation_ops->enter();

khibernation:

suspend_console();
platform_start();
device_suspend(PMSG_FREEZE);
platform_pre_snapshot();
disable_nonboot_cpus();
local_irq_disable();
device_power_down(PMSG_FREEZE);
/* jump to kexeced (hibernating) kernel */
/* in kexeced kernel */
device_power_up();
local_irq_eanble();
enable_nonboot_cpus();
device_resume();
resume_console();
/* write the image */
suspend_console();
device_suspend(PMSG_FREEZE);
disable_nonboot_cpus();
local_irq_disable();
device_power_down(PMSG_FREEZE);
/* jump to original (hibernated) kernel */
/* in original kernel */
hibernation_ops->enter();

The difference is:

- In u/swsusp, ACPI methods are executed twice, before writing out the
image and after writing out the image.
- After writing out the image, the PMSG_SUSPEND is used instead of
PMSG_FREEZE.

Some questions:

- What is the difference between PMSG_SUSPEND and PMSG_FREEZE?
- The ACPI methods should be executed once or twice? According to ACPI
specification?

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
