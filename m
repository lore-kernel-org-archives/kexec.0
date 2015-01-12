Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YAZ85-000155-35
 for kexec@lists.infradead.org; Mon, 12 Jan 2015 07:09:38 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH v8 08/10] iommu/vt-d: assign new page table for dma_map
Date: Mon, 12 Jan 2015 15:06:26 +0800
Message-Id: <1421046388-27925-9-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
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

When a device driver issues the first dma_map command for a
device, we assign a new and empty page-table, thus removing all
mappings from the old kernel for the device.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 56 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 324c504..ccbad3f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -44,6 +44,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <linux/dma-mapping.h>
 
 #include "irq_remapping.h"
 
@@ -455,6 +456,8 @@ static int copy_root_entry_table(struct intel_iommu *iommu, void *ppap);
 static int intel_iommu_load_translation_tables(struct dmar_drhd_unit *drhd,
 		int g_num_of_iommus);
 
+static void unmap_device_dma(struct dmar_domain *domain, struct device *dev);
+
 #endif /* CONFIG_CRASH_DUMP */
 
 /*
@@ -3196,14 +3199,30 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 		return NULL;
 	}
 
-	/* make sure context mapping is ok */
-	if (unlikely(!domain_context_mapped(dev))) {
-		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
-		if (ret) {
-			printk(KERN_ERR "Domain context map for %s failed",
-			       dev_name(dev));
-			return NULL;
-		}
+	/* if in kdump kernel, we need to unmap the mapped dma pages,
+	 * detach this device first.
+	 */
+	if (likely(domain_context_mapped(dev))) {
+#ifdef CONFIG_CRASH_DUMP
+		if (is_kdump_kernel()) {
+			unmap_device_dma(domain, dev);
+			domain = get_domain_for_dev(dev,
+				DEFAULT_DOMAIN_ADDRESS_WIDTH);
+			if (!domain) {
+				pr_err("Allocating domain for %s failed",
+				       dev_name(dev));
+				return NULL;
+			}
+		} else
+#endif
+			return domain;
+	}
+
+	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
+	if (ret) {
+		pr_err("Domain context map for %s failed",
+		       dev_name(dev));
+		return NULL;
 	}
 
 	return domain;
@@ -5691,4 +5710,25 @@ static int intel_iommu_load_translation_tables(struct dmar_drhd_unit *drhd,
 	return 0;
 }
 
+static void unmap_device_dma(struct dmar_domain *domain, struct device *dev)
+{
+	struct intel_iommu *iommu;
+	struct context_entry *ce;
+	struct iova *iova;
+	u8 bus, devfn;
+	phys_addr_t phys_addr;
+	dma_addr_t dev_addr;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	ce = device_to_context_entry(iommu, bus, devfn);
+	phys_addr = context_address_root(ce) << VTD_PAGE_SHIFT;
+	dev_addr = phys_to_dma(dev, phys_addr);
+
+	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
+	if (iova)
+		intel_unmap(dev, dev_addr);
+
+	domain_remove_one_dev_info(domain, dev);
+}
+
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
