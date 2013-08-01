Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V4sDM-0006Uc-99
 for kexec@lists.infradead.org; Thu, 01 Aug 2013 12:42:45 +0000
Message-ID: <1375360934.31262.156.camel@ul30vt.home>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 01 Aug 2013 06:42:14 -0600
In-Reply-To: <51FA015E.10901@jp.fujitsu.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
 <51F85BCC.2070103@jp.fujitsu.com>
 <CAErSpo4yJ2yqCWv7GT7jWSVd_8SktU=xJXT78m8Vxp_wLA4Fow@mail.gmail.com>
 <1699397.FXoFYIGzbk@vostro.rjw.lan> <51FA015E.10901@jp.fujitsu.com>
Mime-Version: 1.0
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
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, bill.sumner@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, vgoyal@redhat.com

On Thu, 2013-08-01 at 15:34 +0900, Takao Indoh wrote:
> (2013/08/01 6:23), Rafael J. Wysocki wrote:
> > On Wednesday, July 31, 2013 03:08:03 PM Bjorn Helgaas wrote:
> >> [+cc Rafael, linux-acpi]
> >>
> >> On Tue, Jul 30, 2013 at 6:35 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
> >>
> >>> On x86, currently IOMMU initialization run *after* PCI enumeration, but
> >>> what you are talking about is that it should be changed so that x86
> >>> IOMMU initialization is done *before* PCI enumeration like sparc, right?
> >>
> >> Yes.  I don't know whether or when that initialization order will ever
> >> be changed, but I do think we should avoid building more
> >> infrastructure that depends on the current order.
> >>
> >> Changing the order is a pretty big deal because it's a lot more than
> >> just the IOMMU.  Basically I think we should be enumerating ACPI
> >> devices, including the IOMMU, before PCI devices, but there's a lot of
> >> legacy involved in that area.  Added Rafael in case he has any
> >> thoughts.
> > 
> > Well, actually, I'm not really familiar with IOMMUs, sorry.
> > 
> > I do think that initializing IOMMU before PCI enumeration would be better,
> > however.  At least if the ordering should be the same on all architectures,
> > which I suppose is the case, that's the one I'd choose.
> 
> Ok guys. If x86 IOMMU maintainer also thinks changing order is
> necessary, maybe I need to give up device reset in kdump kernel and
> consider doing it in panic kernel.
> 
> Either way, I need bus reset interface to reset devices. Bjorn, could
> you review the bus reset patches Alex posted yesterday?

I'll post a non-RFC version today, I've made a couple cleanups, tuned
the delays and rolled in the AER version of secondary bus reset.
Thanks,

Alex



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
