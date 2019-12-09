Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieEwu-00025g-Q9
 for kexec@lists.infradead.org; Mon, 09 Dec 2019 09:03:26 +0000
Received: by mail-pf1-x444.google.com with SMTP id y14so6861038pfm.13
 for <kexec@lists.infradead.org>; Mon, 09 Dec 2019 01:03:24 -0800 (PST)
Date: Mon, 9 Dec 2019 18:03:21 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer
 implementation (reader)
Message-ID: <20191209090321.GF88619@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-3-john.ogness@linutronix.de>
 <20191209084300.GD88619@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209084300.GD88619@google.com>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On (19/12/09 17:43), Sergey Senozhatsky wrote:
> > +static int desc_read_committed(struct prb_desc_ring *desc_ring, u32 id,
> > +			       u64 seq, struct prb_desc *desc)
> > +{
> > +	enum desc_state d_state;
> > +
> > +	d_state = desc_read(desc_ring, id, desc);
> > +	if (desc->info.seq != seq)
> > +		return -EINVAL;
> > +	else if (d_state == desc_reusable)
> > +		return -ENOENT;
> > +	else if (d_state != desc_committed)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Copy the ringbuffer data from the record with @seq to the provided
> > + * @r buffer. On success, 0 is returned.
> > + *
> > + * See desc_read_committed() for error return values.
> > + */
> > +static int prb_read(struct printk_ringbuffer *rb, u64 seq,
> > +		    struct printk_record *r)
> > +{
> > +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> > +	struct prb_desc *rdesc = to_desc(desc_ring, seq);
> > +	atomic_t *state_var = &rdesc->state_var;
> > +	struct prb_desc desc;
> > +	int err;
> > +	u32 id;
> > +
> > +	/* Get a reliable local copy of the descriptor and check validity. */
> > +	id = DESC_ID(atomic_read(state_var));
> > +	err = desc_read_committed(desc_ring, id, seq, &desc);
> > +	if (err)
> > +		return err;
> > +
> > +	/* If requested, copy meta data. */
> > +	if (r->info)
> > +		memcpy(r->info, &desc.info, sizeof(*(r->info)));
> 
> I wonder if those WARN_ON-s will trigger false positive sometimes.
> 
> A theoretical case.
> 
> What if reader gets preempted/interrupted in the middle of
> desc_read_committed()->desc_read()->memcpy(). The context which interrupts
> the reader recycles the descriptor and pushes new data. Suppose that
> reader was interrupted right after it copied ->info.seq and ->info.text_len.
> So the first desc_read_committed() will pass - we have matching ->seq
> and committed state. copy_data(), however, most likely, will generate
> WARNs. The final desc_read_committed() will notice that local copy
> of desc was in non-consistent state and everything is fine, but we have
> WARNs in the log buffer now.

Hmm. No, that won't happen. We should get desc_miss first, and then -EINVAL.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
