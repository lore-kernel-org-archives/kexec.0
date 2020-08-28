Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBbC4-0002GW-Sg
 for kexec@lists.infradead.org; Fri, 28 Aug 2020 10:01:14 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
In-Reply-To: <20200828072148.GC4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
 <20200826100113.GA8849@jagdpanzerIV.localdomain>
 <87eentlh19.fsf@jogness.linutronix.de> <20200826150726.GA4928@alley>
 <87pn7c5s0t.fsf@jogness.linutronix.de> <20200828072148.GC4353@alley>
Date: Fri, 28 Aug 2020 12:07:09 +0206
Message-ID: <873647144a.fsf@jogness.linutronix.de>
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

On 2020-08-28, Petr Mladek <pmladek@suse.com> wrote:
>> Below is a patch against this series that adds support for finalizing
>> all 4 queried states. It passes all my tests. Note that the code handles
>> 2 corner cases:
>> 
>> 1. When seq is 0, there is no previous descriptor to finalize. This
>>    exception is important because we don't want to finalize the -1
>>    placeholder. Otherwise, upon the first wrap, a descriptor will be
>>    prematurely finalized.
>> 
>> 2. When a previous descriptor is being reserved for the first time, it
>>    might have a state_var value of 0 because the writer is still in
>>    prb_reserve() and has not set the initial value yet. I added
>>    considerable comments on this special case.
>> 
>> I am comfortable with adding this new code, although it clearly adds
>> complexity.
>> 
>> John Ogness
>> 
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 90d48973ac9e..1ed1e9eb930f 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -860,9 +860,11 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>  	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>  	unsigned long prev_state_val;
>>  	unsigned long id_prev_wrap;
>> +	unsigned long state_val;
>>  	struct prb_desc *desc;
>>  	unsigned long head_id;
>>  	unsigned long id;
>> +	bool is_final;
>>  
>>  	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(desc_reserve:A) */
>>  
>> @@ -953,10 +955,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>  	 * See "ABA Issues" about why this verification is performed.
>>  	 */
>>  	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
>> -	if (prev_state_val &&
>> -	    get_desc_state(id_prev_wrap, prev_state_val, NULL) != desc_reusable) {
>> -		WARN_ON_ONCE(1);
>> -		return false;
>> +	if (get_desc_state(id_prev_wrap, prev_state_val, &is_final) != desc_reusable) {
>> +		/*
>> +		 * If this descriptor has never been used, @prev_state_val
>> +		 * will be 0. However, even though it may have never been
>> +		 * used, it may have been finalized. So that flag must be
>> +		 * ignored.
>> +		 */
>> +		if ((prev_state_val & ~DESC_FINAL_MASK)) {
>> +			WARN_ON_ONCE(1);
>> +			return false;
>> +		}
>>  	}
>>  
>>  	/*
>> @@ -967,10 +976,25 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>  	 * any other changes. A write memory barrier is sufficient for this.
>>  	 * This pairs with desc_read:D.
>>  	 */
>> -	if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
>> -				     id | 0)) { /* LMM(desc_reserve:F) */
>> -		WARN_ON_ONCE(1);
>> -		return false;
>> +	if (is_final)
>> +		state_val = id | 0 | DESC_FINAL_MASK;
>
> The state from the previous wrap always have to have DESC_FINAL_MASK set.
> Do I miss something, please?

Important: FINAL is not a _state_. It is a _flag_ that marks a
descriptor as non-reopenable. This was a simple change because it does
not affect any state logic. The number of states and possible
transitions have not changed.

When a descriptor transitions to reusable, the FINAL flag is cleared. It
has reached the end of its lifecycle. See desc_make_reusable().

(In order to have transitioned to reusable, the FINAL and COMMIT flags
must have been set.)

In the case of desc_reserve(), a reusable descriptor is transitioning to
reserved. When this transition happens, there may already be a later
descriptor that has been reserved and finalized this descriptor. If the
FINAL flag is set here, it means that the FINAL flag is set for the
_new_ descriptor being reserved.

In summary, the FINAL flag can be set in _any_ state. Once set, it is
preserved for all further state transitions. And it is cleared when that
descriptor becomes reusable.

>> +	else
>> +		state_val = id | 0;
>> +	if (atomic_long_cmpxchg(&desc->state_var, prev_state_val,
>> +				state_val) != prev_state_val) { /* LMM(desc_reserve:F) */
>> +		/*
>> +		 * This reusable descriptor must have been finalized already.
>> +		 * Retry with a reusable+final expected value.
>> +		 */
>> +		prev_state_val |= DESC_FINAL_MASK;
>> +		state_val |= DESC_FINAL_MASK;
>> +
>> +		if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
>> +					     state_val)) { /* LMM(desc_reserve:FIXME) */
>> +
>> +			WARN_ON_ONCE(1);
>> +			return false;
>> +		}
>>  	}
>>  
>>  	/* Now data in @desc can be modified: LMM(desc_reserve:G) */
>> @@ -1364,9 +1388,37 @@ static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
>>  	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
>>  						prev_state_val | DESC_FINAL_MASK)) {
>>  
>> -		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
>> +		switch (get_desc_state(id, prev_state_val, &is_final)) {
>> +		case desc_miss:
>> +			/*
>> +			 * If the ID is exactly 1 wrap behind the expected, it is
>> +			 * in the process of being reserved by another writer and
>> +			 * must be considered reserved.
>> +			 */
>> +			if (get_desc_state(DESC_ID_PREV_WRAP(desc_ring, id),
>> +					   prev_state_val, &is_final) != desc_reusable) {
>> +				/*
>> +				 * If this descriptor has never been used, @prev_state_val
>> +				 * will be 0. However, even though it may have never been
>> +				 * used, it may have been finalized. So that flag must be
>> +				 * ignored.
>> +				 */
>> +				if ((prev_state_val & ~DESC_FINAL_MASK)) {
>> +					WARN_ON_ONCE(1);
>> +					return;
>> +				}
>> +			}
>> +			fallthrough;
>
> How is this supposed to work please?
>
> If the ID is exactly one wrap behind, it is being reserved but the new
> id was not written yet. In this case, DESC_FINAL_MASK is already set.

No. If it is exactly one wrap behind, it is still in the reusable
state. The FINAL flag will not be set because it is cleared when
transitioning to reusable.

> The above cmpxchg will not do any change. And prb_reserve() will not
> be able to distinguish that it has been finalized.

The cmpxchg() will try again using the newly updated @prev_state_val and
try to set it to "prev_state_val | FINAL".

Now, theoretically, a writer could commit and reopen the descriptor with
such timing that this cmpxchg() will always fail. A kind of cat and
mouse, always trying to set the FINAL flag for the last @state_var
value.

That game could be avoided if the descriptor noticed that it is no
longer the head ID and set its own FINAL flag. I like the idea of a
guaranteed finalizing of the previous descriptor and the ability for a
descriptor to finalize itself.

(Although really, if we start talking about timed cmpxchg() attacks,
almost any cmpxchg loop can become near-infinite.)

> I am really not sure what solution is better. Mine have more barriers.
> But this brings many new combinations that need to be checked and
> handled.

I am putting together a fully functional version of your solution with
the appropriate memory barriers and correct handling of the special
cases so that we can get a better look at the difference.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
