Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PfgZz-000783-4e
	for kexec@lists.infradead.org; Wed, 19 Jan 2011 22:32:39 +0000
From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] kexec: include sysctl to disable
Date: Wed, 19 Jan 2011 17:26:30 -0500
Message-ID: <20110119222630.6755.63928.stgit@paris.rdu.redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: ebiederm@xmission.com

much like /proc/sys/kernel/modules_disable is used to disable module
loading, /proc/sys/kernel/kexec_disable is used to disable kexec code
loading.  It would still be possible to use kexec -l to load a kernel, set
the tunable to 1 so the kernel waiting to boot couldn't change, and then
launch the kernel at a later time (through kexec -e or through a crash)

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/kexec.h |    2 ++
 kernel/kexec.c        |    4 ++++
 kernel/sysctl.c       |   13 +++++++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 03e8e8d..fd8b2b8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -195,6 +195,8 @@ extern struct kimage *kexec_crash_image;
 #define VMCOREINFO_NOTE_SIZE       (KEXEC_NOTE_HEAD_BYTES*2 + VMCOREINFO_BYTES \
 				    + VMCOREINFO_NOTE_NAME_BYTES)
 
+extern int kexec_load_disabled;
+
 /* Location of a reserved region to hold the crash kernel.
  */
 extern struct resource crashk_res;
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 213ce69..5aff5cd 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -48,6 +48,7 @@ static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
 u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
 size_t vmcoreinfo_size;
 size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
+int kexec_load_disabled;
 
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {
@@ -949,6 +950,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	    !capable(CAP_SYS_MODULE))
 		return -EPERM;
 
+	if (kexec_load_disabled)
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0e1ac51..1fdc973 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -55,6 +55,7 @@
 #include <linux/kprobes.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/oom.h>
+#include <linux/kexec.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -569,6 +570,18 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &one,
 	},
 #endif
+#ifdef CONFIG_KEXEC
+	{
+		.procname	= "kexec_load_disabled",
+		.data		= &kexec_load_disabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &one,
+		.extra2		= &one,
+	},
+#endif
 #ifdef CONFIG_HOTPLUG
 	{
 		.procname	= "hotplug",


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
