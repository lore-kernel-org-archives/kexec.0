Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtoOZ-0003Hh-56
 for kexec@lists.infradead.org; Fri, 10 Jul 2020 08:28:36 +0000
Date: Fri, 10 Jul 2020 10:28:33 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v5 0/4] printk: replace ringbuffer
Message-ID: <20200710082833.GM4751@alley>
References: <20200709132344.760-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709132344.760-1-john.ogness@linutronix.de>
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

On Thu 2020-07-09 15:29:40, John Ogness wrote:
> Hello,
> 
> Here is a v5 for the first series to rework the printk
> subsystem. The v4 is here [0]. This first series
> only replaces the existing ringbuffer implementation. No locking
> is removed. The semantics/behavior of printk are kept the same
> except for a minor optimization that is reverted (patch 3).
> 
> John Ogness (4):
>   crash: add VMCOREINFO macro to define offset in a struct declared by
>     typedef
>   printk: add lockless ringbuffer
>   Revert "printk: lock/unlock console only for new logbuf entries"
>   printk: use the lockless ringbuffer

The patchset is committed in printk/linux.git, branch printk-rework.

I did not add any target kernel version into the topic branch name.
We could use it for the entire rework. The pieces would go into
mainline when we and linux-next are happy.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
