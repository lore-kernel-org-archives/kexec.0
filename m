Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCv1a-00057I-Gi
	for kexec@lists.infradead.org; Fri, 14 May 2010 13:33:59 +0000
Date: Fri, 14 May 2010 06:33:51 -0700
From: "David N. Lombard" <dnlombar@ichips.intel.com>
Subject: Re: [RFC PATCH] kexec-tools: Fix option/argument parsing
Message-ID: <20100514133351.GA27254@nlxcldnl2.cl.intel.com>
References: <4BEBB4E8.6080000@ozlabs.org> <20100513144549.GB10534@verge.net.au>
	<5224.1273790243@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5224.1273790243@neuling.org>
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
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Matt Evans <matt@ozlabs.org>

On Thu, May 13, 2010 at 03:37:23PM -0700, Michael Neuling wrote:
> In message <20100513144549.GB10534@verge.net.au> you wrote:
> > On Thu, May 13, 2010 at 06:14:32PM +1000, Matt Evans wrote:
> > > 
> > > In playing with kexec-tools I've noticed various problems with the argument
> > > passing, meaning one has to be careful to use certain forms of arguments
> > > and present them in a certain order.
> > > 
[deletia]
> > > 
> > > This behaviour is avoided by using the --opt= forms, but getopt does allow
> > > both and hence the user can have a fairly frustrating experience.  (Doing
> > > something unexpected (ex. 3) is more annoying than an error exit (ex. 1)
> > > in many cases.)
> > > 
> > 
> > This seems reasonable to me.
> > 
> > I've compiled tested the code on all architectures except cris (I don't
> > have my build environment at the moment). I found a minor problem on arm
> > which I have noted below.
> 
> I suspect it'll break someones kexec scripts, so maybe we take this
> patch (or something like it) but bump up the release revision to 2.1?
> 
How?

Command lines that previously worked will continue to work.
Command lines that should have worked, but didn't, will now work.
Command lines that shouldn't have worked will still not work.

The only scripts that may fail are those doing negative testing to check for
a form that *should* have been allowed--quite clearly, any such negative testing
was incorrect.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
