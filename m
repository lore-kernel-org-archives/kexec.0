Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joN42-0007O6-JL
 for kexec@lists.infradead.org; Thu, 25 Jun 2020 08:16:55 +0000
Date: Thu, 25 Jun 2020 10:16:50 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: truncate dict: was: Re: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
Message-ID: <20200625081650.GE6156@alley>
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
> @@ -594,22 +473,26 @@ static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
>  #define MAX_LOG_TAKE_PART 4
>  static const char trunc_msg[] = "<truncated>";
>  
> -static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
> -			u16 *dict_len, u32 *pad_len)
> +static void truncate_msg(u16 *text_len, u16 *trunc_msg_len, u16 *dict_len)
>  {
>  	/*
>  	 * The message should not take the whole buffer. Otherwise, it might
>  	 * get removed too soon.
>  	 */
>  	u32 max_text_len = log_buf_len / MAX_LOG_TAKE_PART;
> +
>  	if (*text_len > max_text_len)
>  		*text_len = max_text_len;
> -	/* enable the warning message */
> +
> +	/* enable the warning message (if there is room) */
>  	*trunc_msg_len = strlen(trunc_msg);
> +	if (*text_len >= *trunc_msg_len)
> +		*text_len -= *trunc_msg_len;
> +	else
> +		*trunc_msg_len = 0;
> +
>  	/* disable the "dict" completely */
>  	*dict_len = 0;

The dictionary does not longer need to be removed at this point.
It is stored in a separate buffer. It is ignored by prb_reserve()
when there is not enough space for it.

> -	/* compute the size again, count also the warning message */
> -	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
>  }
>  
>  /* insert record into the buffer, discard old ones, update heads */

Best Regards,
Petr

PS: I am still in the middle of review of this patch. I decided to
send the tree comments that I already have separately.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
