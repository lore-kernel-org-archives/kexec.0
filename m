From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Feb 2022 14:16:24 +0530
Subject: [RFC PATCH 5/5] powerpc/kdump: export kexec crash FDT details via
 sysfs
In-Reply-To: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
References: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
Message-ID: <20220221084624.85792-6-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Export kexec crash FDT address and size to /sys/kernel/kexec_crash_fdt
and /sys/kernel/kexec_crash_fdt_size files to enabled kexec tool to
utilize pre-allocated space kdump FDT.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 57afceee53a6..9bc9973ab3d3 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -677,6 +677,23 @@ static u32 get_kexec_crash_fdt_size(void)
 	return 1024*1024;
 }
 
+static ssize_t kexec_crash_fdt_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lx\n", __pa(kexec_crash_fdt));
+}
+static struct kobj_attribute kexec_crash_fdt_attr = __ATTR_RO(kexec_crash_fdt);
+
+static ssize_t kexec_crash_fdt_size_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sprintf(buf, "%d\n", kexec_crash_fdt_size);
+}
+static struct kobj_attribute kexec_crash_fdt_size_attr = \
+			__ATTR_RO(kexec_crash_fdt_size);
+
+
 /* Setup the memory hole for kdump fdt in reserved region below RMA.
  */
 static int __init setup_kexec_crash_fdt(void)
@@ -707,6 +724,16 @@ static int __init setup_kexec_crash_fdt(void)
 	kexec_crash_fdt = __va(kbuf.mem);
 	kexec_crash_fdt_size = kbuf.memsz;
 
+	if (sysfs_create_file(kernel_kobj, &kexec_crash_fdt_attr.attr)) {
+		pr_err("unable to create kdump_fdt sysfs file\n.");
+		return -1;
+	}
+
+	if (sysfs_create_file(kernel_kobj, &kexec_crash_fdt_size_attr.attr)) {
+		pr_err("unable to cerate kexec_crash_fdt_size sysfs file.\n");
+		return -1;
+	}
+
 out:
 	return ret;
 }
-- 
2.34.1


