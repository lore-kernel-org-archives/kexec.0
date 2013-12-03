Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnvsG-0006SA-40
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 19:43:13 +0000
From: Bill Sumner <bill.sumner@hp.com>
Subject: [PATCH 1/6] Crashdump-Accepting-Active-IOMMU-Flags-and-Prototypes
Date: Tue,  3 Dec 2013 12:41:29 -0700
Message-Id: <1386099694-4190-2-git-send-email-bill.sumner@hp.com>
In-Reply-To: <1386099694-4190-1-git-send-email-bill.sumner@hp.com>
References: <Crashdump-Accepting-Active-IOMMU>
 <1386099694-4190-1-git-send-email-bill.sumner@hp.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com
Cc: linux-pci@vger.kernel.org, kexec@lists.infradead.org, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, bill.sumner@hp.com


Signed-off-by: Bill Sumner <bill.sumner@hp.com>
---
 drivers/iommu/intel-iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 15e9b57..a0e8a76 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -48,6 +48,7 @@
 
 #include "irq_remapping.h"
 #include "pci.h"
+#include <linux/crash_dump.h>
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -164,6 +165,80 @@ static inline unsigned long virt_to_dma_pfn(void *p)
 	return page_to_dma_pfn(virt_to_page(p));
 }
 
+#ifdef CONFIG_CRASH_DUMP
+/* ===================================================================
+ * Crashdump Accepting Active IOMMU
+ * Enhances the crashdump kernel to deal with an active iommu
+ * and legacy DMA from the (old) panic'd kernel in a manner similar to how
+ * legacy DMA is handled when no hardware iommu was in use by the old kernel --
+ * allow the legacy DMA to continue into its current buffers.
+ *
+ * This code:
+ * 1. accepts the iommu hardware in an active state from the old kernel,
+ * 2. leaves the current translations in-place so that legacy DMA will
+ *    continue to use its current buffers,
+ * 3. allocates to the device drivers in the crashdump kernel
+ *    portions of the iova address ranges that are different
+ *    from the iova address ranges that were being used by the old kernel
+ *    at the time of the panic.
+ * -------------------------------------------------------------------
+ */
+
+/* Flags for Crashdump Accepting Active IOMMU */
+
+static int crashdump_accepting_active_iommu;	/* activate this feature */
+static int intel_iommu_translation_tables_are_mapped;	/* table copy done */
+
+static struct {				/* run-time pr_debug() flags */
+	unsigned in_crashdump:1;	/* if crashdump_accepting_active_iommu */
+	unsigned domain_get:1;		/* pr_debug in domain_get* functions */
+	unsigned copy_page_table:1;	/* enter/leave copy_page_table() */
+	unsigned copy_page_addr:1;	/* enter/leave copy_page_addr() */
+	unsigned addr_ranges:1;		/* accumulated addr ranges */
+	unsigned reserved_ranges:1;	/* accumulated addr ranges reserved */
+	unsigned page_addr:1;		/* adr(each page table) */
+	unsigned enter_oldcopy:1;	/* enter oldcopy() parameters */
+	unsigned leave_oldcopy:1;	/* leave oldcopy() parameters */
+} pr_dbg  = {				/* Enable flags below here */
+	.in_crashdump = 1,
+	.domain_get = 1,
+	.copy_page_table = 1,
+	.copy_page_addr = 0,
+	.addr_ranges = 0,
+	.reserved_ranges = 0,
+	.page_addr = 0,
+	.enter_oldcopy = 0,
+	.leave_oldcopy = 0,
+};
+
+/* Prototypes of interface functions for Crashdump Accepting Active IOMMU */
+
+static int
+copy_intel_iommu_translation_tables(struct dmar_drhd_unit *drhd,
+	struct root_entry **root_old_p, struct root_entry **root_new_p);
+
+static int
+domain_get_did_from_old_kernel(struct intel_iommu *iommu, struct pci_dev *pdev);
+
+static int
+domain_get_gaw_from_old_kernel(struct intel_iommu *iommu, struct pci_dev *pdev);
+
+static u64
+domain_get_pgd_from_old_kernel(struct intel_iommu *iommu, struct pci_dev *pdev);
+
+static void
+domain_get_ranges_from_old_kernel(struct dmar_domain *domain,
+		  struct intel_iommu *iommu, struct pci_dev *pdev);
+static int
+intel_iommu_get_dids_from_old_kernel(struct intel_iommu *iommu);
+
+/* Debug-print functions for  Crashdump Accepting Active IOMMU */
+
+static void
+print_intel_iommu_registers(struct dmar_drhd_unit *drhd);
+#endif	/* CONFIG_CRASH_DUMP */
+
+
 /* global iommu list, set NULL for ignored DMAR units */
 static struct intel_iommu **g_iommus;
 
-- 
Bill Sumner <bill.sumner@hp.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
