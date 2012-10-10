Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TLr4M-0007DC-CG
 for kexec@lists.infradead.org; Wed, 10 Oct 2012 07:51:08 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1E40E3EE0B5
 for <kexec@lists.infradead.org>; Wed, 10 Oct 2012 16:51:00 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0341F45DE59
 for <kexec@lists.infradead.org>; Wed, 10 Oct 2012 16:51:00 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DE53645DE56
 for <kexec@lists.infradead.org>; Wed, 10 Oct 2012 16:50:59 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CB168E08001
 for <kexec@lists.infradead.org>; Wed, 10 Oct 2012 16:50:59 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 812211DB8045
 for <kexec@lists.infradead.org>; Wed, 10 Oct 2012 16:50:59 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Message-Id: <20121010074553.1084.52175.sendpatchset@indoh>
Subject: [PATCH v3 0/2] Reset PCIe devices to address DMA problem on kdump
 with iommu
Date: Wed, 10 Oct 2012 16:50:58 +0900 (JST)
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
Cc: martin.wilck@ts.fujitsu.com, Takao Indoh <indou.takao@jp.fujitsu.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com

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

What I tried:
- Clearing bus master bit and INTx disable bit at boot time
    This did not solve this problem. I still got DMAR error on devices.
- Resetting devices in fixup_final(v1 patch)
    DMAR error disappeared, but sometimes PCI SERR was detected.
    This is well explained here.
    https://lkml.org/lkml/2012/9/9/245
    This PCI SERR seems to be related to interrupt remapping.
- Clearing bus master in setup_arch() and resetting devices in fixup_final
    Neither DMAR error nor PCI SERR occurred. But on certain machine
    kdump kernel hung up when resetting devices. It seems to be a
    problem specific to the platform.
- Resetting devices in setup_arch() (v2 patch)
    This solution solves all problems I found so far.

v3:
Move alloc_bootmem and free_bootmem to early_reset_pcie_devices so that
they are called only once.

v2:
Reset devices in setup_arch() because reset need to be done before
interrupt remapping is initialized.
https://lkml.org/lkml/2012/10/2/54

v1:
Add fixup_final quirk to reset PCIe devices
https://lkml.org/lkml/2012/8/3/160

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
