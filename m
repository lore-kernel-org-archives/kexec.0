Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-x22c.google.com ([2a00:1450:4010:c03::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG9TS-0001x2-H0
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 14:49:47 +0000
Received: by mail-la0-f44.google.com with SMTP id eb20so2578971lab.3
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2013 07:49:40 -0700 (PDT)
Subject: [PATCH bugfix 3.9] PCI: Don't try to disable Bus Master on
 disconnected PCI devices
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date: Thu, 14 Mar 2013 18:49:37 +0400
Message-ID: <20130314144936.10073.2403.stgit@zurg>
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
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Bjorn Helgaas <bhelgaas@google.com>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>

This is fix for commit 7897e6022761ace7377f0f784fca059da55f5d71 from v3.9-rc1
("PCI: Disable Bus Master unconditionally in pci_device_shutdown()")
in turn that was fix for b566a22c23327f18ce941ffad0ca907e50a53d41 from v3.5-rc1
("PCI: disable Bus Master on PCI device shutdown")

Unfortunately fixing one bug uncovers another:
->shutdown() callback might switch device to deep sleep state.
PCI config space no longer available after that.

Link: https://lkml.org/lkml/2013/3/12/529
Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
Reported-and-Tested-by: Vivek Goyal <vgoyal@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1fa1e48..79277fb 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -390,9 +390,10 @@ static void pci_device_shutdown(struct device *dev)
 
 	/*
 	 * Turn off Bus Master bit on the device to tell it to not
-	 * continue to do DMA
+	 * continue to do DMA. Don't touch devices in D3cold or unknown states.
 	 */
-	pci_clear_master(pci_dev);
+	if (pci_dev->current_state <= PCI_D3hot)
+		pci_clear_master(pci_dev);
 }
 
 #ifdef CONFIG_PM


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
