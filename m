From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:16 -0300
Subject: [PATCH 22/30] panic: Introduce the panic post-reboot notifier list
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-23-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently we have 3 notifier lists in the panic path, which will
be wired in a way to allow the notifier callbacks to run in
different moments at panic time, in a subsequent patch.

But there is also an odd set of architecture calls hardcoded in
the end of panic path, after the restart machinery. They're
responsible for late time tunings / events, like enabling a stop
button (Sparc) or effectively stopping the machine (s390).

This patch introduces yet another notifier list to offer the
architectures a way to add callbacks in such late moment on
panic path without the need of ifdefs / hardcoded approaches.

Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/s390/kernel/setup.c       | 19 ++++++++++++++++++-
 arch/sparc/kernel/setup_32.c   | 27 +++++++++++++++++++++++----
 arch/sparc/kernel/setup_64.c   | 29 ++++++++++++++++++++++++-----
 include/linux/panic_notifier.h |  1 +
 kernel/panic.c                 | 19 +++++++------------
 5 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index d860ac300919..d816b2045f1e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -39,7 +39,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/dma-map-ops.h>
 #include <linux/device.h>
-#include <linux/notifier.h>
 #include <linux/pfn.h>
 #include <linux/ctype.h>
 #include <linux/reboot.h>
@@ -51,6 +50,7 @@
 #include <linux/start_kernel.h>
 #include <linux/hugetlb.h>
 #include <linux/kmemleak.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/boot_data.h>
 #include <asm/ipl.h>
@@ -943,6 +943,20 @@ static void __init log_component_list(void)
 	}
 }
 
+/*
+ * The following notifier executes as one of the latest things in the panic
+ * path, only if the restart routines weren't executed (or didn't succeed).
+ */
+static int panic_event(struct notifier_block *n, unsigned long ev, void *unused)
+{
+	disabled_wait();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block post_reboot_panic_block = {
+	.notifier_call = panic_event,
+};
+
 /*
  * Setup function called from init/main.c just after the banner
  * was printed.
@@ -1058,4 +1072,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Add system specific data to the random pool */
 	setup_randomness();
+
+	atomic_notifier_chain_register(&panic_post_reboot_list,
+				       &post_reboot_panic_block);
 }
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c8e0dd99f370..4e2428972f76 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -34,6 +34,7 @@
 #include <linux/kdebug.h>
 #include <linux/export.h>
 #include <linux/start_kernel.h>
+#include <linux/panic_notifier.h>
 #include <uapi/linux/mount.h>
 
 #include <asm/io.h>
@@ -51,6 +52,7 @@
 
 #include "kernel.h"
 
+int stop_a_enabled = 1;
 struct screen_info screen_info = {
 	0, 0,			/* orig-x, orig-y */
 	0,			/* unused */
@@ -293,6 +295,24 @@ void __init sparc32_start_kernel(struct linux_romvec *rp)
 	start_kernel();
 }
 
+/*
+ * The following notifier executes as one of the latest things in the panic
+ * path, only if the restart routines weren't executed (or didn't succeed).
+ */
+static int panic_event(struct notifier_block *n, unsigned long ev, void *unused)
+{
+	/* Make sure the user can actually press Stop-A (L1-A) */
+	stop_a_enabled = 1;
+	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
+		"twice on console to return to the boot prom\n");
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block post_reboot_panic_block = {
+	.notifier_call = panic_event,
+};
+
 void __init setup_arch(char **cmdline_p)
 {
 	int i;
@@ -368,9 +388,10 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 
 	smp_setup_cpu_possible_map();
-}
 
-extern int stop_a_enabled;
+	atomic_notifier_chain_register(&panic_post_reboot_list,
+				       &post_reboot_panic_block);
+}
 
 void sun_do_break(void)
 {
@@ -384,8 +405,6 @@ void sun_do_break(void)
 }
 EXPORT_SYMBOL(sun_do_break);
 
-int stop_a_enabled = 1;
-
 static int __init topology_init(void)
 {
 	int i, ncpus, err;
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 48abee4eee29..9066c25ecc07 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/start_kernel.h>
 #include <linux/memblock.h>
+#include <linux/panic_notifier.h>
 #include <uapi/linux/mount.h>
 
 #include <asm/io.h>
@@ -62,6 +63,8 @@
 #include "entry.h"
 #include "kernel.h"
 
+int stop_a_enabled = 1;
+
 /* Used to synchronize accesses to NatSemi SUPER I/O chip configure
  * operations in asm/ns87303.h
  */
@@ -632,6 +635,24 @@ void __init alloc_irqstack_bootmem(void)
 	}
 }
 
+/*
+ * The following notifier executes as one of the latest things in the panic
+ * path, only if the restart routines weren't executed (or didn't succeed).
+ */
+static int panic_event(struct notifier_block *n, unsigned long ev, void *unused)
+{
+	/* Make sure the user can actually press Stop-A (L1-A) */
+	stop_a_enabled = 1;
+	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
+		"twice on console to return to the boot prom\n");
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block post_reboot_panic_block = {
+	.notifier_call = panic_event,
+};
+
 void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
@@ -691,9 +712,10 @@ void __init setup_arch(char **cmdline_p)
 	 * allocate the IRQ stacks.
 	 */
 	alloc_irqstack_bootmem();
-}
 
-extern int stop_a_enabled;
+	atomic_notifier_chain_register(&panic_post_reboot_list,
+				       &post_reboot_panic_block);
+}
 
 void sun_do_break(void)
 {
@@ -706,6 +728,3 @@ void sun_do_break(void)
 	prom_cmdline();
 }
 EXPORT_SYMBOL(sun_do_break);
-
-int stop_a_enabled = 1;
-EXPORT_SYMBOL(stop_a_enabled);
diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 7912aacbc0e5..bcf6a5ea9d7f 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -8,6 +8,7 @@
 extern struct atomic_notifier_head panic_hypervisor_list;
 extern struct atomic_notifier_head panic_info_list;
 extern struct atomic_notifier_head panic_pre_reboot_list;
+extern struct atomic_notifier_head panic_post_reboot_list;
 
 extern bool crash_kexec_post_notifiers;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index a9d43b98b05b..bf792102b43e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -78,6 +78,9 @@ EXPORT_SYMBOL(panic_info_list);
 ATOMIC_NOTIFIER_HEAD(panic_pre_reboot_list);
 EXPORT_SYMBOL(panic_pre_reboot_list);
 
+ATOMIC_NOTIFIER_HEAD(panic_post_reboot_list);
+EXPORT_SYMBOL(panic_post_reboot_list);
+
 static long no_blink(int state)
 {
 	return 0;
@@ -359,18 +362,10 @@ void panic(const char *fmt, ...)
 			reboot_mode = panic_reboot_mode;
 		emergency_restart();
 	}
-#ifdef __sparc__
-	{
-		extern int stop_a_enabled;
-		/* Make sure the user can actually press Stop-A (L1-A) */
-		stop_a_enabled = 1;
-		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
-			 "twice on console to return to the boot prom\n");
-	}
-#endif
-#if defined(CONFIG_S390)
-	disabled_wait();
-#endif
+
+	atomic_notifier_call_chain(&panic_post_reboot_list,
+				   PANIC_NOTIFIER, buf);
+
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	/* Do not scroll important messages printed above */
-- 
2.36.0


