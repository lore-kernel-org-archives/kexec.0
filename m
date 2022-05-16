From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 May 2022 16:33:41 +0200
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <20220427224924.592546-22-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com>
Message-ID: <YoJgcC8c6LaKADZV@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:15, Guilherme G. Piccoli wrote:
> This patch renames the panic_notifier_list to panic_pre_reboot_list;
> the idea is that a subsequent patch will refactor the panic path
> in order to better split the notifiers, running some of them very
> early, some of them not so early [but still before kmsg_dump()] and
> finally, the rest should execute late, after kdump. The latter ones
> are now in the panic pre-reboot list - the name comes from the idea
> that these notifiers execute before panic() attempts rebooting the
> machine (if that option is set).
> 
> We also took the opportunity to clean-up useless header inclusions,
> improve some notifier block declarations (e.g. in ibmasm/heartbeat.c)
> and more important, change some priorities - we hereby set 2 notifiers
> to run late in the list [iss_panic_event() and the IPMI panic_event()]
> due to the risks they offer (may not return, for example).
> Proper documentation is going to be provided in a subsequent patch,
> that effectively refactors the panic path.
> 
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2163,7 +2162,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>  		int dberror, err_addr;
>  
>  		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
> -		atomic_notifier_chain_register(&panic_notifier_list,
> +		atomic_notifier_chain_register(&panic_pre_reboot_list,

My understanding is that this notifier first prints info about ECC
errors and then triggers reboot. It might make sense to split it
into two notifiers.


>  					       &edac->panic_notifier);
>  
>  		/* Printout a message if uncorrectable error previously. */
> --- a/drivers/leds/trigger/ledtrig-panic.c
> +++ b/drivers/leds/trigger/ledtrig-panic.c
> @@ -64,7 +63,7 @@ static long led_panic_blink(int state)
>  
>  static int __init ledtrig_panic_init(void)
>  {
> -	atomic_notifier_chain_register(&panic_notifier_list,
> +	atomic_notifier_chain_register(&panic_pre_reboot_list,
>  				       &led_trigger_panic_nb);

Blinking => should go to the last "post_reboot/loop" list.


>  
>  	led_trigger_register_simple("panic", &trigger);
> --- a/drivers/misc/ibmasm/heartbeat.c
> +++ b/drivers/misc/ibmasm/heartbeat.c
> @@ -32,20 +31,23 @@ static int suspend_heartbeats = 0;
>  static int panic_happened(struct notifier_block *n, unsigned long val, void *v)
>  {
>  	suspend_heartbeats = 1;
> -	return 0;
> +	return NOTIFY_DONE;
>  }
>  
> -static struct notifier_block panic_notifier = { panic_happened, NULL, 1 };
> +static struct notifier_block panic_notifier = {
> +	.notifier_call = panic_happened,
> +};
>  
>  void ibmasm_register_panic_notifier(void)
>  {
> -	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
> +	atomic_notifier_chain_register(&panic_pre_reboot_list,
> +					&panic_notifier);

Same here. Blinking => should go to the last "post_reboot/loop" list.


>  }
>  
>  void ibmasm_unregister_panic_notifier(void)
>  {
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -			&panic_notifier);
> +	atomic_notifier_chain_unregister(&panic_pre_reboot_list,
> +					&panic_notifier);
>  }


The rest of the moved notifiers seem to fit well this "pre_reboot"
list.

Best Regards,
Petr

