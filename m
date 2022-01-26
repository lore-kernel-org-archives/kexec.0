From: Baoquan He <bhe@redhat.com>
Date: Wed, 26 Jan 2022 13:22:46 +0800
Subject: [PATCH V4] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220124203101.216051-1-gpiccoli@igalia.com>
References: <20220124203101.216051-1-gpiccoli@igalia.com>
Message-ID: <20220126052246.GC2086@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/24/22 at 05:31pm, Guilherme G. Piccoli wrote:
  			Format: <hex>[,nousertaint]
...snip...

> diff --git a/kernel/panic.c b/kernel/panic.c
> index 41ecf9ab824a..b274e6c241d9 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
>  }
>  EXPORT_SYMBOL(nmi_panic);
>  
> -static void panic_print_sys_info(void)
> +static void panic_print_sys_info(bool console_flush)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	if (console_flush) {
> +		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +			console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +		return;
> +	}
>  
>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
> @@ -244,22 +247,20 @@ void panic(const char *fmt, ...)
>  	 */
>  	kgdb_panic(buf);
>  
> -	/*
> -	 * If we have a kdump kernel loaded, give a chance to panic_print
> -	 * show some extra information on kernel log if it was set...
> -	 */
> -	if (kexec_crash_loaded())
> -		panic_print_sys_info();
> -
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
> -	 * everything else.
> +	 * everything else. Also, give a chance to panic_print show some extra
> +	 * information on kernel log if it was set...
> +	 *
>  	 * If we want to run this after calling panic_notifiers, pass
>  	 * the "crash_kexec_post_notifiers" option to the kernel.
>  	 *
>  	 * Bypass the panic_cpu check and call __crash_kexec directly.
>  	 */
>  	if (!_crash_kexec_post_notifiers) {
> +		if (kexec_crash_loaded())
> +			panic_print_sys_info(false);
> +

Please reconsider this change. As I said in another thread, it's not
suggested when adding any action before kdump switching and the action
doesn't benefit kdump switching.

We don't oppose execute handling before kdump switching as long as
it's executed conditionally. For those conditional extra handling and
the followoing crash dumping's stability, it's not under kdump's care.

>  		__crash_kexec(NULL);
>  
>  		/*
> @@ -283,6 +284,15 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	/*
> +	 * If a crash kernel is not loaded (or if it's loaded but we still
> +	 * want to allow the panic notifiers), then we dump panic_print after
> +	 * the notifiers - some notifiers disable watchdogs, for example, so
> +	 * we reduce the risk of lockups/hangs or garbled output this way.
> +	 */
> +	if (_crash_kexec_post_notifiers || !kexec_crash_loaded())
> +		panic_print_sys_info(false);
> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*
> @@ -313,7 +323,7 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>  
> -	panic_print_sys_info();
> +	panic_print_sys_info(true);
>  
>  	if (!panic_blink)
>  		panic_blink = no_blink;
> -- 
> 2.34.1
> 


