From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 11 Apr 2022 14:13:56 +0530
Subject: [RFC v4 PATCH 4/5] powerpc/crash hp: add crash hotplug support for
 kexec_file_load
In-Reply-To: <20220411084357.157308-1-sourabhjain@linux.ibm.com>
References: <20220411084357.157308-1-sourabhjain@linux.ibm.com>
Message-ID: <20220411084357.157308-5-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Two major changes are done to enable the crash CPU hotplug handler.
Firstly, updated the kexec load path to prepare kimage for hotplug
changes, and secondly, implemented the crash hotplug handler.

On the kexec load path, the memsz allocation of the crash FDT segment
is updated to ensure that it has sufficient buffer space to accommodate
future hot add CPUs. Initialized the kimage members to track the kexec
FDT segment.

The crash hotplug handler updates the cpus node of crash FDT. While we
update crash FDT the kexec_crash_image is marked invalid and restored
after FDT update to avoid race.

Since memory crash hotplug support is not there yet the crash hotplug
the handler simply warns the user and returns.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 46 ++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c  | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 249d2632526d..62f77cc86407 100644
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
+		pr_info_once("crash hp: crash update is not supported with memory hotplug\n");
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
index eeb258002d1e..9dc774548ce4 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -24,6 +24,67 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_ppc.h>
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+/**
+ * get_cpu_node_sz() - Calculate the space needed to store a CPU device type node
+ *                     in FDT. The calculation is done based on the existing CPU
+ *                     node in unflatten device tree. Loop through all the
+ *                     properties of the very first CPU type device node found in
+ *                     unflatten device tree and returns the sum of the property
+ *                     length and property string size of all properties of a CPU
+ *                     node.
+ */
+static int get_cpu_node_sz(void) {
+	struct device_node *dn = NULL;
+	struct property *pp;
+	int cpu_node_size = 0;
+
+	dn = of_find_node_by_type(NULL, "cpu");
+
+	if (!dn) {
+		pr_warn("Unable to locate cpu device_type node.\n");
+		goto out;
+	}
+
+	/* Every node in FDT starts with FDT_BEGIN_NODE and ends with
+	 * FDT_END_NODE that takes one byte each.
+	 */
+	cpu_node_size = 2;
+
+	for_each_property_of_node(dn, pp) {
+		/* For each property add two bytes extra. One for string null
+		 * character for property name and other for FDT property start
+		 * tag FDT_PROP.
+		 */
+		cpu_node_size = cpu_node_size + pp->length + strlen(pp->name) + 2;
+	}
+
+out:
+	return cpu_node_size;
+}
+
+/**
+ * get_crash_fdt_mem_sz() - calcuate mem size for crash kernel FDT
+ * @fdt: pointer to crash kernel FDT
+ *
+ * Calculate the buffer space needed to add more CPU nodes in crash FDT
+ * post capture kenrel load due to CPU hotplug events.
+ */
+static unsigned int get_crash_fdt_mem_sz(void *fdt)
+{
+	int fdt_cpu_nodes_sz, offline_cpu_cnt;
+
+	offline_cpu_cnt = (num_possible_cpus() - num_present_cpus()) / MAX_SMT_THREADS;
+	fdt_cpu_nodes_sz = get_cpu_node_sz() * offline_cpu_cnt;
+
+	return fdt_totalsize(fdt) + fdt_cpu_nodes_sz;
+}
+#endif
+
 static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long kernel_len, char *initrd,
 			unsigned long initrd_len, char *cmdline,
@@ -123,6 +184,19 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
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


