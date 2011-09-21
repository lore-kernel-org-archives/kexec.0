Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from p02c11o144.mxlogic.net ([208.65.144.77])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R6CzD-00013t-73
	for kexec@lists.infradead.org; Wed, 21 Sep 2011 02:56:36 +0000
From: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Subject: RE: kexec 2.0.2 MIPS
Date: Wed, 21 Sep 2011 02:56:22 +0000
Message-ID: <F9C551623D2CBB4C9488801D14F864C6072467@ex-mb1.corp.adtran.com>
References: <F9C551623D2CBB4C9488801D14F864C607154A@ex-mb1.corp.adtran.com>
	<20110920085133.GE15087@verge.net.au>
In-Reply-To: <20110920085133.GE15087@verge.net.au>
Content-Language: en-US
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Maxim Uvarov <muvarov@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Matt Evans <matt@ozlabs.org>

> > Attempting to make kexec work for Mips32r2.  2.0.1 works, 2.0.2
> > doesn't.  Looking through the differences of the arch/mips
> folders
> > I find that there is a reference to an extern simple_setup_start.
> > In 2.0.1 this appears to be referencing asm code from the file
> > simple_setup_start.S, however, in 2.0.2 I cannot find the
> > referenced location.
> >
> > Is this the reason that I cannot get a Linux kernel to boot using
> > 2.0.2 using the same command line as the 2.0.1?
> 
> Hi Andy,
> 
> I'm a little unsure why it is that your platform broke between
> 2.0.1
> and 2.0.2. And I'm even less sure what simple_setup_start is/was

Well, the reason you didn't see it is because I was apparently
smoking something that day.  The _real_ filename (in the 2.0.1
I just downloaded from you local store) was mips-setup-simple.S.
This file doesn't exist in 2.0.2.  I'll pull the latest and
test it.  If it works for me in mips I'll bump the version in
BuildRoot too.

BTW, the full path for that asm file is:
kexec-tools-2.0.1/kexec/arc/mips/mips-setup-simple.S

Unfortunately, I don't have much time (always the story, no?) as
I have a very important pre-release of what I'm doing with
kexec, so, forgive me if I don't get back to you with this for
a couple of days.

> (I don't see it in 2.0.1 or 2.0.2 or the current master branch).
> 
> However, I do have a few suggestions.
> 
> 1. Is it possible for you to try the latest development tree?
>    It is available at git://github.com/horms/kexec-tools.git while
>    kernel.org is on holidays.
> 
> 2. If that doesn't work is it possible for your to perform a git
>    bisection between 2.0.2 and 2.0.3? I don't imagine that should
>    take a great deal of time.
> 
> I have also CCed Matt Evans who made some of the few changes
> that touched MIPS code between 2.0.2 and 2.0.3.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
