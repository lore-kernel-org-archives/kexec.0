Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TIxEy-00045T-6B
 for kexec@lists.infradead.org; Tue, 02 Oct 2012 07:50:05 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E3F883EE0BD
 for <kexec@lists.infradead.org>; Tue,  2 Oct 2012 16:49:56 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CC4D645DE55
 for <kexec@lists.infradead.org>; Tue,  2 Oct 2012 16:49:56 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A80B345DE52
 for <kexec@lists.infradead.org>; Tue,  2 Oct 2012 16:49:56 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C5D61DB803A
 for <kexec@lists.infradead.org>; Tue,  2 Oct 2012 16:49:56 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 53F181DB8038
 for <kexec@lists.infradead.org>; Tue,  2 Oct 2012 16:49:56 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Message-Id: <20121002074434.204.47750.sendpatchset@indoh>
Subject: [PATCH v2 0/2] Reset PCIe devices to address DMA problem on kdump
 with iommu
Date: Tue,  2 Oct 2012 16:49:56 +0900 (JST)
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: martin.wilck@ts.fujitsu.com, Takao Indoh <indou.takao@jp.fujitsu.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, mingo@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, vgoyal@redhat.com

These patches reset PCIe devices at boot time to address DMA problem on
kdump with iommu. When "reset_devices" is specified, a hot reset is
triggered on each PCIe root port and downstream port to reset its
downstream endpoint.

Background:
A kdump problem about DMA has been discussed for a long time. That is,
when a kernel is switched to the kdump kernel DMA derived from first
kernel affects second kernel. Recently this problem surfaces when iommu
is used for PCI passthrough on KVM guest. In the case of the machine I
use, when intel_iommu=on is specified, DMAR error is detected in kdump
kernel and PCI SERR is also detected. Finally kdump fails because some
devices does not work correctly.

The root cause is that ongoing DMA from first kernel causes DMAR fault
because page table of DMAR is initialized while kdump kernel is booting
up. Therefore to address this problem DMA needs to be stopped before
DMAR is initialized at kdump kernel boot time. By these patches, PCIe
devices are reset by hot reset and its DMA is stopped when reset_devices
is specified. One problem of this solution is that the monitor blacks
out when VGA controller is reset. So this patch does not reset the port
whose child endpoint is VGA device.

v2:
Reset devices in setup_arch() because reset need to be done before
interrupt remapping is initialized.

v1:
https://lkml.org/lkml/2012/8/3/160

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
