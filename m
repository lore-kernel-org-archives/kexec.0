Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0Ai-0000wq-71
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:38:24 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 05/10] iommu/amd: Add function copy_dev_tables
Date: Thu, 24 Sep 2015 14:37:31 +0800
Message-Id: <1443076656-31776-6-git-send-email-bhe@redhat.com>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
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
To: joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c  | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1fc369e..913a718 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -690,6 +690,32 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
 }
 
+static void copy_dev_tables(void)
+{
+        u64 entry;
+        u32 lo, hi;
+        phys_addr_t old_devtb_phys;
+        struct dev_table_entry *old_devtb;
+        struct amd_iommu *iommu;
+        u16 dom_id;
+        u32 devid;
+
+        for_each_iommu(iommu) {
+                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
+                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
+                entry = (((u64) hi) << 32) + lo;
+                old_devtb_phys = entry & PAGE_MASK;
+                old_devtb = ioremap_cache(old_devtb_phys, dev_table_size);
+                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+                        amd_iommu_dev_table[devid] = old_devtb[devid];
+                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
+                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+                }
+                iounmap(old_devtb);
+        }
+
+}
+
 /* sets a specific bit in the device table entry. */
 static void set_dev_entry_bit(u16 devid, u8 bit)
 {
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f659088..d0f0cfb 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -194,6 +194,8 @@
 #define DEV_ENTRY_MODE_MASK	0x07
 #define DEV_ENTRY_MODE_SHIFT	0x09
 
+#define DEV_DOMID_MASK        0xffff
+
 #define MAX_DEV_TABLE_ENTRIES	0xffff
 
 /* constants to configure the command buffer */
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
