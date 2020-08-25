Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAcTB-0002OU-L2
 for kexec@lists.infradead.org; Tue, 25 Aug 2020 17:10:50 +0000
Date: Tue, 25 Aug 2020 19:10:47 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 2/7][next] printk: ringbuffer: change representation
 of reusable
Message-ID: <20200825171047.GY4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824103538.31446-3-john.ogness@linutronix.de>
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

On Mon 2020-08-24 12:41:33, John Ogness wrote:
> The reusable queried state is represented by the combined flags:
> 
>     DESC_COMMIT_MASK | DESC_REUSE_MASK
> 
> There is no reason for the DESC_COMMIT_MASK to be part of that
> representation. In particular, this will add confusion when more
> state flags are available.
> 
> Change the representation of the reusable queried state to just
> the DESC_REUSE_MASK flag.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
