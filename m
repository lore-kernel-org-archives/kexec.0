Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]
 helo=smtprelay.hostedemail.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6jUu-0000Zl-5d
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 23:52:33 +0000
Message-ID: <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
From: Joe Perches <joe@perches.com>
Date: Fri, 14 Aug 2020 16:52:24 -0700
In-Reply-To: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
 <20200813115435.GB483@jagdpanzerIV.localdomain>
 <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> On Thu, Aug 13, 2020 at 4:54 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > I think what Linus said a long time ago was that the initial purpose of
> > pr_cont was
> > 
> >         pr_info("Initialize feature foo...");
> >         if (init_feature_foo() == 0)
> >                 pr_cont("ok\n");
> >         else
> >                 pr_cont("not ok\n");
> > 
> >         And if init_feature_foo() crashes the kernel then the first printk()
> >         form panic() will flush the cont buffer.
> 
> Right.
> 
> This is why I think any discussion that says "people should buffer
> their lines themselves and we should get rid if pr_cont()" is
> fundamentally broken.
> 
> Don't go down that hole. I won't take it. It's wrong.

I don't think it's wrong per se.

It's reasonable to avoid pr_cont when appropriate.

Trivial buffering, or adding and using YA vsprintf 
extension can avoid unnecessary message interleaving.

For instance, I just sent this patch to allow removal
of print_vma_addr and its use of pr_cont.

https://lore.kernel.org/lkml/09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com/

This is similar to the dump_flags_names removal back
in commit edf14cdbf9a0 ("mm, printk: introduce new format
string for flags")

> The fact is, pr_cont() goes back to the original kernel. No, it wasn't
> pr_cont() back then, and no, there were no actual explicit markers for
> "this is a continuation" at all, it was all just "the last printk
> didn't have a newline, so we continue where we left off".
> 
> We've added pr_cont (and KERN_CONT) since then, and I realize that a
> lot of people hate the complexity it introduces, but it's a
> fundamental complexity that you have to live with.
> 
> If you can't live with pr_cont(), you shouldn't be working on
> printk(), and find some other area of the kernel that you _can_ live
> with.
> 
> It really is that simple.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
