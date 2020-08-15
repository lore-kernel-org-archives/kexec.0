Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]
 helo=smtprelay.hostedemail.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6mYD-0002Ok-Uh
 for kexec@lists.infradead.org; Sat, 15 Aug 2020 03:08:10 +0000
Message-ID: <ccc21619fdee79985f619adeb49bd5713dc97d80.camel@perches.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
From: Joe Perches <joe@perches.com>
Date: Fri, 14 Aug 2020 20:08:02 -0700
In-Reply-To: <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
 <20200813115435.GB483@jagdpanzerIV.localdomain>
 <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
 <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
 <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 2020-08-14 at 19:33 -0700, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 4:52 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> > > This is why I think any discussion that says "people should buffer
> > > their lines themselves and we should get rid if pr_cont()" is
> > > fundamentally broken.
> > > 
> > > Don't go down that hole. I won't take it. It's wrong.
> > 
> > I don't think it's wrong per se.
> 
> It's *absolutely* and 100% wrong.
> 
> Yes, any random *user* of pr_cont() can decide to buffer on it's own.

Which I believe is the point of the discussion,
not the complete removal of KERN_CONT.

> But when the discussion is about printk() - the implementation, not
> the users - then it's complete and utter BS to talk about trying to
> get rid of pr_cont().
> 
> See the difference?

Sure, but I fail to see where anyone said get rid of pr_cont
in this thread.  It seems all that was discussed was just
various schemes to improve coalescing output.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
