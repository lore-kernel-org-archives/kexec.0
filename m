From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 May 2022 16:01:57 +0200
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <20220427224924.592546-20-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
Message-ID: <YoJZVZl/MH0KiE/J@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:13, Guilherme G. Piccoli wrote:
> The goal of this new panic notifier is to allow its users to register
> callbacks to run very early in the panic path. This aims hypervisor/FW
> notification mechanisms as well as simple LED functions, and any other
> simple and safe mechanism that should run early in the panic path; more
> dangerous callbacks should execute later.
> 
> For now, the patch is almost a no-op (although it changes a bit the
> ordering in which some panic notifiers are executed). In a subsequent
> patch, the panic path will be refactored, then the panic hypervisor
> notifiers will effectively run very early in the panic path.
> 
> We also defer documenting it all properly in the subsequent refactor
> patch. While at it, we removed some useless header inclusions and
> fixed some notifiers return too (by using the standard NOTIFY_DONE).

> --- a/arch/mips/sgi-ip22/ip22-reset.c
> +++ b/arch/mips/sgi-ip22/ip22-reset.c
> @@ -195,7 +195,7 @@ static int __init reboot_setup(void)
>  	}
>  
>  	timer_setup(&blink_timer, blink_timeout, 0);
> -	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> +	atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);

This notifier enables blinking. It is not much safe. It calls
mod_timer() that takes a lock internally.

This kind of functionality should go into the last list called
before panic() enters the infinite loop. IMHO, all the blinking
stuff should go there.

>  
>  	return 0;
>  }
> diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
> index 18d1c115cd53..9ee1302c9d13 100644
> --- a/arch/mips/sgi-ip32/ip32-reset.c
> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> @@ -145,7 +144,7 @@ static __init int ip32_reboot_setup(void)
>  	pm_power_off = ip32_machine_halt;
>  
>  	timer_setup(&blink_timer, blink_timeout, 0);
> -	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> +	atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);

Same here. Should be done only before the "loop".

>  
>  	return 0;
>  }
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -1034,7 +1034,7 @@ static __init int gsmi_init(void)
>  
>  	register_reboot_notifier(&gsmi_reboot_notifier);
>  	register_die_notifier(&gsmi_die_notifier);
> -	atomic_notifier_chain_register(&panic_notifier_list,
> +	atomic_notifier_chain_register(&panic_hypervisor_list,
>  				       &gsmi_panic_notifier);

I am not sure about this one. It looks like some logging or
pre_reboot stuff.


>  
>  	printk(KERN_INFO "gsmi version " DRIVER_VERSION " loaded\n");
> --- a/drivers/leds/trigger/ledtrig-activity.c
> +++ b/drivers/leds/trigger/ledtrig-activity.c
> @@ -247,7 +247,7 @@ static int __init activity_init(void)
>  	int rc = led_trigger_register(&activity_led_trigger);
>  
>  	if (!rc) {
> -		atomic_notifier_chain_register(&panic_notifier_list,
> +		atomic_notifier_chain_register(&panic_hypervisor_list,
>  					       &activity_panic_nb);

The notifier is trivial. It just sets a variable.

But still, it is about blinking and should be done
in the last "loop" list.


>  		register_reboot_notifier(&activity_reboot_nb);
>  	}
> --- a/drivers/leds/trigger/ledtrig-heartbeat.c
> +++ b/drivers/leds/trigger/ledtrig-heartbeat.c
> @@ -190,7 +190,7 @@ static int __init heartbeat_trig_init(void)
>  	int rc = led_trigger_register(&heartbeat_led_trigger);
>  
>  	if (!rc) {
> -		atomic_notifier_chain_register(&panic_notifier_list,
> +		atomic_notifier_chain_register(&panic_hypervisor_list,
>  					       &heartbeat_panic_nb);

Same here. Blinking => loop list.

>  		register_reboot_notifier(&heartbeat_reboot_nb);
>  	}
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index a16b99bdaa13..d9d5199cdb2b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -1446,7 +1446,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	/* register for panic notifier */
>  	vk->panic_nb.notifier_call = bcm_vk_on_panic;
> -	err = atomic_notifier_chain_register(&panic_notifier_list,
> +	err = atomic_notifier_chain_register(&panic_hypervisor_list,
>  					     &vk->panic_nb);

It seems to reset some hardware or so. IMHO, it should go into the
pre-reboot list.


>  	if (err) {
>  		dev_err(dev, "Fail to register panic notifier\n");
> --- a/drivers/power/reset/ltc2952-poweroff.c
> +++ b/drivers/power/reset/ltc2952-poweroff.c
> @@ -279,7 +279,7 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
>  	pm_power_off = ltc2952_poweroff_kill;
>  
>  	data->panic_notifier.notifier_call = ltc2952_poweroff_notify_panic;
> -	atomic_notifier_chain_register(&panic_notifier_list,
> +	atomic_notifier_chain_register(&panic_hypervisor_list,
>  				       &data->panic_notifier);

I looks like this somehow triggers the reboot. IMHO, it should go
into the pre_reboot list.

>  	dev_info(&pdev->dev, "probe successful\n");
>  
> --- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> +++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> @@ -814,7 +814,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> -	atomic_notifier_chain_register(&panic_notifier_list,
> +	atomic_notifier_chain_register(&panic_hypervisor_list,
>  				       &brcmstb_pm_panic_nb);

I am not sure about this one. It instruct some HW to preserve DRAM.
IMHO, it better fits into pre_reboot category but I do not have
strong opinion.

>  
>  	pm_power_off = brcmstb_pm_poweroff;

Best Regards,
Petr

