Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PQNi1-0006zL-P6
	for kexec@lists.infradead.org; Wed, 08 Dec 2010 17:21:42 +0000
Date: Wed, 8 Dec 2010 12:21:36 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] Update MCP55 quirk to not affect non HyperTransport
	variants
Message-ID: <20101208172136.GK11454@hmsreliant.think-freely.org>
References: <1291819668-15624-1-git-send-email-nhorman@tuxdriver.com>
	<20101208164423.GH31703@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101208164423.GH31703@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>

On Wed, Dec 08, 2010 at 11:44:23AM -0500, Vivek Goyal wrote:
> On Wed, Dec 08, 2010 at 09:47:48AM -0500, Neil Horman wrote:
> > I wrote this quirk awhile ago to properly setup MCP55 chips on hypertra=
nsport
> > busses so that interrupts reached whatever cpu happend to boot the kdum=
p kernel.
> > while that works well, it was recently shown to me that a a non-hypertr=
ansport
> > variant of the MCP55 exists, and on those system the register that this=
 quirk
> > manipulates causes hangs if you write to it.  Since the quirk was only =
meant to
> > handle errors found on MCP55 chips that have a HT interface, this patch=
 adds a
> > filter to make sure the chip is an HT capable before making the needed =
register
> > adjustment.  This lets the broken MCP55s work with kdump while not brea=
king the
> > non-HT variants.
> > =

> =

> So Neil, with non hypertransport MCP55s, interrupts are delivered to
> all the cpus and seond kernel still boots?
> =

I cannot guarantee that.  All that I can guarantee is that, on MCP55 chips
without hypertransport capability, the register which is used to configure
interrupt delivery is either non-existant, or different in such a way that
writing to it results in a hang on the boot of the initial kernel.  So this
quirk has no effect on kdumps behavior regardless of the interrupt delivery
behavior on such variants of the chip.  I would presume however, given that=
 this
register is so different that interrupts would be delivered to all cpus, as=
 one
would expect.  Mathieu, since you have the affected hardware, could you att=
empt
to preform a kexec operation and tell us for certain?  Thanks!
Neil

> Acked-by: Vivek Goyal <vgoyal@redhat.com>
> =

> Thanks
> Vivek
> =

> > Resolves https://bugzilla.kernel.org/show_bug.cgi?id=3D23952
> > =

> > Tested successfully by the reporter and myself.
> > =

> > Reported-by: Mathieu B=E9rard <mathieu@mberard.eu>
> > CC: linux-pci@vger.kernel.org
> > CC: kexec@lists.infradead.org
> > CC: Vivek Goyal <vgoyal@redhat.com>
> > CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > ---
> >  drivers/pci/quirks.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > =

> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 6f9350c..313c0bd 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2329,6 +2329,9 @@ static void __devinit nvbridge_check_legacy_irq_r=
outing(struct pci_dev *dev)
> >  {
> >  	u32 cfg;
> >  =

> > +	if (!pci_find_capability(dev, PCI_CAP_ID_HT))
> > +		return;
> > +
> >  	pci_read_config_dword(dev, 0x74, &cfg);
> >  =

> >  	if (cfg & ((1 << 2) | (1 << 15))) {
> > -- =

> > 1.7.2.3
> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
