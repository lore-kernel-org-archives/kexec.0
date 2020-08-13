Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k65dm-00007q-Kv
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 05:19:03 +0000
Received: by mail-pf1-x444.google.com with SMTP id d188so2224624pfd.2
 for <kexec@lists.infradead.org>; Wed, 12 Aug 2020 22:18:58 -0700 (PDT)
Date: Thu, 13 Aug 2020 14:18:53 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813051853.GA510@jagdpanzerIV.localdomain>
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
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/08/13 02:30), John Ogness wrote:
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

This is not an unseen pattern, I'm afraid. And the problem here can
be more general:

	pr_info("text");
	pr_cont("1");
	exception/IRQ/NMI
		pr_alert("text\n");
	pr_cont("2");
	pr_cont("\n");

I guess the solution would be to store "last log_level" in task_struct
and get current (new) timestamp for broken cont line?

We have this problem now. E.g. early boot messages from one of my boxes:

6,173,41837,-;x86: Booting SMP configuration:
6,174,41838,-;.... node  #0, CPUs:      #1 #2 #3 #4
4,175,44993,-;MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/...
4,176,44993,c; #5 #6 #7

"CPUs: #1 #2 #3 #4 #5 #6 #7" is supposed to be one cont line with
loglevel 6. But it gets interrupted and flushed so that "#5 #6 #7"
appears with the different loglevel.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
