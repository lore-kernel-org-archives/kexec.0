From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Tue, 22 Feb 2022 10:45:29 +0900
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220214141308.841525-1-gpiccoli@igalia.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
Message-ID: <YhRAOQbH15E7y9s8@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On (22/02/14 11:13), Guilherme G. Piccoli wrote:
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

Yeah, if Petr is fine with that then I'm OK. But at the same time,
we have `panic_print' which is a bit mask of what panic_print_sys_info()
should do. And now we also have a boolean `console_flush` flag that tells
panic_print_sys_info() to ignore some (one as of now) bits of `panic_print'.

So _maybe_ panic_print_sys_info() can just accept panic_print as
its parameter and then we can do something like this (as an example)

	panic_print_sys_info(panic_print & ~PANIC_PRINT_ALL_PRINTK_MSG);


>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
> @@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);

[..]

> +	panic_print_sys_info(false);

Merely because `panic_print_sys_info(false);` doesn't tell much to a reader.
Like what is print sys info false?

Or did you already discuss this?

