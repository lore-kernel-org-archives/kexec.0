Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: [PATCH] kexec: Discard loaded image on memory hotplug
Date: Fri,  1 May 2020 17:57:01 +0100
Message-Id: <20200501165701.24587-1-james.morse@arm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc: James Morse <james.morse@arm.com>, Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>

On x86, the kexec payload contains a copy of the current memory map.
If memory is added or removed, this copy of the memory map becomes
stale. Getting this wrong may prevent the next kernel from booting.
The first kernel may die if it tries to re-assemble the next kernel
in memory that has been removed.

Discard the loaded kexec image when the memory map changes, user-space
should reload it.

Kdump is unaffected, as it is placed within the crashkernel reserved
memory area and only uses this memory. The stale memory map may affect
generation of the vmcore, but the kdump kernel should be in a position
to validate it.

Signed-off-by: James Morse <james.morse@arm.com>
---
This patch obsoletes:
 * kexec/memory_hotplug: Prevent removal and accidental use
https://lore.kernel.org/linux-arm-kernel/20200326180730.4754-1-james.morse@arm.com/

 kernel/kexec_core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..e1901e5bd4b5 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
@@ -22,10 +23,12 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/utsname.h>
+#include <linux/notifier.h>
 #include <linux/numa.h>
 #include <linux/suspend.h>
 #include <linux/device.h>
 #include <linux/freezer.h>
+#include <linux/pfn.h>
 #include <linux/pm.h>
 #include <linux/cpu.h>
 #include <linux/uaccess.h>
@@ -1219,3 +1222,40 @@ void __weak arch_kexec_protect_crashkres(void)
 
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+/*
+ * If the memory layout changes, any loaded kexec image should be evicted
+ * as it may contain a copy of the (now stale) memory map. This also means
+ * we don't need to check the memory is still present when re-assembling the
+ * new kernel at machine_kexec() time.
+ */
+static int mem_change_cb(struct notifier_block *nb, unsigned long action,
+			 void *data)
+{
+	/*
+	 * Actions are either a change, or a change being cancelled.
+	 * A second discard for 'cancel's is harmless.
+	 */
+
+	mutex_lock(&kexec_mutex);
+	if (kexec_image) {
+		kimage_free(xchg(&kexec_image, NULL));
+		pr_warn("loaded image discarded due to memory hotplug");
+	}
+	mutex_unlock(&kexec_mutex);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mem_change_nb = {
+	.notifier_call = mem_change_cb,
+};
+
+static int __init register_mem_change_cb(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return register_memory_notifier(&mem_change_nb);
+
+	return 0;
+}
+device_initcall(register_mem_change_cb);
-- 
2.26.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
