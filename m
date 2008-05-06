Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JtZbd-0002uR-UY
	for kexec@lists.infradead.org; Wed, 07 May 2008 02:42:11 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] Cross compile?
Date: Wed, 7 May 2008 08:42:22 +1000
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<200805060742.45737.jk@ozlabs.org>
	<20080506133108.GB29182@nlxdcldnl2.cl.intel.com>
In-Reply-To: <20080506133108.GB29182@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200805070842.23111.jk@ozlabs.org>
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
To: kexec@lists.infradead.org
Cc: "Lombard, David N" <dnlombar@plxs0284.pdx.intel.com>, "Lombard,
	David N" <dnlombar@ichips.intel.com>

Hi David,

> Well, note the patch *does* uses those values--it's just the
> assignment doesn't work.

Let's fix the assignment then - it's been working fine here (build = 
i386-linux, host = powerpc-linux, target = powerpc64-linux), so I'd 
like to know what's breaking on your system.

What are you using for CC, BUILD_CC and LDFLAGS?

Cheers,


Jeremy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
