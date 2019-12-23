Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ijQ8t-0005A8-24
 for kexec@lists.infradead.org; Mon, 23 Dec 2019 16:01:12 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191221142235.GA7824@andrea>
Date: Mon, 23 Dec 2019 17:01:00 +0100
Message-ID: <87imm7820z.fsf@linutronix.de>
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
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

Hi Andrea,

On 2019-12-21, Andrea Parri <parri.andrea@gmail.com> wrote:
>> +	*desc_out = READ_ONCE(*desc);
>> +
>> +	/* Load data before re-checking state. */
>> +	smp_rmb(); /* matches LMM_REF(desc_reserve:A) */
>
> I looked for a matching WRITE_ONCE() or some other type of marked write,
> but I could not find it.  What is the rationale?  Or what did I miss?

This smp_rmb() matches LMM_TAG(desc_reserve:A).

>> +	do {
>> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
>> +
>> +		if (!data_push_tail(rb, data_ring,
>> +				    next_lpos - DATA_SIZE(data_ring))) {
>> +			/* Failed to allocate, specify a data-less block. */
>> +			blk_lpos->begin = INVALID_LPOS;
>> +			blk_lpos->next = INVALID_LPOS;
>> +			return NULL;
>> +		}
>> +	} while (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &begin_lpos,
>> +					  next_lpos));
>> +
>> +	/*
>> +	 * No barrier is needed here. The data validity is defined by
>> +	 * the state of the associated descriptor. They are marked as
>> +	 * invalid at the moment. And only the winner of the above
>> +	 * cmpxchg() could write here.
>> +	 */
>
> The (successful) CMPXCHG provides a full barrier.  This comment suggests
> that that could be somehow relaxed?  Or the comment could be improved?

You are correct. There is no need for the full barrier here. This code
is based on Petr's POC. I focussed on making sure needed barriers are in
place, but did not try to eliminate excessive barriers.

> (The patch introduces a number of CMPXCHG: similar questions would
> apply to those other instances...)

LMM_TAG(data_push_tail:A) is the only CMPXCHG that requires its full
barrier. All others can be relaxed. I will make this change for the next
series.

Thanks for taking time for this.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
