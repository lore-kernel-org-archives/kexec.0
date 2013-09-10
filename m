Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJVk0-0002CU-Qk
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 21:44:58 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 14/16] kexec: Export sysfs attributes for secureboot and
 secure modules to user space
Date: Tue, 10 Sep 2013 17:44:29 -0400
Message-Id: <1378849471-10521-15-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com, vgoyal@redhat.com

User space kexec-tools need to know whether to verify signature of kernel
image being loaded. This patch exports two knobs to user space. One is
for knowing if  secureboot is enabled, this knob will be set to 1 if secure
boot is enabled. Other knob is secure_module_enabled. This knob will be set
to 1 if secure modules is one.

kexec-tools will verify signature of kernel image if either secureboot is
enabled or secure modules is enabled. The only difference between two is
that kexec-tools will set secureboot on in bootparams being passed to
second kernel if secureboot is on in first kernel.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/ksysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 6ada93c..7262245 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -18,6 +18,8 @@
 #include <linux/stat.h>
 #include <linux/sched.h>
 #include <linux/capability.h>
+#include <linux/efi.h>
+#include <linux/module.h>
 
 #define KERNEL_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
@@ -101,6 +103,25 @@ static ssize_t kexec_crash_loaded_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(kexec_crash_loaded);
 
+static ssize_t secureboot_enabled_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	/* TODO: Change it once secureboot patches are in */
+	return sprintf(buf, "%d\n", 1);
+}
+KERNEL_ATTR_RO(secureboot_enabled);
+
+static ssize_t secure_modules_enabled_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	/*
+	 * TODO: Change it once secure_modules() or secure_level() patches
+	 * are in
+	 */
+	return sprintf(buf, "%d\n", 1);
+}
+KERNEL_ATTR_RO(secure_modules_enabled);
+
 static ssize_t kexec_crash_size_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
@@ -196,6 +217,10 @@ static struct attribute * kernel_attrs[] = {
 	&kexec_crash_size_attr.attr,
 	&vmcoreinfo_attr.attr,
 #endif
+#ifdef CONFIG_EFI
+	&secureboot_enabled_attr.attr,
+#endif
+	&secure_modules_enabled_attr.attr,
 	&rcu_expedited_attr.attr,
 	NULL
 };
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
