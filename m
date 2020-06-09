Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jifYL-0000nR-2l
 for kexec@lists.infradead.org; Tue, 09 Jun 2020 14:48:39 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: redundant check in make_data_reusable(): was [PATCH v2 2/3]
 printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609093103.GB23752@linux-b0ei>
Date: Tue, 09 Jun 2020 16:48:30 +0200
In-Reply-To: <20200609093103.GB23752@linux-b0ei> (Petr Mladek's message of
 "Tue, 9 Jun 2020 11:31:03 +0200")
Message-ID: <87lfkwuwg1.fsf@vostro.fn.ogness.net>
MIME-Version: 1.0
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
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-06-09, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/printk_ringbuffer.c
>> +/*
>> + * Given a data ring (text or dict), put the associated descriptor of each
>> + * data block from @lpos_begin until @lpos_end into the reusable state.
>> + *
>> + * If there is any problem making the associated descriptor reusable, either
>> + * the descriptor has not yet been committed or another writer task has
>> + * already pushed the tail lpos past the problematic data block. Regardless,
>> + * on error the caller can re-load the tail lpos to determine the situation.
>> + */
>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>> +			       struct prb_data_ring *data_ring,
>> +			       unsigned long lpos_begin,
>> +			       unsigned long lpos_end,
>> +			       unsigned long *lpos_out)
>> +{
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	struct prb_data_blk_lpos *blk_lpos;
>> +	struct prb_data_block *blk;
>> +	unsigned long tail_lpos;
>> +	enum desc_state d_state;
>> +	struct prb_desc desc;
>> +	unsigned long id;
>> +
>> +	/*
>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
>> +	 * blk_lpos within the local copy of the descriptor.
>> +	 */
>> +	if (data_ring == &rb->text_data_ring)
>> +		blk_lpos = &desc.text_blk_lpos;
>> +	else
>> +		blk_lpos = &desc.dict_blk_lpos;
>> +
>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>> +		blk = to_block(data_ring, lpos_begin);
>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
>> +
>> +		/*
>> +		 * Guarantee the block ID is loaded before checking the tail
>> +		 * lpos. The loaded block ID can only be considered valid if
>> +		 * the tail lpos has not overtaken @lpos_begin. This pairs
>> +		 * with data_alloc:A.
>> +		 *
>> +		 * Memory barrier involvement:
>> +		 *
>> +		 * If data_make_reusable:A reads from data_alloc:B, then
>> +		 * data_make_reusable:C reads from data_push_tail:D.
>> +		 *
>> +		 * Relies on:
>> +		 *
>> +		 * MB from data_push_tail:D to data_alloc:B
>> +		 *    matching
>> +		 * RMB from data_make_reusable:A to data_make_reusable:C
>> +		 *
>> +		 * Note: data_push_tail:D and data_alloc:B can be different
>> +		 *       CPUs. However, the data_alloc:B CPU (which performs
>> +		 *       the full memory barrier) must have previously seen
>> +		 *       data_push_tail:D.
>> +		 */
>> +		smp_rmb(); /* LMM(data_make_reusable:B) */
>> +
>> +		tail_lpos = atomic_long_read(&data_ring->tail_lpos
>> +					); /* LMM(data_make_reusable:C) */
>> +
>> +		/*
>> +		 * If @lpos_begin has fallen behind the tail lpos, the read
>> +		 * block ID cannot be trusted. Fast forward @lpos_begin to the
>> +		 * tail lpos and try again.
>> +		 */
>> +		if (lpos_begin - tail_lpos >= DATA_SIZE(data_ring)) {
>> +			lpos_begin = tail_lpos;
>> +			continue;
>> +		}
>
> I am sorry if we have had this discussion already in past.

We have [0]. (Search for "Ouch.")

> Well, it would just prove that it really needs a comment why this
> check is necessary.

The comment says why it is necessary. The previous read of the block ID
cannot be trusted if the the tail has been pushed beyond it.

> IMHO, the following check of the descriptor state should be enough:
>
> 1. This function returns "false" when the descriptor is in desc_misc or
>    desc_reusable state or when it does not point back to the data.
>
>    In this case, data_push_tail() does similar check. It loads
>    data_ring->tail_lpos as well. It returns false when the tail did
>    not move. Otherwise, it calls data_make_reusable() again and has
>    the same effect as the continue here.
>
>
> 2. This function returns true only when the descriptor is in committed
>    or reusable state and points back to the same data block. In this,
>    case it really contains consistent data.
>
>    OK, it is possible that the block is already reused when the
>    descriptor is in reusable state. But it is possible only when
>    data_ring->tail_lpos moved. In this case, cmpxchg in
>    data_push_tail() would fail and we would go back as well.

In your email from our previous discussion, you pointed out that two
writers could race to allocate a block and the loser would start freeing
the winner's data because it gets a valid block ID to a descriptor in
the committed state that points back to the block lpos.

You wrote:

> => We should add a check into data_make_reusable() that
>    we are invalidating really the descriptor pointing to
>    the given lpos and not a freshly reused one!

That is what this check is doing. If the tail has been pushed beyond the
block, we cannot trust the block ID read because that area may have been
recycled already.

>> +/*
>> + * Advance the data ring tail to at least @lpos. This function puts
>> + * descriptors into the reusable state if the tail is pushed beyond
>> + * their associated data block.
>> + */
>> +static bool data_push_tail(struct printk_ringbuffer *rb,
>> +			   struct prb_data_ring *data_ring,
>> +			   unsigned long lpos)
>> +{
>> +	unsigned long tail_lpos;
>> +	unsigned long next_lpos;
>> +
>> +	/* If @lpos is not valid, there is nothing to do. */
>> +	if (lpos == INVALID_LPOS)
>> +		return true;
>> +
>> +	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
>> +
>> +	do {
>> +		/* Done, if the tail lpos is already at or beyond @lpos. */
>> +		if ((lpos - tail_lpos) - 1 >= DATA_SIZE(data_ring))
>> +			break;
>> +
>> +		/*
>> +		 * Make all descriptors reusable that are associated with
>> +		 * data blocks before @lpos.
>> +		 */
>> +		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
>> +					&next_lpos)) {
>> +			/*
>> +			 * Guarantee the descriptor state loaded in
>> +			 * data_make_reusable() is performed before reloading
>> +			 * the tail lpos. The failed data_make_reusable() may
>> +			 * be due to a newly recycled descriptor causing
>> +			 * the tail lpos to have been previously pushed. This
>> +			 * pairs with desc_reserve:D.
>> +			 *
>> +			 * Memory barrier involvement:
>> +			 *
>> +			 * If data_make_reusable:D reads from desc_reserve:G,
>> +			 * then data_push_tail:B reads from data_push_tail:D.
>> +			 *
>> +			 * Relies on:
>> +			 *
>> +			 * MB from data_push_tail:D to desc_reserve:G
>> +			 *    matching
>> +			 * RMB from data_make_reusable:D to data_push_tail:B
>> +			 *
>> +			 * Note: data_push_tail:D and desc_reserve:G can be
>> +			 *       different CPUs. However, the desc_reserve:G
>> +			 *       CPU (which performs the full memory barrier)
>> +			 *       must have previously seen data_push_tail:D.
>> +			 */
>> +			smp_rmb(); /* LMM(data_push_tail:A) */
>> +
>> +			next_lpos = atomic_long_read(&data_ring->tail_lpos
>> +						); /* LMM(data_push_tail:B) */
>
> I have been a bit confused whether next_lpos variable is used
> correctly everywhere. The primary purpose is to use a value provided
> by data_make_reusable() in the cmpxchg below.
>
> But it is (mis)used here to temporary store the current tail_lpos
> value. Could we please use another variable here? IMHO, the following
> code would be more clear:
>
> 	tail_lpos_old = tail_lpos;
> 	tail_lpos = atomic_long_read(&data_ring->tail_lpos); /* LMM(data_push_tail:B) */
>
> 	if (tail_lpos == tail_lpos_old)
> 		return false;

You are correct. I am ashamed about this misuse. I will add the variable
and rely on the compiler to appropriately merge/recycle stack variables.

John Ogness

[0] https://lkml.kernel.org/r/87ftecy343.fsf@linutronix.de

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
