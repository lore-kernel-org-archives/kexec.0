Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anL8H-0005uS-MY
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 07:10:38 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v2] s390/kexec: Consolidate crash_map/unmap_reserved_pages()
 and arch_kexec_protect(unprotect)_crashkres()
Date: Tue,  5 Apr 2016 15:09:59 +0800
Message-Id: <1459840199-19920-1-git-send-email-xlpang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, Minfei Huang <mhuang@redhat.com>, Xunlei Pang <xlpang@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, ebiederm@xmission.com, akpm@linux-foundation.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

Commit 3f625002581b ("kexec: introduce a protection mechanism
for the crashkernel reserved memory") is a similar mechanism
for protecting the crash kernel reserved memory to previous
crash_map/unmap_reserved_pages() implementation, the new one
is more generic in name and cleaner in code (besides, some
arch may not be allowed to unmap the pgtable).

Therefore, this patch consolidates them, and uses the new
arch_kexec_protect(unprotect)_crashkres() to replace former
crash_map/unmap_reserved_pages() which by now has been only
used by S390.

The consolidation work needs the crash memory to be mapped
initially, so get rid of S390 crash kernel memblock removal
in reserve_crashkernel(). Once kdump kernel is loaded, the
new arch_kexec_protect_crashkres() implemented for S390 will
actually unmap the pgtable like before.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
Changes from v1: 
1)Merged with Michael's changes:
s390/kdump: Consolidate crash_map/unmap_reserved_pages() - update

 - Move functions back to keep the patch small
 - Consolidate crash_map_reserved_pages/arch_kexec_unprotect_crashkres()
 - Re-introduce memblock_remove()
 - Call arch_kexec_unprotect_crashkres() in machine_kdump_pm_init()

2)Imposed some tweaks.

 arch/s390/kernel/machine_kexec.c | 28 ++++++++++++++++++----------
 include/linux/kexec.h            |  2 --
 kernel/kexec.c                   | 12 ------------
 kernel/kexec_core.c              | 11 ++---------
 4 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 2f1b721..0e64f08 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -43,13 +43,13 @@ static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
 	switch (action) {
 	case PM_SUSPEND_PREPARE:
 	case PM_HIBERNATION_PREPARE:
-		if (crashk_res.start)
-			crash_map_reserved_pages();
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
 		break;
 	case PM_POST_SUSPEND:
 	case PM_POST_HIBERNATION:
-		if (crashk_res.start)
-			crash_unmap_reserved_pages();
+		if (kexec_crash_image)
+			arch_kexec_protect_crashkres();
 		break;
 	default:
 		return NOTIFY_DONE;
@@ -60,6 +60,8 @@ static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
 static int __init machine_kdump_pm_init(void)
 {
 	pm_notifier(machine_kdump_pm_cb, 0);
+	/* Create initial mapping for crashkernel memory */
+	arch_kexec_unprotect_crashkres();
 	return 0;
 }
 arch_initcall(machine_kdump_pm_init);
@@ -146,6 +148,8 @@ static int kdump_csum_valid(struct kimage *image)
 #endif
 }
 
+#ifdef CONFIG_CRASH_DUMP
+
 /*
  * Map or unmap crashkernel memory
  */
@@ -167,21 +171,25 @@ static void crash_map_pages(int enable)
 }
 
 /*
- * Map crashkernel memory
+ * Unmap crashkernel memory
  */
-void crash_map_reserved_pages(void)
+void arch_kexec_protect_crashkres(void)
 {
-	crash_map_pages(1);
+	if (crashk_res.end)
+		crash_map_pages(0);
 }
 
 /*
- * Unmap crashkernel memory
+ * Map crashkernel memory
  */
-void crash_unmap_reserved_pages(void)
+void arch_kexec_unprotect_crashkres(void)
 {
-	crash_map_pages(0);
+	if (crashk_res.end)
+		crash_map_pages(1);
 }
 
+#endif
+
 /*
  * Give back memory to hypervisor before new kdump is loaded
  */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f82d6a2..c76641c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -230,8 +230,6 @@ extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
-void crash_map_reserved_pages(void);
-void crash_unmap_reserved_pages(void);
 void arch_crash_save_vmcoreinfo(void);
 __printf(1, 2)
 void vmcoreinfo_append_str(const char *fmt, ...);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b73dc21..4384672 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -136,9 +136,6 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		return ret;
 
-	if (flags & KEXEC_ON_CRASH)
-		crash_map_reserved_pages();
-
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
 
@@ -161,12 +158,6 @@ out:
 	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
-	/*
-	 * Once the reserved memory is mapped, we should unmap this memory
-	 * before returning
-	 */
-	if (flags & KEXEC_ON_CRASH)
-		crash_unmap_reserved_pages();
 	kimage_free(image);
 	return ret;
 }
@@ -232,9 +223,6 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 
 	result = do_kexec_load(entry, nr_segments, segments, flags);
 
-	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
-		arch_kexec_protect_crashkres();
-
 	mutex_unlock(&kexec_mutex);
 
 	return result;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f826e11..58cd872 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -953,7 +953,6 @@ int crash_shrink_memory(unsigned long new_size)
 	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
 	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
 
-	crash_map_reserved_pages();
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
@@ -967,7 +966,6 @@ int crash_shrink_memory(unsigned long new_size)
 	crashk_res.end = end - 1;
 
 	insert_resource(&iomem_resource, ram_res);
-	crash_unmap_reserved_pages();
 
 unlock:
 	mutex_unlock(&kexec_mutex);
@@ -1549,17 +1547,12 @@ int kernel_kexec(void)
 }
 
 /*
- * Add and remove page tables for crashkernel memory
+ * Protection mechanism for crashkernel reserved memory after
+ * the kdump kernel is loaded.
  *
  * Provide an empty default implementation here -- architecture
  * code may override this
  */
-void __weak crash_map_reserved_pages(void)
-{}
-
-void __weak crash_unmap_reserved_pages(void)
-{}
-
 void __weak arch_kexec_protect_crashkres(void)
 {}
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
