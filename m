From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:05 -0300
Subject: [PATCH 11/30] um: Improve panic notifiers consistency and ordering
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-12-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently the panic notifiers from user mode linux don't follow
the convention for most of the other notifiers present in the
kernel (indentation, priority setting, numeric return).
More important, the priorities could be improved, since it's a
special case (userspace), hence we could run the notifiers earlier;
user mode linux shouldn't care much with other panic notifiers but
the ordering among the mconsole and arch notifier is important,
given that the arch one effectively triggers a core dump.

This patch fixes that by running the mconsole notifier as the first
panic notifier, followed by the architecture one (that coredumps).
Also, we remove a useless header inclusion.

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/um/drivers/mconsole_kern.c | 8 +++-----
 arch/um/kernel/um_arch.c        | 8 ++++----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 8ca67a692683..2ea0421bcc3f 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -11,7 +11,6 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/sched/debug.h>
@@ -846,13 +845,12 @@ static int notify_panic(struct notifier_block *self, unsigned long unused1,
 
 	mconsole_notify(notify_socket, MCONSOLE_PANIC, message,
 			strlen(message) + 1);
-	return 0;
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block panic_exit_notifier = {
-	.notifier_call 		= notify_panic,
-	.next 			= NULL,
-	.priority 		= 1
+	.notifier_call	= notify_panic,
+	.priority	= INT_MAX, /* run as soon as possible */
 };
 
 static int add_notifier(void)
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0760e24f2eba..4485b1a7c8e4 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -246,13 +246,13 @@ static int panic_exit(struct notifier_block *self, unsigned long unused1,
 	bust_spinlocks(0);
 	uml_exitcode = 1;
 	os_dump_core();
-	return 0;
+
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block panic_exit_notifier = {
-	.notifier_call 		= panic_exit,
-	.next 			= NULL,
-	.priority 		= 0
+	.notifier_call	= panic_exit,
+	.priority	= INT_MAX - 1, /* run as 2nd notifier, won't return */
 };
 
 void uml_finishsetup(void)
-- 
2.36.0


