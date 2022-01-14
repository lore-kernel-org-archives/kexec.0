From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 14 Jan 2022 15:30:46 -0300
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <20220114183046.428796-1-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The panic_print setting allows users to collect more information in a
panic event, like memory stats, tasks, CPUs backtraces, etc.
This is a pretty interesting debug mechanism, but currently the print
event happens *after* kmsg_dump(), meaning that pstore, for example,
cannot collect a dmesg with the panic_print information.

This patch changes that in 2 ways:

(a) First, after a good discussion with Petr in the mailing-list[0],
he noticed that one specific setting of panic_print (the console replay,
bit 5) should not be executed before console proper flushing; hence we
hereby split the panic_print_sys_info() function in upper and lower
portions: if the parameter "after_kmsg_dumpers" is passed, only bit 5
(the console replay thing) is evaluated and the function returns - this
is the lower portion. Otherwise all other bits are checked and the
function prints the user required information; this is the upper/earlier
mode.

(b) With the above change, we can safely insert a panic_print_sys_info()
call up some lines, in order kmsg_dump() accounts this new information
and exposes it through pstore or other kmsg dumpers. Notice that this
new earlier call doesn't set "after_kmsg_dumpers" so we print the
information set by user in panic_print, except the console replay that,
if set, will be executed after the console flushing.
Also, worth to notice we needed to guard the panic_print_sys_info(false)
calls against double print - we use kexec_crash_loaded() helper for that
(see discussion [1] for more details).

In the first version of this patch we discussed the risks in the
mailing-list [0], and seems this approach is the least terrible,
despite still having risks of polluting the log with the bulk of
information that panic_print may bring, losing older messages.
In order to attenuate that, we've added a warning in the
kernel-parameters.txt so that users enabling this mechanism consider
to increase the log buffer size via "log_buf_len" as well.

Finally, another decision was to keep 2 panic_print_sys_info(false)
calls (instead of just bringing it up some code lines and keep a single
call) due to the panic notifiers: if kdump is not set, currently the
panic_print information is collected after the notifiers and since
it's a bit safer this way, we decided to keep it as is, only modifying
the kdump case as per the previous commit [2] (see more details about
this discussion also in thread [1]).

[0] https://lore.kernel.org/lkml/20211230161828.121858-1-gpiccoli at igalia.com
[1] https://lore.kernel.org/lkml/f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a at igalia.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5613b7538f69

Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V3: Added a guard in the 2nd panic_print_sys_info(false) to prevent
double print - thanks for catching this Petr!

I didn't implement your final suggestion Petr, i.e., putting the first
panic_print_sys_info(false) inside the if (!_crash_kexec_post_notifiers)
block, and the reason is that when we do this, there's 4 cases to consider:

!kexec_crash_load() && !_crash_kexec_post_notifiers
kexec_crash_load() && !_crash_kexec_post_notifiers
kexec_crash_load() && _crash_kexec_post_notifiers
!kexec_crash_load() && _crash_kexec_post_notifiers

The 3rd case, which means user enabled kdump and set the post_notifiers
in the cmdline fails - we end-up not reaching panic_print_sys_info(false)
in this case, unless we add another variable to track the function call
and prevent double print. My preference was to keep the first call
as introduced by commit [2] (mentioned above) and not rely in another
variable.
Thanks again for the great reviews,

Guilherme


V2: https://lore.kernel.org/lkml/20220106212835.119409-1-gpiccoli at igalia.com



 .../admin-guide/kernel-parameters.txt         |  4 ++++
 kernel/panic.c                                | 22 ++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

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
index 41ecf9ab824a..4ae712665f75 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
-static void panic_print_sys_info(void)
+static void panic_print_sys_info(bool after_kmsg_dumpers)
 {
-	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+	if (after_kmsg_dumpers) {
+		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+			console_flush_on_panic(CONSOLE_REPLAY_ALL);
+		return;
+	}
 
 	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
 		trigger_all_cpu_backtrace();
@@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
 	 * show some extra information on kernel log if it was set...
 	 */
 	if (kexec_crash_loaded())
-		panic_print_sys_info();
+		panic_print_sys_info(false);
 
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
@@ -283,6 +286,15 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	/*
+	 * If kexec_crash_loaded() is true and we still reach this point,
+	 * kernel would double print the information from panic_print; so
+	 * let's guard against that possibility (it happens if kdump users
+	 * also set crash_kexec_post_notifiers in the command-line).
+	 */
+	if (!kexec_crash_loaded())
+		panic_print_sys_info(false);
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -313,7 +325,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
+	panic_print_sys_info(true);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
-- 
2.34.1


