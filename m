From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Feb 2022 14:16:20 +0530
Subject: [RFC PATCH 1/5] powerpc/kdump: export functions from file_load_64.c
In-Reply-To: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
References: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
Message-ID: <20220221084624.85792-2-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Functions get_exclude_memory_ranges and locate_mem_hole_top_down_ppc64
can be shared across different kexec components, so export them as global
functions.

The locate_mem_hole_top_down_ppc64 and get_exclude_memory_ranges functions
definition is moved to core_64.c so that both kexec_load and kexec_file_load
system call can use them.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h  |   4 +
 arch/powerpc/kexec/core_64.c      | 150 ++++++++++++++++++++++++++++++
 arch/powerpc/kexec/file_load_64.c | 148 -----------------------------
 3 files changed, 154 insertions(+), 148 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 88d0d7cf3a79..c2398140aa3b 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -128,6 +128,10 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image);
 int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 			unsigned long initrd_load_addr,
 			unsigned long initrd_len, const char *cmdline);
+int get_exclude_memory_ranges(struct crash_mem **mem_ranges);
+int locate_mem_hole_top_down_ppc64(struct kexec_buf *kbuf,
+				   u64 buf_min, u64 buf_max,
+				   const struct crash_mem *emem);
 #endif /* CONFIG_PPC64 */
 
 #endif /* CONFIG_KEXEC_FILE */
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 89c069d664a5..583eb7fa3388 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 #include <linux/hardirq.h>
+#include <linux/memblock.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -27,6 +28,7 @@
 #include <asm/sections.h>	/* _end */
 #include <asm/prom.h>
 #include <asm/smp.h>
+#include <asm/kexec_ranges.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/asm-prototypes.h>
 #include <asm/svm.h>
@@ -74,6 +76,154 @@ int default_machine_kexec_prepare(struct kimage *image)
 	return 0;
 }
 
