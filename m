Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V439A-0001pQ-Vn
 for kexec@lists.infradead.org; Tue, 30 Jul 2013 06:11:03 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EE3293EE0BC
 for <kexec@lists.infradead.org>; Tue, 30 Jul 2013 15:10:31 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id DD10F45DEB5
 for <kexec@lists.infradead.org>; Tue, 30 Jul 2013 15:10:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id B125145DEB7
 for <kexec@lists.infradead.org>; Tue, 30 Jul 2013 15:10:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9D9A0E08005
 for <kexec@lists.infradead.org>; Tue, 30 Jul 2013 15:10:31 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 420CE1DB8040
 for <kexec@lists.infradead.org>; Tue, 30 Jul 2013 15:10:31 +0900 (JST)
Message-ID: <51F758B6.9090204@jp.fujitsu.com>
Date: Tue, 30 Jul 2013 15:09:58 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
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
In-Reply-To: <CAErSpo4JtG5qVJb-nCywe3vkft=-cDeRDKn_V92RCZ-sGXpwbg@mail.gmail.com>
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
To: bhelgaas@google.com, vgoyal@redhat.com
Cc: alex.williamson@redhat.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, bill.sumner@hp.com

(2013/07/29 23:17), Bjorn Helgaas wrote:
> On Sun, Jul 28, 2013 at 6:37 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>> (2013/07/26 2:00), Bjorn Helgaas wrote:
>>> On Wed, Jul 24, 2013 at 12:29 AM, Takao Indoh
>>> <indou.takao@jp.fujitsu.com> wrote:
>>>> Sorry for letting this discussion slide, I was busy on other works:-(
>>>> Anyway, the summary of previous discussion is:
>>>> - My patch adds new initcall(fs_initcall) to reset all PCIe endpoints on
>>>>     boot. This expects PCI enumeration is done before IOMMU
>>>>     initialization as follows.
>>>>       (1) PCI enumeration
>>>>       (2) fs_initcall ---> device reset
>>>>       (3) IOMMU initialization
>>>> - This works on x86, but does not work on other architecture because
>>>>     IOMMU is initialized before PCI enumeration on some architectures. So,
>>>>     device reset should be done where IOMMU is initialized instead of
>>>>     initcall.
>>>> - Or, as another idea, we can reset devices in first kernel(panic kernel)
>>>>
>>>> Resetting devices in panic kernel is against kdump policy and seems not to
>>>> be good idea. So I think adding reset code into iommu initialization is
>>>> better. I'll post patches for that.
>>>
>>> Of course nobody *wants* to do anything in the panic kernel.  But
>>> simply saying "it's against kdump policy and seems not to be a good
>>> idea" is not a technical argument.  There are things that are
>>> impractical to do in the kdump kernel, so they have to be done in the
>>> panic kernel even though we know the kernel is unreliable and the
>>> attempt may fail.
>>
>> Accessing kernel data in panic kernel causes panic again, so
>> - Don't touch kernel data in panic situation
>> - Jump to kdump kernel as quickly as possible, and do things in safe
>>    kernel
>> These are basic "kdump policy". Of course if there are any works which
>> we cannot do in kdump kernel and can do only in panic kernel, for
>> example saving registers or stopping cpus, we should do them in panic
>> kernel.
>>
>> Resetting devices in panic kernel is worth considering if we can safely
>> find pci_dev and reset it, but I have no idea how to do that because
>> for example struct pci_dev may be borken.
> 
> Nobody can guarantee that the panic kernel can do *anything* safely
> because any arbitrary kernel data or text may be corrupted.  But if
> you consider any specific data structure, e.g., CPU or PCI device
> lists, it's not very likely that it will be corrupted.

To reset device we need to scan pci device tree using for_each_pci_dev.
Something like bust_spinlocks() to clear pci_lock forcibly is needed.
Vivek, adding these into kdump is acceptable for you? Or any other
ideas? I think iterating over a list like for_each_pci_dev is dangerous.

> 
>>> My point about IOMMU and PCI initialization order doesn't go away just
>>> because it doesn't fit "kdump policy."  Having system initialization
>>> occur in a logical order is far more important than making kdump work.
>>
>> My next plan is as follows. I think this is matched to logical order
>> on boot.
>>
>> drivers/pci/pci.c
>> - Add function to reset bus, for example, pci_reset_bus(struct pci_bus *bus)
>>
>> drivers/iommu/intel-iommu.c
>> - On initialization, if IOMMU is already enabled, call this bus reset
>>    function before disabling and re-enabling IOMMU.
> 
> I raised this issue because of arches like sparc that enumerate the
> IOMMU before the PCI devices that use it.  In that situation, I think
> you're proposing this:
> 
>    panic kernel
>      enable IOMMU
>      panic
>    kdump kernel
>      initialize IOMMU (already enabled)
>        pci_reset_bus
>        disable IOMMU
>        enable IOMMU
>      enumerate PCI devices
> 
> But the problem is that when you call pci_reset_bus(), you haven't
> enumerated the PCI devices, so you don't know what to reset.

Right, so my idea is adding reset code into "intel-iommu.c". intel-iommu
initialization is based on the assumption that enumeration of PCI devices 
is already done. We can find target device from IOMMU page table instead
of scanning all devices in pci tree.

Therefore, this idea is only for intel-iommu. Other architectures need
to implement their own reset code.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
