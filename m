Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TBP1M-0002ji-Qq
 for kexec@lists.infradead.org; Tue, 11 Sep 2012 11:52:51 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2B8413EE0BD
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 20:52:45 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 030B145DE50
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 20:52:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E1B7445DD78
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 20:52:44 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D56591DB803F
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 20:52:44 +0900 (JST)
Received: from g01jpexchyt09.g01.fujitsu.local
 (g01jpexchyt09.g01.fujitsu.local [10.128.194.48])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 823B81DB802C
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 20:52:44 +0900 (JST)
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
Subject: RE: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
Date: Tue, 11 Sep 2012 11:52:42 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A4AC9A5@G01JPEXMBYT03>
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com> <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com> <50473306.1070803@jp.fujitsu.com>
 <4A338DB2991D2A44B9A44B8718AECF650A4AA6BF@G01JPEXMBYT03>
 <504D8A28.9090105@jp.fujitsu.com>
In-Reply-To: <504D8A28.9090105@jp.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Indoh, Takao" <indou.takao@jp.fujitsu.com>
Cc: "martin.wilck@ts.fujitsu.com" <martin.wilck@ts.fujitsu.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hbabu@us.ibm.com" <hbabu@us.ibm.com>, "Ishii,
 Hironobu" <ishii.hironobu@jp.fujitsu.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

> -----Original Message-----
> From: Takao Indoh [mailto:indou.takao@jp.fujitsu.com]
> Sent: Monday, September 10, 2012 3:35 PM
> To: Kaneshige, Kenji/金重 憲治
> Cc: vgoyal@redhat.com; kexec@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> bhelgaas@google.com; hbabu@us.ibm.com; Ishii, Hironobu/石井 宏延;
> martin.wilck@ts.fujitsu.com
> Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
> with iommu
> 
> (2012/09/10 11:34), Kaneshige, Kenji wrote:
> >> -----Original Message-----
> >> From: linux-pci-owner@vger.kernel.org
> >> [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Takao Indoh
> >> Sent: Wednesday, September 05, 2012 8:10 PM
> >> To: vgoyal@redhat.com
> >> Cc: kexec@lists.infradead.org; linux-kernel@vger.kernel.org;
> >> linux-pci@vger.kernel.org; bhelgaas@google.com; hbabu@us.ibm.com;
> Ishii,
> >> Hironobu/石井 宏延; martin.wilck@ts.fujitsu.com
> >> Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on
> kdump
> >> with iommu
> >>
> >> (2012/08/07 5:39), Vivek Goyal wrote:
> >>> On Mon, Aug 06, 2012 at 01:30:47PM +0900, Takao Indoh wrote:
> >>>> Hi Vivek,
> >>>>
> >>>> (2012/08/03 20:46), Vivek Goyal wrote:
> >>>>> On Fri, Aug 03, 2012 at 08:24:31PM +0900, Takao Indoh wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> This patch adds kernel parameter "reset_pcie_devices" which resets
> >> PCIe
> >>>>>> devices at boot time to address DMA problem on kdump with iommu.
> When
> >>>>>> this parameter is specified, a hot reset is triggered on each PCIe
> >> root
> >>>>>> port and downstream port to reset its downstream endpoint.
> >>>>>
> >>>>> Hi Takao,
> >>>>>
> >>>>> Why not use existing "reset_devices" parameter instead of introducing
> >>>>> a new one?
> >>>>
> >>>> "reset_devices" is used for each driver to reset their own device,
> and
> >>>> this patch resets all devices forcibly, so I thought they were different
> >>>> things.
> >>>
> >>> Yes reset_devices currently is used for driver to reset its device.
> I
> >>> thought one could very well extend its reach to reset pci express devices
> >>> at bus level.
> >>>
> >>> Having them separate is not going to be much useful from kdump
> >>> perspective. We will end up passing both reset_devices and
> >>> reset_pcie_devices to second kernel whill lead to bus level reset as
> well
> >>> as device level reset.
> >>>
> >>> Ideal situation would be that somehow detect that bus level reset has
> >> been
> >>> done and skip device level reset (assuming bus level reset obviates
> the
> >>> need of device level reset, please correct me if that's not the case).
> >>>
> >>> After pcie reset, can we store the state in a variable and drivers can
> >>> use that variable to check if PCIe level reset was done or not. If yes,
> >>> skip device level reset (Assuming driver knows that device is on a
> >>> PCIe slot).
> >>>
> >>> In that case we will not have to introduce new kernel command line,
> and
> >>> also avoid double reset?
> >>
> >> I found a problem when testing my patch on some machines.
> >>
> >> Originally there are two problems in kdump kernel when iommu is enabled;
> >> DMAR error and PCI SERR. I thought they are fixed by my patch, but I
> >> noticed that PCI SERR is still detected after applying the patch. It
> >> seems that something happens when Interrupt Remapping is initialized
> in
> >> kdump kernel.
> >
> > I'm not sure, but I guess the PCI SERR might be caused as follows.
> >
> > - The 1st kernel enables interrupt remapping. The MSI(-X) address and
> >    data registers of PCI devices are programmed in remappable format.
> >
> > - At the beginning of 2nd kernel, interrupt remapping is still active.
> >    And then it is disabled by enable_IR() function for initialization.
> >
> > - PCI device generate an interrupt. At this moment, interrupt remapping
> >    is not enabled yet. On the other hand, MSI(-X) address and data of
> this
> >    interrupt is in remappable format because those are programmed by 1st
> >    kernel. I guess this might be a cause of PCI SERR.
> >
> > I guess clearing command register or disabling MSI before interrupt
> > remapping initialization in 2nd kernel might solve the PCI SERR problem.
> 
> Thank you for your comment. That makes sense.
> 
> Though I think clearing bus master bit is enough, do you think I need to
> clear
> all command register bit not only bus master?

I thought clearing bus master bit. But we might also need to set the
disable INTx bit.

It would not be needed if we can reset devices before interrupt remapping
initialization. I guess resetting devices before interrupt remapping
initialization would need complex code change and be difficult to implement.
If so, clearing bus master bit would be one of the alternative solution
against PCI SERR issue.

Regards,
Kenji Kaneshige



> 
> Thanks,
> Takao Indoh
> 
> 
> > Regards,
> > Kenji Kaneshige
> >
> >
> >>
> >> Therefore resetting devices has to be done before enable_IR() is
> >> called. I have three ideas for it.
> >>
> >>    (i) Resetting devices in 1st kernel(panic kernel)
> >>    We can reset devices before jumping into 2nd kernel. Of course it
> may
> >>    be dangerous to scan pci device tree and call PCI functions in panic'd
> >>    kernel. Beforehand we need to collect device information so that only
> >>    minimal code could run on panic.
> >>
> >>    (ii) Resetting devices in purgatory
> >>    It seems to be be appropriate place to do this, but I'm not sure
> >>    where I can save/restore PCI config when resetting devices in
> >>    purgatory.
> >>
> >>    (iii) Resetting devices in 2nd kernel(kdump kernel)
> >>    Important point is to do reset before enable_IR() is called as I wrote
> >>    above. I think I should add new function to do reset into
> >>    arch/x86/pci/early.c and call it in setup_arch like
> >>    early_dump_pci_devices() or early_quirks().
> >>
> >> Any comments?
> >>
> >> Thanks,
> >> Takao Indoh
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pci"
> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
