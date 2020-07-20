Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxScZ-0005sr-3N
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 10:02:08 +0000
Received: by mail-qk1-x741.google.com with SMTP id e13so14618297qkg.5
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 03:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain>
 <20200720064303.GA2144711@elver.google.com>
 <20200720084102.GC463@jagdpanzerIV.localdomain>
 <CANpmjNPbnwmHyif79MaXdA478UGUKysB=u=HmtBiD10PPPTEcw@mail.gmail.com>
In-Reply-To: <CANpmjNPbnwmHyif79MaXdA478UGUKysB=u=HmtBiD10PPPTEcw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 20 Jul 2020 12:01:51 +0200
Message-ID: <CACT4Y+ZjpFYKosvGNPPWYyfZaAh6+Gieh4zKH2JzdVmkhPCg6Q@mail.gmail.com>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jul 20, 2020 at 11:41 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, 20 Jul 2020 at 10:41, Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > On (20/07/20 08:43), Marco Elver wrote:
> > > On Sun, Jul 19, 2020 at 12:43PM +0900, Sergey Senozhatsky wrote:
> > >
> > > As I said, a number of debugging tools use them to format reports to be
> > > more readable (visually separate title and report body, and separate
> > > parts of the report). Also, such reports are often parsed by CI systems,
> > > and by changing the reports, these CI systems may break. But those are
> > > just the usecases I'm acutely aware of
> >
> > Can you give example of such CI systems? // that's a real question //
>
> None of ours should break; I agree the CI system is brittle if it
> relies on newlines. Parsed and displayed reports are changing, however
> -- what irks me is now all the reports sent to the LKML look ugly.
>
> Some random KASAN reports (just compare formatting):
> next (ugly): https://lore.kernel.org/lkml/000000000000c87b7305aadb6dba@google.com/
> mainline (normal):
> https://lore.kernel.org/lkml/000000000000f4ef6a05aa92ec6c@google.com/
>
> The same problem exists with lockdep reports, KCSAN reports, ... If
> newline-printks to insert blank lines are now banned, what are we to
> do? Send dozens of patches to switch everyone to printk(" \n")? Or
> some better suggestion? I cannot yet see how that is an improvement.
> (And if the behaviour is not reverted, please document the new
> behaviour.)
>
> That also doesn't yet address the ~400 other newline-printk users, and
> somebody needs to do the due diligence to understand if it's just a
> flush, or an intentional blank line.


Empty lines improve readability of long crash reports significantly.
New lines in sanitizer reports originated in Go race reports 7 years
ago and then spread to user-space ASAN/MSAN/TSAN b/c that was an
improvement and then were specifically added to kernel sanitizers.
This is even more important now that we have up to 5 stacks in KASAN
reports.
Please keep them.

Also having lots of printk("\n") sprinkled in kernel code and turning
them into no-op separately does not look like the right solution.
These printk("\n") are confusing and add clutter. A better solution
would be to remove these printk("\n") from the code. But this also
naturally allows selective removal. Say, keeping for sanitizers and
some other cases, but removing some that are not useful.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
