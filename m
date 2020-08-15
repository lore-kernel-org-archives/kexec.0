Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6ox1-00013z-HX
 for kexec@lists.infradead.org; Sat, 15 Aug 2020 05:41:56 +0000
Received: by mail-pj1-x1043.google.com with SMTP id c6so5359627pje.1
 for <kexec@lists.infradead.org>; Fri, 14 Aug 2020 22:41:48 -0700 (PDT)
Date: Sat, 15 Aug 2020 14:41:43 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200815054143.GD582@jagdpanzerIV.localdomain>
References: <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley> <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <20200813115435.GB483@jagdpanzerIV.localdomain>
 <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
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

On (20/08/14 15:46), Linus Torvalds wrote:
> On Thu, Aug 13, 2020 at 4:54 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
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

I think what we've been talking about so far was "how do we buffer
cont lines now", what are the problems of current buffering and what
can we do to make that buffering SMP safe (preserving the context of
broken cont buffer, etc. etc.). I don't think that anyone concluded
to just "s/pr_cont/printk/g", I don't see this.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
