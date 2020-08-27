Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBIt1-0001YP-Sa
 for kexec@lists.infradead.org; Thu, 27 Aug 2020 14:28:22 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
In-Reply-To: <20200827125047.GB4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <20200827125047.GB4353@alley>
Date: Thu, 27 Aug 2020 16:34:16 +0206
Message-ID: <87mu2g5fjz.fsf@jogness.linutronix.de>
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

Hi Petr,

Thanks for the review. Most of your suggested changes are fine and I'll
integrate them for the next version. Here a few comments on some open
issues.

On 2020-08-27, Petr Mladek <pmladek@suse.com> wrote:
>> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
>> +					 unsigned long *id_out)
>> +{
>> +	unsigned long prev_state_val;
>> +	struct prb_desc *d;
>> +	unsigned long id;
>> +
>> +	id = atomic_long_read(&desc_ring->head_id);
>> +
>> +	d = to_desc(desc_ring, id);
>> +
>> +	prev_state_val = id | DESC_COMMIT_MASK;
>> +	if (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val, id | 0))
>> +		return NULL;
>
> This might deserve a comment why any barrier is not needed here.
> I guess that you did not add it because the reader API allows
> to read data only when DESC_FINAL_MASK is set.
>
> But this assumption looks dangerous to me. As I already wrote above.
> We might later need to add an API to read the already committed
> parts of a continuous lines.

Supporting such an API will require more than just a memory barrier
here. When a record is re-opened, it actually transitions back to a
reserved state. At that point there is no difference between a record
being extended and one that is reserved for the first time.

Perhaps my idea of chaining blocks [0] might be more appropriate. Then
there are discrete committed pieces that can be read if needed.

Either way, such a partial-read feature will require a new memory
barrier pair so a reader would see the state change before any data was
modified. As the code is now (without such a feature), a memory barrier
is not needed.

>> +static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
>> +{
>> +	unsigned long prev_state_val = id | DESC_COMMIT_MASK;
>> +	struct prb_desc *d = to_desc(desc_ring, id);
>> +	bool is_final;
>> +
>> +	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
>> +						prev_state_val | DESC_FINAL_MASK)) {
>> +
>> +		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
>> +			break;
>> +
>> +		if (is_final)
>> +			break;
>> +	}
>
> Do we need the cycle and check if it succeeded?

The initial cmpxchg() is assuming the previous descriptor is in the
commit+!final state (common case). But, for example, if it was in the
reserve+final state, the cmpxhg() would fail and the finalization is
already successful.

> When could the cmpxchg fail?
>
>     + It is still reserved or reserved again => it should get
>       finalized by the one who reserved it. This is related to
>       the problem reported/discussed in the other thread,
>       see https://lore.kernel.org/r/87lfi1ls2g.fsf@jogness.linutronix.de
>
>     + It is already in the final (committed) state => success
>
>     + It is in reusable state => already done in the past
>
>     + It is already reused => already done in the past

  + It is being reserved but is still uninitialized (state_var = 0).

  + It is being reserved but is not yet set (id is one wrap behind).

> IMHO, the following simple call should be enough.
>
> 	atomic_long_try_cmpxchg_relaxed(&d->state_var,	&prev_state_val,
> 					prev_state_val | DESC_FINAL_MASK);

This works if we define that the FINAL flag can only be set when the
COMMIT flag is set. (More on this below.)

> Well, I am not sure about the "relaxed" variant again. I would feel
> more comfortable when it is full barrier especially because it
> might be done by another CPU than what did the commit. And
> we need to avoid the race when nobody finalize the record.

The FINAL flag has nothing to do with whether or not the data is
consistent. It's only use is to prevent a writer from transitioning a
descriptor back to reserved via cmpxchg(). What would a memory barrier
here be pairing with?

>> +static void _prb_commit(struct prb_reserved_entry *e, unsigned long final_mask)
>>  {
>>  	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
>>  	struct prb_desc *d = to_desc(desc_ring, e->id);
>>  	unsigned long prev_state_val = e->id | 0;
>>  
>> -	/* Now the writer has finished all writing: LMM(prb_commit:A) */
>> +	/* Now the writer has finished all writing: LMM(_prb_commit:A) */
>>  
>>  	/*
>>  	 * Set the descriptor as committed. See "ABA Issues" about why
>> @@ -1244,14 +1518,66 @@ void prb_commit(struct prb_reserved_entry *e)
>>  	 * this. This pairs with desc_read:B.
>>  	 */
>>  	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
>> -				     e->id | DESC_COMMIT_MASK)) { /* LMM(prb_commit:B) */
>> -		WARN_ON_ONCE(1);
>> +				     e->id | DESC_COMMIT_MASK |
>> +					     final_mask)) { /* LMM(_prb_commit:B) */
>> +		/*
>> +		 * This reserved descriptor must have been finalized already.
>> +		 * Retry with a reserved+final expected value.
>> +		 */
>> +		prev_state_val = e->id | 0 | DESC_FINAL_MASK;
>
> This does not make sense to me. The state "e->id | 0 | DESC_FINAL_MASK"
> must never happen. It would mean that someone finalized
> record that is still being modified.

Correct. Setting the FINAL flag means the descriptor cannot be
_reopened_. It has nothing to do with the current state of the
descriptor. Once the FINAL flag is set, it remains set for the remaining
lifetime of that record.

> Or we both have different understanding of the logic.

Yes.

> Well, there are actually two approaches:
>
>    + I originally expected that FINAL bit could be set only when
>      COMMIT bit is set. But this brings the problems that prb_commit()
>      would need to set FINAL when it is not longer the last descriptor.

My first attempt was to implement this. It turned out complex because it
involves descriptors finalizing themselves _and_ descriptors finalizing
their predecessor. This required two new memory barrier pairs:

  - between a writer committing and re-checking the head_id that another
    writer may have modified

  - between a writer setting the state and another writer checking that
    state

After re-evaluating the purpose of the FINAL flag, I decided that it
would be simpler to implement the 2nd approach (below) and would not
require any new memory barrier pairs.

>    + Another approach is that FINAL bit could be set even when the
>      COMMIT is not set. It would always be set by the next
>      prb_reserve(). But it causes that there are more possible
>      combinations of COMMIT and FINAL bits. As a result, the caller
>      would  need try more variants of the cmpxchg() calls. And
>      it creates another races/cycles, ...

It does not cause more races. And I don't see where it will cause more
cmpxchg() calls. It probably _does_ lead to more cmpxchg() _code_. But
those are fallbacks for when the common case fails.

> I guess that you wanted to implement the 2nd approach and ended in
> many troubles. I wonder if the 1st approach might be easier.

Well, the "many troubles" were due to my naive assumption about the
previous descriptor state. Once I realized that, the missing piece was
obvious.

I will reconsider the first approach. Perhaps adding memory barriers is
preferable if it reduces lines of code.

And we will need to clarify partial continuous line reading because
right now that will not work.

John Ogness

[0] https://lkml.kernel.org/r/875z9nvvl2.fsf@jogness.linutronix.de

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
