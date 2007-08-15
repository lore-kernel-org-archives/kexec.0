Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ILNq4-0004W3-HX
	for kexec@lists.infradead.org; Wed, 15 Aug 2007 14:43:29 -0400
Date: Wed, 15 Aug 2007 11:44:41 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Message-ID: <20070815184441.GA14161@nlxdcldnl2.cl.intel.com>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070731095101.GA1774@elf.ucw.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kexec@lists.infradead.org

Pavel,

Are you still having problem w/ kexec and the Intel NIC?  What kernel
are you trying to kexec?  There's a problem when placing the e1000
into D3hot when an older kernel is the target of the kexec.  The problem
is manifested by the BARs being 0 in the kexec'd kernel.  We've checked
the PCI specs and believe the e1000 is behaving in a compliant way.  
We've seen this when trying to use kexec to boot any RHEL4 (2.6.9-basis)
kernel; I've not seen it when trying to kexec 2.6.14 or later kernels.

We see work was done in later kernels to properly handle the D3hot to D0
transition that's so problematic to 2.6.9.  And ugly hack that works
around this problem is to not put the NIC in D3hot if we know we're going
to kexec an older kernel--fortunately, this appears to be safe even when a
newer kernel, that doesn't have that problem, is to be started.  I
published that ugly nasty patch to the kboot list as that's the
environment whence we ran into the problem and it only affects older
kernels.

I'll be happy to provide more detail if needed.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
