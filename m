Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jx0ER-0006eE-4k
 for kexec@lists.infradead.org; Sun, 19 Jul 2020 03:43:20 +0000
Received: by mail-pl1-x642.google.com with SMTP id q17so7114789pls.9
 for <kexec@lists.infradead.org>; Sat, 18 Jul 2020 20:43:16 -0700 (PDT)
Date: Sun, 19 Jul 2020 12:43:12 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200719034312.GA566736@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200718121053.GA691245@elver.google.com>
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
To: Marco Elver <elver@google.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Marco,

On (20/07/18 14:10), Marco Elver wrote:
> 
> It seems this causes a regression observed at least with newline-only
> printks. I noticed this during -next testing because various debugging
> tools (K*SAN, lockdep, etc.) use e.g. pr_{err,warn,info}("\n") to format
> reports.
> 
> Without wanting to wait for a report from one of these debugging tools,
> a simple reproducer is below. Without this patch, the expected newline
> is printed.

Empty/blank lines carry no valuable payload, could you please explain
why do you consider this to be a regression?

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
