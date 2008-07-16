Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIuex-00056s-ET
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 00:14:20 +0000
Date: Wed, 16 Jul 2008 10:14:17 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Allow BUILD_CFLAGS and TARGET_CFLAGS to be specified
	at configure time
Message-ID: <20080716001415.GD15703@verge.net.au>
References: <20080715102808.GA29267@verge.net.au>
	<1216123702.433919.719662663715.1.gpush@pingu>
	<20080715122410.GA24840@verge.net.au>
	<200807160958.24783.jk@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200807160958.24783.jk@ozlabs.org>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

Hi Jermemy,

> Hi Horms,
> 
> > Can we get rid of TARGET_CFLAGS? It doesn't seem to be used anywhere.
> 
> We need a way to specify cflags to build things in the target arch (ie,
> purgatory). It looks like we're getting around this by specifying the
> purgatory's cflags in purgatory/arch/$ARCH/Makefile, which I guess is
> ok.
> 
> I'm able to build a powerpc64 kexec to run on a powerpc32 machine,
> which is what I'm after here. I still get a bunch of warnings though:

I'm quite fine with the idea of having TARGET_CFLAGS,
its just that it doesn't seem to be used at this time.
Then again, it isn't doing any harm.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
