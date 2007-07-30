Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IFZtZ-00075T-45
	for kexec@lists.infradead.org; Mon, 30 Jul 2007 14:23:06 -0400
Date: Mon, 30 Jul 2007 11:22:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] Debug handling of early spurious interrupts
Message-Id: <20070730112223.7b52cf63.akpm@linux-foundation.org>
In-Reply-To: <1185789494.9831.107.camel@sebastian.kern.oss.ntt.co.jp>
References: <1184666997.5271.5.camel@sebastian.kern.oss.ntt.co.jp>
	<20070718154659.c8b5ffea.akpm@linux-foundation.org>
	<1184896459.27369.36.camel@sebastian.kern.oss.ntt.co.jp>
	<1184896944.27369.50.camel@sebastian.kern.oss.ntt.co.jp>
	<1184898043.28418.3.camel@sebastian.kern.oss.ntt.co.jp>
	<20070720144302.2785e961.akpm@linux-foundation.org>
	<1185789494.9831.107.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, 30 Jul 2007 18:58:14 +0900
Fernando Luis V__zquez Cao <fernando@oss.ntt.co.jp> wrote:

> > 
> > So bad things might happen because of this change.  And if they do, they
> > will take a loooong time to be discovered, because non-shared interrupt
> > handlers tend to dwell in crufty old drivers which not many people use.
> > 
> > So I'm wondering if it would be more prudent to only do all this for shared
> > handlers?
> 
> I have been testing this patches on all my machines, which spans three
> different architectures: i386, x86_64 (EM64T and Opteron), and ia64.
> 
> The good news is that nothing catastrophic happened and, in the process,
> I managed to find some somewhat buggy interrupt handlers.
> 
> I will present a brief summary of my findings here.

That's quite a lot of breakage for such a small sample of machines.  I do
suspect that if we were to merge this lot into mainline, all sorts of bad
stuff would happen.

otoh, as you point out, pretty much everthing which goes wrong is due to
incorrect or dubious driver behaviour, and there is value in weeding these
things out. 

But the problem with this process is that we're weeding things out at
runtime.  Some drivers don't get used by many people and users of some
architectures (esp embedded) tend to lag kernel.org by a long time.  So it
could be years before all the fallout from this change is finally wrapped
up.

> 
> If we find drivers that are not fixable we should probably consider this
> new behaviour on a per-driver basis, as Andrew suggested.

We haven't found any such yet, have we?

> This would
> probably require passing a new flag into request_irq. Besides, when such
> a driver is detected we should emit a warning that it may not work
> properly in a kdump kernel.
> 
> I would appreciate your comments on this.

Oh well, let's just keep maintaining it in -mm for now, gather more
information so that we can make a more informed decision later on.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
