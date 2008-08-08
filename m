Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRLpy-00082F-Rn
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 06:52:35 +0000
Subject: [PATCH -v2 1/8] kexec jump: clean up #ifdef and comments
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 08 Aug 2008 14:52:30 +0800
Message-Id: <1218178350.22039.74.camel@caritas-dev.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, nigel@nigel.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

Move if (kexec_image->preserve_context) { ... } into #ifdef
CONFIG_KEXEC_JUMP to make code looks cleaner.

Fix no longer correct comments of kernel_kexec().

Signed-off-by: Huang Ying <ying.huang@intel.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>

---
 kernel/kexec.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1426,11 +1426,9 @@ static int __init crash_save_vmcoreinfo_
 
 module_init(crash_save_vmcoreinfo_init)
 
-/**
- *	kernel_kexec - reboot the system
- *
- *	Move into place and start executing a preloaded standalone
- *	executable.  If nothing was preloaded return an error.
+/*
+ * Move into place and start executing a preloaded standalone
+ * executable.  If nothing was preloaded return an error.
  */
 int kernel_kexec(void)
 {
@@ -1443,8 +1441,8 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
-	if (kexec_image->preserve_context) {
 #ifdef CONFIG_KEXEC_JUMP
+	if (kexec_image->preserve_context) {
 		mutex_lock(&pm_mutex);
 		pm_prepare_console();
 		error = freeze_processes();
@@ -1471,8 +1469,9 @@ int kernel_kexec(void)
 		if (error)
 			goto Enable_irqs;
 		save_processor_state();
+	} else
 #endif
-	} else {
+	{
 		blocking_notifier_call_chain(&reboot_notifier_list,
 					     SYS_RESTART, NULL);
 		system_state = SYSTEM_RESTART;
@@ -1484,8 +1483,8 @@ int kernel_kexec(void)
 
 	machine_kexec(kexec_image);
 
-	if (kexec_image->preserve_context) {
 #ifdef CONFIG_KEXEC_JUMP
+	if (kexec_image->preserve_context) {
 		restore_processor_state();
 		device_power_up(PMSG_RESTORE);
  Enable_irqs:
@@ -1499,8 +1498,8 @@ int kernel_kexec(void)
  Restore_console:
 		pm_restore_console();
 		mutex_unlock(&pm_mutex);
-#endif
 	}
+#endif
 
  Unlock:
 	xchg(&kexec_lock, 0);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
