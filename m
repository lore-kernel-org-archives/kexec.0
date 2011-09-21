Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R6Kyq-0008PG-9f
	for kexec@lists.infradead.org; Wed, 21 Sep 2011 11:28:45 +0000
Date: Wed, 21 Sep 2011 20:28:37 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec 2.0.2 MIPS
Message-ID: <20110921112837.GF17108@verge.net.au>
References: <F9C551623D2CBB4C9488801D14F864C607154A@ex-mb1.corp.adtran.com>
	<20110920085133.GE15087@verge.net.au>
	<F9C551623D2CBB4C9488801D14F864C6072473@ex-mb1.corp.adtran.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <F9C551623D2CBB4C9488801D14F864C6072473@ex-mb1.corp.adtran.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Cc: Maxim Uvarov <muvarov@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Matt Evans <matt@ozlabs.org>

On Wed, Sep 21, 2011 at 03:45:21AM +0000, ANDY KENNEDY wrote:
> > On Mon, Sep 19, 2011 at 08:14:21PM +0000, ANDY KENNEDY wrote:
> > > Guys, sorry for the long lines on that last e-mail attempt.
> > > I, unfortunately, have to use LookOut at work.  This is a
> > > better formatted message:
> > >
> > > Attempting to make kexec work for Mips32r2.  2.0.1 works, 2.0.2
> > > doesn't.  Looking through the differences of the arch/mips
> > folders
> > > I find that there is a reference to an extern simple_setup_start.
> > > In 2.0.1 this appears to be referencing asm code from the file
> > > simple_setup_start.S, however, in 2.0.2 I cannot find the
> > > referenced location.
> > >
> > > Is this the reason that I cannot get a Linux kernel to boot using
> > > 2.0.2 using the same command line as the 2.0.1?
> > 
> > Hi Andy,
> > 
> > I'm a little unsure why it is that your platform broke between
> > 2.0.1
> > and 2.0.2. And I'm even less sure what simple_setup_start is/was
> > (I don't see it in 2.0.1 or 2.0.2 or the current master branch).
> > 
> > However, I do have a few suggestions.
> > 
> > 1. Is it possible for you to try the latest development tree?
> >    It is available at git://github.com/horms/kexec-tools.git while
> >    kernel.org is on holidays.
> 
> Eh, best way to get time is to claim you don't have it.
> 
> Done.  Doesn't work.  The only way I could get 2.0.1 to work was via
> the following command:
> kexec -l -f vmlinux # vmlinuz works too.
> With this command, I get a Booted Linux system quickly.  With 2.0.2+,
> however, I get blackness.  It never even kernel panics (I've left it
> accidentally for 6 hours, no change).
> 
> So, I haven't dug into the WHY yet, but it is late and it probably
> won't happen tonight.
> 
> If I get it to work with >2.0.1, I'll make a patch and send it in.
> 
> > 
> > 2. If that doesn't work is it possible for your to perform a git
> >    bisection between 2.0.2 and 2.0.3? I don't imagine that should
> >    take a great deal of time.
> 
> Not a big git user, so I don't know what this would do for me.
> 
> However, since neither 2.0.2 NOR 2.0.3 work, shouldn't it be more
> like 2.0.1 and 2.0.2?  Let me know what you want me to do (spoon
> feed me the git command{,s}) and I'll try it.

My bad, yes the idea is to check between 2.0.1 and 2.0.2.
I will explain git bisect further down. However, it looking at the logs
it strikes me that there was only one significant MIPS change between
2.0.1 and 2.0.2. So that seems like a likely culprit.

Could you try the following?

$ git clone git://github.com/horms/kexec-tools.git
$ cd kexec-tools
$ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17^

Build and see if it works. If so could you then try?

$ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17

Build and see if it works. If it does not then
revision 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 starts to smell
a lot like the cause of the problem you have observed.


Git Bisect
----------

A git bisection works by doing a binary search over a set of commits
in order to (hopefully) isolate which commit introduces a regression.

To this, the git commands are something along these lines:

$ git clone git://github.com/horms/kexec-tools.git
$ cd kexec-tools
$ git checkout v2.0.1

Build and confirm that it does work

$ git checkout v2.0.2

Build and confirm that it does not work.

Now we actually start the bisect

$ git bisect start
$ git bisect bad v2.0.2
$ git bisect good v2.0.1

Git should now select a revision between v2.0.1 and v2.0.2
Test it and see if it works or not. If it does run

$ git bisect good
If not run

$ git bisect bad

Git will now select another revision for you to test...





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
