Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cA8pq-0000aW-8u
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 05:14:07 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 07/12] iommu/amd: Use is_attach_deferred call-back
Date: Fri, 25 Nov 2016 13:13:14 +0800
Message-Id: <1480050799-1237-8-git-send-email-bhe@redhat.com>
In-Reply-To: <1480050799-1237-1-git-send-email-bhe@redhat.com>
References: <1480050799-1237-1-git-send-email-bhe@redhat.com>
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
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, dyoung@redhat.com

Implement call-back is_attach_deferred and use it to defer the
domain attach from iommu driver init to device driver init when
iommu is pre-enabled in kdump kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d5aef72..fc8ecfb 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -138,6 +138,7 @@ struct iommu_dev_data {
 					     PPR completions */
 	u32 errata;			  /* Bitmap for errata to apply */
 	bool use_vapic;			  /* Enable device to use vapic mode */
+	bool defer_attach;
 };
 
 /*
@@ -340,12 +341,17 @@ static u16 get_alias(struct device *dev)
 static struct iommu_dev_data *find_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
 	dev_data = search_dev_data(devid);
 
-	if (dev_data == NULL)
+	if (dev_data == NULL) {
 		dev_data = alloc_dev_data(devid);
 
+		if (translation_pre_enabled(iommu))
+			dev_data->defer_attach = true;
+	}
+
 	return dev_data;
 }
 
@@ -2315,11 +2321,18 @@ static void queue_add(struct dma_ops_domain *dma_dom,
 static struct protection_domain *get_domain(struct device *dev)
 {
 	struct protection_domain *domain;
+	struct iommu_domain *io_domain;
 
 	if (!check_device(dev))
 		return ERR_PTR(-EINVAL);
 
 	domain = get_dev_data(dev)->domain;
+	if (domain == NULL && get_dev_data(dev)->defer_attach) {
+		get_dev_data(dev)->defer_attach = false;
+		io_domain = iommu_get_domain_for_dev(dev);
+		domain = to_pdomain(io_domain);
+		attach_device(dev, domain);
+	}
 	if (!dma_ops_domain(domain))
 		return ERR_PTR(-EBUSY);
 
@@ -3215,6 +3228,13 @@ static void amd_iommu_apply_dm_region(struct device *dev,
 	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
 }
 
+static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
+					 struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev->archdata.iommu;
+	return dev_data->defer_attach;
+}
+
 static const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3231,6 +3251,7 @@ static const struct iommu_ops amd_iommu_ops = {
 	.get_dm_regions = amd_iommu_get_dm_regions,
 	.put_dm_regions = amd_iommu_put_dm_regions,
 	.apply_dm_region = amd_iommu_apply_dm_region,
+	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 };
 
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
