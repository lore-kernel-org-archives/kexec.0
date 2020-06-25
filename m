Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joTgC-0002nn-Aq
 for kexec@lists.infradead.org; Thu, 25 Jun 2020 15:20:45 +0000
Date: Thu, 25 Jun 2020 17:20:42 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: syslog size unread: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
Message-ID: <20200625152042.GI8444@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-4-john.ogness@linutronix.de>
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

On Thu 2020-06-18 16:55:19, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1609,11 +1633,15 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		break;
>  	/* Number of chars in the log buffer */
>  	case SYSLOG_ACTION_SIZE_UNREAD:
> +		if (source != SYSLOG_FROM_PROC) {
> +			text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
> +			if (!text)
> +				return -ENOMEM;

The buffer is needed only to count lines to count the size of
added prefixes. Could we use the new prb_read_valid_info() that
allows to get the number of lines without actually reading the buffer?

> +
> +		}
>  		logbuf_lock_irq();
> -		if (syslog_seq < log_first_seq) {
> +		if (syslog_seq < prb_first_seq(prb)) {
>  			/* messages are gone, move to first one */
> -			syslog_seq = log_first_seq;
> -			syslog_idx = log_first_idx;
> +			syslog_seq = prb_first_seq(prb);
>  			syslog_partial = 0;
>  		}
>  		if (source == SYSLOG_FROM_PROC) {

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
