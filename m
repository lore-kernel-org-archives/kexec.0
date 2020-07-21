Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxtTQ-0003JY-8s
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 14:42:28 +0000
Received: by mail-pj1-x1044.google.com with SMTP id f16so1784785pjt.0
 for <kexec@lists.infradead.org>; Tue, 21 Jul 2020 07:42:25 -0700 (PDT)
Date: Tue, 21 Jul 2020 23:42:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200721144220.GE44523@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
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

On (20/07/20 11:30), Linus Torvalds wrote:
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

OK, I see. I sort of suspect that we may actually have code that does
just pr_cont() (e.g. what Joe pointed out). It doesn't seem like that
"establish a context" was ever enforced, doing a bunch of pr_cont()
simply works.

[..]
> That said, we have traditionally used not just "current process", but
> also "last irq-level" as the context information, so I do think it
> would be good to continue to do that.

OK, so basically, extending printk_caller_id() so that for IRQ/NMI
we will have more info than just "0x80000000 + raw_smp_processor_id()".

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
