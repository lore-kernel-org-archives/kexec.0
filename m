From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Tue, 22 Feb 2022 11:06:44 +0900
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220214141308.841525-1-gpiccoli@igalia.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
Message-ID: <YhRFNKtxSE8Xrbfw@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On (22/02/14 11:13), Guilherme G. Piccoli wrote:
> 
> The additional messages from panic_print could overwrite the oldest
> messages when the buffer is full. The only reasonable solution is to
> use a large enough log buffer, hence we added an advice into the kernel
> parameters documentation about that.

By additional panic_print messages you mean that panic_print_sys_info()
will print everything (except PANIC_PRINT_ALL_PRINTK_MSG) twice?

Do we really need to dump everything twice? show_mem(), show_state(),
ftrace_dump(DUMP_ALL). That's quite a bit of extra data.

Can instead this be something like (?):

@@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);


+	panic_print_sys_info(panic_print & ~PANIC_PRINT_ALL_PRINTK_MSG);


 	kmsg_dump(KMSG_DUMP_PANIC);
  
 	/*
@@ -316,7 +321,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);


+	panic_print_sys_info(PANIC_PRINT_ALL_PRINTK_MSG);


 	if (!panic_blink)
 		panic_blink = no_blink;

