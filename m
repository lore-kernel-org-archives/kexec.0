Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxX6s-0006GC-1K
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 14:49:42 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 1/4] printk: ringbuffer: support dataless records
In-Reply-To: <20200717234818.8622-2-john.ogness@linutronix.de>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-2-john.ogness@linutronix.de>
Date: Mon, 20 Jul 2020 16:55:39 +0206
Message-ID: <87blkas0l8.fsf@jogness.linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-07-18, John Ogness <john.ogness@linutronix.de> wrote:
> In order to support storage of continuous lines, dataless records must
> be allowed. For example, these are generated with the legal calls:
>
>     pr_info("");
>     pr_cont("\n");
>
> Currently dataless records are denoted by INVALID_LPOS in order to
> recognize failed prb_reserve() calls. Change the code to use two
> different identifiers (FAILED_LPOS and NO_LPOS) to distinguish
> between failed prb_reserve() records and successful dataless records.

This patch has been re-posted [0] as a regression fix for the first
series that is already in linux-next. Only the commit message has been
changed to reflect the regression fix rather than preparing for
continuous line support.

Assuming that patch is accepted, this one should be dropped.

John Ogness

[0] https://lkml.kernel.org/r/20200720140111.19935-1-john.ogness@linutronix.de

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
