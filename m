Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RRDyg-0001QG-BX
 for kexec@lists.infradead.org; Fri, 18 Nov 2011 02:14:56 +0000
Date: Fri, 18 Nov 2011 08:48:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] kexec-tools: powerpc: Fix 64bit optimize for size
 (gcc -Os) build
Message-ID: <20111117234829.GA14082@verge.net.au>
References: <20111114185329.19ddc2b4@kryten>
 <20111114221402.GJ14325@bubble.grove.modra.org>
 <20111115092406.31df5f9e@kryten>
 <20111114223036.GK14325@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111114223036.GK14325@bubble.grove.modra.org>
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
To: Alan Modra <amodra@gmail.com>
Cc: Milton Miller <miltonm@bga.com>, Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org, Anton Blanchard <anton@samba.org>, Matt Evans <matt@ozlabs.org>

On Tue, Nov 15, 2011 at 09:00:38AM +1030, Alan Modra wrote:
> On Tue, Nov 15, 2011 at 09:24:06AM +1100, Anton Blanchard wrote:
> > I wonder why we aren't building and linking an -fpic object, wouldn't
> > it make the relocation code much simpler?
> 
> No, powerpc64 is PIC anyway.

Hi Alan, Hi Anton, Hi all,

I am wondering if you are comfortable with me (finally) releasing
a new version of kexec-tools with this series of patches applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
