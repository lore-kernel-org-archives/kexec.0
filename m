Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXIHd-0008LK-GD
 for kexec@lists.infradead.org; Sun, 04 Dec 2011 20:03:34 +0000
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 4 Dec 2011 19:59:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB4K3SNx4645088
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 07:03:28 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB4K3SnF018030
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 07:03:28 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/3] PM / Sleep: Replace mutex_[un]lock(&pm_mutex) with
 [un]lock_system_sleep()
Date: Mon, 05 Dec 2011 01:33:22 +0530
Message-ID: <20111204200248.25620.20660.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
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

Using [un]lock_system_sleep() is safer than directly using mutex_[un]lock()
on 'pm_mutex', since the latter could lead to freezing failures. Hence convert
all the present users of mutex_[un]lock(&pm_mutex) to use these safe APIs
instead.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/kexec.c           |    4 ++--
 kernel/power/hibernate.c |   16 ++++++++--------
 kernel/power/main.c      |    4 ++--
 kernel/power/suspend.c   |    4 ++--
 kernel/power/user.c      |   16 ++++++++--------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index dc7bc08..090ee10 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1523,7 +1523,7 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-		mutex_lock(&pm_mutex);
+		lock_system_sleep();
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1576,7 +1576,7 @@ int kernel_kexec(void)
 		thaw_processes();
  Restore_console:
 		pm_restore_console();
-		mutex_unlock(&pm_mutex);
+		unlock_system_sleep();
 	}
 #endif
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 605149a..6d6d288 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -69,14 +69,14 @@ void hibernation_set_ops(const struct platform_hibernation_ops *ops)
 		WARN_ON(1);
 		return;
 	}
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 	hibernation_ops = ops;
 	if (ops)
 		hibernation_mode = HIBERNATION_PLATFORM;
 	else if (hibernation_mode == HIBERNATION_PLATFORM)
 		hibernation_mode = HIBERNATION_SHUTDOWN;
 
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 }
 
 static bool entering_platform_hibernation;
@@ -597,7 +597,7 @@ int hibernate(void)
 {
 	int error;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
 		error = -EBUSY;
@@ -665,7 +665,7 @@ int hibernate(void)
 	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
  Unlock:
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 	return error;
 }
 
@@ -893,7 +893,7 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
 		if (len == strlen(hibernation_modes[i])
 		    && !strncmp(buf, hibernation_modes[i], len)) {
@@ -919,7 +919,7 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!error)
 		pr_debug("PM: Hibernation mode set to '%s'\n",
 			 hibernation_modes[mode]);
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 	return error ? error : n;
 }
 
@@ -946,9 +946,9 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (maj != MAJOR(res) || min != MINOR(res))
 		goto out;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 	swsusp_resume_device = res;
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 	printk(KERN_INFO "PM: Starting manual resume from disk\n");
 	noresume = 0;
 	software_resume();
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 7d36fb3..9824b41e 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -116,7 +116,7 @@ static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 
 	level = TEST_FIRST;
 	for (s = &pm_tests[level]; level <= TEST_MAX; s++, level++)
@@ -126,7 +126,7 @@ static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 			break;
 		}
 
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 
 	return error ? error : n;
 }
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index d336b27..4fd51be 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -42,9 +42,9 @@ static const struct platform_suspend_ops *suspend_ops;
  */
 void suspend_set_ops(const struct platform_suspend_ops *ops)
 {
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 	suspend_ops = ops;
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 }
 EXPORT_SYMBOL_GPL(suspend_set_ops);
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 06ea33d..98ade21 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -71,7 +71,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	struct snapshot_data *data;
 	int error;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
 		error = -EBUSY;
@@ -123,7 +123,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data->platform_support = 0;
 
  Unlock:
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 
 	return error;
 }
@@ -132,7 +132,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 
 	swsusp_free();
 	free_basic_memory_bitmaps();
@@ -146,7 +146,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	atomic_inc(&snapshot_device_available);
 
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 
 	return 0;
 }
@@ -158,7 +158,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 	ssize_t res;
 	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 
 	data = filp->private_data;
 	if (!data->ready) {
@@ -179,7 +179,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		*offp += res;
 
  Unlock:
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 
 	return res;
 }
@@ -191,7 +191,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	ssize_t res;
 	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	mutex_lock(&pm_mutex);
+	lock_system_sleep();
 
 	data = filp->private_data;
 
@@ -208,7 +208,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	if (res > 0)
 		*offp += res;
 unlock:
-	mutex_unlock(&pm_mutex);
+	unlock_system_sleep();
 
 	return res;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
