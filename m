Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V4mTp-0007OX-KZ
 for kexec@lists.infradead.org; Thu, 01 Aug 2013 06:35:23 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A395E3EE0B6
 for <kexec@lists.infradead.org>; Thu,  1 Aug 2013 15:34:45 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 91DEB45DE52
 for <kexec@lists.infradead.org>; Thu,  1 Aug 2013 15:34:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7860245DE4E
 for <kexec@lists.infradead.org>; Thu,  1 Aug 2013 15:34:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 677331DB803F
 for <kexec@lists.infradead.org>; Thu,  1 Aug 2013 15:34:45 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 191BF1DB802F
 for <kexec@lists.infradead.org>; Thu,  1 Aug 2013 15:34:45 +0900 (JST)
Message-ID: <51FA015E.10901@jp.fujitsu.com>
Date: Thu, 01 Aug 2013 15:34:06 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
 <51F85BCC.2070103@jp.fujitsu.com>
 <CAErSpo4yJ2yqCWv7GT7jWSVd_8SktU=xJXT78m8Vxp_wLA4Fow@mail.gmail.com>
 <1699397.FXoFYIGzbk@vostro.rjw.lan>
In-Reply-To: <1699397.FXoFYIGzbk@vostro.rjw.lan>
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
Cc: alex.williamson@redhat.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, bill.sumner@hp.com, ishii.hironobu@jp.fujitsu.com, vgoyal@redhat.com

(2013/08/01 6:23), Rafael J. Wysocki wrote:
> On Wednesday, July 31, 2013 03:08:03 PM Bjorn Helgaas wrote:
>> [+cc Rafael, linux-acpi]
>>
>> On Tue, Jul 30, 2013 at 6:35 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>>
>>> On x86, currently IOMMU initialization run *after* PCI enumeration, but
>>> what you are talking about is that it should be changed so that x86
>>> IOMMU initialization is done *before* PCI enumeration like sparc, right?
>>
>> Yes.  I don't know whether or when that initialization order will ever
>> be changed, but I do think we should avoid building more
>> infrastructure that depends on the current order.
>>
>> Changing the order is a pretty big deal because it's a lot more than
>> just the IOMMU.  Basically I think we should be enumerating ACPI
>> devices, including the IOMMU, before PCI devices, but there's a lot of
>> legacy involved in that area.  Added Rafael in case he has any
>> thoughts.
> 
> Well, actually, I'm not really familiar with IOMMUs, sorry.
> 
> I do think that initializing IOMMU before PCI enumeration would be better,
> however.  At least if the ordering should be the same on all architectures,
> which I suppose is the case, that's the one I'd choose.

Ok guys. If x86 IOMMU maintainer also thinks changing order is
necessary, maybe I need to give up device reset in kdump kernel and
consider doing it in panic kernel.

Either way, I need bus reset interface to reset devices. Bjorn, could
you review the bus reset patches Alex posted yesterday?

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
