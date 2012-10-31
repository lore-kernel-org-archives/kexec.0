Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TTUE4-0004kD-TB
 for kexec@lists.infradead.org; Wed, 31 Oct 2012 09:04:41 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 43C4D3EE0C5
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:04:38 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A4CA45DE4E
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:04:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 08BD245DE4F
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:04:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EB1021DB8040
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:04:37 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 945181DB8037
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:04:37 +0900 (JST)
Message-ID: <5090E865.1060503@jp.fujitsu.com>
Date: Wed, 31 Oct 2012 17:59:17 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/2] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <20121017061757.2944.36671.sendpatchset@indoh>
In-Reply-To: <20121017061757.2944.36671.sendpatchset@indoh>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, martin.wilck@ts.fujitsu.com, andi@firstfloor.org, kexec@lists.infradead.org, hbabu@us.ibm.com, mingo@redhat.com, ddutile@redhat.com, vgoyal@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, khalid@gonehiking.org

(2012/10/17 15:23), Takao Indoh wrote:
> These patches reset PCIe devices at boot time to address DMA problem on
> kdump with iommu. When "reset_devices" is specified, a hot reset is
> triggered on each PCIe root port and downstream port to reset its
> downstream endpoint.
>
> Background:
> A kdump problem about DMA has been discussed for a long time. That is,
> when a kernel is switched to the kdump kernel DMA derived from first
> kernel affects second kernel. Recently this problem surfaces when iommu
> is used for PCI passthrough on KVM guest. In the case of the machine I
> use, when intel_iommu=on is specified, DMAR error is detected in kdump
> kernel and PCI SERR is also detected. Finally kdump fails because some
> devices does not work correctly.
>
> The root cause is that ongoing DMA from first kernel causes DMAR fault
> because page table of DMAR is initialized while kdump kernel is booting
> up. Therefore to address this problem DMA needs to be stopped before
> DMAR is initialized at kdump kernel boot time. By these patches, PCIe
> devices are reset by hot reset and its DMA is stopped when reset_devices
> is specified. One problem of this solution is that the monitor blacks
> out when VGA controller is reset. So this patch does not reset the port
> whose child endpoint is VGA device.
>
> What I tried:
> - Clearing bus master bit and INTx disable bit at boot time
>      This did not solve this problem. I still got DMAR error on devices.
> - Resetting devices in fixup_final(v1 patch)
>      DMAR error disappeared, but sometimes PCI SERR was detected. This
>      is well explained here.
>      https://lkml.org/lkml/2012/9/9/245
>      This PCI SERR seems to be related to interrupt remapping.
> - Clearing bus master in setup_arch() and resetting devices in
>    fixup_final
>      Neither DMAR error nor PCI SERR occurred. But on certain machine
>      kdump kernel hung up when resetting devices. It seems to be a
>      problem specific to the platform.
> - Resetting devices in setup_arch() (v2 and later patch)
>      This solution solves all problems I found so far.
>
> v5:
> Do bus reset after all devices are scanned and its config registers are
> saved. This fixes a bug that config register is accessed without delay
> after reset.
>
> v4:
> Reduce waiting time after resetting devices. A previous patch does reset
> like this:
>    for (each device) {
>      save config registers
>      reset
>      wait for 500 ms
>      restore config registers
>    }
>
> If there are N devices to be reset, it takes N*500 ms. On the other
> hand, the v4 patch does:
>    for (each device) {
>      save config registers
>      reset
>    }
>    wait 500 ms
>    for (each device) {
>      restore config registers
>    }
> Though it needs more memory space to save config registers, the waiting
> time is always 500ms.
> https://lkml.org/lkml/2012/10/15/49
>
> v3:
> Move alloc_bootmem and free_bootmem to early_reset_pcie_devices so that
> they are called only once.
> https://lkml.org/lkml/2012/10/10/57
>
> v2:
> Reset devices in setup_arch() because reset need to be done before
> interrupt remapping is initialized.
> https://lkml.org/lkml/2012/10/2/54
>
> v1:
> Add fixup_final quirk to reset PCIe devices
> https://lkml.org/lkml/2012/8/3/160

Any other comments or ack/nack? If this is accepted I'll try multiple
domain support as next step.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
