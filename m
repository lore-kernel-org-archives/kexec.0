From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:11 -0300
Subject: [PATCH 17/30] tracing: Improve panic/die notifiers
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-18-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently the tracing dump_on_oops feature is implemented
through separate notifiers, one for die/oops and the other
for panic. With the addition of panic notifier "id", this
patch makes use of such "id" to unify both functions.

It also comments the function and changes the priority of the
notifier blocks, in order they run early compared to other
notifiers, to prevent useless trace data (like the callback
names for the other notifiers). Finally, we also removed an
unnecessary header inclusion.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 kernel/trace/trace.c | 57 +++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..c1d8a3622ccc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -19,7 +19,6 @@
 #include <linux/kallsyms.h>
 #include <linux/security.h>
 #include <linux/seq_file.h>
-#include <linux/notifier.h>
 #include <linux/irqflags.h>
 #include <linux/debugfs.h>
 #include <linux/tracefs.h>
@@ -9767,38 +9766,46 @@ static __init int tracer_init_tracefs(void)
 
 fs_initcall(tracer_init_tracefs);
 
-static int trace_panic_handler(struct notifier_block *this,
-			       unsigned long event, void *unused)
+/*
+ * The idea is to execute the following die/panic callback early, in order
+ * to avoid showing irrelevant information in the trace (like other panic
+ * notifier functions); we are the 2nd to run, after hung_task/rcu_stall
+ * warnings get disabled (to prevent potential log flooding).
+ */
+static int trace_die_panic_handler(struct notifier_block *self,
+				unsigned long ev, void *unused)
 {
-	if (ftrace_dump_on_oops)
+	int do_dump;
+
+	if (!ftrace_dump_on_oops)
+		return NOTIFY_DONE;
+
+	switch (ev) {
+	case DIE_OOPS:
+		do_dump = 1;
+		break;
+	case PANIC_NOTIFIER:
+		do_dump = 1;
+		break;
+	default:
+		do_dump = 0;
+		break;
+	}
+
+	if (do_dump)
 		ftrace_dump(ftrace_dump_on_oops);
-	return NOTIFY_OK;
+
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block trace_panic_notifier = {
-	.notifier_call  = trace_panic_handler,
-	.next           = NULL,
-	.priority       = 150   /* priority: INT_MAX >= x >= 0 */
+	.notifier_call = trace_die_panic_handler,
+	.priority = INT_MAX - 1,
 };
 
-static int trace_die_handler(struct notifier_block *self,
-			     unsigned long val,
-			     void *data)
-{
-	switch (val) {
-	case DIE_OOPS:
-		if (ftrace_dump_on_oops)
-			ftrace_dump(ftrace_dump_on_oops);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
 static struct notifier_block trace_die_notifier = {
-	.notifier_call = trace_die_handler,
-	.priority = 200
+	.notifier_call = trace_die_panic_handler,
+	.priority = INT_MAX - 1,
 };
 
 /*
-- 
2.36.0


