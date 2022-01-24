From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 24 Jan 2022 17:31:01 -0300
Subject: [PATCH V4] panic: Move panic_print before kmsg dumpers
Message-ID: <20220124203101.216051-1-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The panic_print setting allows users to collect more information in a
panic event, like memory stats, tasks, CPUs backtraces, etc.
This is an interesting debug mechanism, but currently the print event
happens *after* kmsg_dump(), meaning that pstore, for example, cannot
collect a dmesg with the panic_print extra information.

This patch changes that in 2 ways:

(a) The panic_print setting allows to replay the existing kernel log
buffer to the console (bit 5), besides the extra information dump.
This functionality makes sense only at the end of the panic() function.
So, we hereby allow to distinguish the two situations by a new boolean
parameter in the function panic_print_sys_info().

(b) With the above change, we can safely call panic_print_sys_info()
before kmsg_dump(), allowing to dump the extra information when using
pstore or other kmsg dumpers.

The additional messages from panic_print could overwrite the oldest
messages when the buffer is full. The only reasonable solution is to
use a large enough log buffer, hence we added an advice into the kernel
parameters documentation about that.

Finally, some panic notifiers might reset watchdogs, like RCU or hung
task detector. Due to that, it's optimal to dump the extra information
from panic_print after the notifiers, when possible. Sometimes it's not
possible though - for example, when users have kdump set but don't pass
"crash_kexec_post_notifiers" in the kernel command-line. For this
reason, we kept 2 calls for panic_print_sys_info().

Cc: Baoquan He <bhe@redhat.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V4:
* Addressed feedback from Petr (thanks!), by refactoring the commit message
to be more direct plus his suggestions to improve code path and the comment.

* Addressed feedback from Baoquan (thanks!) about the new boolean parameter
name on panic_print_sys_info().

V3: https://lore.kernel.org/lkml/20220114183046.428796-1-gpiccoli at igalia.com

V2: https://lore.kernel.org/lkml/20220106212835.119409-1-gpiccoli at igalia.com

V1: https://lore.kernel.org/lkml/20211230161828.121858-1-gpiccoli at igalia.com


 .../admin-guide/kernel-parameters.txt         |  4 +++
 kernel/panic.c                                | 34 ++++++++++++-------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a069d8fe2fee..0f5cbe141bfd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3727,6 +3727,10 @@
 			bit 4: print ftrace buffer
 			bit 5: print all printk messages in buffer
 			bit 6: print all CPUs backtrace (if available in the arch)
+			*Be aware* that this option may print a _lot_ of lines,
+			so there are risks of losing older messages in the log.
+			Use this option carefully, maybe worth to setup a
+			bigger log buffer with "log_buf_len" along with this.
 
 	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
 			Format: <hex>[,nousertaint]
diff --git a/kernel/panic.c b/kernel/panic.c
index 41ecf9ab824a..b274e6c241d9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
-static void panic_print_sys_info(void)
+static void panic_print_sys_info(bool console_flush)
 {
-	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+	if (console_flush) {
+		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+			console_flush_on_panic(CONSOLE_REPLAY_ALL);
+		return;
+	}
 
 	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
 		trigger_all_cpu_backtrace();
@@ -244,22 +247,20 @@ void panic(const char *fmt, ...)
 	 */
 	kgdb_panic(buf);
 
-	/*
-	 * If we have a kdump kernel loaded, give a chance to panic_print
-	 * show some extra information on kernel log if it was set...
-	 */
-	if (kexec_crash_loaded())
-		panic_print_sys_info();
-
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
-	 * everything else.
+	 * everything else. Also, give a chance to panic_print show some extra
+	 * information on kernel log if it was set...
+	 *
 	 * If we want to run this after calling panic_notifiers, pass
 	 * the "crash_kexec_post_notifiers" option to the kernel.
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
 	if (!_crash_kexec_post_notifiers) {
+		if (kexec_crash_loaded())
+			panic_print_sys_info(false);
+
 		__crash_kexec(NULL);
 
 		/*
@@ -283,6 +284,15 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	/*
+	 * If a crash kernel is not loaded (or if it's loaded but we still
+	 * want to allow the panic notifiers), then we dump panic_print after
+	 * the notifiers - some notifiers disable watchdogs, for example, so
+	 * we reduce the risk of lockups/hangs or garbled output this way.
+	 */
+	if (_crash_kexec_post_notifiers || !kexec_crash_loaded())
+		panic_print_sys_info(false);
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -313,7 +323,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
+	panic_print_sys_info(true);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
-- 
2.34.1


