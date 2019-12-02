Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibohb-0000dv-E4
 for kexec@lists.infradead.org; Mon, 02 Dec 2019 16:37:37 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
 <20191202155955.meawljmduiciw5t2@pathway.suse.cz>
Date: Mon, 02 Dec 2019 17:37:26 +0100
In-Reply-To: <20191202155955.meawljmduiciw5t2@pathway.suse.cz> (Petr Mladek's
 message of "Mon, 2 Dec 2019 16:59:55 +0100")
Message-ID: <87sgm2fzuh.fsf@linutronix.de>
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
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On 2019-12-02, Petr Mladek <pmladek@suse.com> wrote:
>> > +/* Reserve a new descriptor, invalidating the oldest if necessary. */
>> > +static bool desc_reserve(struct printk_ringbuffer *rb, u32 *id_out)
>> > +{
>> > +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> > +	struct prb_desc *desc;
>> > +	u32 id_prev_wrap;
>> > +	u32 head_id;
>> > +	u32 id;
>> > +
>> > +	head_id = atomic_read(&desc_ring->head_id);
>> > +
>> > +	do {
>> > +		desc = to_desc(desc_ring, head_id);
>> > +
>> > +		id = DESC_ID(head_id + 1);
>> > +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
>> > +
>> > +		if (id_prev_wrap == atomic_read(&desc_ring->tail_id)) {
>> > +			if (!desc_push_tail(rb, id_prev_wrap))
>> > +				return false;
>> > +		}
>> > +	} while (!atomic_try_cmpxchg(&desc_ring->head_id, &head_id, id));
>> 
>> Hmm, in theory, ABA problem might cause that we successfully
>> move desc_ring->head_id when tail has not been pushed yet.
>> 
>> As a result we would never call desc_push_tail() until
>> it overflows again.
>> 
>> I am not sure if we need to take care of it. The code is called with
>> interrupts disabled. IMHO, only NMI could cause ABA problem
>> in reality. But the game (debugging) is lost anyway when NMI ovewrites
>> the buffer several times.
>
> BTW: If I am counting correctly. The ABA problem would happen when
> exactly 2^30 (1G) messages is written in the mean time.

All the ringbuffer code assumes that the use of index numbers handles
the ABA problem (i.e. there must not be 1 billion printk's within an
NMI). If we want to support 1 billion+ printk's within an NMI, then
perhaps the index number should be increased. For 64-bit systems it
would be no problem to go to 62 bits. For 32-bit systems, I don't know
how well the 64-bit atomic operations are supported.

>> Also it should not be a complete failure. We still could bail out when
>> the previous state was not reusable. We are on the safe side
>> when it was reusable.
>> 
>> Also we could probably detect when desc_ring->tail_id is not
>> updated any longer and do something about it.
>> 
>> > +
>> > +	desc = to_desc(desc_ring, id);
>> > +
>> > +	/* Set the descriptor's ID and also set its state to reserved. */
>> > +	atomic_set(&desc->state_var, id | 0);
>> 
>> We should check here that the original state id from the previous
>> wrap in reusable state (or 0 for bootstrap). On error, we know that
>> there was the ABA problem and would need to do something about it.
>
> I believe that it should be enough to add this check and
> bail out in case of error.

I need to go through the code again in detail and see how many locations
are affected by ABA. All the code was written with the assumption that
this type of ABA will not happen.

As you've stated, we could add minimal handling so that the ringbuffer
at least does not break or get stuck.

BTW: The same assumption is made for logical positions. There are 4
times as many of these (on 32-bit systems) but logical positions advance
much faster. I will review these as well.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
