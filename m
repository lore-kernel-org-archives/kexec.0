Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjNfl-0001ZO-06
 for kexec@lists.infradead.org; Thu, 11 Jun 2020 13:55:15 +0000
Date: Thu, 11 Jun 2020 15:55:09 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: redundant check in make_data_reusable(): was [PATCH v2 2/3]
 printk: add lockless buffer
Message-ID: <20200611135509.GE6581@linux-b0ei>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609093103.GB23752@linux-b0ei>
 <87lfkwuwg1.fsf@vostro.fn.ogness.net>
 <20200610093835.GB4311@linux-b0ei>
 <87o8prp6bi.fsf@vostro.fn.ogness.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o8prp6bi.fsf@vostro.fn.ogness.net>
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

On Wed 2020-06-10 12:24:01, John Ogness wrote:
> On 2020-06-10, Petr Mladek <pmladek@suse.com> wrote:
> >> >> --- /dev/null
> >> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> >> +/*
> >> >> + * Given a data ring (text or dict), put the associated descriptor of each
> >> >> + * data block from @lpos_begin until @lpos_end into the reusable state.
> >> >> + *
> >>>> + * If there is any problem making the associated descriptor reusable, either
> >>>> + * the descriptor has not yet been committed or another writer task has
> >>>> + * already pushed the tail lpos past the problematic data block. Regardless,
> >>>> + * on error the caller can re-load the tail lpos to determine the situation.
> >>>> + */
> >>>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
> >>>> +			       struct prb_data_ring *data_ring,
> >>>> +			       unsigned long lpos_begin,
> >>>> +			       unsigned long lpos_end,
> >>>> +			       unsigned long *lpos_out)
> >>>> +{
> >>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >>>> +	struct prb_data_blk_lpos *blk_lpos;
> >>>> +	struct prb_data_block *blk;
> >>>> +	unsigned long tail_lpos;
> >>>> +	enum desc_state d_state;
> >>>> +	struct prb_desc desc;
> >>>> +	unsigned long id;
> >>>> +
> >>>> +	/*
> >>>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
> >>>> +	 * blk_lpos within the local copy of the descriptor.
> >>>> +	 */
> >>>> +	if (data_ring == &rb->text_data_ring)
> >>>> +		blk_lpos = &desc.text_blk_lpos;
> >>>> +	else
> >>>> +		blk_lpos = &desc.dict_blk_lpos;
> >>>> +
> >>>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
> >>>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
> >>>> +		blk = to_block(data_ring, lpos_begin);
> >>>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
> >>>> +
> >>>> +		/*
> >>>> +		 * Guarantee the block ID is loaded before checking the tail
> >>>> +		 * lpos. The loaded block ID can only be considered valid if
> >>>> +		 * the tail lpos has not overtaken @lpos_begin. This pairs
> >>>> +		 * with data_alloc:A.
> >>>> +		 *
> >>>> +		 * Memory barrier involvement:
> >>>> +		 *
> >>>> +		 * If data_make_reusable:A reads from data_alloc:B, then
> >>>> +		 * data_make_reusable:C reads from data_push_tail:D.
> >>>> +		 *
> >>>> +		 * Relies on:
> >>>> +		 *
> >>>> +		 * MB from data_push_tail:D to data_alloc:B
> >>>> +		 *    matching
> >>>> +		 * RMB from data_make_reusable:A to data_make_reusable:C
> >>>> +		 *
> >>>> +		 * Note: data_push_tail:D and data_alloc:B can be different
> >>>> +		 *       CPUs. However, the data_alloc:B CPU (which performs
> >>>> +		 *       the full memory barrier) must have previously seen
> >>>> +		 *       data_push_tail:D.
> >>>> +		 */
> >>>> +		smp_rmb(); /* LMM(data_make_reusable:B) */
> >>>> +
> >>>> +		tail_lpos = atomic_long_read(&data_ring->tail_lpos
> >>>> +					); /* LMM(data_make_reusable:C) */
> >>>> +
> >>>> +		/*
> >>>> +		 * If @lpos_begin has fallen behind the tail lpos, the read
> >>>> +		 * block ID cannot be trusted. Fast forward @lpos_begin to the
> >>>> +		 * tail lpos and try again.
> >>>> +		 */
> >>>> +		if (lpos_begin - tail_lpos >= DATA_SIZE(data_ring)) {
> >>>> +			lpos_begin = tail_lpos;
> >>>> +			continue;
> >>>> +		}
> >>>
> >>> I am sorry if we have had this discussion already in past.
> >> 
> >> We have [0]. (Search for "Ouch.")
> >
> > I see. Thanks a lot for the pointer.
> >
> >>> Well, it would just prove that it really needs a comment why this
> >>> check is necessary.
> >> 
> >> The comment says why it is necessary. The previous read of the block ID
> >> cannot be trusted if the the tail has been pushed beyond it.
> >
> > Not really. The comment describes what the check does. But it does not
> > explain why it is needed. The reason might be described be something like:
> >
> > 		* Make sure that the id read from tail_lpos is really
> > 		* pointing to this lpos. The block might have been
> > 		* reused in the meantime. Make sure to do not make
> > 		* the new owner reusable.
> 
> That is _not_ what this check is doing. I recommend looking closely at
> the example you posted. This is not about whether or not a descriptor is
> pointing to this lpos. In your example you showed that ID, state, and
> lpos values could all look good, but it is for the _new_ record and we
> should _not_ invalidate that one.

OK, let's make sure that we are talking about the same example.
I was talking about this one from
https://lore.kernel.org/lkml/87ftecy343.fsf@linutronix.de/

% [*] Another problem would be when data_make_reusable() see the new
%     data already in the committed state. It would make fresh new
%     data reusable.
%
%     I mean the following:
%
% CPU0				CPU1
%
% data_alloc()
%   begin_lpos = dr->head_lpos
%   data_push_tail()
%     lpos = dr->tail_lpos
%				prb_reserve()
%				  # reserve the location of current
%				  # dr->tail_lpos
%				prb_commit()
%
%     id = blk->id
%     # read id for the freshly written data on CPU1
%     # and happily make them reusable
%     data_make_reusable()

Sigh, sigh, sigh, there is a hugely misleading comment in the example:

%				  # reserve the location of current
%				  # dr->tail_lpos

It is true that it reserves part of this location. But it will use
data_ring->head_lpos for the related desc->text_blk_lpos.begin !!!

See below:

> We can detect the scenario you pointed out by verifying the tail has not
> moved beyond the data block that the ID was read from. The comment for
> this check says:
> 
>     If @lpos_begin has fallen behind the tail lpos,
>     the read block ID cannot be trusted.
> 
> This is exactly the why. It is only about whether we can trust that a
> non-garbage block ID was read. Or do you want me to add:
> 
>     ... because data read that is behind the tail lpos must be
>     considered garbage.
> 
> > But wait! This situation should get caught by the two existing descriptor
> > checks:
> >
> >>		case desc_committed:
> >>			/*
> >>			 * This data block is invalid if the descriptor
> >>			 * does not point back to it.
> >>			 */
> >>			if (blk_lpos->begin != lpos_begin)
> >>				return false;
> >>			desc_make_reusable(desc_ring, id);
> >>			break;
> >>		case desc_reusable:
> >>			/*
> >>			 * This data block is invalid if the descriptor
> >>			 * does not point back to it.
> >>			 */
> >>			if (blk_lpos->begin != lpos_begin)
> >>				return false;
> >>			break;
> 
> No. Your example showed that it is not caught here.

I am afraid that my example was wrong:

If blk->id comes from the new descriptor written by CPU1 then
blk_lpos->begin is based on the old data_ring->head_lpos.
Then it is different from lpos_begin.


Let's put it another way. The state of the descriptor defines validity
of the data. Descriptor in committed state _must not_ point to invalid
data block!!!

If a descriptor in committed state point to lpos that was in invalid range
before reading the descriptor then we have a huge hole in the design.

This is why I believe that the check of the descriptor must be enough.


Best Regards,
Petr

PS: I am sorry if I create too much confusion. It is easy to
get lost :-(

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
