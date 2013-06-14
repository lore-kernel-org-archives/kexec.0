Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UnJUi-0003MB-EH
 for kexec@lists.infradead.org; Fri, 14 Jun 2013 02:12:06 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 231F23EE0AE
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 11:11:33 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 13E4845DEBA
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 11:11:33 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id EDF2845DEB5
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 11:11:32 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E094E1DB803C
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 11:11:32 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F111E38001
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 11:11:32 +0900 (JST)
Message-ID: <51BA7BB6.1080104@jp.fujitsu.com>
Date: Fri, 14 Jun 2013 11:11:02 +0900
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
In-Reply-To: <CAErSpo5tVK-Z3aOdMTzab-S8o5zLVtDOFQ8-LSYpUgbrJSsxuw@mail.gmail.com>
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
To: bhelgaas@google.com
Cc: alex.williamson@redhat.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, vgoyal@redhat.com, ishii.hironobu@jp.fujitsu.com, bill.sumner@hp.com

(2013/06/13 12:41), Bjorn Helgaas wrote:
> On Wed, Jun 12, 2013 at 8:44 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>> (2013/06/12 13:45), Bjorn Helgaas wrote:
>>> [+cc Vivek, Haren; sorry I didn't think to add you earlier]
>>>
>>> On Tue, Jun 11, 2013 at 12:08 AM, Takao Indoh
>>> <indou.takao@jp.fujitsu.com> wrote:
>>>> (2013/06/11 11:20), Bjorn Helgaas wrote:
>>>
>>>>> I'm not sure you need to reset legacy devices (or non-PCI devices)
>>>>> yet, but the current hook isn't anchored anywhere -- it's just an
>>>>> fs_initcall() that doesn't give the reader any clue about the
>>>>> connection between the reset and the problem it's solving.
>>>>>
>>>>> If we do something like this patch, I think it needs to be done at the
>>>>> point where we enable or disable the IOMMU.  That way, it's connected
>>>>> to the important event, and there's a clue about how to make
>>>>> corresponding fixes for other IOMMUs.
>>>>
>>>> Ok. pci_iommu_init() is appropriate place to add this hook?
>>>
>>> I looked at various IOMMU init places today, and it's far more
>>> complicated and varied than I had hoped.
>>>
>>> This reset scheme depends on enumerating PCI devices before we
>>> initialize the IOMMU used by those devices.  x86 works that way today,
>>> but not all architectures do (see the sparc pci_fire_pbm_init(), for
>>
>> Sorry, could you tell me which part depends on architecture?
> 
> Your patch works if PCIe devices are reset before the kdump kernel
> enables the IOMMU.  On x86, this is possible because PCI enumeration
> happens before the IOMMU initialization.  On sparc, the IOMMU is
> initialized before PCI devices are enumerated, so there would still be
> a window where ongoing DMA could cause an IOMMU error.

Ok, understood, thanks.

Hmmm, it seems to be difficult to find out method which is common to
all architectures. So, what I can do for now is introducing reset scheme
which is only for x86.

1) Change this patch so that it work only on x86 platform. For example
   call this reset code from x86_init.iommu.iommu_init() instead of
   fs_initcall.

Or another idea is:

2) Enumerate PCI devices in IOMMU layer. That is:
   PCI layer
     Just provide interface to reset given strcut pci_dev. Maybe
     pci_reset_function() looks good for this purpose.
   IOMMU layer
     Determine which devices should be reset. On kernel boot, check if
     IOMMU is already active or not, and if active, check IOMMU page
     table and reset devices whose entry exists there.

> Of course, it might be possible to reorganize the sparc code to to the
> IOMMU init *after* it enumerates PCI devices.  But I think that change
> would be hard to justify.
> 
> And I think even on x86, it would be better if we did the IOMMU init
> before PCI enumeration -- the PCI devices depend on the IOMMU, so
> logically the IOMMU should be initialized first so the PCI devices can
> be associated with it as they are enumerated.

So third idea is:

3) Do reset before PCI enumeration(arch_initcall_sync or somewhere). We
   need to implement new code to enumerate PCI devices and reset them
   for this purpose.

Idea 2 is not difficult to implement, but one problem is that this
method may be dangerous. We need to scan IOMMU page table which is used
in previous kernel, but it may be broken. Idea 3 seems to be difficult
to implement...


> 
>>> example).  And I think conceptually, the IOMMU should be enumerated
>>> and initialized *before* the devices that use it.
>>>
>>> So I'm uncomfortable with that aspect of this scheme.
>>>
>>> It would be at least conceivable to reset the devices in the system
>>> kernel, before the kexec.  I know we want to do as little as possible
>>> in the crashing kernel, but it's at least a possibility, and it might
>>> be cleaner.
>>
>> I bet this will be not accepted by kdump maintainer. Everything in panic
>> kernel is unreliable.
> 
> kdump is inherently unreliable.  The kdump kernel doesn't start from
> an arbitrary machine state.  We don't expect it to tolerate all CPUs
> running, for example.  Maybe it should be expected to tolerate PCI
> devices running, either.

What I wanted to say is that any resources of first kernel are
unreliable. Under panic situation, struct pci_dev tree may be broken, or
pci_lock may be already hold by someone, etc. So, if we do this in first
kernel, maybe kdump needs its own code to enumerate PCI devices and
reset them.

Vivek?

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
