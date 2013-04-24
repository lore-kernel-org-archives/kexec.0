Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUrno-0008Fz-Ql
 for kexec@lists.infradead.org; Wed, 24 Apr 2013 04:59:34 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 5D2353EE0C3
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 13:59:26 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4C6B445DE50
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 13:59:26 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 352AA45DE4E
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 13:59:26 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1BE671DB8040
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 13:59:26 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BE83B1DB8037
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 13:59:25 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH] Reset PCIe devices to stop ongoing DMA
Date: Wed, 24 Apr 2013 13:58:59 +0900
Message-Id: <1366779539-3584-1-git-send-email-indou.takao@jp.fujitsu.com>
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
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org

This patch resets PCIe devices on boot to stop ongoing DMA. When
"pci=pcie_reset_devices" is specified, a hot reset is triggered on each
PCIe root port and downstream port to reset its downstream endpoint.

Problem:
This patch solves the problem that kdump can fail when intel_iommu=on is
specified. When intel_iommu=on is specified, many dma-remapping errors
occur in second kernel and it causes problems like driver error or PCI
SERR, at last kdump fails. This problem is caused as follows.
1) Devices are working on first kernel.
2) Switch to second kernel(kdump kernel). The devices are still working
   and its DMA continues during this switch.
3) iommu is initialized during second kernel boot and ongoing DMA causes
   dma-remapping errors.

Solution:
All DMA transactions have to be stopped before iommu is initialized. By
this patch devices are reset and in-flight DMA is stopped before
pci_iommu_init.

To invoke hot reset on an endpoint, its upstream link need to be reset.
reset_pcie_devices() is called from fs_initcall_sync, and it finds root
port/downstream port whose child is PCIe endpoint, and then reset link
between them. If the endpoint is VGA device, it is skipped because the
monitor blacks out if VGA controller is reset.

Actually this is v8 patch but quite different from v7 and it's been so
long since previous post, so I start over again.
Previous post:
[PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
https://lkml.org/lkml/2012/11/26/814

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 Documentation/kernel-parameters.txt |    2 +
 drivers/pci/pci.c                   |  103 +++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4609e81..2a31ade 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2250,6 +2250,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				any pair of devices, possibly at the cost of
 				reduced performance.  This also guarantees
 				that hot-added devices will work.
+		pcie_reset_devices	Reset PCIe endpoint on boot by hot
+				reset
 		cbiosize=nn[KMG]	The fixed amount of bus space which is
 				reserved for the CardBus bridge's IO window.
 				The default value is 256 bytes.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b099e00..42385c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3878,6 +3878,107 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_fixup_cardbus);
 
+/*
+ * Return true if dev is PCIe root port or downstream port whose child is PCIe
+ * endpoint except VGA device.
+ */
+static int __init need_reset(struct pci_dev *dev)
+{
+	struct pci_bus *subordinate;
+	struct pci_dev *child;
+
+	if (!pci_is_pcie(dev) || !dev->subordinate ||
+	    list_empty(&dev->subordinate->devices) ||
+	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
+		return 0;
+
+	subordinate = dev->subordinate;
+	list_for_each_entry(child, &subordinate->devices, bus_list) {
+		if ((pci_pcie_type(child) == PCI_EXP_TYPE_UPSTREAM) ||
+		    (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) ||
+		    ((child->class >> 16) == PCI_BASE_CLASS_DISPLAY))
+			/* Don't reset switch, bridge, VGA device */
+			return 0;
+	}
+
+	return 1;
+}
+
+static void __init save_config(struct pci_dev *dev)
+{
+	struct pci_bus *subordinate;
+	struct pci_dev *child;
+
+	if (!need_reset(dev))
+		return;
+
+	subordinate = dev->subordinate;
+	list_for_each_entry(child, &subordinate->devices, bus_list) {
+		dev_info(&child->dev, "save state\n");
+		pci_save_state(child);
+	}
+}
+
+static void __init restore_config(struct pci_dev *dev)
+{
+	struct pci_bus *subordinate;
+	struct pci_dev *child;
+
+	if (!need_reset(dev))
+		return;
+
+	subordinate = dev->subordinate;
+	list_for_each_entry(child, &subordinate->devices, bus_list) {
+		dev_info(&child->dev, "restore state\n");
+		pci_restore_state(child);
+	}
+}
+
+static void __init do_device_reset(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	if (!need_reset(dev))
+		return;
+
+	dev_info(&dev->dev, "Reset Secondary bus\n");
+
+	/* Assert Secondary Bus Reset */
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
+	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+
+	msleep(2);
+
+	/* De-assert Secondary Bus Reset */
+	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+}
+
+static int __initdata pcie_reset_devices;
+static int __init reset_pcie_devices(void)
+{
+	struct pci_dev *dev = NULL;
+
+	if (!pcie_reset_devices)
+		return 0;
+
+	for_each_pci_dev(dev)
+		save_config(dev);
+
+	for_each_pci_dev(dev)
+		do_device_reset(dev);
+
+	msleep(1000);
+
+	for_each_pci_dev(dev)
+		restore_config(dev);
+
+	return 0;
+}
+fs_initcall_sync(reset_pcie_devices);
+
 static int __init pci_setup(char *str)
 {
 	while (str) {
@@ -3920,6 +4021,8 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+			} else if (!strncmp(str, "pcie_reset_devices", 18)) {
+				pcie_reset_devices = 1;
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
-- 
1.7.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
