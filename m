Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by pentafluge.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jcrxd-0002VA-01
	for kexec@lists.infradead.org; Sat, 22 Mar 2008 00:51:50 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2M0d1aW025171
	for <kexec@lists.infradead.org>; Fri, 21 Mar 2008 20:39:01 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2M0d1i01085612
	for <kexec@lists.infradead.org>; Fri, 21 Mar 2008 20:39:01 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2M0d1hw029313
	for <kexec@lists.infradead.org>; Fri, 21 Mar 2008 20:39:01 -0400
Message-ID: <47E45523.7080708@austin.ibm.com>
Date: Fri, 21 Mar 2008 19:38:59 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] pseries: phyp dump: Disable phyp-dump through boot-var.
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


The goal of these 2 patches is to ensure that there is only one dumping
mechanism enabled at any given time. These patches depend upon phyp-dump
patches posted earlier.

Patch 1:

Addition of boot-variable "phyp_dump", which takes values [0/1] for disabling/
enabling phyp_dump at boot time. Kdump can use this on cmdline (phyp_dump=0) 
to disable phyp-dump during boot when enabling itself. This will ensure only
one dumping mechanism is active at any given time.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>

---
 arch/powerpc/kernel/prom.c                 |    5 +++++
 arch/powerpc/platforms/pseries/phyp_dump.c |   18 ++++++++++++++++++
 include/asm-powerpc/phyp_dump.h            |    1 +
 3 files changed, 24 insertions(+)

Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-03-22 00:42:02.000000000 -0500
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-03-22 01:07:43.000000000 -0500
@@ -460,3 +460,21 @@ int __init early_init_dt_scan_phyp_dump(
 						*((unsigned long *)&sizes[4]);
 	return 1;
 }
+
+/* Look for phyp_dump= cmdline option */
+static int __init early_phyp_dump_enabled(char *p)
+{
+	phyp_dump_info->phyp_dump_at_boot = 1;
+
+        if (!p)
+                return 0;
+
+        if (strncmp(p, "1", 1) == 0)
+		phyp_dump_info->phyp_dump_at_boot = 1;
+        else if (strncmp(p, "0", 1) == 0)
+		phyp_dump_info->phyp_dump_at_boot = 0;
+
+        return 0;
+}
+early_param("phyp_dump", early_phyp_dump_enabled);
+
Index: 2.6.25-rc1/include/asm-powerpc/phyp_dump.h
===================================================================
--- 2.6.25-rc1.orig/include/asm-powerpc/phyp_dump.h	2008-03-22 00:42:02.000000000 -0500
+++ 2.6.25-rc1/include/asm-powerpc/phyp_dump.h	2008-03-22 00:42:08.000000000 -0500
@@ -25,6 +25,7 @@ struct phyp_dump {
 	unsigned long init_reserve_start;
 	unsigned long init_reserve_size;
 	/* Check status during boot if dump supported, active & present*/
+	unsigned long phyp_dump_at_boot;
 	unsigned long phyp_dump_configured;
 	unsigned long phyp_dump_is_active;
 	/* store cpu & hpte size */
Index: 2.6.25-rc1/arch/powerpc/kernel/prom.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/kernel/prom.c	2008-03-22 00:42:02.000000000 -0500
+++ 2.6.25-rc1/arch/powerpc/kernel/prom.c	2008-03-22 00:42:54.000000000 -0500
@@ -1059,6 +1059,11 @@ static void __init phyp_dump_reserve_mem
 		return;
 	}
 
+	if (!phyp_dump_info->phyp_dump_at_boot) {
+		printk(KERN_INFO "Phyp-dump disabled at boot time\n");
+		return;
+	}
+
 	if (phyp_dump_info->phyp_dump_is_active) {
 		/* Reserve *everything* above RMR.Area freed by userland tools*/
 		base = PHYP_DUMP_RMR_END;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
