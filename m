From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Tue, 15 Mar 2022 04:17:24 +0530
Subject: [RFC v2 PATCH 1/5] powerpc/kexec: make update_cpus_node non-static
In-Reply-To: <20220314224728.79990-1-sourabhjain@linux.ibm.com>
References: <20220314224728.79990-1-sourabhjain@linux.ibm.com>
Message-ID: <20220314224728.79990-2-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Make the update_cpus_node function non-static and export it for
usage in other kexec components.

The update_cpus_node definition is moved to core_64.c so that it
can be used with both kexec_load and kexec_file_load system calls.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h  |  1 +
 arch/powerpc/kexec/core_64.c      | 88 +++++++++++++++++++++++++++++++
 arch/powerpc/kexec/file_load_64.c | 87 ------------------------------
 3 files changed, 89 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 8ebdd23d987c..e1288826e22e 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -127,6 +127,7 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image);
 int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 			unsigned long initrd_load_addr,
 			unsigned long initrd_len, const char *cmdline);
+int update_cpus_node(void *fdt);
 #endif /* CONFIG_PPC64 */
 
 #endif /* CONFIG_KEXEC_FILE */
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 635b5fc30b53..249d2632526d 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 #include <linux/hardirq.h>
+#include <linux/libfdt.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -378,6 +379,93 @@ void default_machine_kexec(struct kimage *image)
 	/* NOTREACHED */
 }
 
+/**
+ * add_node_props - Reads node properties from device node structure and add
+ *                  them to fdt.
+ * @fdt:            Flattened device tree of the kernel
+ * @node_offset:    offset of the node to add a property at
+ * @dn:             device node pointer
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+static int add_node_props(void *fdt, int node_offset, const struct device_node *dn)
+{
+	int ret = 0;
+	struct property *pp;
+
+	if (!dn)
+		return -EINVAL;
+
+	for_each_property_of_node(dn, pp) {
+		ret = fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->length);
+		if (ret < 0) {
+			pr_err("Unable to add %s property: %s\n", pp->name, fdt_strerror(ret));
+			return ret;
+		}
+	}
+	return ret;
+}
+
+/**
+ * update_cpus_node - Update cpus node of flattened device tree using of_root
+ *                    device node.
+ * @fdt:              Flattened device tree of the kernel.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int update_cpus_node(void *fdt)
+{
+	struct device_node *cpus_node, *dn;
+	int cpus_offset, cpus_subnode_offset, ret = 0;
+
+	cpus_offset = fdt_path_offset(fdt, "/cpus");
+	if (cpus_offset < 0 && cpus_offset != -FDT_ERR_NOTFOUND) {
+		pr_err("Malformed device tree: error reading /cpus node: %s\n",
+		       fdt_strerror(cpus_offset));
+		return cpus_offset;
+	}
+
+	if (cpus_offset > 0) {
+		ret = fdt_del_node(fdt, cpus_offset);
+		if (ret < 0) {
+			pr_err("Error deleting /cpus node: %s\n", fdt_strerror(ret));
+			return -EINVAL;
+		}
+	}
+
+	/* Add cpus node to fdt */
+	cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"), "cpus");
+	if (cpus_offset < 0) {
+		pr_err("Error creating /cpus node: %s\n", fdt_strerror(cpus_offset));
+		return -EINVAL;
+	}
+
+	/* Add cpus node properties */
+	cpus_node = of_find_node_by_path("/cpus");
+	ret = add_node_props(fdt, cpus_offset, cpus_node);
+	of_node_put(cpus_node);
+	if (ret < 0)
+		return ret;
+
+	/* Loop through all subnodes of cpus and add them to fdt */
+	for_each_node_by_type(dn, "cpu") {
+		cpus_subnode_offset = fdt_add_subnode(fdt, cpus_offset, dn->full_name);
+		if (cpus_subnode_offset < 0) {
+			pr_err("Unable to add %s subnode: %s\n", dn->full_name,
+			       fdt_strerror(cpus_subnode_offset));
+			ret = cpus_subnode_offset;
+			goto out;
+		}
+
+		ret = add_node_props(fdt, cpus_subnode_offset, dn);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	of_node_put(dn);
+	return ret;
+}
+
 #ifdef CONFIG_PPC_64S_HASH_MMU
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long htab_base;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 07da6bf1cf24..57f991b0a9da 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -951,93 +951,6 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image)
 	return (unsigned int)(usm_entries * sizeof(u64));
 }
 
-/**
- * add_node_props - Reads node properties from device node structure and add
- *                  them to fdt.
- * @fdt:            Flattened device tree of the kernel
- * @node_offset:    offset of the node to add a property at
- * @dn:             device node pointer
- *
- * Returns 0 on success, negative errno on error.
- */
-static int add_node_props(void *fdt, int node_offset, const struct device_node *dn)
-{
-	int ret = 0;
-	struct property *pp;
-
-	if (!dn)
-		return -EINVAL;
-
-	for_each_property_of_node(dn, pp) {
-		ret = fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->length);
-		if (ret < 0) {
-			pr_err("Unable to add %s property: %s\n", pp->name, fdt_strerror(ret));
-			return ret;
-		}
-	}
-	return ret;
-}
-
-/**
- * update_cpus_node - Update cpus node of flattened device tree using of_root
- *                    device node.
- * @fdt:              Flattened device tree of the kernel.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int update_cpus_node(void *fdt)
-{
-	struct device_node *cpus_node, *dn;
-	int cpus_offset, cpus_subnode_offset, ret = 0;
-
-	cpus_offset = fdt_path_offset(fdt, "/cpus");
-	if (cpus_offset < 0 && cpus_offset != -FDT_ERR_NOTFOUND) {
-		pr_err("Malformed device tree: error reading /cpus node: %s\n",
-		       fdt_strerror(cpus_offset));
-		return cpus_offset;
-	}
-
-	if (cpus_offset > 0) {
-		ret = fdt_del_node(fdt, cpus_offset);
-		if (ret < 0) {
-			pr_err("Error deleting /cpus node: %s\n", fdt_strerror(ret));
-			return -EINVAL;
-		}
-	}
-
-	/* Add cpus node to fdt */
-	cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"), "cpus");
-	if (cpus_offset < 0) {
-		pr_err("Error creating /cpus node: %s\n", fdt_strerror(cpus_offset));
-		return -EINVAL;
-	}
-
-	/* Add cpus node properties */
-	cpus_node = of_find_node_by_path("/cpus");
-	ret = add_node_props(fdt, cpus_offset, cpus_node);
-	of_node_put(cpus_node);
-	if (ret < 0)
-		return ret;
-
-	/* Loop through all subnodes of cpus and add them to fdt */
-	for_each_node_by_type(dn, "cpu") {
-		cpus_subnode_offset = fdt_add_subnode(fdt, cpus_offset, dn->full_name);
-		if (cpus_subnode_offset < 0) {
-			pr_err("Unable to add %s subnode: %s\n", dn->full_name,
-			       fdt_strerror(cpus_subnode_offset));
-			ret = cpus_subnode_offset;
-			goto out;
-		}
-
-		ret = add_node_props(fdt, cpus_subnode_offset, dn);
-		if (ret < 0)
-			goto out;
-	}
-out:
-	of_node_put(dn);
-	return ret;
-}
-
 /**
  * setup_new_fdt_ppc64 - Update the flattend device-tree of the kernel
  *                       being loaded.
-- 
2.35.1


