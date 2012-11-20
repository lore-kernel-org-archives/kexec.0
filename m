Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TapPI-0007Uh-TA
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 15:06:41 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:35419 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1633949Ab2KTPEx
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Tue, 20 Nov 2012 16:04:53 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 05/11] x86/xen: Register resources required by kexec-tools
Date: Tue, 20 Nov 2012 16:04:47 +0100
Message-Id: <1353423893-23125-6-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1353423893-23125-5-git-send-email-daniel.kiper@oracle.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-3-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-4-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-5-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Register resources required by kexec-tools.

v2 - suggestions/fixes:
   - change logging level
     (suggested by Konrad Rzeszutek Wilk).

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/xen/kexec.c |  150 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 150 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/xen/kexec.c

diff --git a/arch/x86/xen/kexec.c b/arch/x86/xen/kexec.c
new file mode 100644
index 0000000..7ec4c45
--- /dev/null
+++ b/arch/x86/xen/kexec.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright (c) 2011 Daniel Kiper
+ * Copyright (c) 2012 Daniel Kiper, Oracle Corporation
+ *
+ * kexec/kdump implementation for Xen was written by Daniel Kiper.
+ * Initial work on it was sponsored by Google under Google Summer
+ * of Code 2011 program and Citrix. Konrad Rzeszutek Wilk from Oracle
+ * was the mentor for this project.
+ *
+ * Some ideas are taken from:
+ *   - native kexec/kdump implementation,
+ *   - kexec/kdump implementation for Xen Linux Kernel Ver. 2.6.18,
+ *   - PV-GRUB.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <xen/interface/platform.h>
+#include <xen/interface/xen.h>
+#include <xen/xen.h>
+
+#include <asm/xen/hypercall.h>
+
+unsigned long xen_vmcoreinfo_maddr = 0;
+unsigned long xen_vmcoreinfo_max_size = 0;
+
+static int __init xen_init_kexec_resources(void)
+{
+	int rc;
+	static struct resource xen_hypervisor_res = {
+		.name = "Hypervisor code and data",
+		.flags = IORESOURCE_BUSY | IORESOURCE_MEM
+	};
+	struct resource *cpu_res;
+	struct xen_kexec_range xkr;
+	struct xen_platform_op cpuinfo_op;
+	uint32_t cpus, i;
+
+	if (!xen_initial_domain())
+		return 0;
+
+	if (strstr(boot_command_line, "crashkernel="))
+		pr_warn("kexec: Ignoring crashkernel option. "
+			"It should be passed to Xen hypervisor.\n");
+
+	/* Register Crash kernel resource. */
+	xkr.range = KEXEC_RANGE_MA_CRASH;
+	rc = HYPERVISOR_kexec_op(KEXEC_CMD_kexec_get_range, &xkr);
+
+	if (rc) {
+		pr_warn("kexec: %s: HYPERVISOR_kexec_op(KEXEC_RANGE_MA_CRASH)"
+			": %i\n", __func__, rc);
+		return rc;
+	}
+
+	if (!xkr.size)
+		return 0;
+
+	crashk_res.start = xkr.start;
+	crashk_res.end = xkr.start + xkr.size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
+
+	/* Register Hypervisor code and data resource. */
+	xkr.range = KEXEC_RANGE_MA_XEN;
+	rc = HYPERVISOR_kexec_op(KEXEC_CMD_kexec_get_range, &xkr);
+
+	if (rc) {
+		pr_warn("kexec: %s: HYPERVISOR_kexec_op(KEXEC_RANGE_MA_XEN)"
+			": %i\n", __func__, rc);
+		return rc;
+	}
+
+	xen_hypervisor_res.start = xkr.start;
+	xen_hypervisor_res.end = xkr.start + xkr.size - 1;
+	insert_resource(&iomem_resource, &xen_hypervisor_res);
+
+	/* Determine maximum number of physical CPUs. */
+	cpuinfo_op.cmd = XENPF_get_cpuinfo;
+	cpuinfo_op.u.pcpu_info.xen_cpuid = 0;
+	rc = HYPERVISOR_dom0_op(&cpuinfo_op);
+
+	if (rc) {
+		pr_warn("kexec: %s: HYPERVISOR_dom0_op(): %i\n", __func__, rc);
+		return rc;
+	}
+
+	cpus = cpuinfo_op.u.pcpu_info.max_present + 1;
+
+	/* Register CPUs Crash note resources. */
+	cpu_res = kcalloc(cpus, sizeof(struct resource), GFP_KERNEL);
+
+	if (!cpu_res) {
+		pr_warn("kexec: %s: kcalloc(): %i\n", __func__, -ENOMEM);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < cpus; ++i) {
+		xkr.range = KEXEC_RANGE_MA_CPU;
+		xkr.nr = i;
+		rc = HYPERVISOR_kexec_op(KEXEC_CMD_kexec_get_range, &xkr);
+
+		if (rc) {
+			pr_warn("kexec: %s: cpu: %u: HYPERVISOR_kexec_op"
+				"(KEXEC_RANGE_MA_XEN): %i\n", __func__, i, rc);
+			continue;
+		}
+
+		cpu_res->name = "Crash note";
+		cpu_res->start = xkr.start;
+		cpu_res->end = xkr.start + xkr.size - 1;
+		cpu_res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
+		insert_resource(&iomem_resource, cpu_res++);
+	}
+
+	/* Get vmcoreinfo address and maximum allowed size. */
+	xkr.range = KEXEC_RANGE_MA_VMCOREINFO;
+	rc = HYPERVISOR_kexec_op(KEXEC_CMD_kexec_get_range, &xkr);
+
+	if (rc) {
+		pr_warn("kexec: %s: HYPERVISOR_kexec_op(KEXEC_RANGE_MA_VMCOREINFO)"
+			": %i\n", __func__, rc);
+		return rc;
+	}
+
+	xen_vmcoreinfo_maddr = xkr.start;
+	xen_vmcoreinfo_max_size = xkr.size;
+
+	return 0;
+}
+
+core_initcall(xen_init_kexec_resources);
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
