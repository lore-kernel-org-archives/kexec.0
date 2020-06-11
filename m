Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjTEV-0001OT-AL
 for kexec@lists.infradead.org; Thu, 11 Jun 2020 19:51:29 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: redundant check in make_data_reusable(): was [PATCH v2 2/3]
 printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609093103.GB23752@linux-b0ei>
 <87lfkwuwg1.fsf@vostro.fn.ogness.net>
 <20200610093835.GB4311@linux-b0ei>
 <87o8prp6bi.fsf@vostro.fn.ogness.net>
 <87d067otoq.fsf@vostro.fn.ogness.net>
Date: Thu, 11 Jun 2020 21:51:18 +0200
In-Reply-To: <87d067otoq.fsf@vostro.fn.ogness.net> (John Ogness's message of
 "Wed, 10 Jun 2020 16:56:53 +0200")
Message-ID: <87k10dtm89.fsf@vostro.fn.ogness.net>
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

On 2020-06-10, John Ogness <john.ogness@linutronix.de> wrote:
>>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>>> +			       struct prb_data_ring *data_ring,
>>> +			       unsigned long lpos_begin,
>>> +			       unsigned long lpos_end,
>>> +			       unsigned long *lpos_out)
>>> +{
>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>> +	struct prb_data_blk_lpos *blk_lpos;
>>> +	struct prb_data_block *blk;
>>> +	unsigned long tail_lpos;
>>> +	enum desc_state d_state;
>>> +	struct prb_desc desc;
>>> +	unsigned long id;
>>> +
>>> +	/*
>>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
>>> +	 * blk_lpos within the local copy of the descriptor.
>>> +	 */
>>> +	if (data_ring == &rb->text_data_ring)
>>> +		blk_lpos = &desc.text_blk_lpos;
>>> +	else
>>> +		blk_lpos = &desc.dict_blk_lpos;
>>> +
>>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>>> +		blk = to_block(data_ring, lpos_begin);
>>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
>>> +
>>> +		/*
>>> +		 * Guarantee the block ID is loaded before checking the tail
>>> +		 * lpos. The loaded block ID can only be considered valid if
>>> +		 * the tail lpos has not overtaken @lpos_begin. This pairs
>>> +		 * with data_alloc:A.
>>> +		 *
>>> +		 * Memory barrier involvement:
>>> +		 *
>>> +		 * If data_make_reusable:A reads from data_alloc:B, then
>>> +		 * data_make_reusable:C reads from data_push_tail:D.
>>> +		 *
>>> +		 * Relies on:
>>> +		 *
>>> +		 * MB from data_push_tail:D to data_alloc:B
>>> +		 *    matching
>>> +		 * RMB from data_make_reusable:A to data_make_reusable:C
>>> +		 *
>>> +		 * Note: data_push_tail:D and data_alloc:B can be different
>>> +		 *       CPUs. However, the data_alloc:B CPU (which performs
>>> +		 *       the full memory barrier) must have previously seen
>>> +		 *       data_push_tail:D.
>>> +		 */
>>> +		smp_rmb(); /* LMM(data_make_reusable:B) */
>>> +
>>> +		tail_lpos = atomic_long_read(&data_ring->tail_lpos
>>> +					); /* LMM(data_make_reusable:C) */
>>> +
>>> +		/*
>>> +		 * If @lpos_begin has fallen behind the tail lpos, the read
>>> +		 * block ID cannot be trusted. Fast forward @lpos_begin to the
>>> +		 * tail lpos and try again.
>>> +		 */
>>> +		if (lpos_begin - tail_lpos >= DATA_SIZE(data_ring)) {
>>> +			lpos_begin = tail_lpos;
>>> +			continue;
>>> +		}
>>> +
>>> +		d_state = desc_read(desc_ring, id,
>>> +				    &desc); /* LMM(data_make_reusable:D) */
>>> +
>>> +		switch (d_state) {
>>> +		case desc_miss:
>>> +			return false;
>>> +		case desc_reserved:
>>> +			return false;
>>> +		case desc_committed:
>>> +			/*
>>> +			 * This data block is invalid if the descriptor
>>> +			 * does not point back to it.
>>> +			 */
>>
>> Here again the comments describe what the check does but not why.
>> I would write something like:
>>
>> 			/*
>> 			 * The block might have already been
>> 			 * reused. Make sure that the descriptor really
>> 			 * points back to the checked lpos. It covers
>> 			 * both situations. Random data might point to
>> 			 * a valid descriptor just by chance. Or the block
>> 			 * has been already reused by another descriptor.
>> 			 */
>
> Originally this check was needed because the descriptor would be read
> even if there was a data race reading the ID from the data
> block. Validating the lpos value was a kind of protection against
> reading random data that by chance yielded an ID of a committed/reusable
> descriptor.
>
> However, after you pointed out that this check was not enough, the code
> now re-checks the data tail to make sure that no data race happened. So
> actually it is not possible that a descriptor in the committed/reusable
> state will point anywhere else. We know the ID is not random garbage or
> recycled, so the state can be trusted.
>
> I recommend to either remove this sanity check (for committed and
> reusable) or at least change it to:
>
> 			WARN_ON_ONCE(blk_lpos->begin != lpos_begin);

Sorry, I wasn't thinking things out correctly which this suggestion. We
need the checks. The explanation is as follows...

With regard to the block ID read (data_make_reusable:A):

Failing the following tail check is a guarantee that we read
garbage. Data behind the data tail must never be trusted. It is correct
to try again with the new tail value.

Passing the following tail check could still be a garbage read. The
descriptor owning that data block may be in the reserved state and has
not yet written the new block ID. In that case we read whatever random
data was there even though the tail check passes. And that random data
could yield a valid descriptor ID, resulting in some state value that
does not apply.

The "descriptor pointing back to data block" checks are playing the
critical role of protecting against data_make_reusable:A reading
garbage. And indeed, I can reproduce this situation fairly easily on
ppc64le+kvm tests.

So please disregard this suggestion. And yes, the comments for these
checks need to be expanded to make clear just how critical they are and
explain how the situation can occur.

John Ogness

>>> +			if (blk_lpos->begin != lpos_begin)
>>> +				return false;
>>> +			desc_make_reusable(desc_ring, id);
>>> +			break;
>>> +		case desc_reusable:
>>> +			/*
>>> +			 * This data block is invalid if the descriptor
>>> +			 * does not point back to it.
>>> +			 */
>>> +			if (blk_lpos->begin != lpos_begin)
>>> +				return false;
>>> +			break;
>>> +		}
>>> +
>>> +		/* Advance @lpos_begin to the next data block. */
>>> +		lpos_begin = blk_lpos->next;
>>> +	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
