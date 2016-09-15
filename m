Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkYD0-0007P6-VF
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 15:04:15 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 6/8] iommu/amd: Do not re-enable dev table entries in kdump
Date: Thu, 15 Sep 2016 23:03:24 +0800
Message-Id: <1473951806-25511-7-git-send-email-bhe@redhat.com>
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

This enabling should have been done in normal kernel. It's unnecessary
to enable it again in kdump kernel.

And clean up the function comments of init_device_table_dma.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 47a8fc9..8d5db2e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1651,7 +1651,12 @@ static int __init amd_iommu_init_pci(void)
 	 */
 	ret = amd_iommu_init_api();
 
-	init_device_table_dma();
+	for_each_iommu(iommu) {
+		if ( !translation_pre_enabled(iommu) ) {
+			init_device_table_dma();
+			break;
+		}
+	}
 
 	for_each_iommu(iommu)
 		iommu_flush_all_caches(iommu);
@@ -1829,8 +1834,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 }
 
 /*
- * Init the device table to not allow DMA access for devices and
- * suppress all page faults
+ * Init the device table to not allow DMA access for devices.
  */
 static void init_device_table_dma(void)
 {
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
