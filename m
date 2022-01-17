From: Baoquan He <bhe@redhat.com>
Date: Mon, 17 Jan 2022 11:33:44 +0800
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220114183046.428796-1-gpiccoli@igalia.com>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
Message-ID: <20220117033344.GA2523@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/14/22 at 03:30pm, Guilherme G. Piccoli wrote:
...... 
>  .../admin-guide/kernel-parameters.txt         |  4 ++++
>  kernel/panic.c                                | 22 ++++++++++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a069d8fe2fee..0f5cbe141bfd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3727,6 +3727,10 @@
>  			bit 4: print ftrace buffer
>  			bit 5: print all printk messages in buffer
>  			bit 6: print all CPUs backtrace (if available in the arch)
> +			*Be aware* that this option may print a _lot_ of lines,
> +			so there are risks of losing older messages in the log.
> +			Use this option carefully, maybe worth to setup a
> +			bigger log buffer with "log_buf_len" along with this.
>  
>  	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
>  			Format: <hex>[,nousertaint]
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 41ecf9ab824a..4ae712665f75 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
>  }
>  EXPORT_SYMBOL(nmi_panic);
>  
> -static void panic_print_sys_info(void)
> +static void panic_print_sys_info(bool after_kmsg_dumpers)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	if (after_kmsg_dumpers) {
> +		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +			console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +		return;
> +	}
>  
>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
> @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
>  	 * show some extra information on kernel log if it was set...
>  	 */
>  	if (kexec_crash_loaded())
> -		panic_print_sys_info();
> +		panic_print_sys_info(false);

Patch can'e be applied on the latest code of linus's tree, can you tell
which branch your code are based on?

>  
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
> @@ -283,6 +286,15 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	/*
> +	 * If kexec_crash_loaded() is true and we still reach this point,
> +	 * kernel would double print the information from panic_print; so
> +	 * let's guard against that possibility (it happens if kdump users
> +	 * also set crash_kexec_post_notifiers in the command-line).
> +	 */
> +	if (!kexec_crash_loaded())
> +		panic_print_sys_info(false);
> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*
> @@ -313,7 +325,7 @@ void panic(const char *fmt, ...)
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


