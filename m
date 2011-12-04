Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXIH9-0008KY-G3
 for kexec@lists.infradead.org; Sun, 04 Dec 2011 20:03:04 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 4 Dec 2011 20:00:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB4K2iPl4358286
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 07:02:44 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB4K2ij4017390
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 07:02:44 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
Date: Mon, 05 Dec 2011 01:32:38 +0530
Message-ID: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: rjw@sisk.pl
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz, tj@kernel.org

The [un]lock_system_sleep() APIs were originally introduced to mutually
exclude memory hotplug and hibernation.

Directly using mutex_lock(&pm_mutex) to achieve mutual exclusion with
suspend or hibernation code can lead to freezing failures. However, the
APIs [un]lock_system_sleep() can be safely used to achieve the same, without
causing freezing failures.

So, since it would be beneficial to modify all the existing users of
mutex_lock(&pm_mutex) (in all parts of the kernel), so that they use these
safe APIs intead, make these APIs generic by removing the restriction that
they work only when CONFIG_HIBERNATE_CALLBACKS is set. Moreover, that
restriction didn't buy us anything anyway.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/suspend.h |   42 ++++++++++++++++++------------------------
 1 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 1f7fff4..d109847 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -331,6 +331,8 @@ static inline bool system_entering_hibernation(void) { return false; }
 #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
 #define PM_POST_RESTORE		0x0006 /* Restore failed */
 
+extern struct mutex pm_mutex;
+
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);
 void restore_processor_state(void);
@@ -351,6 +353,21 @@ extern bool events_check_enabled;
 extern bool pm_wakeup_pending(void);
 extern bool pm_get_wakeup_count(unsigned int *count);
 extern bool pm_save_wakeup_count(unsigned int count);
+
+static inline void lock_system_sleep(void)
+{
+	/* simplified freezer_do_not_count() */
+	current->flags |= PF_FREEZER_SKIP;
+	mutex_lock(&pm_mutex);
+}
+
+static inline void unlock_system_sleep(void)
+{
+	mutex_unlock(&pm_mutex);
+	/* simplified freezer_count() */
+	current->flags &= ~PF_FREEZER_SKIP;
+}
+
 #else /* !CONFIG_PM_SLEEP */
 
 static inline int register_pm_notifier(struct notifier_block *nb)
@@ -366,32 +383,9 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
 static inline bool pm_wakeup_pending(void) { return false; }
-#endif /* !CONFIG_PM_SLEEP */
-
-extern struct mutex pm_mutex;
-
-#ifndef CONFIG_HIBERNATE_CALLBACKS
 static inline void lock_system_sleep(void) {}
 static inline void unlock_system_sleep(void) {}
-
-#else
-
-/* Let some subsystems like memory hotadd exclude hibernation */
-
-static inline void lock_system_sleep(void)
-{
-	/* simplified freezer_do_not_count() */
-	current->flags |= PF_FREEZER_SKIP;
-	mutex_lock(&pm_mutex);
-}
-
-static inline void unlock_system_sleep(void)
-{
-	mutex_unlock(&pm_mutex);
-	/* simplified freezer_count() */
-	current->flags &= ~PF_FREEZER_SKIP;
-}
-#endif
+#endif /* !CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_ARCH_SAVE_PAGE_KEYS
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
