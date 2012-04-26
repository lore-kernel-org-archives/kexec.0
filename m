Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SNTSr-00062r-9z
 for kexec@lists.infradead.org; Thu, 26 Apr 2012 18:30:50 +0000
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
 by g4t0015.houston.hp.com (Postfix) with ESMTP id C667586D0
 for <kexec@lists.infradead.org>; Thu, 26 Apr 2012 18:30:42 +0000 (UTC)
Received: from ldl (ldl.usa.hp.com [16.125.112.222])
 by g4t0009.houston.hp.com (Postfix) with ESMTP id AFDBBC401
 for <kexec@lists.infradead.org>; Thu, 26 Apr 2012 18:30:42 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
 by ldl (Postfix) with ESMTP id 83DD11A7E0DE
 for <kexec@lists.infradead.org>; Thu, 26 Apr 2012 12:30:42 -0600 (MDT)
Received: from ldl ([127.0.0.1])
 by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zeJsy6nxxSNR for <kexec@lists.infradead.org>;
 Thu, 26 Apr 2012 12:30:42 -0600 (MDT)
Received: from [16.71.9.99] (lyra.americas.hpqcorp.net [16.71.9.99])
 by ldl (Postfix) with ESMTP id 658131A7E0DD
 for <kexec@lists.infradead.org>; Thu, 26 Apr 2012 12:30:42 -0600 (MDT)
Subject: [RFC PATCH V2]  Disable Bus Master bit on PCI device shutdown
From: Khalid Aziz <khalid.aziz@hp.com>
Date: Thu, 26 Apr 2012 12:30:42 -0600
Message-ID: <1335465042.13081.22.camel@lyra>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Eric suggested I disable bus master bit in PCI susbsystem instead
and that makes perfect sense. So here is take 2 on this patch. Please
review and let me know if I missed anything.


Subject: [PATCH] Disable Bus Master bit on the device in
 pci_device_shutdown() to ensure PCI devices do not continue
 to DMA data after shutdown. This can cause memory
 corruption in case of a kexec where the current kernel
 shuts down and transfers control to a new kernel while a
 PCI device continues to DMA to memory that does not belong
 to it any more in the new kernel.


Signed-off-by: Khalid Aziz <khalid.aziz@hp.com>
---
 drivers/pci/pci-driver.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6b54b23..9db5940 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -420,6 +420,12 @@ static void pci_device_shutdown(struct device *dev)
 	pci_msi_shutdown(pci_dev);
 	pci_msix_shutdown(pci_dev);
 
+	/* 
+	 * Turn off Bus Master bit on the device to tell it to not
+	 * continue to do DMA
+	 */
+	pci_disable_device(pci_dev);
+
 	/*
 	 * Devices may be enabled to wake up by runtime PM, but they need not
 	 * be supposed to wake up the system from its "power off" state (e.g.
-- 
1.7.8.3


-- 
Khalid


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
