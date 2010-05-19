Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OEX3s-0004pH-IO
	for kexec@lists.infradead.org; Wed, 19 May 2010 00:23:01 +0000
Date: Wed, 19 May 2010 09:22:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch] ppc: Fix gamecube build
Message-ID: <20100519002255.GD8536@verge.net.au>
References: <20100513152519.GA4143@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100513152519.GA4143@verge.net.au>
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
To: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Cc: Maxim Uvarov <muvarov@gmail.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

On Fri, May 14, 2010 at 12:25:19AM +0900, Simon Horman wrote:
> This fixes the kexec-build on ppc32 when
> the --game-cube option is supplied to ./configure.
> It seems to have bit-rotted a little.
> 
> Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Cc: Maxim Uvarov <muvarov@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

I have gone ahead and applied this change.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
