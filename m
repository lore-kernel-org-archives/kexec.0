Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwo3I-0004Rr-6F
 for kexec@lists.infradead.org; Sat, 18 Jul 2020 14:43:01 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
In-Reply-To: <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
Date: Sat, 18 Jul 2020 16:48:55 +0206
Message-ID: <87blkcanps.fsf@jogness.linutronix.de>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On 2020-07-17, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Make sure you test the case of "fast concurrent readers". The last
> time we did things like this, it was a disaster, because a concurrent
> reader would see and return the _incomplete_ line, and the next entry
> was still being generated on another CPU.
>
> The reader would then decide to return that incomplete line, because
> it had something.
>
> And while in theory this could then be handled properly in user space,
> in practice it wasn't. So you'd see a lot of logging tools that would
> then report all those continuations as separate log events.
>
> Which is the whole point of LOG_CONT - for that *not* to happen.

I expect this is handled correctly since the reader is not given any
parts until a full line is ready, but I will put more focus on testing
this to make sure. Thanks for the regression and testing tips.

> So this is just a heads-up that I will not pull something that breaks
> LOG_CONT because it thinks "user space can handle it". No. User space
> does not handle it, and we need to handle it for the user.

Understood. Petr and Sergey are also strict about this. We are making a
serious effort to avoid breaking things for userspace.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
