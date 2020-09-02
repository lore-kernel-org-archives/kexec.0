Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDQoO-0002wM-1I
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 11:20:20 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: state names: vas: Re: [PATCH next v3 6/8] printk: ringbuffer: add
 finalization/extension support
In-Reply-To: <20200902105250.GA15764@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-7-john.ogness@linutronix.de>
 <20200902105250.GA15764@alley>
Date: Wed, 02 Sep 2020 13:26:14 +0206
Message-ID: <87r1rkctn5.fsf@jogness.linutronix.de>
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

On 2020-09-02, Petr Mladek <pmladek@suse.com> wrote:
>> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
>> +					 u32 caller_id, unsigned long *id_out)
>> +{
>> +	unsigned long prev_state_val;
>> +	enum desc_state d_state;
>> +	struct prb_desc desc;
>> +	struct prb_desc *d;
>> +	unsigned long id;
>> +
>> +	id = atomic_long_read(&desc_ring->head_id);
>> +
>> +	/*
>> +	 * To minimize unnecessarily reopening a descriptor, first check the
>> +	 * descriptor is in the correct state and has a matching caller ID.
>> +	 */
>> +	d_state = desc_read(desc_ring, id, &desc);
>> +	if (d_state != desc_reserved ||
>> +	    !(atomic_long_read(&desc.state_var) & DESC_COMMIT_MASK) ||
>
> This looks like a hack. And similar extra check of the bit is needed
> also in desc_read(), see
> https://lore.kernel.org/r/878sdvq8kd.fsf@jogness.linutronix.de

Agreed.

> I has been actually getting less and less happy with the inconsistency
> between names of the bits and states.
>
> ...
>
> First, define 5 desc_states, something like:
>
> enum desc_state {
> 	desc_miss = -1,		/* ID mismatch */
> 	desc_modified =	 0x0,	/* reserved, being modified by writer */

I prefer the "desc_reserved" name. It may or may not have be modified yet.

> 	desc_committed = 0x1,	/* committed by writer, could get reopened */
> 	desc_finalized = 0x2,	/* committed, could not longer get modified */
> 	desc_reusable =	 0x3,	/* free, not yet used by any writer */
> };
>
> Second, only 4 variants of the 3 state bits are currently used.
> It means that two bits are enough and they might use exactly
> the above names:
>
> I mean to do something like:
>
> #define DESC_SV_BITS		(sizeof(unsigned long) * 8)
> #define DESC_SV(desc_state)	((unsigned long)desc_state << (DESC_SV_BITS - 2))
> #define DESC_ST(state_val)	((unsigned long)state_val >> (DESC_SV_BITS - 2))

This makes sense and will get us back the bit we lost because of
finalization.

> I am sorry that I did not came up with this earlier. I know how
> painful it is to rework bigger patchsets. But it affects format
> of the ring buffer, so we should do it early.

Agreed.

I am wondering if VMCOREINFO should include a DESC_FLAGS_MASK so that
crash tools could at least successfully iterate the ID's, even if they
didn't know what all the flag values mean (in the case that more bits
are added later).

> PS: I am still middle of review. It looks good so far. I wanted to
> send this early and separately because it is a bigger change.

Thanks for the heads up.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
