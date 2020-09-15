Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI7Z8-0002Bb-Qa
 for kexec@lists.infradead.org; Tue, 15 Sep 2020 09:47:59 +0000
Date: Tue, 15 Sep 2020 11:47:56 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v5 0/6] printk: reimplement LOG_CONT handling
Message-ID: <20200915094756.GF11154@alley>
References: <20200914123354.832-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914123354.832-1-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon 2020-09-14 14:39:48, John Ogness wrote:
> Hello,
> 
> Here is v5 for the second series to rework the printk subsystem.
> (The v4 is here [0].) This series implements a new ringbuffer
> feature that allows the last record to be extended. Petr Mladek
> provided the initial proof of concept [1] for this.
> 
> Using the record extension feature, LOG_CONT is re-implemented
> in a way that exactly preserves its behavior, but avoids the
> need for an extra buffer. In particular, it avoids the need for
> any synchronization that such a buffer requires.

The series is ready for linux-next from my POV. I am going to push
it there tomorrow if nobody complains.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
