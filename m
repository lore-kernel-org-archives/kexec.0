Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvB7S-0003yw-Qh
 for kexec@lists.infradead.org; Tue, 14 Jul 2020 02:56:35 +0000
Received: by mail-pg1-x543.google.com with SMTP id e18so6949199pgn.7
 for <kexec@lists.infradead.org>; Mon, 13 Jul 2020 19:56:33 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Tue, 14 Jul 2020 11:56:26 +0900
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
Message-ID: <20200714025626.GD491026@jagdpanzerIV.localdomain>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200708152005.GF4751@alley>
 <87wo3d9nlo.fsf@jogness.linutronix.de>
 <20200710091137.GN4751@alley>
 <87o8onhf31.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o8onhf31.fsf@jogness.linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/10 11:58), John Ogness wrote:
> 
> IMHO users of these sequence number interfaces need to see all the
> records individually and reassemble the LOG_CONT messages themselves if
> they want to. I believe that is the only sane path forward. To do this,
> the caller id will no longer be optional to the sequence number output
> since that is vital information to re-assemble the LOG_CONT messages.

Agreed. The caller id thus probably can be extended. Right now it only
tells us either we are in a process context (PID) or in something else.
This works sort of fine (I guess) because deeply nested printouts (printks
from NMI atop of process or irq printks) land in the deferred printk-safe
buffers, but things will change with the new logbuf (and after removal of
the logbuf_lock and per-CPU printk-safe buffers).

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
