Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]
 helo=smtprelay.hostedemail.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxjLt-0003Nc-1g
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 03:54:02 +0000
Message-ID: <b44b9b7c0f0d5ace01e56d2bac0251573ea7df17.camel@perches.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
From: Joe Perches <joe@perches.com>
Date: Mon, 20 Jul 2020 20:53:52 -0700
In-Reply-To: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
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

On Mon, 2020-07-20 at 11:30 -0700, Linus Torvalds wrote:
> On Sun, Jul 19, 2020 at 6:51 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > Do I get it right, what you are saying is - when we process a PR_CONT
> > message the cont buffer should already contain previous non-LOG_NEWLINE
> > and non-PR_CONT message, otherwise it's a bug?
> 
> No.
> 
> I'm saying that the code that does PR_CONT should have done *some*
> printing before, otherwise it's at the very least questionable.
> 
> IOW, you can't just randomly start printing with PR_CONT, without
> having established _some_ context for it.

I believe there are at least a few cases that
_only_ use pr_cont to emit
complete lines.

For example: SEQ_printf in kernel/sched/debug.c



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
