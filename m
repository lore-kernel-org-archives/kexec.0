Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0Ax-0001FL-7C
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:38:40 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 10/10] iommu/amd: Copy the old ir table
Date: Thu, 24 Sep 2015 14:37:36 +0800
Message-Id: <1443076656-31776-11-git-send-email-bhe@redhat.com>
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
 drivers/iommu/amd_iommu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1e86f4c..f4f3e63 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3683,12 +3683,25 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 
 	memset(table->table, 0, MAX_IRQS_PER_TABLE * sizeof(u32));
 
-	if (ioapic) {
-		int i;
-
-		for (i = 0; i < 32; ++i)
-			table->table[i] = IRTE_ALLOCATED;
-	}
+	if (translation_pre_enabled()) {
+		u64 dte;
+                u64 old_intr_virt;
+                dte     = amd_iommu_dev_table[devid].data[2];
+                dte &= DTE_IRQ_PHYS_ADDR_MASK;
+                old_intr_virt = ioremap_cache(dte, MAX_IRQS_PER_TABLE * sizeof(u32));
+                memcpy_fromio(table->table, old_intr_virt, MAX_IRQS_PER_TABLE * sizeof(u32));
+                iounmap(old_intr_virt);
+                iommu_flush_irt(iommu, devid);
+        }
+        else {
+
+                if (ioapic) {
+                        int i;
+
+                        for (i = 0; i < 32; ++i)
+                                table->table[i] = IRTE_ALLOCATED;
+                }
+        }
 
 	irq_lookup_table[devid] = table;
 	set_dte_irq_entry(devid, table);
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
