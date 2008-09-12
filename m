Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KeDs6-0005zR-In
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 18:59:58 +0000
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: SetVirtualAddressMap() on Tiano EFI firmware
Date: Fri, 12 Sep 2008 12:59:53 -0600
References: <200809111423.58814.bjorn.helgaas@hp.com>
	<20080911215954.GA3104@nlxdcldnl2.cl.intel.com>
In-Reply-To: <20080911215954.GA3104@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809121259.54155.bjorn.helgaas@hp.com>
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
To: "Lombard, David N" <dnlombar@ichips.intel.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thursday 11 September 2008 03:59:54 pm Lombard, David N wrote:
> On Thu, Sep 11, 2008 at 01:23:58PM -0700, Bjorn Helgaas wrote:
> > Has kexec been tested on x86 with EFI firmware?
> > 
> > I'm testing it on ia64 with Tiano-based EFI firmware, and I
> > tripped over an issue with SetVirtualAddressMap().  I would
> > expect a similar problem to happen on x86, but I don't see
> > any code to deal with it.
> 
> Hmmm.  I run on 32- and 64-bit kernels on a 32-bit IA EFI, and
> haven't seen this problem, including chains of kexec invocations.
> 
> I'll take a closer look at what's going on on my systems.

Thanks.  In case it wasn't clear, here's my confusion about x86:

I don't see anything in kexec-tools that touches SetVirtualAddressMap().
And I don't see anything in Linux that prevents x86 from calling
SetVirtualAddressMap() in the new kernel.

If we do call SetVirtualAddressMap() in the new kernel, I would
expect it to return EFI_UNSUPPORTED, which should cause Linux to
panic.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
