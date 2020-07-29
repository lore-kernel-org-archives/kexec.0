Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0bRq-0003S7-10
 for kexec@lists.infradead.org; Wed, 29 Jul 2020 02:04:02 +0000
Received: by mail-pj1-x1043.google.com with SMTP id ha11so1246283pjb.1
 for <kexec@lists.infradead.org>; Tue, 28 Jul 2020 19:04:01 -0700 (PDT)
Date: Wed, 29 Jul 2020 11:03:55 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200729020355.GA1534750@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
 <20200721144220.GE44523@jagdpanzerIV.localdomain>
 <87ft9kx6er.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ft9kx6er.fsf@jogness.linutronix.de>
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
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/21 17:03), John Ogness wrote:
> On 2020-07-21, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >> That said, we have traditionally used not just "current process", but
> >> also "last irq-level" as the context information, so I do think it
> >> would be good to continue to do that.
> >
> > OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> > we will have more info than just "0x80000000 + raw_smp_processor_id()".
> 
> If bit31 is set, the upper 8 bits could specify what the lower 24 bits
> represent. That would give some freedom for the future.
> 
> For example:
> 
> 0x80 = cpu id (generic context)
> 0x81 = interrupt number
> 0x82 = cpu id (nmi context)

Looks good to me. I'd probably add in_softirq state. So the contexts
are: in_task, in_softirq, in_irq, in_nmi

For the purpose of future extensions, I would probably consider
u64 for callerid. So that we can store more "state bits" in the future,
like disabled/enabled preemption; disabled/enabled local irqs; etc.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
