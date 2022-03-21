From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Mar 2022 13:34:21 +0530
Subject: [RFC v3 PATCH 4/5] powerpc/crash hp: add crash hotplug support for
 kexec_file_load
In-Reply-To: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
References: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
Message-ID: <20220321080422.56255-5-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Two major changes are done to enable the crash CPU hotplug handler.
Firstly, updated the kexec_load path to prepare kimage for hotplug
changes and secondly, implemented the crash hotplug handler itself.

On the kexec load path, memsz allocation of crash FDT segment is
updated to ensure that it has sufficient buffer space to accommodate
future hot add CPUs. Initialized the kimage members to track the FDT
segment.

The crash hotplug handler updates the cpus node of crash FDT. While
we update crash FDT the kexec_crash_image is marked invalid and restored
after FDT update to avoid race.

Since memory crash hotplug support is not there yet the crash hotplug
handler simply warn the user and return.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 46 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c  | 40 +++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 249d2632526d..a470fe6904e3 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -466,6 +466,52 @@ int update_cpus_node(void *fdt)
 	return ret;
 }
 
+#ifdef CONFIG_CRASH_HOTPLUG
+/**
+ * arch_crash_hotplug_handler() - Handle hotplug FDT changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ * @a: first parameter dependent upon hp_action
+ * @b: first parameter dependent upon hp_action
+ *
+ * To accurately reflect CPU hot un/plug changes, the FDT
+ * must be updated with the new list of CPUs and memories.
+ */
+void arch_crash_hotplug_handler(struct kimage *image, unsigned int hp_action,
+				unsigned long a, unsigned long b)
+{
+	void *fdt;
+
+	/* No action needed for CPU hot-unplug */
+	if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		return;
+
+	/* crash update on memory hotplug is not support yet */
+	if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
+		pr_err("crash hp: crash update is not supported with memory hotplug\n");
+		return;
+	}
+
+	/* Must have valid FDT index */
+	if (!image->arch.fdt_index_valid) {
+		pr_err("crash hp: unable to locate FDT segment");
+		return;
+	}
+
+	fdt = __va((void *)image->segment[image->arch.fdt_index].mem);
+
+	/* Temporarily invalidate the crash image while it is replaced */
+	xchg(&kexec_crash_image, NULL);
+
+	/* update FDT to refelect changes to CPU resrouces */
+	if (update_cpus_node(fdt))
+		pr_err("crash hp: failed to update crash FDT");
+
+	/* The crash image is now valid once again */
+	xchg(&kexec_crash_image, image);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
+
 #ifdef CONFIG_PPC_64S_HASH_MMU
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long htab_base;
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e..2ffe6d69e186 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -24,6 +24,33 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#define MAX_CORE 256
+#define PER_CORE_NODE_SIZE 1500
+
+/**
+ * get_crash_fdt_mem_sz() - calcuate mem size for crash kernel FDT
+ * @fdt: pointer to crash kernel FDT
+ *
+ * Calculate the buffer space needed to add more CPU nodes in FDT after
+ * capture kenrel load due to hot add events.
+ *
+ * Some assumption are made to calculate the additional buffer size needed
+ * to accommodate future hot add CPUs to the crash FDT. The maximum core count
+ * in the system would not go beyond MAX_CORE and memory needed to store per core
+ * date in FDT is PER_CORE_NODE_SIZE.
+ *
+ * Certainly MAX_CORE count can be replaced with possible core count and
+ * PER_CORE_NODE_SIZE to some standard value instead of randomly observed
+ * core size value on Power9 LPAR.
+ */
+static unsigned int get_crash_fdt_mem_sz(void *fdt)
+{
+	return fdt_totalsize(fdt) + (PER_CORE_NODE_SIZE * MAX_CORE);
+}
+#endif
+
 static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long kernel_len, char *initrd,
 			unsigned long initrd_len, char *cmdline,
@@ -123,6 +150,19 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	kbuf.buf_align = PAGE_SIZE;
 	kbuf.top_down = true;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kbuf.memsz = get_crash_fdt_mem_sz(fdt);
+		fdt_set_totalsize(fdt, kbuf.memsz);
+		image->arch.fdt_index = image->nr_segments;
+		image->arch.fdt_index_valid = true;
+	} else
+#endif
+	{
+		kbuf.memsz = fdt_totalsize(fdt);
+	}
+
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out_free_fdt;
-- 
2.35.1


