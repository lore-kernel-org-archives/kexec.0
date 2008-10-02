Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KlL4G-0005v9-Be
	for kexec@lists.infradead.org; Thu, 02 Oct 2008 10:05:57 +0000
Date: Thu, 2 Oct 2008 20:05:53 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
Message-ID: <20081002100553.GA5886@verge.net.au>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
	<7AB33E84-B8C2-4B32-B1F8-7FA213198FE4@kernel.crashing.org>
	<48E47D38.3040508@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48E47D38.3040508@linutronix.de>
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
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, kexec@lists.infradead.org, Kumar Gala <galak@kernel.crashing.org>

On Thu, Oct 02, 2008 at 09:50:16AM +0200, Sebastian Siewior wrote:
> Kumar Gala wrote:
> 
> > are you trying to get this accepted?
> 
> If the reviewer don't have any objections yes. You sound
> like there is something terrible wrong. Do you want it in smaller pieces?

I'm not speaking on behalf of Kumar Gala, just on behalf of myself.

I would like to get some review of this patch by if possible.
Also, I'm a little unclear of how it will interact with the
patches that Mohan Kumar sent this week. But at this point
I don't see any particular need to break the patch up into
smaller pieices.


-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
