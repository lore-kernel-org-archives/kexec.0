Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0Ad-0000lH-76
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:38:19 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 02/10] iommu/amd: Adjust functons which get first/last devid
 by reading pci config
Date: Thu, 24 Sep 2015 14:37:28 +0800
Message-Id: <1443076656-31776-3-git-send-email-bhe@redhat.com>
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

The old functon find_last_devid_on_pci not only gets the last devid, but calls
update_last_devid(). Now adjust the function definition to make it be consistent
with its name. Meanwhile add a new function find_first_devid_on_pci for later use.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 286da26..be20a56 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -412,14 +412,32 @@ static inline int ivhd_entry_length(u8 *ivhd)
  * This function reads the last device id the IOMMU has to handle from the PCI
  * capability header for this IOMMU
  */
-static int __init find_last_devid_on_pci(int bus, int dev, int fn, int cap_ptr)
+static int __init find_first_devid_on_pci(struct ivhd_header *h)
 {
-	u32 cap;
+	u32 range;
 
-	cap = read_pci_config(bus, dev, fn, cap_ptr+MMIO_RANGE_OFFSET);
-	update_last_devid(PCI_DEVID(MMIO_GET_BUS(cap), MMIO_GET_LD(cap)));
+	range = read_pci_config(PCI_BUS_NUM(h->devid),
+				PCI_SLOT(h->devid),
+				PCI_FUNC(h->devid),
+				h->cap_ptr+MMIO_RANGE_OFFSET);
 
-	return 0;
+	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_FD(range));
+}
+
+/*
+ * This function reads the last device id the IOMMU has to handle from the PCI
+ * capability header for this IOMMU
+ */
+static int __init find_last_devid_on_pci(struct ivhd_header *h)
+{
+	u32 range;
+
+	range = read_pci_config(PCI_BUS_NUM(h->devid),
+				PCI_SLOT(h->devid),
+				PCI_FUNC(h->devid),
+				h->cap_ptr+MMIO_RANGE_OFFSET);
+
+	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_LD(range));
 }
 
 /*
@@ -430,15 +448,14 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 {
 	u8 *p = (void *)h, *end = (void *)h;
 	struct ivhd_entry *dev;
+	u16 devid;
+
+	devid = find_last_devid_on_pci(h);
+	update_last_devid(devid);
 
 	p += sizeof(*h);
 	end += h->length;
 
-	find_last_devid_on_pci(PCI_BUS_NUM(h->devid),
-			PCI_SLOT(h->devid),
-			PCI_FUNC(h->devid),
-			h->cap_ptr);
-
 	while (p < end) {
 		dev = (struct ivhd_entry *)p;
 		switch (dev->type) {
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
