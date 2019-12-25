Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ikCGJ-0000zB-Rf
 for kexec@lists.infradead.org; Wed, 25 Dec 2019 19:24:05 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH] PCI,
 kdump: Clear bus master bit upon shutdown in kdump kernel
Date: Thu, 26 Dec 2019 03:21:18 +0800
Message-Id: <20191225192118.283637-1-kasong@redhat.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>

There are reports about kdump hang upon reboot on some HPE machines,
kernel hanged when trying to shutdown a PCIe port, an uncorrectable
error occurred and crashed the system.

On the machine I can reproduce this issue, part of the topology
looks like this:

[0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
          +-01.0-[02]--
          +-01.1-[05]--
          +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
          |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
          +-02.1-[0f]--
          +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array Gen9 Controllers

When shuting down PCIe port 0000:00:02.2 or 0000:00:02.0, the machine
will hang, depend on which device is reinitialized in kdump kernel.

If force remove unused device then trigger kdump, the problem will never
happen:

    echo 1 > /sys/bus/pci/devices/0000\:00\:02.2/0000\:07\:00.0/remove
    echo c > /proc/sysrq-trigger

    ... Kdump save vmcore through network, the NIC get reinitialized and
    hpsa is untouched. Then reboot with no problem. (If hpsa is used
    instead, shutdown the NIC in first kernel will help)

The cause is that some devices are enabled by the first kernel, but it
don't have the chance to shutdown the device, and kdump kernel is not
aware of it, unless it reinitialize the device.

Upon reboot, kdump kernel will skip downstream device shutdown and
clears its bridge's master bit directly. The downstream device could
error out as it can still send requests but upstream refuses it.

So for kdump, let kernel read the correct hardware power state on boot,
and always clear the bus master bit of PCI device upon shutdown if the
device is on. PCIe port driver will always shutdown all downstream
devices first, so this should ensure all downstream devices have bus
master bit off before clearing the bridge's bus master bit.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/pci/pci-driver.c | 11 ++++++++---
 drivers/pci/quirks.c     | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..84a7fd643b4d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/crash_dump.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -488,10 +489,14 @@ static void pci_device_shutdown(struct device *dev)
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
 	 * devices in D3cold or unknown states.
-	 * If it is not a kexec reboot, firmware will hit the PCI
-	 * devices with big hammer and stop their DMA any way.
+	 * If this is kdump kernel, also turn off Bus Master, the device
+	 * could be activated by previous crashed kernel and may block
+	 * it's upstream from shutting down.
+	 * Else, firmware will hit the PCI devices with big hammer
+	 * and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if ((kexec_in_progress || is_kdump_kernel()) &&
+			pci_dev->current_state <= PCI_D3hot)
 		pci_clear_master(pci_dev);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..c65d11ab3939 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/switchtec.h>
+#include <linux/crash_dump.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -192,6 +193,25 @@ static int __init pci_apply_final_quirks(void)
 }
 fs_initcall_sync(pci_apply_final_quirks);
 
+/*
+ * Read the device state even if it's not enabled. The device could be
+ * activated by previous crashed kernel, this will read and correct the
+ * cached state.
+ */
+static void quirk_read_pm_state_in_kdump(struct pci_dev *dev)
+{
+	u16 pmcsr;
+
+	if (!is_kdump_kernel())
+		return;
+
+	if (dev->pm_cap) {
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_read_pm_state_in_kdump);
+
 /*
  * Decoding should be disabled for a PCI device during BAR sizing to avoid
  * conflict. But doing so may cause problems on host bridge and perhaps other
-- 
2.24.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
