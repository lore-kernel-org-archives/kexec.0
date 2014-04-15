Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WaCUH-0005B0-KI
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 23:09:58 +0000
From: Bill Sumner <bill.sumner@hp.com>
Subject: [PATCH 2/8] Consolidate all .h lines at front of intel-iommu.c file
Date: Tue, 15 Apr 2014 17:09:03 -0600
Message-Id: <1397603349-30930-3-git-send-email-bill.sumner@hp.com>
In-Reply-To: <1397603349-30930-1-git-send-email-bill.sumner@hp.com>
References: <1397603349-30930-1-git-send-email-bill.sumner@hp.com>
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
To: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, kexec@lists.infradead.org, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, bill.sumner@hp.com

 In intel-iommu.c, move downward the few lines near the
 front that should not move to an intel-iommu-private.h
 file (mostly data-item definitions) This leaves a
 consolidated block of the lines that would move to an
 intel-iommu-private.h file at the front of the file.


Signed-off-by: Bill Sumner <bill.sumner@hp.com>
---
 drivers/iommu/intel-iommu.c | 74 +++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8abcb6c..22298e9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -165,17 +165,6 @@ static inline unsigned long virt_to_dma_pfn(void *p)
 	return page_to_dma_pfn(virt_to_page(p));
 }
 
-/* global iommu list, set NULL for ignored DMAR units */
-static struct intel_iommu **g_iommus;
-
-static void __init check_tylersburg_isoch(void);
-static int rwbf_quirk;
-
-/*
- * set to 1 to panic kernel if can't successfully enable VT-d
- * (used when kernel is launched w/ TXT)
- */
-static int force_on;
 
 /*
  * 0: Present
@@ -314,15 +303,6 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
-/*
- * This domain is a statically identity mapping domain.
- *	1. This domain creats a static 1:1 mapping to all usable memory.
- *	2. It maps to each iommu if successful.
- *	3. Each iommu mapps to this domain if successful.
- */
-static struct dmar_domain *si_domain;
-static int hw_pass_through = 1;
-
 /* devices under the same p2p bridge are owned in one domain */
 #define DOMAIN_FLAG_P2P_MULTIPLE_DEVICES (1 << 0)
 
@@ -380,6 +360,44 @@ struct device_domain_info {
 	struct dmar_domain *domain; /* pointer to domain */
 };
 
+static inline void *alloc_pgtable_page(int node)
+{
+	struct page *page;
+	void *vaddr = NULL;
+
+	page = alloc_pages_node(node, GFP_ATOMIC | __GFP_ZERO, 0);
+	if (page)
+		vaddr = page_address(page);
+	return vaddr;
+}
+
+static inline void free_pgtable_page(void *vaddr)
+{
+	free_page((unsigned long)vaddr);
+}
+
+
+static void __init check_tylersburg_isoch(void);
+
+/* global iommu list, set NULL for ignored DMAR units */
+static struct intel_iommu **g_iommus;
+static int rwbf_quirk;
+
+/*
+ * set to 1 to panic kernel if can't successfully enable VT-d
+ * (used when kernel is launched w/ TXT)
+ */
+static int force_on;
+
+/*
+ * This domain is a statically identity mapping domain.
+ *	1. This domain creats a static 1:1 mapping to all usable memory.
+ *	2. It maps to each iommu if successful.
+ *	3. Each iommu mapps to this domain if successful.
+ */
+static struct dmar_domain *si_domain;
+static int hw_pass_through = 1;
+
 static void flush_unmaps_timeout(unsigned long data);
 
 static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
@@ -468,22 +486,6 @@ static struct kmem_cache *iommu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 static struct kmem_cache *iommu_iova_cache;
 
-static inline void *alloc_pgtable_page(int node)
-{
-	struct page *page;
-	void *vaddr = NULL;
-
-	page = alloc_pages_node(node, GFP_ATOMIC | __GFP_ZERO, 0);
-	if (page)
-		vaddr = page_address(page);
-	return vaddr;
-}
-
-static inline void free_pgtable_page(void *vaddr)
-{
-	free_page((unsigned long)vaddr);
-}
-
 static inline void *alloc_domain_mem(void)
 {
 	return kmem_cache_alloc(iommu_domain_cache, GFP_ATOMIC);
-- 
Bill Sumner <bill.sumner@hp.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
