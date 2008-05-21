Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JymWK-0000YA-BZ
	for kexec@lists.infradead.org; Wed, 21 May 2008 11:30:12 +0000
Date: Wed, 21 May 2008 13:30:48 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Add --reuse-cmdline
Message-ID: <20080521133048.7bf4082f@halley.suse.de>
In-Reply-To: <20080513182423.GA18392@nlxdcldnl2.cl.intel.com>
References: <20080508204943.GA24160@suse.de> <19164.1210353205@neuling.org>
	<20080512153849.74753e71@kopernikus.site>
	<17602.1210621437@neuling.org>
	<20080513182423.GA18392@nlxdcldnl2.cl.intel.com>
Mime-Version: 1.0
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
Cc: Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org

* Lombard, David N [2008-05-13 11:24]:
>
> The problem is that not all boot options are always usable in the next
> kernel, in addition to being architecturally specific, it's very
> situational.  Having written that, a generic framework could be usable.

Yes. I think that the framework to read out the command line and filter
out options like crashkernel that *never* make sense should be
architecture independent. Then architecture specific code could make
the rest.


	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
