From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Wed, 23 Feb 2022 01:27:35 +0000
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
Message-ID: <YhWNhzacAVDuFtwB@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On (22/02/22 11:10), Guilherme G. Piccoli wrote:
> On 21/02/2022 23:06, Sergey Senozhatsky wrote:
> > On (22/02/14 11:13), Guilherme G. Piccoli wrote:
> > [...]
> > By additional panic_print messages you mean that panic_print_sys_info()
> > will print everything (except PANIC_PRINT_ALL_PRINTK_MSG) twice?
> > 
> > Do we really need to dump everything twice? show_mem(), show_state(),
> > ftrace_dump(DUMP_ALL). That's quite a bit of extra data.
> > 
> 
> Oh no, we don't print everything twice, that'd be insane heh

My bad! I did not spot the `return` at the end of the new branch.

+       if (console_flush) {
+               if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+                       console_flush_on_panic(CONSOLE_REPLAY_ALL);
+               return;
+       }

Hmm. Yeah, well, that's a bit of a tricky interface now

	panic()
		// everything (if corresponding bits set), no console flush
		panic_print_sys_info(false)
		...
		// console flush only if corresponding bit set
		panic_print_sys_info(true)



If everyone is fine then OK.

But I _personally_ would look into changing this to something like this:

	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)
	panic()
		panic_print_sys_info(panic_print & EARLY_PANIC_MASK)
		...
		panic_print_sys_info(panic_print & LATE_PANIC_MASK)

