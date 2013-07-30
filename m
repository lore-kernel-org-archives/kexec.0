Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-x22c.google.com ([2607:f8b0:4003:c01::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V4CL8-0003Fj-GE
 for kexec@lists.infradead.org; Tue, 30 Jul 2013 15:59:59 +0000
Received: by mail-ob0-f172.google.com with SMTP id er7so1070457obc.31
 for <kexec@lists.infradead.org>; Tue, 30 Jul 2013 08:59:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51F758B6.9090204@jp.fujitsu.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
 <CAErSpo4t_2Xw76p3Z9FVzyyK-MBovavDu9D=pYoPMjESSxgT=w@mail.gmail.com>
 <51B19DF3.2070009@jp.fujitsu.com>
 <CAErSpo6dfEnzriHD_aWZB_3E-kSzauhNRHPd+VuFX5HONVKgqw@mail.gmail.com>
 <51B6BEDB.3000509@jp.fujitsu.com>
 <CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
 <51B93221.2040505@jp.fujitsu.com>
 <CAErSpo5tVK-Z3aOdMTzab-S8o5zLVtDOFQ8-LSYpUgbrJSsxuw@mail.gmail.com>
 <51BA7BB6.1080104@jp.fujitsu.com> <51EF7466.20703@jp.fujitsu.com>
 <CAErSpo5B7NzVfxwW3bQnfK+iK+DrRsWQd2Cm14z5PWNnRHWL5w@mail.gmail.com>
 <51F5B966.9080405@jp.fujitsu.com>
 <CAErSpo4JtG5qVJb-nCywe3vkft=-cDeRDKn_V92RCZ-sGXpwbg@mail.gmail.com>
 <51F758B6.9090204@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 30 Jul 2013 09:59:16 -0600
Message-ID: <CAErSpo7TNhQO0dx_xZvF=dU2fSWTFf8x=xUJcEsbadJkv8ktuQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Don Dutile <ddutile@redhat.com>, "Sumner, William" <bill.sumner@hp.com>, "ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Jul 30, 2013 at 12:09 AM, Takao Indoh
<indou.takao@jp.fujitsu.com> wrote:
> (2013/07/29 23:17), Bjorn Helgaas wrote:
>> On Sun, Jul 28, 2013 at 6:37 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>>> (2013/07/26 2:00), Bjorn Helgaas wrote:

>>>> My point about IOMMU and PCI initialization order doesn't go away just
>>>> because it doesn't fit "kdump policy."  Having system initialization
>>>> occur in a logical order is far more important than making kdump work.
>>>
>>> My next plan is as follows. I think this is matched to logical order
>>> on boot.
>>>
>>> drivers/pci/pci.c
>>> - Add function to reset bus, for example, pci_reset_bus(struct pci_bus *bus)
>>>
>>> drivers/iommu/intel-iommu.c
>>> - On initialization, if IOMMU is already enabled, call this bus reset
>>>    function before disabling and re-enabling IOMMU.
>>
>> I raised this issue because of arches like sparc that enumerate the
>> IOMMU before the PCI devices that use it.  In that situation, I think
>> you're proposing this:
>>
>>    panic kernel
>>      enable IOMMU
>>      panic
>>    kdump kernel
>>      initialize IOMMU (already enabled)
>>        pci_reset_bus
>>        disable IOMMU
>>        enable IOMMU
>>      enumerate PCI devices
>>
>> But the problem is that when you call pci_reset_bus(), you haven't
>> enumerated the PCI devices, so you don't know what to reset.
>
> Right, so my idea is adding reset code into "intel-iommu.c". intel-iommu
> initialization is based on the assumption that enumeration of PCI devices
> is already done. We can find target device from IOMMU page table instead
> of scanning all devices in pci tree.
>
> Therefore, this idea is only for intel-iommu. Other architectures need
> to implement their own reset code.

That's my point.  I'm opposed to adding code to PCI when it only
benefits x86 and we know other arches will need a fundamentally
different design.  I would rather have a design that can work for all
arches.

If your implementation is totally implemented under arch/x86 (or in
intel-iommu.c, I guess), I can't object as much.  However, I think
that eventually even x86 should enumerate the IOMMUs via ACPI before
we enumerate PCI devices.

It's pretty clear that's how BIOS designers expect the OS to work.
For example, sec 8.7.3 of the Intel Virtualization Technology for
Directed I/O spec, rev 1.3, shows the expectation that remapping
hardware (IOMMU) is initialized before discovering the I/O hierarchy
below a hot-added host bridge.  Obviously you're not talking about a
hot-add scenario, but I think the same sequence should apply at
boot-time as well.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
