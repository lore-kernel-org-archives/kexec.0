Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDQTE-0000M4-Ds
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 10:58:29 +0000
Date: Wed, 2 Sep 2020 12:58:26 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH next v3 6/8] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200902105826.GB15764@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831011058.6286-7-john.ogness@linutronix.de>
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

On Mon 2020-08-31 03:16:56, John Ogness wrote:
> Add support for extending the newest data block. For this, introduce
> a new finalization state flag (DESC_FINAL_MASK) that denotes when a
> descriptor may not be extended, i.e. is finalized.
> 
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> +/*
> + * Try to resize an existing data block associated with the descriptor
> + * specified by @id. If the resized datablock should become wrapped, it
> + * copies the old data to the new data block.
> + *
> + * Fail if this is not the last allocated data block or if there is not
> + * enough space or it is not possible make enough space.
> + *
> + * Return a pointer to the beginning of the entire data buffer or NULL on
> + * failure.
> + */
> +static char *data_realloc(struct printk_ringbuffer *rb,
> +			  struct prb_data_ring *data_ring, unsigned int size,
> +			  struct prb_data_blk_lpos *blk_lpos, unsigned long id)
> +{
> +	struct prb_data_block *blk;
> +	unsigned long head_lpos;
> +	unsigned long next_lpos;
> +	bool wrapped;
> +
> +	/* Reallocation only works if @blk_lpos is the newest data block. */
> +	head_lpos = atomic_long_read(&data_ring->head_lpos);
> +	if (head_lpos != blk_lpos->next)
> +		return NULL;
> +
> +	/* Keep track if @blk_lpos was a wrapping data block. */
> +	wrapped = (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, blk_lpos->next));
> +
> +	size = to_blk_size(size);
> +
> +	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
> +
> +	/* If the data block does not increase, there is nothing to do. */
> +	if (next_lpos == head_lpos) {
> +		blk = to_block(data_ring, blk_lpos->begin);
> +		return &blk->data[0];
> +	}

We might be here even when the data are shrinked but the code below
is not fully ready for this.

> +	if (!data_push_tail(rb, data_ring, next_lpos - DATA_SIZE(data_ring)))
> +		return NULL;
> +
> +	/* The memory barrier involvement is the same as data_alloc:A. */
> +	if (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &head_lpos,
> +				     next_lpos)) { /* LMM(data_realloc:A) */
> +		return NULL;
> +	}
> +
> +	blk = to_block(data_ring, blk_lpos->begin);
> +
> +	if (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, next_lpos)) {
> +		struct prb_data_block *old_blk = blk;
> +
> +		/* Wrapping data blocks store their data at the beginning. */
> +		blk = to_block(data_ring, 0);
> +
> +		/*
> +		 * Store the ID on the wrapped block for consistency.
> +		 * The printk_ringbuffer does not actually use it.
> +		 */
> +		blk->id = id;
> +
> +		if (!wrapped) {
> +			/*
> +			 * Since the allocated space is now in the newly
> +			 * created wrapping data block, copy the content
> +			 * from the old data block.
> +			 */
> +			memcpy(&blk->data[0], &old_blk->data[0],
> +			       (blk_lpos->next - blk_lpos->begin) - sizeof(blk->id));

It took me quite some time to check whether this code is correct or not.

First, I wondered whether the size was correctly calculated.
It is because the original block was not wrapped, so
lpos->next - lpos->beging defines the real data buffer size.

Second, I wondered whether the target block might be smaller
than the original (the above check allows shrinking). It can't
be smaller because then the new block won't be wrapped as well.

Sigh, it is a bit tricky. And there is 3rd possibility that
is not handled. The original block might be wrapped but
the new shrunken one might not longer be wrapped.
Then we would need to copy the data the other way.


I know that this function is not currently used for shrinking.
But I would prefer to be on the safe side. Either make
the copying generic, e.g. by calculating the real data size
using the code from get_data(). Or simply comletely
refuse shrinking by the above check.

Best Regards,
Petr

> +		}
> +	}
> +
> +	blk_lpos->next = next_lpos;
> +
> +	return &blk->data[0];
> +}
> +
>  /* Return the number of bytes used by a data block. */
>  static unsigned int space_used(struct prb_data_ring *data_ring,
>  			       struct prb_data_blk_lpos *blk_lpos)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
