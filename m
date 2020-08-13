Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Bof-0007KU-RL
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 11:54:42 +0000
Received: by mail-pg1-x543.google.com with SMTP id v15so2691895pgh.6
 for <kexec@lists.infradead.org>; Thu, 13 Aug 2020 04:54:40 -0700 (PDT)
Date: Thu, 13 Aug 2020 20:54:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813115435.GB483@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley> <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813084136.GK12903@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/08/13 10:41), Petr Mladek wrote:
> > My concerns about this idea:
> > 
> > - What if the printk user does not correctly terminate the cont message?
> >   There is no mechanism to allow that open record to be force-finalized
> >   so that readers can read newer records.
> 
> This is a real problem. And it is the reason why the cont buffer is
> currently flushed (finalized) by the next message from another context.

I understand that you think that this should be discussed and addressed
later in a separate patch, but, since we are on pr_cont topic right now,
can we slow down and maybe re-think what is actually expected from
pr_cont()? IOW, have the "what is expect from this feature" thread?

For instance, is missing \n the one and only reason why printk-s from
another context flush cont buffer now? Because I can see some more reasons
for current behaviour and I'd like to question those reasons.

I think what Linus said a long time ago was that the initial purpose of
pr_cont was

	pr_info("Initialize feature foo...");
	if (init_feature_foo() == 0)
		pr_cont("ok\n");
	else
		pr_cont("not ok\n");

	And if init_feature_foo() crashes the kernel then the first printk()
	form panic() will flush the cont buffer.

We can handle this by realizing that new printk() message has LOG_NEWLINE
and has different log_level (not pr_cont), maybe.

Let's look at the more general case:

CPU0					.. CPU255
pr_info("text");
					pr_alert("boom\n");
pr_cont("1);
pr_cont("2\n");

Do we really need to preliminary flush CPU0 pr_cont buffer in this
case? There is no connection between messages from CPU0 and CPU255.
Maybe (maybe!) what matters here is keeping the order of messages
per-context rather than globally system-wide?

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
