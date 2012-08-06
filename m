Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SyFFp-0007aV-UY
 for kexec@lists.infradead.org; Mon, 06 Aug 2012 04:49:23 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 93B9D3EE0C2
 for <kexec@lists.infradead.org>; Mon,  6 Aug 2012 13:49:16 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7912645DE52
 for <kexec@lists.infradead.org>; Mon,  6 Aug 2012 13:49:16 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5676845DE4F
 for <kexec@lists.infradead.org>; Mon,  6 Aug 2012 13:49:16 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3AD7BE08007
 for <kexec@lists.infradead.org>; Mon,  6 Aug 2012 13:49:16 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id CC4DCE08001
 for <kexec@lists.infradead.org>; Mon,  6 Aug 2012 13:49:15 +0900 (JST)
Message-ID: <501F4BCE.4060702@jp.fujitsu.com>
Date: Mon, 06 Aug 2012 13:45:02 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <501BB4EF.7080909@jp.fujitsu.com> <501F4387.3010404@redhat.com>
In-Reply-To: <501F4387.3010404@redhat.com>
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
To: ddutile@redhat.com
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, vgoyal@redhat.com

Hi Don,

(2012/08/06 13:09), Don Dutile wrote:
> On 08/03/2012 07:24 AM, Takao Indoh wrote:
>> Hi all,
>>
>> This patch adds kernel parameter "reset_pcie_devices" which resets PCIe
>> devices at boot time to address DMA problem on kdump with iommu. When
>> this parameter is specified, a hot reset is triggered on each PCIe root
>> port and downstream port to reset its downstream endpoint.
>>
>> Background:
>> A kdump problem about DMA has been discussed for a long time. That is,
>> when a kernel is switched to the kdump kernel DMA derived from first
>> kernel affects second kernel. Recently this problem surfaces when iommu
>> is used for PCI passthrough on KVM guest. In the case of the machine I
>> use, when intel_iommu=on is specified, DMAR error is detected in kdump
>> kernel and PCI SERR is also detected. Finally kdump fails because some
>> devices does not work correctly.
>>
>> The root cause is that ongoing DMA from first kernel causes DMAR fault
>> because page table of DMAR is initialized while kdump kernel is booting
>> up. Therefore to address this problem DMA needs to be stopped before DMAR
>> is initialized at kdump kernel boot time. By this patch, PCIe devices
>> are reset by hot reset and its DMA is stopped when reset_pcie_devices is
>> specified. One problem of this solution is that VGA is reset and the
>> monitor blacks out when the link between the port and VGA controller was
>> reset. So this patch does not reset the port whose child endpoint is VGA
>> device.
>>
>> Any comments would be appreciated.
>>
>> Signed-off-by: Takao Indoh<indou.takao@jp.fujitsu.com>
>> ---
> Have you considered something less disruptive such as clearing the
> Master Enable in each endpoint's PCI Command Register ?
> That should prevent DMA transactions from endpoints during the kdump and
> kexec, and when the driver for the device gets reconfigured,
> Master Enable will be set back on, but after the driver has had the
> opportunity to do a device-specific reset.

Yes, that is what I tried first. First of all I found this thread.

[PATCH] Disable Bus Master on PCI device shutdown
https://lkml.org/lkml/2012/6/6/278
original patch: http://marc.info/?l=kexec&m=133546519231295&w=2

And I thought ongoing DMA could be stopped by disabling it on kdump
kernel boot, but DMAR error is still found after adding quirk below.

In this thread, AER link reset was also suggested, so I got the
idea to reset root port and downstream port.

Thanks,
Takao Indoh

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5155317..0e8b41a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -31,6 +31,22 @@
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
+static void test_pci_device_reset(struct pci_dev *dev)
+{
+	u16 pci_command;
+
+	if (!reset_devices)
+		return;
+
+	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_MASTER) {
+		dev_info(&dev->dev, "DEBUG: Disable Bus Master bit\n");
+		pci_command &= ~PCI_COMMAND_MASTER;
+		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, test_pci_device_reset);
+
 /*
  * Decoding should be disabled for a PCI device during BAR sizing to avoid
  * conflict. But doing so may cause problems on host bridge and perhaps other


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
