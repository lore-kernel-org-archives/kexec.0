Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k67iS-0002MN-Kz
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 07:32:01 +0000
Date: Thu, 13 Aug 2020 09:31:58 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813073158.GI12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley> <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v9hn2y1p.fsf@jogness.linutronix.de>
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

On Thu 2020-08-13 02:30:02, John Ogness wrote:
> On 2020-08-12, Petr Mladek <pmladek@suse.com> wrote:
> > So, I have one crazy idea to add one more state bit so that we
> > could have:
> >
> >   + committed: set when the data are written into the data ring.
> >   + final: set when the data block could not longer get reopened
> >   + reuse: set when the desctiptor/data block could get reused
> >
> > "final" bit will define when the descriptor could not longer
> > get reopened (cleared committed bit) and the data block could
> > not get extended.
> 
> I implemented this solution for myself and am currently running more
> tests. Some things that I changed from your suggestion:
> 
> 1. I created a separate prb_reserve_cont() function. The reason for this
> is because the caller needs to understand what is happening. The caller
> is getting an existing record with existing data and must append new
> data. The @text_len field of the info reports how long the existing data
> is.

I see.

> So the LOG_CONT handling code in printk.c looks something like this:

Yeah, it makes sense.


> 2. I haven't yet figured out how to preserve calling context when a
> newline appears. For example:
> 
> pr_info("text");
> pr_cont(" 1");
> pr_cont(" 2\n");
> pr_cont("3");
> pr_cont(" 4\n");
> 
> For "3" the calling context (info, timestamp) is lost because with "2"
> the record is finalized. Perhaps the above is invalid usage of LOG_CONT?

I am going to answer Sergey's reply.


> 3. There are some memory barriers introduced, but it looks like it
> shouldn't add too much complexity.

Uff. I have hooped for this.

> I will continue to refine my working version and post a patch so that we
> have something to work with. This looks to be the most promising way
> forward. Thanks.

Uff, I am happy that it seems working. Several other approaches looked
much more complicated or they caused regressions.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
