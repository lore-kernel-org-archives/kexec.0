Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cA8q5-0000g6-94
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 05:14:22 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 12/12] iommu/amd: Allocate memory below 4G for dev table if
 translation pre-enabled
Date: Fri, 25 Nov 2016 13:13:19 +0800
Message-Id: <1480050799-1237-13-git-send-email-bhe@redhat.com>
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

AMD pointed out it's unsafe to update the device-table while iommu
is enabled. It turns out that device-table pointer update is split
up into two 32bit writes in the IOMMU hardware. So updating it while
the IOMMU is enabled could have some nasty side effects.

The only way to work around this is to allocate the device-table below
4GB if translation is pre-enabled in kdump kernel. If allocation failed,
still use the old one.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d362b63..f17f297 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2149,11 +2149,23 @@ static void early_enable_iommu(struct amd_iommu *iommu)
  */
 static void early_enable_iommus(void)
 {
+	struct dev_table_entry *dev_tbl;
 	struct amd_iommu *iommu;
 	bool is_pre_enabled = false;
 
 	for_each_iommu(iommu) {
 		if (translation_pre_enabled(iommu)) {
+			gfp_t gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;;
+
+			dev_tbl = (void *)__get_free_pages(gfp_flag,
+						get_order(dev_table_size));
+			if (dev_tbl != NULL) {
+				memcpy(dev_tbl, amd_iommu_dev_table, dev_table_size);
+				free_pages((unsigned long)amd_iommu_dev_table,
+						get_order(dev_table_size));
+				amd_iommu_dev_table = dev_tbl;
+			}
+
 			is_pre_enabled = true;
 			break;
 		}
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
