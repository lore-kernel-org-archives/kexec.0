Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyOek-0000d1-UZ
 for kexec@lists.infradead.org; Thu, 23 Jul 2020 00:00:16 +0000
Date: Wed, 22 Jul 2020 19:00:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200723000012.GA1325359@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200722215048.GL220876@anatevka.americas.hpqcorp.net>
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
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: jroedel@suse.de, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, linux-pci@vger.kernel.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Randy Wright <rwright@hpe.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Myron Stowe <myron.stowe@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Wed, Jul 22, 2020 at 03:50:48PM -0600, Jerry Hoemann wrote:
> On Wed, Jul 22, 2020 at 10:21:23AM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 22, 2020 at 10:52:26PM +0800, Kairui Song wrote:

> > > I think I didn't make one thing clear, The PCI UR error never arrives
> > > in kernel, it's the iLo BMC on that HPE machine caught the error, and
> > > send kernel an NMI. kernel is panicked by NMI, I'm still trying to
> > > figure out why the NMI hanged kernel, even with panic=-1,
> > > panic_on_io_nmi, panic_on_unknown_nmi all set. But if we can avoid the
> > > NMI by shutdown the devices in right order, that's also a solution.

ACPI v6.3, chapter 18, does mention NMIs several times, e.g., Table
18-394 and sec 18.4.  I'm not familiar enough with APEI to know
whether Linux correctly supports all those cases.  Maybe this is a
symptom that we don't?

> > I'm not sure how much sympathy to have for this situation.  A PCIe UR
> > is fatal for the transaction and maybe even the device, but from the
> > overall system point of view, it *should* be a recoverable error and
> > we shouldn't panic.
> > 
> > Errors like that should be reported via the normal AER or ACPI/APEI
> > mechanisms.  It sounds like in this case, the platform has decided
> > these aren't enough and it is trying to force a reboot?  If this is
> > "special" platform behavior, I'm not sure how much we need to cater
> > for it.
> 
> Are these AER errors the type processed by the GHES code?

My understanding from ACPI v6.3, sec 18.3.2, is that the Hardware
Error Source Table may contain Error Source Descriptors of types like:

  IA-32 Machine Check Exception
  IA-32 Corrected Machine Check
  IA-32 Non-Maskable Interrupt
  PCIe Root Port AER
  PCIe Device AER
  Generic Hardware Error Source (GHES)
  Hardware Error Notification
  IA-32 Deferred Machine Check

I would naively expect PCIe UR errors to be reported via one of the
PCIe Error Sources, not GHES, but maybe there's some reason to use
GHES.

The kernel should already know how to deal with the PCIe AER errors,
but we'd have to add new device-specific code to handle things
reported via GHES, along the lines of what Shiju is doing here:

  https://lore.kernel.org/r/20200722104245.1060-1-shiju.jose@huawei.com

> I'll note that RedHat runs their crash kernel with:  hest_disable.
> So, the ghes code is disabled in the crash kernel.

That would disable all the HEST error sources, including the PCIe AER
ones as well as GHES ones.  If we turn off some of the normal error
handling mechanisms, I guess we have to expect that some errors won't
be handled correctly.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
