Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkYDA-0007TG-VH
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 15:04:26 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 8/8] iommu/amd: Update domain into to dte entry during
 device driver init
Date: Thu, 15 Sep 2016 23:03:26 +0800
Message-Id: <1473951806-25511-9-git-send-email-bhe@redhat.com>
In-Reply-To: <1473951806-25511-1-git-send-email-bhe@redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
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
To: joro@8bytes.org
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Vincent.Wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com

All devices are supposed to reset themselves at device driver initialization
stage. At this time if in kdump kernel those on-flight DMA will be stopped
because of device reset. It's best time to update the protection domain info,
especially pte_root, to dte entry which the device relates to.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6c37300..00b64ee 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2310,6 +2310,10 @@ static dma_addr_t __map_single(struct device *dev,
 	unsigned int pages;
 	int prot = 0;
 	int i;
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
+	struct protection_domain *domain = get_domain(dev);
+	u16 alias = amd_iommu_alias_table[dev_data->devid];
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
 
 	pages = iommu_num_pages(paddr, size, PAGE_SIZE);
 	paddr &= PAGE_MASK;
@@ -2319,6 +2323,13 @@ static dma_addr_t __map_single(struct device *dev,
 		goto out;
 
 	prot = dir2prot(direction);
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
+               dev_data->domain_updated = true;
+               set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
+               if (alias != dev_data->devid)
+                       set_dte_entry(alias, domain, dev_data->ats.enabled);
+               device_flush_dte(dev_data);
+       }
 
 	start = address;
 	for (i = 0; i < pages; ++i) {
@@ -2470,6 +2481,9 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *s;
 	unsigned long address;
 	u64 dma_mask;
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
+	u16 alias = amd_iommu_alias_table[dev_data->devid];
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
@@ -2485,6 +2499,13 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		goto out_err;
 
 	prot = dir2prot(direction);
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
+               dev_data->domain_updated = true;
+               set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
+               if (alias != dev_data->devid)
+                       set_dte_entry(alias, domain, dev_data->ats.enabled);
+               device_flush_dte(dev_data);
+       }
 
 	/* Map all sg entries */
 	for_each_sg(sglist, s, nelems, i) {
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
