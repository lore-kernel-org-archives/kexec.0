Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NhfGc-0005dS-PH
	for kexec@lists.infradead.org; Wed, 17 Feb 2010 08:28:23 +0000
Date: Wed, 17 Feb 2010 09:28:12 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: powerpc32 support with device tree
Message-ID: <20100217082812.GA7889@Chamillionaire.breakpoint.cc>
References: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
	<20100217075420.GC27742@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100217075420.GC27742@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Kumar Gala <galak@kernel.crashing.org>

* Simon Horman | 2010-02-17 18:54:20 [+1100]:

>Hi Sebastian,
Hi Simon,

>sorry for taking so long to respond to your email.
>There are some minor problems with your patchset
>
>1) The last patch breaks the build if zlib isn't installed.
>   Please use HAVE_ZLIB or something similar to resolve this.
Okay.

>2) Patch 3 breaks the built although that is fixed by patch 4.
>   I think I'll let this slip as you're importing code and then
>   fixing it and that seems like a reasonable thing to do in this case.

I can't think how I break the build and fix it by patch 4 but I will at
this.

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
