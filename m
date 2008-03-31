Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgBal-0006az-Bu
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 04:25:55 +0000
Date: Mon, 31 Mar 2008 13:25:54 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 2/4] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20080331131640.DDCF.ODA@valinux.co.jp>
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

This patch is for linux-2.6.18-xen-3.2.0.

--- drivers/xen/core/xen_sysfs.c.org	2008-03-25 08:43:21.000000000 +0900
+++ drivers/xen/core/xen_sysfs.c	2008-03-25 09:15:55.000000000 +0900
@@ -15,6 +15,7 @@
 #include <xen/features.h>
 #include <xen/hypervisor_sysfs.h>
 #include <xen/xenbus.h>
+#include <xen/interface/kexec.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mike D. Day <ncmike@us.ibm.com>");
@@ -330,6 +331,24 @@
 			   &xen_properties_group);
 }
 
+static ssize_t vmcoreinfo_show(struct hyp_sysfs_attr *attr, char *page)
+{
+	return sprintf(page, "%lx %zx\n",
+		paddr_vmcoreinfo_xen, vmcoreinfo_max_size_xen);
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
@@ -350,9 +369,14 @@
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
@@ -366,6 +390,7 @@
 
 static void __exit hyper_sysfs_exit(void)
 {
+	xen_sysfs_vmcoreinfo_destroy();
 	xen_properties_destroy();
 	xen_compilation_destroy();
 	xen_sysfs_uuid_destroy();
--- drivers/xen/core/machine_kexec.c.org	2008-03-25 09:01:39.000000000 +0900
+++ drivers/xen/core/machine_kexec.c	2008-03-25 09:05:47.000000000 +0900
@@ -15,6 +15,9 @@
 static struct resource xen_hypervisor_res;
 static struct resource *xen_phys_cpus;
 
+size_t vmcoreinfo_max_size_xen = 4096;
+unsigned long paddr_vmcoreinfo_xen;
+
 void __init xen_machine_kexec_setup_resources(void)
 {
 	xen_kexec_range_t range;
@@ -92,6 +95,17 @@
 		crashk_res.end = range.start + range.size - 1;
 	}
 
+	/* get physical address of vmcoreinfo */
+	memset(&range, 0, sizeof(range));
+	range.range = KEXEC_RANGE_MA_VMCOREINFO;
+
+	if (HYPERVISOR_kexec_op(KEXEC_CMD_kexec_get_range, &range))
+		return;
+
+	if (range.size) {
+		paddr_vmcoreinfo_xen = range.start;
+	}
+
 	return;
 
  err:
--- include/xen/interface/kexec.h.org	2008-03-25 09:08:43.000000000 +0900
+++ include/xen/interface/kexec.h	2008-03-25 09:12:02.000000000 +0900
@@ -111,6 +111,10 @@
 #define KEXEC_RANGE_MA_CRASH 0   /* machine address and size of crash area */
 #define KEXEC_RANGE_MA_XEN   1   /* machine address and size of Xen itself */
 #define KEXEC_RANGE_MA_CPU   2   /* machine address and size of a CPU note */
+#define KEXEC_RANGE_MA_VMCOREINFO   3   /* machine address and size of vmcoreinfo */
+
+extern size_t vmcoreinfo_max_size_xen;
+extern unsigned long paddr_vmcoreinfo_xen;
 
 /*
  * Find the address and size of certain memory areas

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
