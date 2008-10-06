Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kmxgb-0005D0-Fc
	for kexec@lists.infradead.org; Mon, 06 Oct 2008 21:32:14 +0000
Date: Tue, 7 Oct 2008 08:32:10 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch] ia64: make PA() work for both physical identity-mapped
	virtual addresses
Message-ID: <20081006213208.GA10959@verge.net.au>
References: <200810060924.04033.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200810060924.04033.bjorn.helgaas@hp.com>
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
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Lombard, David N" <dnlombar@ichips.intel.com>, kexec@lists.infradead.org

On Mon, Oct 06, 2008 at 09:24:03AM -0600, Bjorn Helgaas wrote:
> The EFI Runtime Services Table contains pointers to ia64 function
> descriptors.  On existing, pre-Tiano, firmware, SetVirtualAddressMap()
> converts *all* these pointers from physical to virtual.  On Tiano-based
> firmware, the pointer to the SetVirtualAddressMap() function descriptor
> is not converted, so it remains a physical pointer.
> 
> The ia64 kexec purgatory patches the SetVirtualAddressMap() function
> descriptor so that when the new kernel calls SetVirtualAddressMap(), it
> never reaches firmware.  Instead, it calls a dummy function that just
> returns success.
> 
> Purgatory runs in physical mode, so it must convert the pointer from the
> RuntimeServicesTable to a physical address.  This patch makes that
> conversion work both for old firmware (where the pointer is an identity-
> mapped virtual address) and new Tiano firmware (where the pointer is a
> physical address).
> 
> Without this patch, kexec on Tiano firmware causes an MCA because
> ia64_env_setup() subtracts PAGE_OFFSET from a physical address and ends
> up with an invalid physical address.  Referencing that address causes
> the MCA.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Thanks Bjorn, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
