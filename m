Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrkQb-0004WH-Sz
 for kexec@lists.infradead.org; Mon, 11 May 2015 09:55:14 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH v11 10/10] iommu/vt-d: Use old irte in kdump kernel
Date: Mon, 11 May 2015 17:52:54 +0800
Message-Id: <1431337974-545-11-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
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

Fix the intr-remapping fault.

[1.594890] dmar: DRHD: handling fault status reg 2
[1.594894] dmar: INTR-REMAP: Request device [[41:00.0] fault index 4d
[1.594894] INTR-REMAP:[fault reason 34] Present field in the IRTE entry
is clear

Use old irte in second kernel, do not disable and re-enable interrupt
remapping.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel_irq_remapping.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index c2a4406..46d80ad 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -197,6 +197,10 @@ static int modify_irte(int irq, struct irte *irte_modified)
 
 	set_64bit(&irte->low, irte_modified->low);
 	set_64bit(&irte->high, irte_modified->high);
+
+	if (iommu->pre_enabled_ir)
+		__iommu_update_old_irte(iommu, index);
+
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
 	rc = qi_flush_iec(iommu, index, 0);
@@ -258,6 +262,9 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	bitmap_release_region(iommu->ir_table->bitmap, index,
 			      irq_iommu->irte_mask);
 
+	if (iommu->pre_enabled_ir)
+		__iommu_update_old_irte(iommu, -1);
+
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
 
@@ -657,11 +664,13 @@ static int __init intel_enable_irq_remapping(void)
 		 */
 		dmar_fault(-1, iommu);
 
+		iommu_check_pre_ir_status(iommu);
+
 		/*
-		 * Disable intr remapping and queued invalidation, if already
-		 * enabled prior to OS handover.
+		 * Here we do not disable intr remapping,
+		 * if already enabled prior to OS handover.
 		 */
-		iommu_disable_irq_remapping(iommu);
+		/* iommu_disable_irq_remapping(iommu); */
 
 		dmar_disable_qi(iommu);
 	}
@@ -697,7 +706,18 @@ static int __init intel_enable_irq_remapping(void)
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
-		iommu_set_irq_remapping(iommu, eim);
+		if (iommu->pre_enabled_ir) {
+			unsigned long long q;
+
+			q = dmar_readq(iommu->reg + DMAR_IRTA_REG);
+			iommu->ir_table->base_old_phys = q & VTD_PAGE_MASK;
+			iommu->ir_table->base_old_virt = ioremap_cache(
+				iommu->ir_table->base_old_phys,
+				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+			__iommu_load_old_irte(iommu);
+		} else
+			iommu_set_irq_remapping(iommu, eim);
+
 		setup = true;
 	}
 
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
