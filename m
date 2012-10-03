Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TJOvN-0002Q5-HB
 for kexec@lists.infradead.org; Wed, 03 Oct 2012 13:23:43 +0000
Message-ID: <506C3C4C.1060808@redhat.com>
Date: Wed, 03 Oct 2012 09:23:24 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <20121002074434.204.47750.sendpatchset@indoh>
In-Reply-To: <20121002074434.204.47750.sendpatchset@indoh>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, vgoyal@redhat.com

On 10/02/2012 03:49 AM, Takao Indoh wrote:
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
> v2:
> Reset devices in setup_arch() because reset need to be done before
> interrupt remapping is initialized.
>
> v1:
> https://lkml.org/lkml/2012/8/3/160
>
> Thanks,
> Takao Indoh
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Maybe you've tried the following, and I missed a thread on it,
but instead of a somewhat-large, reset hammer, did any one try
just reading all the endpoint-only device CMD register, flip the MasterEnable
bit off, and write it back? .... that would stop all DMA (should stop
all MSI writes as well since they are just another DMA), and then
restart the system?
May also have to do PCI INT Disable as well... and note, that's a PCI 2.3
optional feature.... so devices using INT signalling vs MSI
is just borked on IOMMU/intr-remapping systems... which I would expect
are few. Then again, if this is foolishly done, then reset legacy PCI
busses as the fallback.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
