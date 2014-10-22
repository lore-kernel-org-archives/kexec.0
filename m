Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qc0-x230.google.com ([2607:f8b0:400d:c01::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XglUP-0004Z7-9x
 for kexec@lists.infradead.org; Wed, 22 Oct 2014 02:17:30 +0000
Received: by mail-qc0-f176.google.com with SMTP id r5so2054608qcx.7
 for <kexec@lists.infradead.org>; Tue, 21 Oct 2014 19:17:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140702133258.GN26537@8bytes.org>
References: <1398386198-19304-1-git-send-email-bill.sumner@hp.com>
 <1398854973.12733.23.camel@i7.infradead.org>
 <20140702133258.GN26537@8bytes.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 21 Oct 2014 20:16:46 -0600
Message-ID: <CAErSpo69VmK5zD-ztNVHCA=KrK8zucqubY17z0K3rcpe6ReNUA@mail.gmail.com>
Subject: Re: [PATCH 0/8] iommu/vt-d: Fix crash dump failure caused by legacy
 DMA/IO
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
To: Joerg Roedel <joro@8bytes.org>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, Baoquan He <bhe@redhat.com>, "Vaden, Tom L (HP Server OS Architecture)" <tom.vaden@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Hoemann,
 Jerry" <jerry.hoemann@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Zhen-Hua <zhen-hual@hp.com>, doug.hatch@hp.com, "ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>, zhenhua@hp.com, David Woodhouse <dwmw2@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

[-cc Bill, +cc Zhen-Hua, Eric, Tom, Jerry]

Hi Joerg,

I was looking at Zhen-Hua's recent patches, trying to figure out if I
need to do anything with them.  Resetting devices in the old kernel
seems like a non-starter.  Resetting devices in the new kernel, ...,
well, maybe.  It seems ugly, and it seems like the sort of problem
that IOMMUs are designed to solve.  Anyway, I found this old
discussion that I didn't quite understand:

On Wed, Jul 2, 2014 at 7:32 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Apr 30, 2014 at 11:49:33AM +0100, David Woodhouse wrote:

>> After the last round of this patchset, we discussed a potential
>> improvement where you point every virtual bus address at the *same*
>> physical scratch page.
>
> That is a solution to prevent the in-flight DMA failures. But what
> happens when there is some in-flight DMA to a disk to write some inodes
> or a new superblock. Then this scratch address-space may cause
> filesystem corruption at worst.

This in-flight DMA is from a device programmed by the old kernel, and
it would be reading data from the old kernel's buffers.  I think
you're suggesting that we might want that DMA read to complete so the
device can update filesystem metadata?

I don't really understand that argument.  Don't we usually want to
stop any data from escaping the machine after a crash, on the theory
that the old kernel is crashing because something is catastrophically
wrong and we may have already corrupted things in memory?  If so,
allowing this old DMA to complete is just as likely to make things
worse as to make them better.

Without kdump, we likely would reboot through the BIOS and the device
would get reset and the DMA would never happen at all.  So if we made
the dump kernel program the IOMMU to prevent the DMA, that seems like
a similar situation.

> So with this in mind I would prefer initially taking over the
> page-tables from the old kernel before the device drivers re-initialize
> the devices.

This makes the dump kernel more dependent on data from the old kernel,
which we obviously want to avoid when possible.

I didn't find the previous discussion where pointing every virtual bus
address at the same physical scratch page was proposed.  Why was that
better than programming the IOMMU to reject every DMA?

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
