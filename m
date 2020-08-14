Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6QUB-00008C-Tb
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 03:34:32 +0000
Received: by mail-pj1-x1043.google.com with SMTP id ha11so3750895pjb.1
 for <kexec@lists.infradead.org>; Thu, 13 Aug 2020 20:34:29 -0700 (PDT)
Date: Fri, 14 Aug 2020 12:34:24 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200814033424.GA582@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley> <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <87v9hmrg84.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v9hmrg84.fsf@jogness.linutronix.de>
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

On (20/08/13 12:35), John Ogness wrote:
> I believe I failed to recognize the fundamental problem. The fundamental
> problem is that the pr_cont() semantics are very poor.

The semantics is pretty clear - use it only in UP early bootup,
anything else is broken :)

  /*
   * Annotation for a "continued" line of log printout (only done after a
   * line that had no enclosing \n). Only to be used by core/arch code
   * during early bootup (a continued line is not SMP-safe otherwise).
   */
  #define KERN_CONT	KERN_SOH "c"

> I now strongly believe that we need to fix those semantics by having the
> pr_cont() user take responsibility for buffering the message. Patching the
> ~2000 pr_cont() users will be far easier than continuing to twist ourselves
> around this madness.

I welcome this effort. We've been talking about the fact that pr_cont() is
not something we can ignore anymore (we have more and more SMP users of
it) since the Kernel Summit in Santa Fe, NM, but the general response back
then was "oh my god, who cares" (pretty sure this is very close to what Ted
Ts'o said during the printk session).

> Here is an example for a new pr_cont() API:
> 
>     struct pr_cont c;
> 
>     pr_cont_alloc_info(&c);
>        (or alternatively)
>     dev_cont_alloc_info(dev, &c);
> 
>     pr_cont(&c, "1");
>     pr_cont(&c, "2");
> 
>     pr_cont_flush(&c);

This might be a bit more complex.

One thing that we need to handle here, I believe, is that the context
which crashes the kernel should flush its cont buffer, because the
information there is relevant to the crash:

	pr_cont_alloc_info(&c);
	pr_cont(&c, "1");
	pr_cont(&c, "2");
	>>
	   oops
	      panic()
	<<
	pr_cont_flush(&c);

We better flush that context's pr_cont buffer during panic().

Another example:


	pr_cont_alloc_info(&c);

	for (i = 0; i < p->sz; i++)
		pr_cont(&c, p->buf[i]);
	>>
	   page fault
	    exit
	<<
	pr_cont_flush(&c);

I believe we need to preliminary flush pr_cont() in this case as well,
because the information there might be very helpful.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
