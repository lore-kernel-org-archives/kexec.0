Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMAxQ-0000R7-PQ
 for kexec@lists.infradead.org; Wed, 18 Sep 2013 06:09:49 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id AD71B3EE0B6
 for <kexec@lists.infradead.org>; Wed, 18 Sep 2013 15:09:18 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9ED0345F0AF
 for <kexec@lists.infradead.org>; Wed, 18 Sep 2013 15:09:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D3CB45F0AD
 for <kexec@lists.infradead.org>; Wed, 18 Sep 2013 15:09:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D1B41DB803E
 for <kexec@lists.infradead.org>; Wed, 18 Sep 2013 15:09:18 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 221BC1DB803B
 for <kexec@lists.infradead.org>; Wed, 18 Sep 2013 15:09:18 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH v2] intel-iommu: Quiesce devices before disabling IOMMU
Date: Wed, 18 Sep 2013 15:09:01 +0900
Message-Id: <1379484541-4496-1-git-send-email-indou.takao@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, joro@8bytes.org
Cc: alex.williamson@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

This patch quiesces devices before disabling IOMMU on boot to stop
ongoing DMA. In intel_iommu_init(), check context entries and if there
is entry whose present bit is set then reset corresponding device.

When IOMMU is already enabled on boot, it is disabled and new DMAR table
is created and then re-enabled in intel_iommu_init(). This causes DMAR
faults if there are in-flight DMAs.

This causes problem on kdump. Devices are working in first kernel, and
after switching to second kernel and initializing IOMMU, many DMAR
faults occur and it causes problems like driver error or PCI SERR, at
last kdump fails. This patch fixes this problem.

Changelog:
v2:
- Add CONTEXT_ENTRY_NR

v1:
https://lkml.org/lkml/2013/8/21/71

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 drivers/iommu/intel-iommu.c |   56 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index eec0d3e..d0e8aff 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -224,6 +224,7 @@ struct context_entry {
 	u64 lo;
 	u64 hi;
 };
+#define CONTEXT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct context_entry))
 
 static inline bool context_present(struct context_entry *context)
 {
@@ -3663,6 +3664,56 @@ static struct notifier_block device_nb = {
 	.notifier_call = device_notifier,
 };
 
+/* Reset PCI devices if its entry exists in DMAR table */
+static void __init iommu_reset_devices(struct intel_iommu *iommu, u16 segment)
+{
+	u64 addr;
+	struct root_entry *root;
+	struct context_entry *context;
+	int bus, devfn;
+	struct pci_dev *dev;
+
+	addr = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+	if (!addr)
+		return;
+
+	/*
+	 *  In the case of kdump, ioremap is needed because root-entry table
+	 *  exists in first kernel's memory area which is not mapped in second
+	 *  kernel
+	 */
+	root = (struct root_entry *)ioremap(addr, PAGE_SIZE);
+	if (!root)
+		return;
+
+	for (bus = 0; bus < ROOT_ENTRY_NR; bus++) {
+		if (!root_present(&root[bus]))
+			continue;
+
+		context = (struct context_entry *)ioremap(
+			root[bus].val & VTD_PAGE_MASK, PAGE_SIZE);
+		if (!context)
+			continue;
+
+		for (devfn = 0; devfn < CONTEXT_ENTRY_NR; devfn++) {
+			if (!context_present(&context[devfn]))
+				continue;
+
+			dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
+			if (!dev)
+				continue;
+
+			if (!pci_reset_bus(dev->bus)) /* go to next bus */
+				break;
+			else /* Try per-function reset */
+				pci_reset_function(dev);
+
+		}
+		iounmap(context);
+	}
+	iounmap(root);
+}
+
 int __init intel_iommu_init(void)
 {
 	int ret = 0;
@@ -3687,8 +3738,11 @@ int __init intel_iommu_init(void)
 			continue;
 
 		iommu = drhd->iommu;
-		if (iommu->gcmd & DMA_GCMD_TE)
+		if (iommu->gcmd & DMA_GCMD_TE) {
+			if (reset_devices)
+				iommu_reset_devices(iommu, drhd->segment);
 			iommu_disable_translation(iommu);
+		}
 	}
 
 	if (dmar_dev_scope_init() < 0) {
-- 
1.7.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
