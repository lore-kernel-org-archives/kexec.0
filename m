Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TEbz0-0002bd-6l
 for kexec@lists.infradead.org; Thu, 20 Sep 2012 08:19:39 +0000
Message-ID: <1348129173.8212.218.camel@yhuang-dev>
Subject: Re: [RFC 1/3] PCI/PM: Fix kexec for D3cold and bridge suspending
From: Huang Ying <ying.huang@intel.com>
Date: Thu, 20 Sep 2012 16:19:33 +0800
In-Reply-To: <877grpywhy.fsf@xmission.com>
References: <1347872076-5260-1-git-send-email-ying.huang@intel.com>
 <1347872076-5260-2-git-send-email-ying.huang@intel.com>
 <CAErSpo5fVbN2vD5Omc7dGJFWUccYZoCOVRF4YmXPe2Oxm81u5g@mail.gmail.com>
 <877grpywhy.fsf@xmission.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>

On Thu, 2012-09-20 at 00:38 -0700, Eric W. Biederman wrote:
> Bjorn Helgaas <bhelgaas@google.com> writes:
> 
> > +cc Eric and kexec list
> >
> > On Mon, Sep 17, 2012 at 2:54 AM, Huang Ying <ying.huang@intel.com> wrote:
> >> If PCI devices are put into D3cold before kexec, because the
> >> configuration registers of PCI devices in D3cold are not accessible.
> >>
> >> And if PCI bridges are put into low power state before kexec,
> >> configuration registers of PCI devices underneath the PCI bridges are
> >> not accessible too.
> >>
> >> These will make some PCI devices can not be scanned after kexec, so
> >> resume the PCI devices in D3cold or PCI bridges in low power state
> >> before kexec.
> >
> > Don't we need to resume the device even without the kexec issue?  And
> > even if it's in D1 or D2?
> 
> The basic requirement is that the device needs to be visible so we can
> auto discover it.  As I recall most sleep states don't make the device
> invisible and we can handle the rest in the device initializatoin code.

PCI devices in D3cold or under a bridge in D3hot will not be visible, so
we must fix that for kexec to run properly.

> > It looks to me like pci_msi_shutdown() (and probably drv->shutdown())
> > depend on the device being in D0.
> 
> There is certainly a depenency on the config registers being visible.
> Although I don't know if much will go wrong if they aren't.
> 
> Ceratinly pci_msi_shutdown doesn't have anything to do if the device has
> had so much power removed that the device is not even exectuing.

Don't know which power state device should be in for pci_msi_shutdown
etc.  But it appears that normal shutdown/reboot and kexec works at most
times so far.  D3cold and bridge in D3hot works for normal
shutdown/reboot, but not for kexec.  So I write some fix.

Best Regards,
Huang Ying

> >> Signed-off-by: Huang Ying <ying.huang@intel.com>
> >> ---
> >>  drivers/pci/pci-driver.c |    4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -421,6 +421,10 @@ static void pci_device_shutdown(struct d
> >>         struct pci_dev *pci_dev = to_pci_dev(dev);
> >>         struct pci_driver *drv = pci_dev->driver;
> >>
> >> +       /* Resume bridges and devices in D3cold for kexec to work properly */
> >> +       if (pci_dev->current_state == PCI_D3cold || pci_dev->subordinate)
> >> +               pm_runtime_resume(dev);
> >> +
> >>         if (drv && drv->shutdown)
> >>                 drv->shutdown(pci_dev);
> >>         pci_msi_shutdown(pci_dev);
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
