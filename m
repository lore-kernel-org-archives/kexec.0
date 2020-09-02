Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDQNs-0007w0-I0
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 10:52:57 +0000
Date: Wed, 2 Sep 2020 12:52:50 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: state names: vas: Re: [PATCH next v3 6/8] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200902105250.GA15764@alley>
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
 
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -49,14 +49,16 @@
>   * Descriptors have three states:
>   *
>   *   reserved
> - *     A writer is modifying the record.
> + *     A writer is modifying the record. Internally represented as either "0"
> + *     or "DESC_COMMIT_MASK".

We should explain the difference between the two values. It might be
enough to add something like:

    See "Descriptor Finalization" section for more details."

> @@ -79,6 +81,25 @@
>   * committed or reusable queried state. This makes it possible that a valid
>   * sequence number of the tail is always available.
>   *
> + * Descriptor Finalization
> + * ~~~~~~~~~~~~~~~~~~~~~~~
> + * When a writer calls the commit function prb_commit(), the record may still
> + * continue to be in the reserved queried state. In order for that record to
> + * enter into the committed queried state, that record also must be finalized.
> + * A record can be finalized by three different scenarios:
> + *
> + *   1) A writer can finalize its record immediately by calling
> + *      prb_final_commit() instead of prb_commit().
> + *
> + *   2) When a new record is reserved and the previous record has been
> + *      committed via prb_commit(), that previous record is finalized.
> + *
> + *   3) When a record is committed via prb_commit() and a newer record
> + *      already exists, the record being committed is finalized.
> + *
> + * Until a record is finalized (represented by "DESC_FINAL_MASK"), a writer
> + * may "reopen" that record and extend it with more data.
> + *
>   * Data Rings
>   * ~~~~~~~~~~
>   * The two data rings (text and dictionary) function identically. They exist

[...]

> +/*
> + * Attempt to remove the commit flag so that the record can be modified by a
> + * writer again. This is only possible if the descriptor is not yet finalized.
> + *
> + * Note that on success, the queried state did not change. A non-finalized
> + * record (even with the commit flag set) is in the reserved queried state.
> + */
> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
> +					 u32 caller_id, unsigned long *id_out)
> +{
> +	unsigned long prev_state_val;
> +	enum desc_state d_state;
> +	struct prb_desc desc;
> +	struct prb_desc *d;
> +	unsigned long id;
> +
> +	id = atomic_long_read(&desc_ring->head_id);
> +
> +	/*
> +	 * To minimize unnecessarily reopening a descriptor, first check the
> +	 * descriptor is in the correct state and has a matching caller ID.
> +	 */
> +	d_state = desc_read(desc_ring, id, &desc);
> +	if (d_state != desc_reserved ||
> +	    !(atomic_long_read(&desc.state_var) & DESC_COMMIT_MASK) ||

This looks like a hack. And similar extra check of the bit is needed
also in desc_read(), see
https://lore.kernel.org/r/878sdvq8kd.fsf@jogness.linutronix.de

I has been actually getting less and less happy with the inconsistency
between names of the bits and states.

Sigh, you will hate me because this would mean a bigger change.
IMHO, it would be much cleaner and help with long-term maintainability
when we do the following two changes:

First, define 5 desc_states, something like:

enum desc_state {
	desc_miss = -1,		/* ID mismatch */
	desc_modified =	 0x0,	/* reserved, being modified by writer */
	desc_committed = 0x1,	/* committed by writer, could get reopened */
	desc_finalized = 0x2,	/* committed, could not longer get modified */
	desc_reusable =	 0x3,	/* free, not yet used by any writer */
};

Second, only 4 variants of the 3 state bits are currently used.
It means that two bits are enough and they might use exactly
the above names:

I mean to do something like:

#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
#define DESC_SV(desc_state)	((unsigned long)desc_state << (DESC_SV_BITS - 2))
#define DESC_ST(state_val)	((unsigned long)state_val >> (DESC_SV_BITS - 2))


Then we could have:

static enum desc_state get_desc_state(unsigned long id,
				      unsigned long state_val)
{
	if (id != DESC_ID(state_val))
		return desc_miss;

	return DESC_ST(state_val);
}

and use in the code:

unsigned long val_committed = id | DESC_SV(desc_committed);


or do

#define DESC_SV(id, desc_state)	(id | (unsigned long)desc_state << (DESC_SV_BITS - 2))

and then use DESC_SV(id, DESC_COMMITTED).


I am sorry that I did not came up with this earlier. I know how
painful it is to rework bigger patchsets. But it affects format
of the ring buffer, so we should do it early.

Best Regards,
Petr

PS: I am still middle of review. It looks good so far. I wanted to
send this early and separately because it is a bigger change.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
