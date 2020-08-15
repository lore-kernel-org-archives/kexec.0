Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6sRK-0005gI-IE
 for kexec@lists.infradead.org; Sat, 15 Aug 2020 09:25:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Date: Sat, 15 Aug 2020 09:25:16 +0000
Message-ID: <2777285d9e224c509e10b8448844f19a@AcuMS.aculab.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
 <20200813115435.GB483@jagdpanzerIV.localdomain>
 <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
 <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
In-Reply-To: <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Joe Perches' <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>

From: Joe Perches
> Sent: 15 August 2020 00:52
...
> > This is why I think any discussion that says "people should buffer
> > their lines themselves and we should get rid if pr_cont()" is
> > fundamentally broken.
> >
> > Don't go down that hole. I won't take it. It's wrong.
> 
> I don't think it's wrong per se.
> 
> It's reasonable to avoid pr_cont when appropriate.
> 
> Trivial buffering, or adding and using YA vsprintf
> extension can avoid unnecessary message interleaving.
> 
> For instance, I just sent this patch to allow removal
> of print_vma_addr and its use of pr_cont.
> 
> https://lore.kernel.org/lkml/09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com/

ISTM that is a bit complex for a printf format.
Even with the 'noinline_for_stack' it is going to
use a lot of stack - and error printfs are already likely
to be near the stack limit.
The recursion for %pV might also cause grief.

In that case formatting the data into an on-stack char[]
before the printf is probably the simplest solution.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
