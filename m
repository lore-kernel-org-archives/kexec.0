Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6UtF-00069A-Pw
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 08:16:42 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
In-Reply-To: <20200814033424.GA582@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
 <87v9hmrg84.fsf@jogness.linutronix.de>
 <20200814033424.GA582@jagdpanzerIV.localdomain>
Date: Fri, 14 Aug 2020 10:22:35 +0206
Message-ID: <87k0y1k5gc.fsf@jogness.linutronix.de>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-08-14, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> One thing that we need to handle here, I believe, is that the context
> which crashes the kernel should flush its cont buffer, because the
> information there is relevant to the crash:
>
> 	pr_cont_alloc_info(&c);
> 	pr_cont(&c, "1");
> 	pr_cont(&c, "2");
> 	>>
> 	   oops
> 	      panic()
> 	<<
> 	pr_cont_flush(&c);
>
> We better flush that context's pr_cont buffer during panic().

I am not convinced of the general usefulness of partial messages, but as
long as we have an API that includes registration, usage, and
deregistration of some sort of handle, then we leave the window open for
such implementations.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
