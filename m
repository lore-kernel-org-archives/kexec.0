Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OD4bR-0001nh-0t
	for kexec@lists.infradead.org; Fri, 14 May 2010 23:47:38 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [RFC PATCH] kexec-tools: Fix option/argument parsing
In-reply-to: <20100514133351.GA27254@nlxcldnl2.cl.intel.com>
References: <4BEBB4E8.6080000@ozlabs.org> <20100513144549.GB10534@verge.net.au>
	<5224.1273790243@neuling.org>
	<20100514133351.GA27254@nlxcldnl2.cl.intel.com>
Date: Sat, 15 May 2010 09:39:18 +1000
Message-ID: <22330.1273880358@neuling.org>
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
To: "David N. Lombard" <dnlombar@ichips.intel.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Matt Evans <matt@ozlabs.org>

In message <20100514133351.GA27254@nlxcldnl2.cl.intel.com> you wrote:
> On Thu, May 13, 2010 at 03:37:23PM -0700, Michael Neuling wrote:
> > In message <20100513144549.GB10534@verge.net.au> you wrote:
> > > On Thu, May 13, 2010 at 06:14:32PM +1000, Matt Evans wrote:
> > > > 
> > > > In playing with kexec-tools I've noticed various problems with the argu
ment
> > > > passing, meaning one has to be careful to use certain forms of argument
s
> > > > and present them in a certain order.
> > > > 
> [deletia]
> > > > 
> > > > This behaviour is avoided by using the --opt= forms, but getopt does al
low
> > > > both and hence the user can have a fairly frustrating experience.  (Doi
ng
> > > > something unexpected (ex. 3) is more annoying than an error exit (ex. 1
)
> > > > in many cases.)
> > > > 
> > > 
> > > This seems reasonable to me.
> > > 
> > > I've compiled tested the code on all architectures except cris (I don't
> > > have my build environment at the moment). I found a minor problem on arm
> > > which I have noted below.
> > 
> > I suspect it'll break someones kexec scripts, so maybe we take this
> > patch (or something like it) but bump up the release revision to 2.1?
> > 
> How?
> 
> Command lines that previously worked will continue to work.
> Command lines that should have worked, but didn't, will now work.
> Command lines that shouldn't have worked will still not work.
> 
> The only scripts that may fail are those doing negative testing to
> check for a form that *should* have been allowed--quite clearly, any
> such negative testing was incorrect.

Yeah, and like I said, users are pretty dumb, so put 1 and 1
together... :-)

That being said, I don't have a strong opinion.  If others think it's
unlikely enough that anyone will hit it, then let's keep the release
numbering as it is.

... and I think we all agree we need the patch. 

Mikey


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
