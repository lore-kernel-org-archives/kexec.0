Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxT6C-0001lj-UT
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 10:32:45 +0000
Received: by mail-oo1-xc42.google.com with SMTP id a9so3064894oof.12
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 03:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
 <87eep6sd1e.fsf@jogness.linutronix.de>
In-Reply-To: <87eep6sd1e.fsf@jogness.linutronix.de>
From: Marco Elver <elver@google.com>
Date: Mon, 20 Jul 2020 12:32:29 +0200
Message-ID: <CANpmjNNnu2a3MqCgjieQEOFrXvs21pfxybvPkicLKO4jaBnpgA@mail.gmail.com>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>

On Mon, 20 Jul 2020 at 12:20, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2020-07-18, Marco Elver <elver@google.com> wrote:
> > It seems this causes a regression observed at least with newline-only
> > printks.
> > [...]
> > ------ >8 ------
> >
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1039,6 +1039,10 @@ asmlinkage __visible void __init start_kernel(void)
> >       sfi_init_late();
> >       kcsan_init();
> >
> > +     pr_info("EXPECT BLANK LINE --vv\n");
> > +     pr_info("\n");
> > +     pr_info("EXPECT BLANK LINE --^^\n");
> > +
> >       /* Do the rest non-__init'ed, we're now alive */
> >       arch_call_rest_init();
>
> Thanks for the example. This is an unintentional regression in the
> series. I will submit a patch to fix this.
>
> Note that this regression does not exist when the followup series [0]
> (reimplementing LOG_CONT) is applied. All the more reason that the 1st
> series should be fixed before pushing the 2nd series to linux-next.

Great, thank you for clarifying! :-)

-- Marco

> John Ogness
>
> [0] https://lkml.kernel.org/r/20200717234818.8622-1-john.ogness@linutronix.de

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
