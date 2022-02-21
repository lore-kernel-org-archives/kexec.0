From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Feb 2022 14:16:21 +0530
Subject: [RFC PATCH 2/5] powerpc/kdump: setup kexec crash FDT
In-Reply-To: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
References: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
Message-ID: <20220221084624.85792-3-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

DLPAR operation post kexec_load or kexec_file_load system call makes the
kexec crash kernel FDT stale. Booting kdump kernel with stale FDT leads
to kernel hang. To keep the kdump FDT updated kdump reload is performed
after DLPAR operation.

The kdump reloading after each DLPAR operation can be avoided if kdump_load
and kexec_file_load can use the FDT created and maintained by the kernel.

Set up a kexec crash FDT in crashkernel reserved region by allocating a memory
hole in crashkernel reserved region. Subsequent patches take care of updating
this FDT and using this FDT in kexec_load and kexec_file_load system calls.

A new config KEXEC_CRASH_FDT is added to include this feature at the build
time.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig             | 11 +++++++
 arch/powerpc/include/asm/kexec.h |  5 +++
 arch/powerpc/kexec/core_64.c     | 52 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ba5b66189358..b11a50851d2c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -634,6 +634,17 @@ config PRESERVE_FA_DUMP
 	  memory preserving kernel boot would process this crash data.
 	  Petitboot kernel is the typical usecase for this option.
 
+config KEXEC_CRASH_FDT
+	bool "Update crash kernel FDT on hotplug event"
+	depends on CRASH_DUMP && HOTPLUG_CPU
+	help
+	  This option avoids the need to reload kdump on every hotplug event.
+	  During boot, the kernel pre-allocates the space for kdump FDT in
+	  the reserved area and uses the same space to store the FDT created
+	  during kexec_load or kexec_file_load. This helps the kernel to just
+	  update the FDT with the latest hotplug event info rather than
+	  preparing and reloading all the kexec components again.
+
 config OPAL_CORE
 	bool "Export OPAL memory as /sys/firmware/opal/core"
 	depends on PPC64 && PPC_POWERNV
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index c2398140aa3b..dc5b29eb2ddb 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -119,6 +119,11 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 #ifdef CONFIG_PPC64
 struct kexec_buf;
 
+#ifdef CONFIG_KEXEC_CRASH_FDT
+extern void *kexec_crash_fdt;
+extern u32 kexec_crash_fdt_size;
+#endif /* CONFIG_KEXEC_CRASH_FDT */
+
 int load_crashdump_segments_ppc64(struct kimage *image,
 				  struct kexec_buf *kbuf);
 int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 583eb7fa3388..be15aaf17a88 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 
 #include <asm/page.h>
+#include <asm/kexec.h>
 #include <asm/current.h>
 #include <asm/machdep.h>
 #include <asm/cacheflush.h>
@@ -34,6 +35,13 @@
 #include <asm/svm.h>
 #include <asm/ultravisor.h>
 
+#ifdef CONFIG_KEXEC_CRASH_FDT
+void *kexec_crash_fdt;
+EXPORT_SYMBOL_GPL(kexec_crash_fdt);
+u32 kexec_crash_fdt_size;
+EXPORT_SYMBOL_GPL(kexec_crash_fdt_size);
+#endif
+
 int default_machine_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -571,3 +579,47 @@ static int __init export_htab_values(void)
 }
 late_initcall(export_htab_values);
 #endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_KEXEC_CRASH_FDT
+/* Calculate the size of kexec crash fdt */
+static u32 get_kexec_crash_fdt_size(void)
+{
+	// TODO: add logic to calculate it based on system configuration
+	return 1024*1024;
+}
+
+/* Setup the memory hole for kdump fdt in reserved region below RMA.
+ */
+static int __init setup_kexec_crash_fdt(void)
+{
+	int ret = 0;
+	struct crash_mem *exclude_ranges = NULL;
+	struct kexec_buf kbuf;
+
+	/* make sure kdump is enabled and necessary memory reservation
+	 * is done. The kexec crash FDT will be part of reserved memory
+	 * region.
+	 */
+	if (!crash_get_memory_size())
+		goto out;
+
+	if (get_exclude_memory_ranges(&exclude_ranges))
+		goto out;
+
+	/* locate memory hole for kdump fdt in reserved region below RMA */
+	kbuf.mem = 0;
+	kbuf.memsz = (unsigned long) get_kexec_crash_fdt_size();
+	ret = locate_mem_hole_top_down_ppc64(&kbuf, crashk_res.start,
+					     min(ppc64_rma_size, crashk_res.end),
+					     exclude_ranges);
+	if (ret)
+		return -ENOMEM;
+
+	kexec_crash_fdt = __va(kbuf.mem);
+	kexec_crash_fdt_size = kbuf.memsz;
+
+out:
+	return ret;
+}
+late_initcall(setup_kexec_crash_fdt);
+#endif /* CONFIG_KEXEC_CRASH_FDT */
-- 
2.34.1


