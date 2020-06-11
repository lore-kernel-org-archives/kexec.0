Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjWHQ-0003FX-99
 for kexec@lists.infradead.org; Thu, 11 Jun 2020 23:06:41 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: Barrier before pushing desc_ring tail: was [PATCH v2 2/3] printk:
 add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609113751.GD23752@linux-b0ei>
 <87d068utbg.fsf@vostro.fn.ogness.net>
 <20200611120107.GD6581@linux-b0ei>
Date: Fri, 12 Jun 2020 01:06:28 +0200
In-Reply-To: <20200611120107.GD6581@linux-b0ei> (Petr Mladek's message of
 "Thu, 11 Jun 2020 14:01:08 +0200")
Message-ID: <87bllpyzgr.fsf@vostro.fn.ogness.net>
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

On 2020-06-11, Petr Mladek <pmladek@suse.com> wrote:
> All this relies on the fact the the full barrier is called in
> data_push_tail() and data_push_tail() is called right above.
> But there are two situations where the barrier is not called.
> It is when:
>
>   1. desc.text_blk_lpos.next already is behind data_ring->tail_lpos.
>
>      This is safe.

Yes, and I have since expanded the comment above the data_push_tail()
while loop to mention that:

	/*
	 * Loop until the tail lpos is at or beyond @lpos. This condition
	 * may already be satisfied, resulting in no full memory barrier
	 * from data_push_tail:C being performed. However, since this CPU
	 * sees the new tail lpos, any descriptor states that transitioned to
	 * the reusable state must already be visible.
	 */

>   2. desc.text_blk_lpos == INVALID_LPOS.
>
>      It seems that this is not synchronized and other CPUs might see
>      the old state.

Great catch! This could trigger the WARN_ON at desc_reserve:F and lead
to prb_reserve() unnecessarily failing.

> The question is what to do with the empty data case. I see three
> possibilities:
>
>   1. Ignore the case with empty block because it (probably) does not
>      cause real problems.

It could cause dropped messages.

>   2. Call the full barrier in data_push_tail() even when the data
>      block is empty.

This is the common case, since most records will not have dictionary
data.

>   3. Call the full barrier also in desc_push_tail() as I suggested.
>
> My opinion:
>
> I prefer 3rd solution.

Agreed. For my next version I am folding all smp_mb() and smp_wmb()
calls into their neighboring cmpxchg_relaxed(). This would apply here as
well, changing desc_push_tail:B to a full cmpxchg().

We still need the full memory barrier at data_push_tail:C. Readers rely
on it to be able to verify if their copied data is still valid:

CPU0 (writer0)        CPU1 (writer1)       CPU2 (reader)
                                           desc_read->committed
desc_make_reusable
smp_mb
data_push_tail
                      read new data tail
                      data_push_head
                      smp_mb
                      write new data
                                           read garbage new data
                                           desc_read->reusable

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
