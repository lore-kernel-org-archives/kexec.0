Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxKxJ-00026T-Tv
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 01:51:03 +0000
Received: by mail-pj1-x1043.google.com with SMTP id ch3so9379652pjb.5
 for <kexec@lists.infradead.org>; Sun, 19 Jul 2020 18:51:01 -0700 (PDT)
Date: Mon, 20 Jul 2020 10:50:57 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200720015057.GA463@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
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

On (20/07/19 11:27), Linus Torvalds wrote:
> On Sun, Jul 19, 2020 at 7:35 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > Can we merge lines that we don't want to merge?
> >
> >    pr_cont()  ->  IRQ -> pr_cont() -> NMI -> pr_cont()
> 
> That pr_cont in either IRQ or NMI context would be a bug.
> 
> You can't validly have a PR_CONT without the non-cont that precedes it.

Do I get it right, what you are saying is - when we process a PR_CONT
message the cont buffer should already contain previous non-LOG_NEWLINE
and non-PR_CONT message, otherwise it's a bug?

lockdep (I'll trim the code)

static void __print_lock_name(struct lock_class *class)
{
 ..
	name = class->name;
	if (!name) {
		name = __get_key_name(class->key, str);
		printk(KERN_CONT "%s", name);
	} else {
		printk(KERN_CONT "%s", name);
		if (class->name_version > 1)
			printk(KERN_CONT "#%d", class->name_version);
		if (class->subclass)
			printk(KERN_CONT "/%d", class->subclass);
	}
}

static void print_lock_name(struct lock_class *class)
{
	printk(KERN_CONT " (");
	__print_lock_name(class);
	printk(KERN_CONT "){%s}-{%hd:%hd}", usage, ...
}

static void
print_bad_irq_dependency(struct task_struct *curr,
{
 ..
	pr_warn("which would create a new lock dependency:\n");
	print_lock_name(hlock_class(prev));
	pr_cont(" ->");
	print_lock_name(hlock_class(next));
	pr_cont("\n");
 ..
}

pr_warn() is LOG_NEWLINE, so cont buffer is empty by the time
we call print_lock_name()->__print_lock_name(), which do several
pr_cont() print outs.

I'm quite sure there is more code that does similar things.

But, overall, isn't it by design that we can process pr_cont()
message with no preceding non-cont message? Because of preliminary
flushes. Example:

CPU0

 pr_info("foo");    // !LOG_NEWLINE goes into the cont buffer
 pr_cont("1");      // OK
 -> IRQ / NMI / exception / etc
 	pr_alert("error\n"); // flush cont buffer, log_store error message (it's LOG_NEWLINE)
 <- iret
 pr_cont("2");      // cont buffer was flushed. There is no preceding non-cont message
 pr_cont("3");
 pr_cont("\n");

Or am I misunderstanding what you saying?

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
