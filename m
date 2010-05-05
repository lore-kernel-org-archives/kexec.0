Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O9VnC-0001OE-OK
	for kexec@lists.infradead.org; Wed, 05 May 2010 04:01:03 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec-tools: don't include every archs Makefile
In-reply-to: <20100505033123.GB2612@verge.net.au>
References: <15110.1273024133@neuling.org> <15472.1273024270@neuling.org>
	<20100505033123.GB2612@verge.net.au>
Date: Wed, 05 May 2010 14:00:58 +1000
Message-ID: <16571.1273032058@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org



In message <20100505033123.GB2612@verge.net.au> you wrote:
> On Wed, May 05, 2010 at 11:51:10AM +1000, Michael Neuling wrote:
> > This patches changes the kexec/Makefile to only include the required
> > arch Makefile.  
> > 
> > Including all arch Makefiles causes unexpected results as changing one
> > archs Makefile effects all other archs.
> > 
> > ppc64 recently broke surprisingly because
> > 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
> > improvements" added "CFLAGS +=-Wall -Werror" to
> > kexec/arch/mips/Makefile.  This shouldn't happen.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > Horms: Tested by compiling on x86 and ppc64, but probably needs
> > testing on other archs before being committed.
> 
> Unfortunately this breaks make tarball - only kexec/arch/$ARCH is
> included in the tarball.

I figured it might break something :-)

BTW make tarball works here.

> Perhaps we could introduce $(ARCH)_FLAGS, which I think is
> consistent with the handling of other variables by the kexec build.

Seems like a bit of a band aid.

It still seems pretty broken that we use arch/mips/Makefile for ppc64.

Looking at 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 and trying to work
out how it broke ppc64 was pretty annoying.

Mikey


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
