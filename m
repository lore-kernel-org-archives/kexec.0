Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxRFj-0005jV-Ra
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 08:34:28 +0000
Received: by mail-pj1-x1044.google.com with SMTP id k1so93366pjt.5
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 01:34:25 -0700 (PDT)
Date: Mon, 20 Jul 2020 17:34:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200720083420.GB463@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain>
 <20200720064303.GA2144711@elver.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720064303.GA2144711@elver.google.com>
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

On (20/07/20 08:43), Marco Elver wrote:
[..]
> please see a full list of newline-print users below.
[..]
> $> git grep -En '\<(printk|pr_err|pr_warn|pr_info)\>\("\\n"\)'
> arch/alpha/kernel/core_wildfire.c:650:	printk("\n");
> arch/alpha/kernel/core_wildfire.c:658:	printk("\n");
> arch/alpha/kernel/traps.c:120:	printk("\n");
[..]

In many cases printk("\n") is not for "print a blank line", but
rather for "flush pr_cont buffer".

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
