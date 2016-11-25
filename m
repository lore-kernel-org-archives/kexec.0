Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cA8pv-0000bI-9C
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 05:14:12 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 08/12] iommu/amd: Add sanity check of irq remap information
 of old dev table entry
Date: Fri, 25 Nov 2016 13:13:15 +0800
Message-Id: <1480050799-1237-9-git-send-email-bhe@redhat.com>
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

Firstly split the dev table entry copy into address translation part and
irq remapping part. Because these two parts could be configured to
be available indepentently.

Secondly check if IntCtl and IntTabLen are 10b and 1000b if they are
set.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c       |  5 -----
 drivers/iommu/amd_iommu_init.c  | 25 ++++++++++++++++++++++---
 drivers/iommu/amd_iommu_types.h |  8 ++++++++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fc8ecfb..cea90d5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3640,11 +3640,6 @@ EXPORT_SYMBOL(amd_iommu_device_info);
 
 static struct irq_chip amd_ir_chip;
 
-#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
-#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
-#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
-#define DTE_IRQ_REMAP_ENABLE    1ULL
-
 static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 {
 	u64 dte;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4233f26..4427c63 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -837,12 +837,12 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
 
 static int copy_dev_tables(void)
 {
+	u64 int_ctl, int_tab_len, entry, last_entry = 0;
 	struct dev_table_entry *old_devtb = NULL;
 	u32 lo, hi, devid, old_devtb_size;
 	phys_addr_t old_devtb_phys;
-	u64 entry, last_entry = 0;
 	struct amd_iommu *iommu;
-	u16 dom_id, dte_v;
+	u16 dom_id, dte_v, irq_v;
 	static int copied;
 
 	for_each_iommu(iommu) {
@@ -881,8 +881,27 @@ static int copy_dev_tables(void)
 			amd_iommu_dev_table[devid] = old_devtb[devid];
 			dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
 			dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
-			if (dte_v && dom_id)
+			if (dte_v && dom_id) {
+				amd_iommu_dev_table[devid].data[0]
+					= old_devtb[devid].data[0];
+				amd_iommu_dev_table[devid].data[1]
+					= old_devtb[devid].data[1];
 				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+			}
+
+			irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
+			int_ctl = old_devtb[devid].data[2] & DTE_IRQ_REMAP_INTCTL_MASK;
+			int_tab_len = old_devtb[devid].data[2] & DTE_IRQ_TABLE_LEN_MASK;
+			if (irq_v && (int_ctl || int_tab_len)) {
+				if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
+					 (int_tab_len != DTE_IRQ_TABLE_LEN)) {
+					pr_err("Wrong old irq remapping flag: %#x\n", devid);
+					return -1;
+				}
+
+				amd_iommu_dev_table[devid].data[2]
+					= old_devtb[devid].data[2];
+			}
 		}
 		memunmap(old_devtb);
 		copied = 1;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 79ec841..b5ae18e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -250,6 +250,14 @@
 
 #define GA_GUEST_NR		0x1
 
+/* Bit value definition for dte irq remapping fields*/
+#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
+#define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
+#define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
+#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
+#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
+#define DTE_IRQ_REMAP_ENABLE    1ULL
+
 #define PAGE_MODE_NONE    0x00
 #define PAGE_MODE_1_LEVEL 0x01
 #define PAGE_MODE_2_LEVEL 0x02
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
