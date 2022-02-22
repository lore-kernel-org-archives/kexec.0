From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Tue, 22 Feb 2022 11:10:43 +0900
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YhRFNKtxSE8Xrbfw@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
Message-ID: <YhRGI51mOEy2EAZb@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

A trivial typo:

On (22/02/22 11:06), Sergey Senozhatsky wrote:
> @@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 
> 
> +	panic_print_sys_info(panic_print & ~PANIC_PRINT_ALL_PRINTK_MSG);
> 
> 
>  	kmsg_dump(KMSG_DUMP_PANIC);
>   
>  	/*
> @@ -316,7 +321,7 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> 

+	panic_print_sys_info(panic_print & PANIC_PRINT_ALL_PRINTK_MSG);



I also wonder if we want to CONSOLE_FLUSH_PENDING when
PANIC_PRINT_ALL_PRINTK_MSG set.

