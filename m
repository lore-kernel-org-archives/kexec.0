Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6i7d-0004FR-Te
	for kexec@lists.infradead.org; Thu, 12 Jun 2008 08:25:30 +0000
Date: Thu, 12 Jun 2008 17:23:23 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 2/2] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20080612170441.16D0.ODA@valinux.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xensource.com
Cc: kexec@lists.infradead.org

This patch is for linux-2.6.18-xen.

- get the machine address of the vmcoreinfo area of xen
- expose the machine address and the size of the vmcoreinfo area
  via /sys/hypervisor/vmcoreinfo so that the kexec-tools looks them.

Signed-off-by: Itsuro Oda <oda@valinux.co.jp>

diff -r e01b3a133ddc drivers/xen/core/machine_kexec.c
--- a/drivers/xen/core/machine_kexec.c	Wed Jun 11 09:28:01 2008 +0100
+++ b/drivers/xen/core/machine_kexec.c	Thu Jun 12 13:10:40 2008 +0900
@@ -19,6 +19,9 @@ static struct resource xen_hypervisor_re
 static struct resource xen_hypervisor_res;
 static struct resource *xen_phys_cpus;
 
+size_t vmcoreinfo_size_xen;
+unsigned long paddr_vmcoreinfo_xen;
+
 void __init xen_machine_kexec_setup_resources(void)
 {
 	xen_kexec_range_t range;
@@ -94,6 +97,18 @@ void __init xen_machine_kexec_setup_reso
 	if (range.size) {
 		crashk_res.start = range.start;
 		crashk_res.end = range.start + range.size - 1;
+	}
+
+	/* get physical address of vmcoreinfo */
+	memset(&range, 0, sizeof(range));
+	range.range = KEXEC_RANGE_MA_VMCOREINFO;
+
+	if (HYPERVISOR_kexec_op(KEXEC_CMD_kexec_get_range, &range))
+		return;
+
+	if (range.size) {
+		paddr_vmcoreinfo_xen = range.start;
+		vmcoreinfo_size_xen = range.size;
 	}
 
 	if (machine_kexec_setup_resources(&xen_hypervisor_res, xen_phys_cpus,
diff -r e01b3a133ddc drivers/xen/core/xen_sysfs.c
--- a/drivers/xen/core/xen_sysfs.c	Wed Jun 11 09:28:01 2008 +0100
+++ b/drivers/xen/core/xen_sysfs.c	Thu Jun 12 13:39:04 2008 +0900
@@ -15,6 +15,7 @@
 #include <xen/features.h>
 #include <xen/hypervisor_sysfs.h>
 #include <xen/xenbus.h>
+#include <xen/interface/kexec.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mike D. Day <ncmike@us.ibm.com>");
@@ -334,6 +335,24 @@ static void xen_properties_destroy(void)
 			   &xen_properties_group);
 }
 
+static ssize_t vmcoreinfo_show(struct hyp_sysfs_attr *attr, char *page)
+{
+	return sprintf(page, "%lx %zx\n",
+		paddr_vmcoreinfo_xen, vmcoreinfo_size_xen);
+}
+
+HYPERVISOR_ATTR_RO(vmcoreinfo);
+
+static int __init xen_sysfs_vmcoreinfo_init(void)
+{
+	return sysfs_create_file(&hypervisor_subsys.kset.kobj, &vmcoreinfo_attr.attr);
+}
+
+static void xen_sysfs_vmcoreinfo_destroy(void)
+{
+	sysfs_remove_file(&hypervisor_subsys.kset.kobj, &vmcoreinfo_attr.attr);
+}
+
 static int __init hyper_sysfs_init(void)
 {
 	int ret;
@@ -354,9 +373,14 @@ static int __init hyper_sysfs_init(void)
 	if (ret)
 		goto uuid_out;
 	ret = xen_properties_init();
+	if (ret)
+		goto prop_out;
+	ret = xen_sysfs_vmcoreinfo_init();
 	if (!ret)
 		goto out;
 
+	xen_properties_destroy();
+prop_out:
 	xen_sysfs_uuid_destroy();
 uuid_out:
 	xen_compilation_destroy();
@@ -370,6 +394,7 @@ out:
 
 static void __exit hyper_sysfs_exit(void)
 {
+	xen_sysfs_vmcoreinfo_destroy();
 	xen_properties_destroy();
 	xen_compilation_destroy();
 	xen_sysfs_uuid_destroy();
diff -r e01b3a133ddc include/xen/interface/kexec.h
--- a/include/xen/interface/kexec.h	Wed Jun 11 09:28:01 2008 +0100
+++ b/include/xen/interface/kexec.h	Thu Jun 12 13:11:44 2008 +0900
@@ -138,6 +138,10 @@ typedef struct xen_kexec_load {
                                      * the ia64_boot_param */
 #define KEXEC_RANGE_MA_EFI_MEMMAP 5 /* machine address and size of
                                      * of the EFI Memory Map */
+#define KEXEC_RANGE_MA_VMCOREINFO 6 /* machine address and size of vmcoreinfo */
+
+extern size_t vmcoreinfo_size_xen;
+extern unsigned long paddr_vmcoreinfo_xen;
 
 /*
  * Find the address and size of certain memory areas

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
