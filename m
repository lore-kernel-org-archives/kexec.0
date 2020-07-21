Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxiQh-0006ED-TY
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 02:54:56 +0000
Received: by mail-pl1-x644.google.com with SMTP id x9so9614773plr.2
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 19:54:55 -0700 (PDT)
Date: Tue, 21 Jul 2020 11:54:50 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH][next] printk: ringbuffer: support dataless records
Message-ID: <20200721025450.GA5678@jagdpanzerIV.localdomain>
References: <20200720140111.19935-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720140111.19935-1-john.ogness@linutronix.de>
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
Cc: Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/20 16:07), John Ogness wrote:
>  
> +/* Determine if a logical position refers to a data-less block. */
> +#define LPOS_DATALESS(lpos)		((lpos) & 1UL)
> +

[..]

> @@ -1402,7 +1396,9 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
>  	/* Copy text data. If it fails, this is a data-less record. */
>  	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, desc.info.text_len,
>  		       r->text_buf, r->text_buf_size, line_count)) {
> -		return -ENOENT;
> +		/* Report an error if there should have been data. */
> +		if (desc.info.text_len != 0)
> +			return -ENOENT;
>  	}

If this is a dataless record then should copy_data() return error?

Otherwise, looks good to me
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
