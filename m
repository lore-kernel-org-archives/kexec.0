From: Petr Mladek <pmladek@suse.com>
Date: Thu, 13 Jan 2022 12:50:06 +0100
Subject: [PATCH V2] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220106212835.119409-1-gpiccoli@igalia.com>
References: <20220106212835.119409-1-gpiccoli@igalia.com>
Message-ID: <Yd/0K1x7ILw3Qa46@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu 2022-01-06 18:28:35, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is a pretty interesting debug mechanism, but currently the print
> event happens *after* kmsg_dump(), meaning that pstore, for example,
> cannot collect a dmesg with the panic_print information.

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
>  	 * show some extra information on kernel log if it was set...
>  	 */
>  	if (kexec_crash_loaded())
> -		panic_print_sys_info();
> +		panic_print_sys_info(false);

panic_print_sys_info(false) will be called twice when both
kexec_crash_loaded() and _crash_kexec_post_notifiers are true.

Do we really need to call panic_print_sys_info() here? All information
provided by panic_print_sys_info(false) can be found also in
the crash dump.

>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
> @@ -283,6 +286,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	panic_print_sys_info(false);

This is where the info might be printed 2nd time.

> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*

Otherwise, the change makes sense to me.

Best Regards,
Petr

