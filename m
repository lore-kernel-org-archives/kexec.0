Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icUBC-0007pj-A0
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 12:54:56 +0000
Date: Wed, 4 Dec 2019 13:54:50 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer
 implementation (reader)
Message-ID: <20191204125450.ob5b7xi3gevor4qz@pathway.suse.cz>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-3-john.ogness@linutronix.de>
 <20191203120622.zux33do54rmjafns@pathway.suse.cz>
 <87pnh5bjz4.fsf@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pnh5bjz4.fsf@linutronix.de>
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
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On Tue 2019-12-03 14:46:07, John Ogness wrote:
> On 2019-12-03, Petr Mladek <pmladek@suse.com> wrote:
> >> Add the reader implementation for the new ringbuffer.
> >> 
> >> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >> ---
> >>  kernel/printk/printk_ringbuffer.c | 234 ++++++++++++++++++++++++++++++
> >>  kernel/printk/printk_ringbuffer.h |  12 +-
> >>  2 files changed, 245 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >> index 09c32e52fd40..f85762713583 100644
> >> --- a/kernel/printk/printk_ringbuffer.c
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> @@ -674,3 +674,237 @@ void prb_commit(struct prb_reserved_entry *e)
> >>  	local_irq_restore(e->irqflags);
> >>  }
> >>  EXPORT_SYMBOL(prb_commit);
> >> +
> >> +/*
> >> + * Given @blk_lpos, return a pointer to the raw data from the data block
> >> + * and calculate the size of the data part. A NULL pointer is returned
> >> + * if @blk_lpos specifies values that could never be legal.
> >> + *
> >> + * This function (used by readers) performs strict validation on the lpos
> >> + * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
> >> + * triggered if an internal error is detected.
> >> + */
> >> +static char *get_data(struct prb_data_ring *data_ring,
> >> +		      struct prb_data_blk_lpos *blk_lpos,
> >> +		      unsigned long *data_size)
> >> +{
> >> +	struct prb_data_block *db;
> >> +
> >> +	if (blk_lpos->begin == INVALID_LPOS &&
> >> +	    blk_lpos->next == INVALID_LPOS) {
> >> +		/* descriptor without a data block */
> >> +		return NULL;
> >> +	} else if (DATA_WRAPS(data_ring, blk_lpos->begin) ==
> >> +		   DATA_WRAPS(data_ring, blk_lpos->next)) {
> >> +		/* regular data block */
> >> +		if (WARN_ON_ONCE(blk_lpos->next <= blk_lpos->begin))
> >> +			return NULL;
> >> +		db = to_block(data_ring, blk_lpos->begin);
> >> +		*data_size = blk_lpos->next - blk_lpos->begin;
> >> +
> >> +	} else if ((DATA_WRAPS(data_ring, blk_lpos->begin) + 1 ==
> >> +		    DATA_WRAPS(data_ring, blk_lpos->next)) ||
> >> +		   ((DATA_WRAPS(data_ring, blk_lpos->begin) ==
> >> +		     DATA_WRAPS(data_ring, -1UL)) &&
> >> +		    (DATA_WRAPS(data_ring, blk_lpos->next) == 0))) {
> >
> > I am a bit confused. I would expect that (-1UL + 1) = 0. So the second
> > condition after || looks just like a special variant of the first
> > valid condition.
> >
> > Or do I miss anything? Is there a problems with type casting?
> 
> Sorry, this code deserves a comment.
> 
> Here we are only comparing the number of wraps. For a wrapping data
> block, @begin will be 1 wrap less than @next. The first part of the
> check is checking the typical case, making sure that:
> 
>    1 + WRAPS(@begin) == WRAPS(@next)
> 
> There is also the case when the lpos overflows. In that case the number
> of wraps starts over at zero (without having overflowed). (Note: The
> lpos overflows, _not_ the number of wraps. This is why the first check
> is not enough.) In this case, the number of wraps of the highest
> possible lpos value (-1UL) should be the same as the number of wraps of
> @begin. And the number of wraps of @next should be 0. The simplified
> pseudo-code check is:
> 
>    WRAPS(@begin) == WRAPS(-1UL)
>       &&
>    WRAPS(@next) == 0

Got it. I knew that it must have been something like this but I did
not see it.

I wonder if the following might be easier to understand even for
people like me ;-)

	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
		    DATA_WRAPS(data_ring, blk_lpos->next)) {

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
