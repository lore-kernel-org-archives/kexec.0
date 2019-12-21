Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iifeX-0003M5-5f
 for kexec@lists.infradead.org; Sat, 21 Dec 2019 14:22:47 +0000
Received: by mail-wm1-x341.google.com with SMTP id f129so11982496wmf.2
 for <kexec@lists.infradead.org>; Sat, 21 Dec 2019 06:22:44 -0800 (PST)
Date: Sat, 21 Dec 2019 15:22:35 +0100
From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191221142235.GA7824@andrea>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-2-john.ogness@linutronix.de>
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
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

Hi John,

Sorry for the delay.

I don't have an overall understanding of the patch(-set) yet, so I limit
to a couple of general questions about the memory barriers introduced by
the path.  Please see inline comments.


> +	*desc_out = READ_ONCE(*desc);
> +
> +	/* Load data before re-checking state. */
> +	smp_rmb(); /* matches LMM_REF(desc_reserve:A) */

I looked for a matching WRITE_ONCE() or some other type of marked write,
but I could not find it.  What is the rationale?  Or what did I miss?


> +	do {
> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
> +
> +		if (!data_push_tail(rb, data_ring,
> +				    next_lpos - DATA_SIZE(data_ring))) {
> +			/* Failed to allocate, specify a data-less block. */
> +			blk_lpos->begin = INVALID_LPOS;
> +			blk_lpos->next = INVALID_LPOS;
> +			return NULL;
> +		}
> +	} while (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &begin_lpos,
> +					  next_lpos));
> +
> +	/*
> +	 * No barrier is needed here. The data validity is defined by
> +	 * the state of the associated descriptor. They are marked as
> +	 * invalid at the moment. And only the winner of the above
> +	 * cmpxchg() could write here.
> +	 */

The (successful) CMPXCHG provides a full barrier.  This comment suggests
that that could be somehow relaxed?  Or the comment could be improved?

(The patch introduces a number of CMPXCHG: similar questions would apply
to those other instances...)

Thanks,
  Andrea

P. S.  Please use my @gmail.com address for future communications.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
