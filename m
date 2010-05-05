Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O9YLk-0002Pk-O9
	for kexec@lists.infradead.org; Wed, 05 May 2010 06:44:54 +0000
Date: Wed, 5 May 2010 16:44:45 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: don't include every archs Makefile
Message-ID: <20100505064442.GA2453@verge.net.au>
References: <15110.1273024133@neuling.org> <15472.1273024270@neuling.org>
	<20100505033123.GB2612@verge.net.au> <16571.1273032058@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16571.1273032058@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Neuling <mikey@neuling.org>
Cc: kexec@lists.infradead.org

On Wed, May 05, 2010 at 02:00:58PM +1000, Michael Neuling wrote:
> 
> 
> In message <20100505033123.GB2612@verge.net.au> you wrote:
> > On Wed, May 05, 2010 at 11:51:10AM +1000, Michael Neuling wrote:
> > > This patches changes the kexec/Makefile to only include the required
> > > arch Makefile.  
> > > 
> > > Including all arch Makefiles causes unexpected results as changing one
> > > archs Makefile effects all other archs.
> > > 
> > > ppc64 recently broke surprisingly because
> > > 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
> > > improvements" added "CFLAGS +=-Wall -Werror" to
> > > kexec/arch/mips/Makefile.  This shouldn't happen.
> > > 
> > > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > > ---
> > > Horms: Tested by compiling on x86 and ppc64, but probably needs
> > > testing on other archs before being committed.
> > 
> > Unfortunately this breaks make tarball - only kexec/arch/$ARCH is
> > included in the tarball.
> 
> I figured it might break something :-)
> 
> BTW make tarball works here.
> 
> > Perhaps we could introduce $(ARCH)_FLAGS, which I think is
> > consistent with the handling of other variables by the kexec build.
> 
> Seems like a bit of a band aid.
> 
> It still seems pretty broken that we use arch/mips/Makefile for ppc64.
> 
> Looking at 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 and trying to work
> out how it broke ppc64 was pretty annoying.

I agree that its entirely non-obvious and could be improved :-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
