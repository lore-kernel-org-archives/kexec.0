Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxR4p-0004Nc-OW
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 08:23:12 +0000
Received: by mail-pl1-x644.google.com with SMTP id q17so8335956pls.9
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 01:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain>
 <20200720064303.GA2144711@elver.google.com>
In-Reply-To: <20200720064303.GA2144711@elver.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Jul 2020 11:22:51 +0300
Message-ID: <CAHp75Vc-x9jo8_7zcTv9EQ3RaterJDCEXWWbJBbVDAUtXufZxA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
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
To: Marco Elver <elver@google.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jul 20, 2020 at 9:45 AM Marco Elver <elver@google.com> wrote:
> On Sun, Jul 19, 2020 at 12:43PM +0900, Sergey Senozhatsky wrote:
> > On (20/07/18 14:10), Marco Elver wrote:
> > >
> > > It seems this causes a regression observed at least with newline-only
> > > printks. I noticed this during -next testing because various debugging
> > > tools (K*SAN, lockdep, etc.) use e.g. pr_{err,warn,info}("\n") to format
> > > reports.
> > >
> > > Without wanting to wait for a report from one of these debugging tools,
> > > a simple reproducer is below. Without this patch, the expected newline
> > > is printed.
> >
> > Empty/blank lines carry no valuable payload, could you please explain
> > why do you consider this to be a regression?
>
> Empty/blank lines are visually valuable.
>
> Did I miss a discussion somewhere that this change is acceptable?
> Unfortunately, I can't find it mentioned in the commit message, and
> therefore assumed it's a regression.
>
> As I said, a number of debugging tools use them to format reports to be
> more readable (visually separate title and report body, and separate
> parts of the report).

While I can find it useful in some cases, though messages can be
interleaved, ...

> Also, such reports are often parsed by CI systems,
> and by changing the reports, these CI systems may break. But those are
> just the usecases I'm acutely aware of -- please see a full list of
> newline-print users below.

...but this is a weak argument. If your CI relies on message rather on
the ABI, you earn the breakage.
Go and fix your CI to do sane things instead.

> Breaking the observable behaviour of a widely used interface such as
> printk doesn't seem right. Where the newline-print is inappropriate,
> wouldn't removing that newline-print be more appropriate (instead of
> forcing this behaviour on everyone)?

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
