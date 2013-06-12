Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-x229.google.com ([2607:f8b0:4003:c02::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Umcwm-0004Dk-0g
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 04:46:12 +0000
Received: by mail-oa0-f41.google.com with SMTP id n10so2099015oag.0
 for <kexec@lists.infradead.org>; Tue, 11 Jun 2013 21:45:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51B6BEDB.3000509@jp.fujitsu.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
 <CAErSpo4t_2Xw76p3Z9FVzyyK-MBovavDu9D=pYoPMjESSxgT=w@mail.gmail.com>
 <51B19DF3.2070009@jp.fujitsu.com>
 <CAErSpo6dfEnzriHD_aWZB_3E-kSzauhNRHPd+VuFX5HONVKgqw@mail.gmail.com>
 <51B6BEDB.3000509@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Jun 2013 22:45:27 -0600
Message-ID: <CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
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
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Don Dutile <ddutile@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, ishii.hironobu@jp.fujitsu.com, bill.sumner@hp.com

[+cc Vivek, Haren; sorry I didn't think to add you earlier]

On Tue, Jun 11, 2013 at 12:08 AM, Takao Indoh
<indou.takao@jp.fujitsu.com> wrote:
> (2013/06/11 11:20), Bjorn Helgaas wrote:

>> I'm not sure you need to reset legacy devices (or non-PCI devices)
>> yet, but the current hook isn't anchored anywhere -- it's just an
>> fs_initcall() that doesn't give the reader any clue about the
>> connection between the reset and the problem it's solving.
>>
>> If we do something like this patch, I think it needs to be done at the
>> point where we enable or disable the IOMMU.  That way, it's connected
>> to the important event, and there's a clue about how to make
>> corresponding fixes for other IOMMUs.
>
> Ok. pci_iommu_init() is appropriate place to add this hook?

I looked at various IOMMU init places today, and it's far more
complicated and varied than I had hoped.

This reset scheme depends on enumerating PCI devices before we
initialize the IOMMU used by those devices.  x86 works that way today,
but not all architectures do (see the sparc pci_fire_pbm_init(), for
example).  And I think conceptually, the IOMMU should be enumerated
and initialized *before* the devices that use it.

So I'm uncomfortable with that aspect of this scheme.

It would be at least conceivable to reset the devices in the system
kernel, before the kexec.  I know we want to do as little as possible
in the crashing kernel, but it's at least a possibility, and it might
be cleaner.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
