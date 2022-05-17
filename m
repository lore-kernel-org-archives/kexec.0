From: Petr Mladek <pmladek@suse.com>
Date: Tue, 17 May 2022 15:57:29 +0200
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
Message-ID: <YoOpyW1+q+Z5as78@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon 2022-05-16 12:06:17, Guilherme G. Piccoli wrote:
> Thanks for the review!
> 
> I agree with the blinking stuff, I can rework and add all LED/blinking
> stuff into the loop list, it does make sense. I'll comment a bit in the
> others below...
> 
> On 16/05/2022 11:01, Petr Mladek wrote:
> >> --- a/drivers/firmware/google/gsmi.c
> >> +++ b/drivers/firmware/google/gsmi.c
> >> @@ -1034,7 +1034,7 @@ static __init int gsmi_init(void)
> >>  
> >>  	register_reboot_notifier(&gsmi_reboot_notifier);
> >>  	register_die_notifier(&gsmi_die_notifier);
> >> -	atomic_notifier_chain_register(&panic_notifier_list,
> >> +	atomic_notifier_chain_register(&panic_hypervisor_list,
> >>  				       &gsmi_panic_notifier);
> > 
> > I am not sure about this one. It looks like some logging or
> > pre_reboot stuff.
> > 
> 
> Disagree here. I'm looping Google maintainers, so they can comment.
> (CCed Evan, David, Julius)
> 
> This notifier is clearly a hypervisor notification mechanism. I've fixed
> a locking stuff there (in previous patch), I feel it's low-risk but even
> if it's mid-risk, the class of such callback remains a perfect fit with
> the hypervisor list IMHO.

It is similar to drivers/soc/bcm/brcmstb/pm/pm-arm.c.
See below for another idea.

> >> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> >> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> >> @@ -1446,7 +1446,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >>  
> >>  	/* register for panic notifier */
> >>  	vk->panic_nb.notifier_call = bcm_vk_on_panic;
> >> -	err = atomic_notifier_chain_register(&panic_notifier_list,
> >> +	err = atomic_notifier_chain_register(&panic_hypervisor_list,
> >>  					     &vk->panic_nb);
> > 
> > It seems to reset some hardware or so. IMHO, it should go into the
> > pre-reboot list.
> 
> Mixed feelings here, I'm looping Broadcom maintainers to comment.
> (CC Scott and Broadcom list)
> 
> I'm afraid it breaks kdump if this device is not reset beforehand - it's
> a doorbell write, so not high risk I think...
> 
> But in case the not-reset device can be probed normally in kdump kernel,
> then I'm fine in moving this to the reboot list! I don't have the HW to
> test myself.

Good question. Well, it if has to be called before kdump then
even "hypervisor" list is a wrong place because is not always
called before kdump.


> >> --- a/drivers/power/reset/ltc2952-poweroff.c
> >> +++ b/drivers/power/reset/ltc2952-poweroff.c
> >> @@ -279,7 +279,7 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
> >>  	pm_power_off = ltc2952_poweroff_kill;
> >>  
> >>  	data->panic_notifier.notifier_call = ltc2952_poweroff_notify_panic;
> >> -	atomic_notifier_chain_register(&panic_notifier_list,
> >> +	atomic_notifier_chain_register(&panic_hypervisor_list,
> >>  				       &data->panic_notifier);
> > 
> > I looks like this somehow triggers the reboot. IMHO, it should go
> > into the pre_reboot list.
> 
> Mixed feeling again here - CCing the maintainers for comments (Sebastian
> / PM folks).
> 
> This is setting a variable only, and once it's set (data->kernel_panic
> is the bool's name), it just bails out the IRQ handler and a timer
> setting - this timer seems kinda tricky, so bailing out ASAP makes sense
> IMHO.

IMHO, the timer informs the hardware that the system is still alive
in the middle of panic(). If the timer is not working then the
hardware (chip) will think that the system frozen in panic()
and will power off the system. See the comments in
drivers/power/reset/ltc2952-poweroff.c:

 * The following GPIOs are used:
 * - trigger (input)
 *     A level change indicates the shut-down trigger. If it's state reverts
 *     within the time-out defined by trigger_delay, the shut down is not
 *     executed. If no pin is assigned to this input, the driver will start the
 *     watchdog toggle immediately. The chip will only power off the system if
 *     it is requested to do so through the kill line.
 *
 * - watchdog (output)
 *     Once a shut down is triggered, the driver will toggle this signal,
 *     with an internal (wde_interval) to stall the hardware shut down.

IMHO, we really have to keep it alive until we reach the reboot stage.

Another question is how it actually works when the interrupts are
disabled during panic() and the timer callbacks are not handled.


> > [...]
> >> --- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> >> +++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> >> @@ -814,7 +814,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
> >>  		goto out;
> >>  	}
> >>  
> >> -	atomic_notifier_chain_register(&panic_notifier_list,
> >> +	atomic_notifier_chain_register(&panic_hypervisor_list,
> >>  				       &brcmstb_pm_panic_nb);
> > 
> > I am not sure about this one. It instruct some HW to preserve DRAM.
> > IMHO, it better fits into pre_reboot category but I do not have
> > strong opinion.
> 
> Disagree here, I'm CCing Florian for information.
> 
> This notifier preserves RAM so it's *very interesting* if we have
> kmsg_dump() for example, but maybe might be also relevant in case kdump
> kernel is configured to store something in a persistent RAM (then,
> without this notifier, after kdump reboots the system data would be lost).

I see. It is actually similar problem as with
drivers/firmware/google/gsmi.c.

I does similar things like kmsg_dump() so it should be called in
the same location (after info notifier list and before kdump).

A solution might be to put it at these notifiers at the very
end of the "info" list or make extra "dump" notifier list.

Best Regards,
Petr

