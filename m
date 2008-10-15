Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KpxCc-0003OR-QU
	for kexec@lists.infradead.org; Wed, 15 Oct 2008 03:37:39 +0000
Date: Wed, 15 Oct 2008 14:37:36 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
Message-ID: <20081015033735.GG27243@verge.net.au>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
	<20081008030325.GD22396@verge.net.au>
	<20081012133955.GA7536@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081012133955.GA7536@Chamillionaire.breakpoint.cc>
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
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

On Sun, Oct 12, 2008 at 03:39:55PM +0200, Sebastian Andrzej Siewior wrote:
> * Simon Horman | 2008-10-08 14:03:26 [+1100]:
> 
> >> +#ifdef WITH_GAMECUBE
> >> +static int go_purgatory = 0;
> >> +#else
> >> +static int go_purgatory = 1;
> >> +#endif
> >
> >Can you just use WITH_GAMECUBE inside elf_ppc_load() and remove
> >the need for go_purgatory, or do you plan to make go_purgatory
> >switchable at run-time at some point in the future?

> For the first shot I would prefer to use WITH_GAMECUBE inside of
> elf_ppc_load(). In longterm I don't see any reason why GameCube can't
> use the purgatory code like the other archs and get the memory maps from
> the device tree. However I'm not sure if GameCube still runs on a recent
> kernel: now that arc/ppc isn't available anymore GameCube has to pass a
> dtb somehow and this isn't the case. So therefore I would like the keep
> #ifdef and the exisiting behavior until someone clears this up.

Ok, in this case I would like to request that you remove
go_purgatory (for now) and just use #ifdef WITH_GAMECUBE instead.
I think that it will make things cleaner (for now).

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
