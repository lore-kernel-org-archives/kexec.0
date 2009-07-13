Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.valinux.co.jp ([210.128.90.3])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MQCjX-0003Wn-JQ
	for kexec@lists.infradead.org; Mon, 13 Jul 2009 04:01:54 +0000
Date: Mon, 13 Jul 2009 13:01:41 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH] fix missing Crash note in /proc/iomem
Message-Id: <20090713112628.9F01.277DD91C@valinux.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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

Hi,

Missing "Crash note" in /proc/iomem (dom 0) happens on the Xen 3.4.*.
This causes a crash dump cannot be analyzed normally.

This patch fixes this problem.
This patch is for linux-2.6.18-xen.hg.

The range of "Crash note" is within the "Hypervisor code and data" 
on the Xen 3.3.* and before. The code assumed this.
It is not true for the Xen 3.4.

== example: before patch: one of two "Crash note" is missing
# cat /proc/iomem 
...
00100000-c779ffff : System RAM
  02000000-09ffffff : Crash kernel
  c7300000-c74aa35f : Hypervisor code and data
    c7456080-c7456213 : Crash note
c77a0000-c77adfff : ACPI Tables
...

== example: after patch: two "Crash note" are showed normally
# cat /proc/iomem 
...
00100000-c779ffff : System RAM
  02000000-09ffffff : Crash kernel
  c7300000-c74aa35f : Hypervisor code and data
    c7456080-c7456213 : Crash note
  c7791c00-c7791df3 : Crash note
c77a0000-c77adfff : ACPI Tables
...

This problem is occured on the x86_64 only. This patch has no bad effect for
other architectures and is backword compatible.

Please apply this patch to the newer dom-0 kernel too.

Thanks.
Itsuro Oda

---
Signed-off-by: Itsuro Oda <oda@valinux.co.jp>

diff -r b086278a4406 drivers/xen/core/machine_kexec.c
--- a/drivers/xen/core/machine_kexec.c	Mon Jun 29 10:57:46 2009 +0100
+++ b/drivers/xen/core/machine_kexec.c	Fri Jul 10 16:57:34 2009 +0900
@@ -144,7 +144,15 @@ void __init xen_machine_kexec_setup_reso
 
 void __init xen_machine_kexec_register_resources(struct resource *res)
 {
+	int k;
+	struct resource *r;
+
 	request_resource(res, &xen_hypervisor_res);
+	for (k = 0; k < xen_max_nr_phys_cpus; k++) {
+		r = xen_phys_cpus + k;
+		if (r->parent == NULL) /* out of xen_hypervisor_res range */
+			request_resource(res, r);
+	} 
 	machine_kexec_register_resources(res);
 }

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
