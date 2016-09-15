Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkYD6-0007Qh-00
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 15:04:20 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 7/8] iommu/amd: Don't update domain info to dte entry at
 iommu init stage
Date: Thu, 15 Sep 2016 23:03:25 +0800
Message-Id: <1473951806-25511-8-git-send-email-bhe@redhat.com>
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

AMD iommu creates protection domain and assign each device to it during
iommu driver initialization stage. This happened just after system pci
bus scanning stage, and much earlier than device driver init stage. So
at this time if in kdump kernel the domain info, especially pte_root,
can't be updated to dte entry. We should wait until device driver init
stage.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fcb69ff..6c37300 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -137,6 +137,7 @@ struct iommu_dev_data {
 	bool pri_tlp;			  /* PASID TLB required for
 					     PPR completions */
 	u32 errata;			  /* Bitmap for errata to apply */
+	bool domain_updated;
 };
 
 /*
@@ -1708,6 +1709,15 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
+	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+	dev_data = find_dev_data(devid);
+        if (!dev_data)
+                return;
+
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
+		return;
 
 	if (domain->mode != PAGE_MODE_NONE)
 		pte_root = virt_to_phys(domain->pt_root);
@@ -1756,6 +1766,14 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 
 static void clear_dte_entry(u16 devid)
 {
+	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+	dev_data = find_dev_data(devid);
+        if (!dev_data)
+                return;
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
+		return;
 	/* remove entry from the device table seen by the hardware */
 	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
 	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