+/**
+ * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
+ *                             regions like opal/rtas, tce-table, initrd,
+ *                             kernel, htab which should be avoided while
+ *                             setting up kexec load segments.
+ * @mem_ranges:                Range list to add the memory ranges to.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
+{
+	int ret;
+
+	ret = add_tce_mem_ranges(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_initrd_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_htab_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_kernel_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_rtas_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_opal_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_reserved_mem_ranges(mem_ranges);
+	if (ret)
+		goto out;
+
+	/* exclude memory ranges should be sorted for easy lookup */
+	sort_memory_ranges(*mem_ranges, true);
+out:
+	if (ret)
+		pr_err("Failed to setup exclude memory ranges\n");
+	return ret;
+}
+
+/**
+ * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
+ *                              in the memory regions between buf_min & buf_max
+ *                              for the buffer. If found, sets kbuf->mem.
+ * @kbuf:                       Buffer contents and memory parameters.
+ * @buf_min:                    Minimum address for the buffer.
+ * @buf_max:                    Maximum address for the buffer.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
+				      u64 buf_min, u64 buf_max)
+{
+	int ret = -EADDRNOTAVAIL;
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range_rev(i, &start, &end) {
+		/*
+		 * memblock uses [start, end) convention while it is
+		 * [start, end] here. Fix the off-by-one to have the
+		 * same convention.
+		 */
+		end -= 1;
+
+		if (start > buf_max)
+			continue;
+
+		/* Memory hole not found */
+		if (end < buf_min)
+			break;
+
+		/* Adjust memory region based on the given range */
+		if (start < buf_min)
+			start = buf_min;
+		if (end > buf_max)
+			end = buf_max;
+
+		start = ALIGN(start, kbuf->buf_align);
+		if (start < end && (end - start + 1) >= kbuf->memsz) {
+			/* Suitable memory range found. Set kbuf->mem */
+			kbuf->mem = ALIGN_DOWN(end - kbuf->memsz + 1,
+					       kbuf->buf_align);
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * locate_mem_hole_top_down_ppc64 - Skip special memory regions to find a
+ *                                  suitable buffer with top down approach.
+ * @kbuf:                           Buffer contents and memory parameters.
+ * @buf_min:                        Minimum address for the buffer.
+ * @buf_max:                        Maximum address for the buffer.
+ * @emem:                           Exclude memory ranges.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int locate_mem_hole_top_down_ppc64(struct kexec_buf *kbuf,
+					  u64 buf_min, u64 buf_max,
+					  const struct crash_mem *emem)
+{
+	int i, ret = 0, err = -EADDRNOTAVAIL;
+	u64 start, end, tmin, tmax;
+
+	tmax = buf_max;
+	for (i = (emem->nr_ranges - 1); i >= 0; i--) {
+		start = emem->ranges[i].start;
+		end = emem->ranges[i].end;
+
+		if (start > tmax)
+			continue;
+
+		if (end < tmax) {
+			tmin = (end < buf_min ? buf_min : end + 1);
+			ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
+			if (!ret)
+				return 0;
+		}
+
+		tmax = start - 1;
+
+		if (tmax < buf_min) {
+			ret = err;
+			break;
+		}
+		ret = 0;
+	}
+
+	if (!ret) {
+		tmin = buf_min;
+		ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
+	}
+	return ret;
+}
+
 /* Called during kexec sequence with MMU off */
 static notrace void copy_segments(unsigned long ind)
 {
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 5056e175ca2c..194a3c72a7a9 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -42,55 +42,6 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
 
-/**
- * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
- *                             regions like opal/rtas, tce-table, initrd,
- *                             kernel, htab which should be avoided while
- *                             setting up kexec load segments.
- * @mem_ranges:                Range list to add the memory ranges to.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
-{
-	int ret;
-
-	ret = add_tce_mem_ranges(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_initrd_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_htab_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_kernel_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_rtas_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_opal_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_reserved_mem_ranges(mem_ranges);
-	if (ret)
-		goto out;
-
-	/* exclude memory ranges should be sorted for easy lookup */
-	sort_memory_ranges(*mem_ranges, true);
-out:
-	if (ret)
-		pr_err("Failed to setup exclude memory ranges\n");
-	return ret;
-}
-
 /**
  * get_usable_memory_ranges - Get usable memory ranges. This list includes
  *                            regions like crashkernel, opal/rtas & tce-table,
@@ -232,105 +183,6 @@ static int get_reserved_memory_ranges(struct crash_mem **mem_ranges)
 	return ret;
 }
 
-/**
- * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
- *                              in the memory regions between buf_min & buf_max
- *                              for the buffer. If found, sets kbuf->mem.
- * @kbuf:                       Buffer contents and memory parameters.
- * @buf_min:                    Minimum address for the buffer.
- * @buf_max:                    Maximum address for the buffer.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
-				      u64 buf_min, u64 buf_max)
-{
-	int ret = -EADDRNOTAVAIL;
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range_rev(i, &start, &end) {
-		/*
-		 * memblock uses [start, end) convention while it is
-		 * [start, end] here. Fix the off-by-one to have the
-		 * same convention.
-		 */
-		end -= 1;
-
-		if (start > buf_max)
-			continue;
-
-		/* Memory hole not found */
-		if (end < buf_min)
-			break;
-
-		/* Adjust memory region based on the given range */
-		if (start < buf_min)
-			start = buf_min;
-		if (end > buf_max)
-			end = buf_max;
-
-		start = ALIGN(start, kbuf->buf_align);
-		if (start < end && (end - start + 1) >= kbuf->memsz) {
-			/* Suitable memory range found. Set kbuf->mem */
-			kbuf->mem = ALIGN_DOWN(end - kbuf->memsz + 1,
-					       kbuf->buf_align);
-			ret = 0;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-/**
- * locate_mem_hole_top_down_ppc64 - Skip special memory regions to find a
- *                                  suitable buffer with top down approach.
- * @kbuf:                           Buffer contents and memory parameters.
- * @buf_min:                        Minimum address for the buffer.
- * @buf_max:                        Maximum address for the buffer.
- * @emem:                           Exclude memory ranges.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int locate_mem_hole_top_down_ppc64(struct kexec_buf *kbuf,
-					  u64 buf_min, u64 buf_max,
-					  const struct crash_mem *emem)
-{
-	int i, ret = 0, err = -EADDRNOTAVAIL;
-	u64 start, end, tmin, tmax;
-
-	tmax = buf_max;
-	for (i = (emem->nr_ranges - 1); i >= 0; i--) {
-		start = emem->ranges[i].start;
-		end = emem->ranges[i].end;
-
-		if (start > tmax)
-			continue;
-
-		if (end < tmax) {
-			tmin = (end < buf_min ? buf_min : end + 1);
-			ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
-			if (!ret)
-				return 0;
-		}
-
-		tmax = start - 1;
-
-		if (tmax < buf_min) {
-			ret = err;
-			break;
-		}
-		ret = 0;
-	}
-
-	if (!ret) {
-		tmin = buf_min;
-		ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
-	}
-	return ret;
-}
-
 /**
  * __locate_mem_hole_bottom_up - Looks bottom up for a large enough memory hole
  *                               in the memory regions between buf_min & buf_max
-- 
2.34.1


