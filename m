From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 11 Feb 2022 18:55:39 -0300
Subject: [PATCH V5] panic: Move panic_print before kmsg dumpers
Message-ID: <20220211215539.822466-1-gpiccoli@igalia.com>
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

Cc: Baoquan He <bhe@redhat.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V5:
* Rebased against next-20220211.
* Removed code dealing with kdump, based on Baoquan concerns.
  This was possible after asking Stephen to remove a patch from
  linux-next[0] to address Baoquan sugestions, so this version
  is more simple and doesn't ever panic_print before kdump, unless
  "crash_kexec_post_notifiers" is passed in the kernel cmdline.

[0] https://lore.kernel.org/lkml/c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2 at igalia.com/

V4: https://lore.kernel.org/lkml/20220124203101.216051-1-gpiccoli at igalia.com/


 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 kernel/panic.c                                  | 13 +++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3c2b3e24e8f5..2cf7078eaa95 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3766,6 +3766,10 @@
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
index 3c3fb36d8d41..eb4dfb932c85 100644
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
@@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	panic_print_sys_info(false);
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -316,7 +321,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
+	panic_print_sys_info(true);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
-- 
2.35.0


