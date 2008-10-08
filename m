Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnhfW-0007c4-OM
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 22:38:11 +0000
Date: Thu, 9 Oct 2008 09:38:09 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Cross compile?
Message-ID: <20081008223808.GM16178@verge.net.au>
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<20080521054705.GA3714@verge.net.au>
	<20080527144004.GA9884@nlxdcldnl2.cl.intel.com>
	<200806041042.06607.jk@ozlabs.org>
	<20080609151702.GB10743@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080609151702.GB10743@nlxdcldnl2.cl.intel.com>
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
To: Jeremy Kerr <jk@ozlabs.org>, kexec@lists.infradead.org, "Lombard, David N" <dnlombar@ichips.intel.com>

On Mon, Jun 09, 2008 at 08:17:02AM -0700, Lombard, David N wrote:
> On Wed, Jun 04, 2008 at 10:42:06AM +0800, Jeremy Kerr wrote:
> > Hi David,
> > 
> > (sorry about the late reply, been on holidays for the last 3 weeks..)
> > 
> > > ./configure --build=`uname -m`-linux-uclibc \
> > >           --host=`uname -m` --prefix=/home/dnl/kboot-11/root \
> > >           CC=uclibc-gcc BUILD_CC=host-gcc
> > 
> > Ah, there's the problem. You're specifying CC on the configure line, 
> > which is overriding it for *everything*. Which is why the 
> > CC=$(BUILD_CC) assignment in util/Makefile isn't working for you.
> 
> I'm perfectly happy to admit I've horked this...
> 
> > I'll see if I can work out a proper fix...
> > 
> > Also, why are you setting --build to -uclibc?
> 
> Some of the above came from kboot; everything else is my own fault :)
> 
> kexec is being built on a glibc-based x86 for use on a uclibc-based
> x86.

I know that this is a bit of a blast from the past,
but I believe that this has been fixed by Jeremy.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
