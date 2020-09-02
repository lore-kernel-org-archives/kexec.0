Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDSxt-0002e0-6P
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 13:38:18 +0000
Date: Wed, 2 Sep 2020 15:38:12 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH next v3 7/8] printk: reimplement log_cont using record
 extension
Message-ID: <20200902133811.GC15764@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831011058.6286-8-john.ogness@linutronix.de>
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

On Mon 2020-08-31 03:16:57, John Ogness wrote:
> Use the record extending feature of the ringbuffer to implement
> continuous messages. This preserves the existing continuous message
> behavior.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 98 +++++++++---------------------------------
>  1 file changed, 20 insertions(+), 78 deletions(-)

It looks simple from the printk() side ;-)

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
