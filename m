Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t5424.austin.hp.com ([15.216.225.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YgUYE-0006ZY-K5
 for kexec@lists.infradead.org; Fri, 10 Apr 2015 08:44:35 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH v10 09/10] iommu/vt-d: Copy functions for irte
Date: Fri, 10 Apr 2015 16:42:12 +0800
Message-Id: <1428655333-19504-10-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
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
Cc: jerry.hoemann@hp.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, lisa.mitchell@hp.com, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, zhen-hual@hp.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com

Functions to copy the irte data from the old kernel into the kdump kernel.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel_irq_remapping.c | 68 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h         |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 14de1ab..e6426a0 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -17,6 +17,10 @@
 
 #include "irq_remapping.h"
 
+static int __iommu_load_old_irte(struct intel_iommu *iommu);
+static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
+static void iommu_check_pre_ir_status(struct intel_iommu *iommu);
+
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -1302,3 +1306,67 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 
 	return ret;
 }
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
+	__iommu_flush_cache(iommu, iommu->ir_table->base,
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
+	__iommu_flush_cache(iommu, to + start, size);
+
+	return 0;
+}
+
+static void iommu_check_pre_ir_status(struct intel_iommu *iommu)
+{
+	u32 sts;
+
+	sts = readl(iommu->reg + DMAR_GSTS_REG);
+	if (sts & DMA_GSTS_IRES) {
+		pr_info("IR is enabled prior to OS.\n");
+		iommu->pre_enabled_ir = 1;
+	}
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 9ca025a..d7ee5ba 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -289,6 +289,8 @@ struct q_inval {
 struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
+	void __iomem *base_old_virt;
+	unsigned long base_old_phys;
 };
 #endif
 
@@ -330,6 +332,8 @@ struct intel_iommu {
 
 	/* whether translation is enabled prior to OS*/
 	u8		pre_enabled_trans;
+	/* whether interrupt remapping is enabled prior to OS*/
+	u8		pre_enabled_ir;
 
 	void __iomem	*root_entry_old_virt; /* mapped from old root entry */
 	unsigned long	root_entry_old_phys; /* root entry in old kernel */
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
