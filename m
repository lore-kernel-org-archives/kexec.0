Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JcrtH-00086V-Kn
	for kexec@lists.infradead.org; Sat, 22 Mar 2008 00:47:20 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2M0gua3025572
	for <kexec@lists.infradead.org>; Fri, 21 Mar 2008 20:42:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2M0esrG1085448
	for <kexec@lists.infradead.org>; Fri, 21 Mar 2008 20:40:54 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2M0esc2031216
	for <kexec@lists.infradead.org>; Fri, 21 Mar 2008 20:40:54 -0400
Message-ID: <47E45595.6060509@austin.ibm.com>
Date: Fri, 21 Mar 2008 19:40:53 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] pseries: phyp dump: inform kdump, phyp-dump is loaded.
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
To: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, paulus@samba.org
Cc: mahuja@us.ibm.com, smaneesh@in.ibm.com, linasvepstas@gmail.com, ssant@in.ibm.com


Patch 2:

Addition of /sys/kernel/phyp_dump_active so that kdump init scripts may 
look for it and take appropriate action if this file is found. This
file is only loaded when phyp_dump has been registered.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>

---
 arch/powerpc/platforms/pseries/phyp_dump.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-03-22 01:07:43.000000000 -0500
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-03-22 01:08:56.000000000 -0500
@@ -182,6 +182,18 @@ static void print_dump_header(const stru
 #endif
 }
 
+static ssize_t show_phyp_dump_active(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+
+	/* create filesystem entry so kdump is phyp-dump aware */
+	return sprintf(buf, "%lx\n", phyp_dump_info->phyp_dump_at_boot);
+}
+
+static struct kobj_attribute pdl = __ATTR(phyp_dump_active, 0600,
+					show_phyp_dump_active,
+					NULL);
+
 static void register_dump_area(struct phyp_dump_header *ph, unsigned long addr)
 {
 	int rc;
@@ -204,7 +216,13 @@ static void register_dump_area(struct ph
 		printk(KERN_ERR "phyp-dump: unexpected error (%d) on "
 						"register\n", rc);
 		print_dump_header(ph);
+		return;
 	}
+
+	rc = sysfs_create_file(kernel_kobj, &pdl.attr);
+	if (rc)
+		printk(KERN_ERR "phyp-dump: unable to create sysfs"
+				" file (%d)\n", rc);
 }
 
 static

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
