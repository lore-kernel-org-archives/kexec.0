Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga07.intel.com ([143.182.124.22] helo=azsmga101.ch.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KduO4-00020G-RR
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 22:11:41 +0000
Date: Thu, 11 Sep 2008 14:59:54 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: SetVirtualAddressMap() on Tiano EFI firmware
Message-ID: <20080911215954.GA3104@nlxdcldnl2.cl.intel.com>
References: <200809111423.58814.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200809111423.58814.bjorn.helgaas@hp.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Sep 11, 2008 at 01:23:58PM -0700, Bjorn Helgaas wrote:
> Has kexec been tested on x86 with EFI firmware?
> 
> I'm testing it on ia64 with Tiano-based EFI firmware, and I
> tripped over an issue with SetVirtualAddressMap().  I would
> expect a similar problem to happen on x86, but I don't see
> any code to deal with it.

Hmmm.  I run on 32- and 64-bit kernels on a 32-bit IA EFI, and
haven't seen this problem, including chains of kexec invocations.

I'll take a closer look at what's going on on my systems.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
