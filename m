Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SUZ6r-0000er-CI
 for kexec@lists.infradead.org; Wed, 16 May 2012 07:57:26 +0000
Message-ID: <4FB35D98.8080500@cn.fujitsu.com>
Date: Wed, 16 May 2012 15:56:08 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 4/5] ksysfs: Export VMCSINFO via sysfs
References: <4FB35C48.30708@cn.fujitsu.com>
In-Reply-To: <4FB35C48.30708@cn.fujitsu.com>
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
To: Avi Kivity <avi@redhat.com>, mtosatti@redhat.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

This patch creates two sysfs files to export where VMCSINFO is
allocated and what maximum size of VMCSINFO is, as below:
        $ cat /sys/kernel/vmcsinfo
        1cb88a0
        $ cat /sys/kernel/vmcsinfo_maxsize
        1000
/sys/kernel/vmcsinfo shows the physical address of VMCSINFO,
while /sys/kernel/vmcsinfo_maxsize shows the max size of VMCSINFO.

Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
---
 kernel/ksysfs.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 4e316e1..8a27ece 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -18,6 +18,8 @@
 #include <linux/stat.h>
 #include <linux/sched.h>
 #include <linux/capability.h>
+#include <asm/vmcsinfo.h>
+#include <asm/virtext.h>
 
 #define KERNEL_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
@@ -133,6 +135,29 @@ KERNEL_ATTR_RO(vmcoreinfo);
 
 #endif /* CONFIG_KEXEC */
 
+#ifdef CONFIG_X86
+static ssize_t vmcsinfo_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	if (cpu_has_vmx())
+		return sprintf(buf, "%lx\n",
+			       paddr_vmcsinfo_note());
+	return 0;
+}
+KERNEL_ATTR_RO(vmcsinfo);
+
+static ssize_t vmcsinfo_maxsize_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	if (cpu_has_vmx())
+		return sprintf(buf, "%x\n",
+			       (unsigned int)vmcsinfo_max_size);
+	return 0;
+}
+KERNEL_ATTR_RO(vmcsinfo_maxsize);
+
+#endif /* CONFIG_X86 */
+
 /* whether file capabilities are enabled */
 static ssize_t fscaps_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
@@ -182,6 +207,10 @@ static struct attribute * kernel_attrs[] = {
 	&kexec_crash_size_attr.attr,
 	&vmcoreinfo_attr.attr,
 #endif
+#ifdef CONFIG_X86
+	&vmcsinfo_attr.attr,
+	&vmcsinfo_maxsize_attr.attr,
+#endif
 	NULL
 };
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
