From: Michael Kelley (LINUX) <mikelley@microsoft.com>
Date: Sat, 19 Mar 2022 15:30:16 +0000
Subject: [PATCH] Drivers: hv: vmbus: Fix potential crash on module unload
In-Reply-To: <20220315203535.682306-1-gpiccoli@igalia.com>
References: <20220315203535.682306-1-gpiccoli@igalia.com>
Message-ID: <PH0PR21MB302540E78316B06885EBE72AD7149@PH0PR21MB3025.namprd21.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Tuesday, March 15, 2022 1:36 PM
> 
> The vmbus driver relies on the panic notifier infrastructure to perform
> some operations when a panic event is detected. Since vmbus can be built
> as module, it is required that the driver handles both registering and
> unregistering such panic notifier callback.
> 
> After commit 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic
> callback")
> though, the panic notifier registration is done unconditionally in the module
> initialization routine whereas the unregistering procedure is conditionally
> guarded and executes only if HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE capability
> is set.
> 
> This patch fixes that by unconditionally unregistering the panic notifier
> in the module's exit routine as well.
> 
> Fixes: 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> Hi folks, thanks in advance for any reviews! This was build-tested
> with Debian config, on 5.17-rc7.
> 
> This patch is a result of code analysis - I didn't experience this
> issue but seems a valid/feasible case.
> 
> Also, this is part of an ongoing effort of clearing/refactoring the panic
> notifiers, more will be done soon, but I prefer to send the simple bug
> fixes quickly, or else it might take a while since the next steps are more
> complex and subject to many iterations I expect.
> 
> Cheers,
> 
> Guilherme
> 
> 
>  drivers/hv/vmbus_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a2b37e87f3..12585324cc4a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2780,10 +2780,15 @@ static void __exit vmbus_exit(void)
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>  		kmsg_dump_unregister(&hv_kmsg_dumper);
>  		unregister_die_notifier(&hyperv_die_block);
> -		atomic_notifier_chain_unregister(&panic_notifier_list,
> -						 &hyperv_panic_block);
>  	}
> 
> +	/*
> +	 * The panic notifier is always registered, hence we should
> +	 * also unconditionally unregister it here as well.
> +	 */
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &hyperv_panic_block);
> +
>  	free_page((unsigned long)hv_panic_page);
>  	unregister_sysctl_table(hv_ctl_table_hdr);
>  	hv_ctl_table_hdr = NULL;
> --
> 2.35.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


