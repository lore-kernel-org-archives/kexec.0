From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Fri, 25 Feb 2022 14:18:22 +0900
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YheXRmmWr619Qxin@alley>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com> <YheXRmmWr619Qxin@alley>
Message-ID: <YhhmnmgAlVCcVqSV@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On (22/02/24 15:33), Petr Mladek wrote:
> > My bad! I did not spot the `return` at the end of the new branch.
> > 
> > +       if (console_flush) {
> > +               if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> > +                       console_flush_on_panic(CONSOLE_REPLAY_ALL);
> > +               return;
> > +       }
> > 
> > Hmm. Yeah, well, that's a bit of a tricky interface now
> > 
> > 	panic()
> > 		// everything (if corresponding bits set), no console flush
> > 		panic_print_sys_info(false)
> > 		...
> > 		// console flush only if corresponding bit set
> > 		panic_print_sys_info(true)
> 
> I agree that self-explaining names are always better than true/false.
> It is pity that replay the log is handled in panic_print at all.
> 
> I sometimes hide these tricks into wrappers. We could rename:
> 
>     panic_printk_sys_info() -> panic_print_handler()
> 
> and add wrappers:
> 
> void panic_print_sys_info()
> {
> 	panic_printk_handler(false);
> }
> 
> void panic_print_log_replay()
> {
> 	panic_printk_handler(true);
> }
> 
> Or just split panic_printk_sys_info() into these two functions.

Agreed. I also tend to think that panic_printk_sys_info() is needed anyway,
just because now we do

	debug_locks_off();
	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
		console_flush_on_panic(CONSOLE_REPLAY_ALL);

It probably would be better if we do

	debug_locks_off();
	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
		console_flush_on_panic(CONSOLE_REPLAY_ALL);
	else
		console_flush_on_panic(CONSOLE_FLUSH_PENDING);

instead.

IOW move console_flush_on_panic() handling out of panic_print_sys_info().
console_flush_on_panic() isn't really related to "print sys info" stuff
that panic_print_sys_info() does.

Something like this may be:

---
 static void panic_print_sys_info(void)
 {
-	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-		console_flush_on_panic(CONSOLE_REPLAY_ALL);
-
 	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
 		trigger_all_cpu_backtrace();
 
@@ -196,6 +193,23 @@ static void panic_print_sys_info(void)
 		ftrace_dump(DUMP_ALL);
 }
 
+static void panic_console_flush(void)
+{
+	/*
+	 * We may have ended up stopping the CPU holding the lock (in
+	 * smp_send_stop()) while still having some valuable data in the console
+	 * buffer.  Try to acquire the lock then release it regardless of the
+	 * result.  The release will also print the buffers out.  Locks debug
+	 * should be disabled to avoid reporting bad unlock balance when
+	 * panic() is not being callled from OOPS.
+	 */
+	debug_locks_off();
+	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+	else
+		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -329,17 +343,7 @@ void panic(const char *fmt, ...)
 #endif
 	console_unblank();
 
-	/*
-	 * We may have ended up stopping the CPU holding the lock (in
-	 * smp_send_stop()) while still having some valuable data in the console
-	 * buffer.  Try to acquire the lock then release it regardless of the
-	 * result.  The release will also print the buffers out.  Locks debug
-	 * should be disabled to avoid reporting bad unlock balance when
-	 * panic() is not being callled from OOPS.
-	 */
-	debug_locks_off();
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
-
+	panic_console_flush();
 	panic_print_sys_info();
 
 	if (!panic_blink)
---

> > If everyone is fine then OK.
> > 
> > But I _personally_ would look into changing this to something like this:
> > 
> > 	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
> > 	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)
> 
> These lists cause merge and backporting conflicts. I vote to avoid
> this approach ;-)

OK :)

