Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 11 Jun 2020 18:03:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH][v2] iommu: arm-smmu-v3: Copy SMMU table for kdump kernel
Message-ID: <20200611230323.GA1616315@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ2QiJJ58nWe_vpjLWoFuM7s-7f7H-40q-4r-aGqorKPy9EPQw@mail.gmail.com>
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
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, Myron Stowe <myron.stowe@redhat.com>, Vijay Mohan Pandarathil <vijaymohan.pandarathil@hp.com>, Marc Zyngier <maz@kernel.org>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, Prabhakar Kushwaha <pkushwaha@marvell.com>, Will Deacon <will@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sun, Jun 07, 2020 at 02:00:35PM +0530, Prabhakar Kushwaha wrote:
> On Thu, Jun 4, 2020 at 5:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jun 03, 2020 at 11:12:48PM +0530, Prabhakar Kushwaha wrote:
> > > On Sat, May 30, 2020 at 1:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, May 29, 2020 at 07:48:10PM +0530, Prabhakar Kushwaha wrote:
<snip>

> > > > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > > > index 117c0a2b2ba4..26b908f55aef 100644
> > > > > --- a/drivers/pci/pcie/err.c
> > > > > +++ b/drivers/pci/pcie/err.c
> > > > > @@ -66,6 +66,20 @@ static int report_error_detected(struct pci_dev *dev,
> > > > >                 if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> > > > >                         vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> > > > >                         pci_info(dev, "can't recover (no
> > > > > error_detected callback)\n");
> > > > > +
> > > > > +                       pci_save_state(dev);
> > > > > +                       pci_cfg_access_lock(dev);
> > > > > +
> > > > > +                       /* Quiesce the device completely */
> > > > > +                       pci_write_config_word(dev, PCI_COMMAND,
> > > > > +                             PCI_COMMAND_INTX_DISABLE);
> > > > > +                       if (!__pci_reset_function_locked(dev)) {
> > > > > +                               vote = PCI_ERS_RESULT_RECOVERED;
> > > > > +                               pci_info(dev, "recovered via pci level
> > > > > reset\n");
> > > > > +                       }
> >
> > So I guess we *do* need to save the state before the reset and restore
> > it (either that or enumerate the device from scratch just like we
> > would if it had been hot-added).  I'm not really thrilled with trying
> > to save the state after the device has already reported an error.  I'd
> > rather do it earlier, maybe during enumeration, like in
> > pci_init_capabilities().  But I don't understand all the subtleties of
> > dev->state_saved, so that requires some legwork.
> 
> I tried moving pci_save_state earlier. All observations are the same
> as mentioned in earlier discussions.

By "legwork", I didn't mean just trying things to see whether they
seem to work.  I meant researching the history to find out *why* it's
designed the way it is so that when we change it, we don't break
things.

For example, these commits are obviously important to understand:

  aa8c6c93747f ("PCI PM: Restore standard config registers of all devices early")
  c82f63e411f1 ("PCI: check saved state before restore")
  4b77b0a2ba27 ("PCI: Clear saved_state after the state has been restored")

I think we need to step back and separate this AER issue from the
whole SMMU table copying thing.  Then do the research and start a
new thread with a patch to fix just the AER issue.

The ARM guys would probably be grateful to be dropped from the AER
thread because it really has nothing to do with ARM.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
