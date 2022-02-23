From: yingelin <yingelin@huawei.com>
Date: Wed, 23 Feb 2022 11:03:18 +0800
Subject: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls into
 its own file
Message-ID: <20220223030318.213093-1-yingelin@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This move the kernel/kexec_core.c respective sysctls to its own file.

Signed-off-by: yingelin <yingelin@huawei.com>
---
 kernel/kexec_core.c | 20 ++++++++++++++++++++
 kernel/sysctl.c     | 13 -------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..e57339d49439 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -936,6 +936,26 @@ int kimage_load_segment(struct kimage *image,
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 int kexec_load_disabled;
+static struct ctl_table kexec_core_sysctls[] = {
+	{
+		.procname	= "kexec_load_disabled",
+		.data		= &kexec_load_disabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static int __init kexec_core_sysctl_init(void)
+{
+	register_sysctl_init("kernel", kexec_core_sysctls);
+	return 0;
+}
+late_initcall(kexec_core_sysctl_init);
 
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ae5e59396b5d..00e97c6d6576 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -61,7 +61,6 @@
 #include <linux/capability.h>
 #include <linux/binfmts.h>
 #include <linux/sched/sysctl.h>
-#include <linux/kexec.h>
 #include <linux/bpf.h>
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
@@ -1839,18 +1838,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= tracepoint_printk_sysctl,
 	},
 #endif
-#ifdef CONFIG_KEXEC_CORE
-	{
-		.procname	= "kexec_load_disabled",
-		.data		= &kexec_load_disabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		/* only handle a transition from default "0" to "1" */
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_MODULES
 	{
 		.procname	= "modprobe",
-- 
2.26.2


