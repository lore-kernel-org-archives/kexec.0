Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxaZ2-00014t-Dp
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 18:31:01 +0000
Received: by mail-lj1-x242.google.com with SMTP id x9so21307230ljc.5
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 11:30:58 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id j144sm3797753lfj.54.2020.07.20.11.30.53
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 11:30:55 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id x9so21306945ljc.5
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 11:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
In-Reply-To: <20200720015057.GA463@jagdpanzerIV.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Jul 2020 11:30:36 -0700
Message-ID: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>

On Sun, Jul 19, 2020 at 6:51 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> Do I get it right, what you are saying is - when we process a PR_CONT
> message the cont buffer should already contain previous non-LOG_NEWLINE
> and non-PR_CONT message, otherwise it's a bug?

No.

I'm saying that the code that does PR_CONT should have done *some*
printing before, otherwise it's at the very least questionable.

IOW, you can't just randomly start printing with PR_CONT, without
having established _some_ context for it.

But that context could be a previous newline you created (the PR_CONT
will be a no-op). That's certainly useful for printing a header and
then after that printing possible other complex data that may or may
not have line breaks in it.

So your example looks fine. The context starts out with

    pr_warn("which would create a new lock dependency:\n");

and after that you can use KERN_CONT / pr_cont() as much as you want,
since you've established a context for what you're printing.

And then it ends with 'pr_cont("\n")'.

So anything that was interrupted by this, and uses KERN_CONT /
pr_cont() will have no ambiguous issues. The code you pointed at both
started and ended a line.

That said, we have traditionally used not just "current process", but
also "last irq-level" as the context information, so I do think it
would be good to continue to do that.

At that point, "an interrupt printed something in the middle" isn't
even an issue any more, because it's clear that the context has
changed.

                     Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
