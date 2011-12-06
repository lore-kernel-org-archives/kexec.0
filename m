Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RY0c4-0002vS-Jj
 for kexec@lists.infradead.org; Tue, 06 Dec 2011 19:23:37 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 6 Dec 2011 19:21:03 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB6JJhvQ3162180
 for <kexec@lists.infradead.org>; Wed, 7 Dec 2011 06:19:43 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB6JNJ3M015165
 for <kexec@lists.infradead.org>; Wed, 7 Dec 2011 06:23:19 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
Date: Wed, 07 Dec 2011 00:53:13 +0530
Message-ID: <20111206192000.25854.53769.stgit@srivatsabhat.in.ibm.com>
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
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, oleg@redhat.com, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz, tj@kernel.org

The [un]lock_system_sleep() APIs were originally introduced to mutually
exclude memory hotplug and hibernation.

Directly using mutex_lock(&pm_mutex) to achieve mutual exclusion with
suspend or hibernation code can lead to freezing failures. However, the
APIs [un]lock_system_sleep() can be safely used to achieve the same,
without causing freezing failures.

So, since it would be beneficial to modify all the existing users of
mutex_lock(&pm_mutex) (in all parts of the kernel), so that they use these
safe APIs intead, make these APIs generic by removing the restriction that
they work only when CONFIG_HIBERNATE_CALLBACKS is set. Moreover, that
restriction didn't buy us anything anyway.

v2: Rebased on top of the patchset posted at:
    https://lkml.org/lkml/2011/12/6/334

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/suspend.h |   36 ++++++++++++++++--------------------
 1 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 906d62c..95040cc 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -332,6 +332,8 @@ static inline bool system_entering_hibernation(void) { return false; }
 #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
 #define PM_POST_RESTORE		0x0006 /* Restore failed */
 
+extern struct mutex pm_mutex;
+
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);
 void restore_processor_state(void);
@@ -352,6 +354,19 @@ extern bool events_check_enabled;
 extern bool pm_wakeup_pending(void);
 extern bool pm_get_wakeup_count(unsigned int *count);
 extern bool pm_save_wakeup_count(unsigned int count);
+
+static inline void lock_system_sleep(void)
+{
+	freezer_do_not_count();
+	mutex_lock(&pm_mutex);
+}
+
+static inline void unlock_system_sleep(void)
+{
+	mutex_unlock(&pm_mutex);
+	freezer_count();
+}
+
 #else /* !CONFIG_PM_SLEEP */
 
 static inline int register_pm_notifier(struct notifier_block *nb)
@@ -367,30 +382,11 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
 static inline bool pm_wakeup_pending(void) { return false; }
-#endif /* !CONFIG_PM_SLEEP */
-
-extern struct mutex pm_mutex;
 
-#ifndef CONFIG_HIBERNATE_CALLBACKS
 static inline void lock_system_sleep(void) {}
 static inline void unlock_system_sleep(void) {}
 
-#else
-
-/* Let some subsystems like memory hotadd exclude hibernation */
-
-static inline void lock_system_sleep(void)
-{
-	freezer_do_not_count();
-	mutex_lock(&pm_mutex);
-}
-
-static inline void unlock_system_sleep(void)
-{
-	mutex_unlock(&pm_mutex);
-	freezer_count();
-}
-#endif
+#endif /* !CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_ARCH_SAVE_PAGE_KEYS
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
