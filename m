Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jj1C9-0002KE-NB
 for kexec@lists.infradead.org; Wed, 10 Jun 2020 13:55:11 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: blk->id read race: was: [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609071030.GA23752@linux-b0ei>
 <87tuzkuxtw.fsf@vostro.fn.ogness.net>
 <20200610084248.GA4311@linux-b0ei>
Date: Wed, 10 Jun 2020 15:55:00 +0200
In-Reply-To: <20200610084248.GA4311@linux-b0ei> (Petr Mladek's message of
 "Wed, 10 Jun 2020 10:42:48 +0200")
Message-ID: <87k10fowjv.fsf@vostro.fn.ogness.net>
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

On 2020-06-10, Petr Mladek <pmladek@suse.com> wrote:
>>>> --- /dev/null
>>>> +++ b/kernel/printk/printk_ringbuffer.c
>>>> +/*
>>>> + * Given a data ring (text or dict), put the associated descriptor of each
>>>> + * data block from @lpos_begin until @lpos_end into the reusable state.
>>>> + *
>>>> + * If there is any problem making the associated descriptor reusable, either
>>>> + * the descriptor has not yet been committed or another writer task has
>>>> + * already pushed the tail lpos past the problematic data block. Regardless,
>>>> + * on error the caller can re-load the tail lpos to determine the situation.
>>>> + */
>>>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>>>> +			       struct prb_data_ring *data_ring,
>>>> +			       unsigned long lpos_begin,
>>>> +			       unsigned long lpos_end,
>>>> +			       unsigned long *lpos_out)
>>>> +{
>>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>>> +	struct prb_data_blk_lpos *blk_lpos;
>>>> +	struct prb_data_block *blk;
>>>> +	unsigned long tail_lpos;
>>>> +	enum desc_state d_state;
>>>> +	struct prb_desc desc;
>>>> +	unsigned long id;
>>>> +
>>>> +	/*
>>>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
>>>> +	 * blk_lpos within the local copy of the descriptor.
>>>> +	 */
>>>> +	if (data_ring == &rb->text_data_ring)
>>>> +		blk_lpos = &desc.text_blk_lpos;
>>>> +	else
>>>> +		blk_lpos = &desc.dict_blk_lpos;
>>>> +
>>>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>>>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>>>> +		blk = to_block(data_ring, lpos_begin);
>>>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
>>>
>>> This would deserve some comment:
>
> I wonder if the comment might look like:
>
> /*
>  * No barrier is needed between reading tail_lpos and the related
>  * blk->id. Only CPU that modifies tail_lpos via cmpxchg is allowed
>  * to modify the related blk->id. CPUs that see the moved tail_lpos
>  * are looking at another block related to the new tail_lpos.
>  * It does not mater when the previous winner modifies the previous
>  * block.
>  */

Sorry, but this comment does not make sense for me. The tail is pushed
_before_ the block ID is modified. So any kind of barrier here (where we
read the tail, then the block ID, i.e. the same order) would be
inappropriate anyway.

Also, this comment only talks about when a new value is seen, but not
about when the old value is seen. IMO it is seeing the old value that is
worthy of a comment since that is the only case with a data race.

In preparation for my next version I have added the following comment:

        blk = to_block(data_ring, lpos_begin);

        /*
         * When going from lpos to block pointer, the wrap around
         * feature of the lpos value is lost. Since another CPU could
         * invalidate this data area at any time, the data tail must
         * be re-checked after the block ID has been read.
         */

        id = blk->id; /* LMM(data_make_reusable:A) */

I think this comment also helps to further clarify "why" the following
data tail check occurs.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
