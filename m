Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxtho-0005df-MK
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 14:57:21 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
In-Reply-To: <20200721144220.GE44523@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
 <20200721144220.GE44523@jagdpanzerIV.localdomain>
Date: Tue, 21 Jul 2020 17:03:16 +0206
Message-ID: <87ft9kx6er.fsf@jogness.linutronix.de>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On 2020-07-21, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> That said, we have traditionally used not just "current process", but
>> also "last irq-level" as the context information, so I do think it
>> would be good to continue to do that.
>
> OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> we will have more info than just "0x80000000 + raw_smp_processor_id()".

If bit31 is set, the upper 8 bits could specify what the lower 24 bits
represent. That would give some freedom for the future.

For example:

0x80 = cpu id (generic context)
0x81 = interrupt number
0x82 = cpu id (nmi context)

Or maybe ascii should be used instead?

0x80 | '\0' = cpu id (generic context)
0x80 | 'i'  = interrupt number
0x80 | 'n'  = cpu id (nmi context)

Just an idea.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
