Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JvzFe-0003xR-Mk
	for kexec@lists.infradead.org; Tue, 13 May 2008 18:29:27 +0000
Date: Tue, 13 May 2008 11:24:23 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH] Add --reuse-cmdline
Message-ID: <20080513182423.GA18392@nlxdcldnl2.cl.intel.com>
References: <20080508204943.GA24160@suse.de> <19164.1210353205@neuling.org>
	<20080512153849.74753e71@kopernikus.site>
	<17602.1210621437@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17602.1210621437@neuling.org>
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
To: Michael Neuling <mikey@neuling.org>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

On Mon, May 12, 2008 at 02:43:57PM -0500, Michael Neuling wrote:
> In message <20080512153849.74753e71@kopernikus.site> you wrote:
> 
> Sorry, I think I was mistaken.  ppc64 only takes the "root=<blah>" from
> the first kernel, provided it's not specified on the kexec command line
> for the next kernel.
> 
> Anyway, the code is in kexec/arch/ppc64/fs2dt.c (search for "root=")

Externally to kexec(8), I copy the console keyword under the same
circumstances, e.g., it has not been explicitly set.

> > > Either way, this should probably be a generic option, not x86 specific.
> > 
> > Well, I thought first of it. But since the '--append' parameter is not
> > generic, this makes no sense.
> > 
> > Maybe it would make sense to change the command line handling in
> > general to be global and not image specific, but first I need to
> > understand how that works on PPC64 ... (and probably others).
> 
> Yeah, the cmdline should be generically and consistently handled rather
> than what we have now.

The problem is that not all boot options are always usable in the next
kernel, in addition to being architecturally specific, it's very
situational.  Having written that, a generic framework could be usable.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
