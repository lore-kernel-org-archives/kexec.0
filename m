Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: RFC on Kdump and PCIe on ARM64
Message-ID: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
Date: Thu, 1 Mar 2018 12:44:26 -0500
MIME-Version: 1.0
Content-Language: en-US
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
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Linux PCI <linux-pci@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Nate Watterson <nwatters@codeaurora.org>, "shankerd@codeaurora.org" <shankerd@codeaurora.org>, Vikram Sethi <vikrams@codeaurora.org>, "Goel, Sameer" <sgoel@codeaurora.org>, kexec@lists.infradead.org

Hi,

We are seeing IOMMU faults when booting the kdump kernel on ARM64.

[    7.220162] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
[    7.226123] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000010000000002
[    7.232023] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
[    7.237925] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
[    7.243827] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000

This is Nate's interpretation of the fault:

"The PCI device is sending transactions just after the SMMU was reset/reinitialized
which is problematic because the device has not yet been added to the SMMU
and thus should not be doing *any* DMA.  DMA from the PCI devices should be
quiesced prior to starting the crashdump kernel or you risk overwriting portions
of memory you meant to preserve. In this case the SMMU was actually doing you a favor
by blocking these errant DMA operations!!"

I think this makes sense especially for the IOMMU enabled case on the host where an
IOVA can overlap with the region of memory kdump reserved for itself.

Apparently, there has been similar concerns in the past.

https://www.fujitsu.com/jp/documents/products/software/os/linux/catalog/LinuxConJapan2013-Indoh.pdf

and was not addressed globally due to IOMMU+PCI driver ordering issues and bugs in
HW due to hot reset.

https://lkml.org/lkml/2012/8/3/160

Hot reset as mentioned is destructive and may not be the best implementation choice. 
However, most of the modern endpoints support PCIE function level reset.

One other solution is for SMMUv3 driver to reserve the kdump used IOVA addresses.

Another solution is for the SMMUv3 driver to disable PCIe devices behind the SMMU
if it see SMMU is already enabled.

Appreciate the feedback,
Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
