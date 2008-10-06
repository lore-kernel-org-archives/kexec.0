Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kmy8X-0001EV-Lw
	for kexec@lists.infradead.org; Mon, 06 Oct 2008 22:01:06 +0000
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] ia64: make PA() work for both physical identity-mapped
	virtual addresses
Date: Mon, 6 Oct 2008 16:00:49 -0600
References: <200810060924.04033.bjorn.helgaas@hp.com>
	<20081006213208.GA10959@verge.net.au>
In-Reply-To: <20081006213208.GA10959@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810061600.49929.bjorn.helgaas@hp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "Lombard, David N" <dnlombar@ichips.intel.com>, kexec@lists.infradead.org

On Monday 06 October 2008 3:32:10 pm Simon Horman wrote:
> On Mon, Oct 06, 2008 at 09:24:03AM -0600, Bjorn Helgaas wrote:
> > The EFI Runtime Services Table contains pointers to ia64 function
> > descriptors.  On existing, pre-Tiano, firmware, SetVirtualAddressMap()
> > converts *all* these pointers from physical to virtual.  On Tiano-based
> > firmware, the pointer to the SetVirtualAddressMap() function descriptor
> > is not converted, so it remains a physical pointer.
> >
> > The ia64 kexec purgatory patches the SetVirtualAddressMap() function
> > descriptor so that when the new kernel calls SetVirtualAddressMap(), it
> > never reaches firmware.  Instead, it calls a dummy function that just
> > returns success.
> >
> > Purgatory runs in physical mode, so it must convert the pointer from the
> > RuntimeServicesTable to a physical address.  This patch makes that
> > conversion work both for old firmware (where the pointer is an identity-
> > mapped virtual address) and new Tiano firmware (where the pointer is a
> > physical address).
> >
> > Without this patch, kexec on Tiano firmware causes an MCA because
> > ia64_env_setup() subtracts PAGE_OFFSET from a physical address and ends
> > up with an invalid physical address.  Referencing that address causes
> > the MCA.
> >
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> Thanks Bjorn, applied.

Thanks!

Any idea when you'll make another kexec-tools release?  I have a
Red Hat feature request in for RHEL6, and they'll need to know
what kexec-tools version to look for.  RH will get the latest
for RHEL6, but I really don't know when they'll start putting
that together.

https://bugzilla.redhat.com/show_bug.cgi?id=463477

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
