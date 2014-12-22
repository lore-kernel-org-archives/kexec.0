Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y2z7N-0000Ta-SL
 for kexec@lists.infradead.org; Mon, 22 Dec 2014 09:17:34 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH 09/10] iommu/vt-d: Copy functions for irte
Date: Mon, 22 Dec 2014 17:15:28 +0800
Message-Id: <1419239729-26529-10-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1419239729-26529-1-git-send-email-zhen-hual@hp.com>
References: <1419239729-26529-1-git-send-email-zhen-hual@hp.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com, joro@8bytes.org, vgoyal@redhat.com, dyoung@redhat.com
Cc: jerry.hoemann@hp.com, tom.vaden@hp.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, lisa.mitchell@hp.com, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, zhen-hual@hp.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com

Functions to copy the irte data from the old kernel into the kdump kernel.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel_irq_remapping.c | 57 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h         |  4 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index a55b207..13f2034 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -8,6 +8,7 @@
 #include <linux/irq.h>
 #include <linux/intel-iommu.h>
 #include <linux/acpi.h>
+#include <linux/crash_dump.h>
 #include <asm/io_apic.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
@@ -17,6 +18,11 @@
 
 #include "irq_remapping.h"
 
+#ifdef CONFIG_CRASH_DUMP
+static int __iommu_load_old_irte(struct intel_iommu *iommu);
+static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
+#endif /* CONFIG_CRASH_DUMP */
+
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -1296,3 +1302,54 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 
 	return ret;
 }
+
+#ifdef CONFIG_CRASH_DUMP
+
+static int __iommu_load_old_irte(struct intel_iommu *iommu)
+{
+	if ((!iommu)
+		|| (!iommu->ir_table)
+		|| (!iommu->ir_table->base)
+		|| (!iommu->ir_table->base_old_phys)
+		|| (!iommu->ir_table->base_old_virt))
+		return -1;
+
+	memcpy(iommu->ir_table->base,
+		iommu->ir_table->base_old_virt,
+		INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+
+	return 0;
+}
+
+static int __iommu_update_old_irte(struct intel_iommu *iommu, int index)
+{
+	int start;
+	unsigned long size;
+	void __iomem *to;
+	void *from;
+
+	if ((!iommu)
+		|| (!iommu->ir_table)
+		|| (!iommu->ir_table->base)
+		|| (!iommu->ir_table->base_old_phys)
+		|| (!iommu->ir_table->base_old_virt))
+		return -1;
+
+	if (index < -1 || index >= INTR_REMAP_TABLE_ENTRIES)
+		return -1;
+
+	if (index == -1) {
+		start = 0;
+		size = INTR_REMAP_TABLE_ENTRIES * sizeof(struct irte);
+	} else {
+		start = index * sizeof(struct irte);
+		size = sizeof(struct irte);
+	}
+
+	to = iommu->ir_table->base_old_virt;
+	from = iommu->ir_table->base;
+	memcpy(to + start, from + start, size);
+
+	return 0;
+}
+#endif /* CONFIG_CRASH_DUMP */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8e29b97..76c6ea5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -290,6 +290,10 @@ struct q_inval {
 struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
+#ifdef CONFIG_CRASH_DUMP
+	void __iomem *base_old_virt;
+	unsigned long base_old_phys;
+#endif
 };
 #endif
 
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
