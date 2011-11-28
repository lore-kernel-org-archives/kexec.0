Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RUzj8-0006OO-Q9
 for kexec@lists.infradead.org; Mon, 28 Nov 2011 11:50:27 +0000
Date: Mon, 28 Nov 2011 22:49:49 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] kexec-tools: powerpc: Fix 64bit optimize for size
 (gcc -Os) build
Message-ID: <20111128224949.6b81f8f1@kryten>
In-Reply-To: <20111117234829.GA14082@verge.net.au>
References: <20111114185329.19ddc2b4@kryten>
 <20111114221402.GJ14325@bubble.grove.modra.org>
 <20111115092406.31df5f9e@kryten>
 <20111114223036.GK14325@bubble.grove.modra.org>
 <20111117234829.GA14082@verge.net.au>
Mime-Version: 1.0
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
Cc: Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>, Matt Evans <matt@ozlabs.org>, Alan Modra <amodra@gmail.com>


Hi Horms,

> Hi Alan, Hi Anton, Hi all,
> 
> I am wondering if you are comfortable with me (finally) releasing
> a new version of kexec-tools with this series of patches applied.

Sorry for taking a while to get back to you. I haven't found any more
bugs on the ppc64 side, so I'm definitely comfortable (from a ppc64
perspective).

Anton

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
