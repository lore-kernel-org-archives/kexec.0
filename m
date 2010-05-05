Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O9VKc-0000Ra-9A
	for kexec@lists.infradead.org; Wed, 05 May 2010 03:31:32 +0000
Date: Wed, 5 May 2010 13:31:24 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: don't include every archs Makefile
Message-ID: <20100505033123.GB2612@verge.net.au>
References: <15110.1273024133@neuling.org>
 <15472.1273024270@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15472.1273024270@neuling.org>
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

On Wed, May 05, 2010 at 11:51:10AM +1000, Michael Neuling wrote:
> This patches changes the kexec/Makefile to only include the required
> arch Makefile.  
> 
> Including all arch Makefiles causes unexpected results as changing one
> archs Makefile effects all other archs.
> 
> ppc64 recently broke surprisingly because
> 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
> improvements" added "CFLAGS +=-Wall -Werror" to
> kexec/arch/mips/Makefile.  This shouldn't happen.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Horms: Tested by compiling on x86 and ppc64, but probably needs
> testing on other archs before being committed.

Unfortunately this breaks make tarball - only kexec/arch/$ARCH is
included in the tarball.

Perhaps we could introduce $(ARCH)_FLAGS, which I think is
consistent with the handling of other variables by the kexec build.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
