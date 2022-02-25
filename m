From: Petr Mladek <pmladek@suse.com>
Date: Fri, 25 Feb 2022 13:16:48 +0100
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YhhmnmgAlVCcVqSV@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com> <YheXRmmWr619Qxin@alley>
 <YhhmnmgAlVCcVqSV@google.com>
Message-ID: <YhjIsPpA0kN1yeOM@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri 2022-02-25 14:18:22, Sergey Senozhatsky wrote:
> IOW move console_flush_on_panic() handling out of panic_print_sys_info().
> console_flush_on_panic() isn't really related to "print sys info" stuff
> that panic_print_sys_info() does.
> 
> Something like this may be:
> 
>  static void panic_print_sys_info(void)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> -
>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
>  
> @@ -196,6 +193,23 @@ static void panic_print_sys_info(void)
>  		ftrace_dump(DUMP_ALL);
>  }
>  
> +static void panic_console_flush(void)
> +{
> +	/*
> +	 * We may have ended up stopping the CPU holding the lock (in
> +	 * smp_send_stop()) while still having some valuable data in the console
> +	 * buffer.  Try to acquire the lock then release it regardless of the
> +	 * result.  The release will also print the buffers out.  Locks debug
> +	 * should be disabled to avoid reporting bad unlock balance when
> +	 * panic() is not being callled from OOPS.
> +	 */
> +	debug_locks_off();
> +	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	else
> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> +}
> +
>  /**
>   *	panic - halt the system
>   *	@fmt: The text string to print
> @@ -329,17 +343,7 @@ void panic(const char *fmt, ...)
>  #endif
>  	console_unblank();
>  
> -	/*
> -	 * We may have ended up stopping the CPU holding the lock (in
> -	 * smp_send_stop()) while still having some valuable data in the console
> -	 * buffer.  Try to acquire the lock then release it regardless of the
> -	 * result.  The release will also print the buffers out.  Locks debug
> -	 * should be disabled to avoid reporting bad unlock balance when
> -	 * panic() is not being callled from OOPS.
> -	 */
> -	debug_locks_off();
> -	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> -
> +	panic_console_flush();
>  	panic_print_sys_info();
>  
>  	if (!panic_blink)

The result looks good to me. We could do it as a followup patch.

Best Regards,
Petr

