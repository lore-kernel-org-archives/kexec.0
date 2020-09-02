Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDS39-00032D-1t
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 12:39:40 +0000
Date: Wed, 2 Sep 2020 14:39:36 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: state names: vas: Re: [PATCH next v3 6/8] printk: ringbuffer:
 add finalization/extension support
Message-ID: <20200902123936.GC9496@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-7-john.ogness@linutronix.de>
 <20200902105250.GA15764@alley>
 <87r1rkctn5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r1rkctn5.fsf@jogness.linutronix.de>
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

On Wed 2020-09-02 13:26:14, John Ogness wrote:
> On 2020-09-02, Petr Mladek <pmladek@suse.com> wrote:
> >> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
> >> +					 u32 caller_id, unsigned long *id_out)
> >> +{
> >> +	unsigned long prev_state_val;
> >> +	enum desc_state d_state;
> >> +	struct prb_desc desc;
> >> +	struct prb_desc *d;
> >> +	unsigned long id;
> >> +
> >> +	id = atomic_long_read(&desc_ring->head_id);
> >> +
> >> +	/*
> >> +	 * To minimize unnecessarily reopening a descriptor, first check the
> >> +	 * descriptor is in the correct state and has a matching caller ID.
> >> +	 */
> >> +	d_state = desc_read(desc_ring, id, &desc);
> >> +	if (d_state != desc_reserved ||
> >> +	    !(atomic_long_read(&desc.state_var) & DESC_COMMIT_MASK) ||
> >
> > First, define 5 desc_states, something like:
> >
> > enum desc_state {
> > 	desc_miss = -1,		/* ID mismatch */
> > 	desc_modified =	 0x0,	/* reserved, being modified by writer */
> 
> I prefer the "desc_reserved" name. It may or may not have be modified yet.

Yeah, "desc_reserved" sounds better. I probably just wanted to free my
fantasy from the current code ;-)


> > 	desc_committed = 0x1,	/* committed by writer, could get reopened */
> > 	desc_finalized = 0x2,	/* committed, could not longer get modified */
> > 	desc_reusable =	 0x3,	/* free, not yet used by any writer */
> > };
> >
> > Second, only 4 variants of the 3 state bits are currently used.
> > It means that two bits are enough and they might use exactly
> > the above names:
> >
> > I mean to do something like:
> >
> > #define DESC_SV_BITS		(sizeof(unsigned long) * 8)
> > #define DESC_SV(desc_state)	((unsigned long)desc_state << (DESC_SV_BITS - 2))
> > #define DESC_ST(state_val)	((unsigned long)state_val >> (DESC_SV_BITS - 2))
> 
> This makes sense and will get us back the bit we lost because of
> finalization.

Yup. Which is good especially on 32-bit architectures.

> I am wondering if VMCOREINFO should include a DESC_FLAGS_MASK so that
> crash tools could at least successfully iterate the ID's, even if they
> didn't know what all the flag values mean (in the case that more bits
> are added later).

Good point. I am just not sure whether they should try read all ids
or they should refuse reading anything when a new bit is added.

Well, I really hope that we will not need new states anytime soon.
It would need a really strong reason.

I personally can't think about any use case. pr_cont() was special
because it was the writer side. All other steps of the printk rework
are on the reader side.

I believe that we are getting close with all the ring buffer code.
And I have good feeling about it.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
