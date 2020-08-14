Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6VlS-0005AW-WC
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 09:12:43 +0000
Date: Fri, 14 Aug 2020 11:12:41 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200814091240.GL6215@alley>
References: <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley> <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <87v9hmrg84.fsf@jogness.linutronix.de>
 <20200814033424.GA582@jagdpanzerIV.localdomain>
 <87k0y1k5gc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k0y1k5gc.fsf@jogness.linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri 2020-08-14 10:22:35, John Ogness wrote:
> On 2020-08-14, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > One thing that we need to handle here, I believe, is that the context
> > which crashes the kernel should flush its cont buffer, because the
> > information there is relevant to the crash:
> >
> > 	pr_cont_alloc_info(&c);
> > 	pr_cont(&c, "1");
> > 	pr_cont(&c, "2");
> > 	>>
> > 	   oops
> > 	      panic()
> > 	<<
> > 	pr_cont_flush(&c);
> >
> > We better flush that context's pr_cont buffer during panic().
> 
> I am not convinced of the general usefulness of partial messages, but as
> long as we have an API that includes registration, usage, and
> deregistration of some sort of handle, then we leave the window open for
> such implementations.

Registering some handle is an interesting idea. But it rules out
buffers on the stack. And we should avoid dynamic allocation.
printk() must be reliable also when there is not enough memory.

Please, keep it simple and do not add dependencies on new subsystems.
Using external code in printk() is always a call for problems.
The called code must be lockless and must not call printk().

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
