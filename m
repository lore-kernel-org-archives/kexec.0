Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0FGj-0007lG-1I
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 02:23:06 +0000
Received: by mail-pj1-x1042.google.com with SMTP id k1so10692035pjt.5
 for <kexec@lists.infradead.org>; Mon, 27 Jul 2020 19:23:03 -0700 (PDT)
Date: Tue, 28 Jul 2020 11:22:59 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200728022259.GB1286082@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
 <20200721144220.GE44523@jagdpanzerIV.localdomain>
 <CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com>
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

On (20/07/21 08:40), Linus Torvalds wrote:
> On Tue, Jul 21, 2020 at 7:42 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> > we will have more info than just "0x80000000 + raw_smp_processor_id()".
> 
> I think it's really preempt_count() that we want to have there.
> 
> That has the softirq/hardirq/NMI information in it.
> 
> So the "context" identifier of an incomplete write would be { task,
> cpu, preempt_count() } of the writer. If a new KERN_CONT writer comes
> in, it would have to match in that context to actually combine.
> 
> You can probably play "hide the bits" tricks to not *ac tually* use
> three words for it. The task structure in particular tends to be very
> aligned, you could hide bits in the low bits there. The CPU number
> would fit in there, for example.

The purpose of callerid has changed. We used to keep it _only_ in
struct printk_log and never used it for anything but

	if (cont.owner == current && (lflags & LOG_CONT))
		...

so it was easy to use task_struct pointers - we only cared if cont.owner
matches current and never dereferenced the cont.owner pointer.

But we do show caller id to users now (CONFIG_PRINTK_CALLER), so it
makes sense to keep there something more or less human readable, it
helps syzkaller/fuzzer people. That's why we keep PID in [30,0] bits
of callerid if the printk was called in_task(), and CPU_ID otherwise.

Replacing easy to understand PID/CPU_ID with some magic hex, e.g.
hash(current) >> shift or hash(smp_processor_id()) >> shift, will
make things less convenient, so I think it is reasonable to preserve
the existing scheme.

I like what John suggests:

- if printk was called from in_task(), then we keep PID in [30,0] bits
- otherwise we keep smp_processor_id() in [27,0] bits and in the upper
  bits we keep the IRQ/NMI/etc flags.

It may make sense to "promote" u32 callerid to u64, just in case if
someone sometime in the future will have boxes with more than several
billion PIDs.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
