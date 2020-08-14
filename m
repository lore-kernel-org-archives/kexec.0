Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6VdY-0004Ql-DX
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 09:04:33 +0000
Date: Fri, 14 Aug 2020 11:04:26 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200814090426.GK6215@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley> <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <20200813115435.GB483@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813115435.GB483@jagdpanzerIV.localdomain>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu 2020-08-13 20:54:35, Sergey Senozhatsky wrote:
> On (20/08/13 10:41), Petr Mladek wrote:
> > > My concerns about this idea:
> > > 
> > > - What if the printk user does not correctly terminate the cont message?
> > >   There is no mechanism to allow that open record to be force-finalized
> > >   so that readers can read newer records.
> > 
> > This is a real problem. And it is the reason why the cont buffer is
> > currently flushed (finalized) by the next message from another context.
> 
> I understand that you think that this should be discussed and addressed
> later in a separate patch, but, since we are on pr_cont topic right now,
> can we slow down and maybe re-think what is actually expected from
> pr_cont()? IOW, have the "what is expect from this feature" thread?
> 
> For instance, is missing \n the one and only reason why printk-s from
> another context flush cont buffer now? Because I can see some more reasons
> for current behaviour and I'd like to question those reasons.
> 
> I think what Linus said a long time ago was that the initial purpose of
> pr_cont was
> 
> 	pr_info("Initialize feature foo...");
> 	if (init_feature_foo() == 0)
> 		pr_cont("ok\n");
> 	else
> 		pr_cont("not ok\n");
> 
> 	And if init_feature_foo() crashes the kernel then the first printk()
> 	form panic() will flush the cont buffer.
> 
> We can handle this by realizing that new printk() message has LOG_NEWLINE
> and has different log_level (not pr_cont), maybe.

Yes, this is a handy behavior. But it is also complicated
on the implementation side. It requires that consoles are able to
print the existing part of the continuous line and print only
the rest later.

BTW: It used to work before the commit 5c2992ee7fd8a29d041 ("printk:
     remove console flushing special cases for partial buffered
     lines");

BTW2: It will be much easier to implement when only the last
     message can be partially shown on the consoles. Each console
     driver will need to track the position only in one message.

     Also it will be easier when the part of the message if stored
     in the main lockless ring buffer. Then the driver could just
     try to reread the last message and see if it was concatenated.


> Let's look at the more general case:
> 
> CPU0					.. CPU255
> pr_info("text");
> 					pr_alert("boom\n");
> pr_cont("1);
> pr_cont("2\n");
> 
> Do we really need to preliminary flush CPU0 pr_cont buffer in this
> case? There is no connection between messages from CPU0 and CPU255.
> Maybe (maybe!) what matters here is keeping the order of messages
> per-context rather than globally system-wide?

Honestly, I have no idea how many newlines are missing. They are often
not noticed because the buffered message is flushed later by some
other one.

The chance that some other "random" message will flush the pending
message is much lower if we have many cont buffers per-context
and per-cpu.

I am not brave enough to add more cont buffers without some fallback
mechanism to flush them later (irq_work?, timer?) or without
audit of all callers.

Where the audit is implicit when all callers are converted to
the buffered printk API.


There is one more problem. Any buffering might cause that nobody
will be able to see the message when things go wrong. Flushing
during panic() might help but only when panic() is called
and when there are system-wide cont buffers.

By other words, the current pr_cont() behavior causes mixed output
from time to time. But it increases the chance to see the messages.
And it makes it easier to find them in crashdump. Perfect output
is nice. But it will not help when the messages gets lost.

All I want to say that it is not black and white.


My opinion:

I will leave the decision on John. If he thinks that converting
all pr_cont() users to a buffered API is easier I will be fine
with it. It was proposed and requested several times.

If John realizes that my proposal to allow to reopen committed
messages is easier, I will be fine with it as well. We could
create the buffered API and convert the most critical
users one by one later. Also the context information will
allow to connect the broken messages in userspace and
do not complicate the kernel side.

Anyway, the lockless printk() feature is more important for
me that a perfect output of continuous lines.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
